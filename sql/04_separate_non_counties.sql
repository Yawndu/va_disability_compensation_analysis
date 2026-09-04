CREATE TABLE veterans_disability_other as 
SELECT * FROM veterans_disability 
WHERE county_name IN ('Unknwon', 'US Territories (excluding Puerto Rico)', 'Other Foreign Countries') 
	OR fips_code IN ('00000', '88888', 'Unknown', '72000');

DELETE FROM veterans_disability 
WHERE county_name IN ('Unknwon', 'US Territories (excluding Puerto Rico)', 'Other Foreign Countries') 
	OR fips_code IN ('00000', '88888', 'Unknown', '72000');