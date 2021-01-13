-- Query for telemetry_derived.attributed_windows_desktop_funnel_sessions_v1
CREATE TEMP FUNCTION map_country_name_to_prefix(input STRING)
RETURNS STRING
LANGUAGE js
AS
  """
    if (input === "USA") {
        return "US";
    } else if (input === "Germany") {
        return "DE";
    } else if (input === "United Kingdom") {
        return "GB";
    } else if (input === "France") {
        return "FR"
    } else if (input === "Canada") {
        return "CA"
    } else if (input === "Brazil") {
        return "BR"
    } else if (input === "Mexico") {
        return "MX"
    }
    return "OTHER";
    """;

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

SELECT
  date,
  country_group,
  sum(non_fx_sessions) AS nonFxSessions,
  sum(non_fx_downloads) AS nonFxDownloads
FROM
  `moz-fx-data-marketing-prod.ga_derived`.www_site_metrics_summary_v1
CROSS JOIN
  UNNEST(
    ARRAY_CONCAT(['Overall'], bucket_country(map_country_name_to_prefix(standardized_country_name)))
  ) AS country_group
WHERE
  date = @submission_date
  AND operating_system = 'Windows'
  AND browser != 'Mozilla'
GROUP BY
  date,
  country_group
ORDER BY
  date,
  country_group;
