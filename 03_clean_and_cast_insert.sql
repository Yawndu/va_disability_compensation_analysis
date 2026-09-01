INSERT INTO veterans_disability (
	fips_code, state, county_name, total_recipients, 
	scd_0_20, scd_30_40, scd_50_60, scd_70_90, scd_100,
	age_17_44, age_45_64, age_65_older, male, female
)

Select
	fips_code,
	state,
	county_name,
	CAST(NULLIF(REPLACE(total_recipients, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(scd_0_20, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(scd_30_40, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(scd_50_60, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(scd_70_90, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(scd_100, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(age_17_44, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(age_45_64, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(age_65_older, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(male, ',',''), '') AS INTEGER),
	CAST(NULLIF(REPLACE(female, ',',''), '') AS INTEGER)
FROM staging_va;