  /*

Return a boolean value indicating whether the search is monetized

*/
CREATE OR REPLACE FUNCTION udf.monetized_search(
  engine STRING,
  country STRING,
  distribution_id STRING,
  submission_date DATE
) AS (
  CASE
  WHEN
    engine = 'google-nocodes'
  THEN
    FALSE
  WHEN
    engine LIKE 'google%'
    AND distribution_id LIKE 'canonical%'
    AND submission_date < '2020-07-29'
  THEN
    TRUE
  WHEN
    engine = 'google-canonical'
    AND submission_date >= '2020-07-29'
  THEN
    TRUE
  WHEN
    engine LIKE 'google%'
    AND country IN ('RU', 'TR', 'KZ', 'BY', 'CN')
  THEN
    FALSE  -- excluded territory for Google
  WHEN
    engine LIKE 'google%'
    AND country IN ('UA')
    AND submission_date < '2017-07-14'
  THEN
    FALSE
  WHEN
    engine LIKE 'google%'
    AND country IN ('US', 'CA', 'TW', 'HK')
    AND submission_date < '2017-11-14'
  THEN
    FALSE
  WHEN
    engine IN ('google', 'google-sysaddon', 'google-b-d', 'google-b-e')
  THEN
    TRUE -- RoW code (search in US with RoW code will be at RoW share)
  WHEN
    engine IN ('google-2018', 'google-2018-sysaddon', 'google-b-1-d', 'google-b-1-e')
    AND country = 'US'
  THEN
    TRUE -- US code
  WHEN
    engine IN ('google-2018', 'google-2018-sysaddon', 'google-b-1-d', 'google-b-1-e')
    AND country != 'US'
  THEN
    FALSE -- US code not monetized in RoW
  WHEN
    engine LIKE 'yandex%'
    AND country = 'UA'
    AND submission_date < '2017-07-01'
  THEN
    TRUE
  WHEN
    (engine LIKE 'yandex%' OR engine = 'yasearch')
    AND country IN ('RU', 'KZ', 'BY', 'TR')
  THEN
    TRUE
  WHEN
    engine IN ('bing', 'ddg', 'duckduckgo')
  THEN
    TRUE
  WHEN
    engine LIKE 'ebay%'
    AND country IN ('US', 'GB', 'CA', 'IE', 'FR', 'IT', 'DE', 'AT', 'ES', 'NL', 'AU', 'CH')
  THEN
    TRUE
  WHEN
    engine LIKE 'amazon%'
    AND country IN ('US', 'IT', 'GB', 'FR', 'DE', 'JP')
  THEN
    TRUE
  WHEN
    engine LIKE 'yahoo-jp%'
    AND country IN ('JP')
  THEN
    TRUE
  WHEN
    engine = 'baidu'
    AND country IN ('CN')
  THEN
    TRUE
  WHEN
   engine = 'ecosia'
    AND country IN ('DE')
  THEN
    TRUE
  WHEN
    engine = 'qwant'
    AND country IN ('FR')
  THEN
    TRUE
  WHEN
    engine = 'mailru'
    AND country IN ('RU')
  THEN
    TRUE
  WHEN
    engine = 'seznam-cz'
    AND country IN ('CZ')
  THEN
    TRUE
  WHEN
    engine = 'webde-suche'
    AND country IN ('DE')
  THEN
    TRUE
  WHEN
    engine = 'rakuten'
    AND country IN ('JP')
  THEN
    TRUE
  WHEN
    engine IN ('amazondotcom-adm', 'amazon-en-GB-adm', 'amazon-de-adm')
  THEN
    TRUE -- AdMarketplace
  WHEN
    engine LIKE('yahoo%')
   AND submission_date < '2017-11-14'
  THEN
    TRUE
  ELSE
    FALSE
  END
);

-- Test
SELECT
  assert.false(udf.monetized_search('google-nocodes', 'US', '', '2020-12-21')), 
  assert.false(udf.monetized_search('google-b-1-d', 'DE', '', '2021-01-08')),  
  assert.true(udf.monetized_search('google-b-1-d', 'US', '', '2021-01-08')),  
  assert.true(udf.monetized_search('google-b-d', 'DE', '', '2021-01-08')),  
  assert.true(udf.monetized_search('google-b-d', 'US', '', '2021-01-08')),    
  assert.true(udf.monetized_search('google-canonical', 'RU', 'canonical', '2020-07-01')),
  assert.false(udf.monetized_search('yandex', 'DE', '', '2020-07-01')), 
  assert.true(udf.monetized_search('yasearch', 'RU', '', '2020-07-01')),
  assert.true(udf.monetized_search('google', 'FR', '', '2020-01-01')),
  assert.false(udf.monetized_search('ddg', 'CA', '', '2020-01-01'));


