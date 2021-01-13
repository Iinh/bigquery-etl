CREATE TEMP FUNCTION bucket_country(country STRING) AS (
  CASE
  WHEN
    country IN ('US', 'CA', 'DE', 'FR', 'GB')
  THEN
    [country, 'tier-1']
  WHEN
    country IN ('MX', 'BR')
  THEN
    [country, 'non-tier-1']
  ELSE
    ['non-tier-1']
  END
);

CREATE TEMP FUNCTION get_ua_attribution(input STRING)
RETURNS STRING
LANGUAGE js
AS
  """
    if (input == null) {
      return 'Unknown';
    }

    try {    
      pt1 = input.split('26ua%3D')[1];
      pt2 = pt1.split('%')[0];
      return pt2;
    } catch {
        return 'Unknown';
    }
    """;

SELECT
  DATE(submission_timestamp) AS date,
  country_group,
  COUNTIF(had_old_install = FALSE) AS successful_new_installs,
  COUNTIF(had_old_install = TRUE) AS successful_paveovers
FROM
  firefox_installer.install
CROSS JOIN
  UNNEST(ARRAY_CONCAT(['Overall'], bucket_country(normalized_country_code))) AS country_group
WHERE
  DATE(submission_timestamp) = @submission_date
  AND succeeded = TRUE
  AND (
    silent = FALSE
    OR silent IS NULL
  ) -- ignore silent installs (most of the time silent is unset)
  AND build_channel = 'release'
  AND DATE_DIFF(  -- Only use builds from the last month
    DATE(submission_timestamp),
    SAFE.PARSE_DATE('%Y%m%d', SUBSTR(build_id, 0, 8)),
    MONTH
  ) <= 1
  -- FIXME: change the below to "not Firefox", but make sure there *is*
  -- attribution (i.e. is not null, not 0)
  AND get_ua_attribution(attribution) IN ('chrome', 'ie', 'edge')
  -- TODO: filter for Windows here as well (not currently important since only Windows sends installer pings
  -- but may be if/when we get Mac installer pings)
GROUP BY
  1,
  2
ORDER BY
  1,
  2
