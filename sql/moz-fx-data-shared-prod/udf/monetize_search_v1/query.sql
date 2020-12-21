/*

Return a boolean value indicating whether the search is monetized

*/

CREATE OR REPLACE FUNCTION udf.monetized_search(engine STRING, country STRING, distribution_id STRING, submission_date DATE) AS (
CASE 
     WHEN engine LIKE 'yandex%' and country = 'UA' and submission_date < '2017-07-01' THEN True
     WHEN (engine LIKE 'yandex%' or engine = 'yasearch') and country in ('RU', 'KZ', 'BY', 'TR') THEN True
     WHEN engine IN ('bing', 'ddg', 'duckduckgo') THEN True
     WHEN engine LIKE 'ebay%' and country in ('US', 'GB', 'CA', 'IE', 'FR', 'IT', 'DE', 'AT', 'ES', 'NL', 'AU', 'CH') THEN True
     WHEN engine LIKE 'amazon%' and country in ('US', 'IT', 'GB', 'FR', 'DE', 'JP') THEN True
     WHEN engine LIKE 'yahoo-jp%' and country in ('JP') THEN True
     WHEN engine = 'baidu' and country in ('CN') THEN True
     WHEN engine = 'ecosia' and country in ('DE') THEN True
     WHEN engine = 'qwant' and country in ('FR') THEN True
     WHEN engine = 'mailru' and country in ('RU') THEN True
     WHEN engine = 'seznam-cz' and country in ('CZ') THEN True
     WHEN engine = 'webde-suche' and country in ('DE') THEN True  
     WHEN engine = 'rakuten' and country in ('JP') THEN True
     WHEN engine IN ('amazondotcom-adm', 'amazon-en-GB-adm', 'amazon-de-adm') THEN True -- AdMarketplace
     WHEN engine LIKE ('yahoo%') AND submission_date < '2017-11-14' THEN True
     WHEN engine = 'google-nocodes'  THEN False
     WHEN engine like 'google%' AND distribution_id like 'canonical%'  AND submission_date < '2020-07-29' THEN True
     WHEN engine = 'google-canonical' AND submission_date >= '2020-07-29' THEN True
     WHEN engine LIKE 'google%' AND country IN ('RU', 'TR' ,'KZ' ,'BY', 'CN') THEN False  -- excluded territory for Google
     WHEN engine LIKE 'google%' AND country IN ('UA') AND submission_date < '2017-07-14' THEN False
     WHEN engine LIKE 'google%' AND country IN ('US', 'CA' ,'TW', 'HK') AND submission_date < '2017-11-14'  THEN False
     WHEN engine IN ('google', 'google-sysaddon',  'google-b-d',  'google-b-e') THEN True -- RoW code (search in US with RoW code will be at RoW share)
     WHEN engine IN ('google-2018', 'google-2018-sysaddon',  'google-b-1-d', 'google-b-1-e') AND country = 'US'   THEN True -- US code
     WHEN engine IN ('google-2018', 'google-2018-sysaddon',  'google-b-1-d', 'google-b-1-e') AND country != 'US'  THEN False -- US code not monetized in RoW
     ELSE False
     END
);


-- Test
SELECT 
assert.equals('False', 'google-nocodes', 'US', '', '2020-12-21')
assert.equals('True', 'google', 'FR', '', '2020-01-01')
assert.equals('False', 'ddg', 'CA', '', '2020-01-01')
