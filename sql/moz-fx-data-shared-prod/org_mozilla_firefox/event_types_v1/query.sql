CREATE OR REPLACE TABLE
  org_mozilla_firefox.event_types_v1
AS
SELECT
  * EXCEPT (submission_date)
FROM
  org_mozilla_firefox_derived.event_types_history_v1
WHERE
  submission_date = @submission_date