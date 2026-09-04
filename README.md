# VA Disability Compensation Recipients by County

## Overview
This project cleans, structures, and analyzes county-level data on Veterans receiving VA Disability Compensation benefits as of 9/30/2025. The dataset breaks recipients down by service-connected disability (SCD) rating, age group, and sex, across all US counties, Puerto Rico, and US territories.

## Data Source
- **Provider:** Department of Veterans Affairs, National Center for Veterans Analysis & Statistics
- **Underlying data:** USVETS25 data, Veterans Benefits Administration VETSNET FY2025 compensation data, Melissa Data (September 2025) geography data
- **Reference:** [www.va.gov/vetdata](https://www.va.gov/vetdata)
- **Snapshot date:** 9/30/2025

## Important Data Notes
These details affect how the data should be interpreted, and are easy to miss if you only look at the raw table:

- **Blank values are suppressed, not zero.** Small cell counts are intentionally blanked to protect Veteran identity, including some additional cells suppressed to prevent back-calculating those small counts. A `NULL` in this dataset means "unknown/suppressed," never "zero recipients."
- **Category totals may not sum to the total.** Age and sex breakdowns don't always add up to `total_recipients`, since some records are missing that information (878 Veterans have no sex on file, 28 have no age on file).
- **This is a snapshot, not a full-year record.** 149,077 Veterans who received disability compensation at some point in FY2025 but were no longer recipients by year-end are **not included** in this table.
- **Puerto Rico is not county-level.** It appears in the source as a single aggregated row ("Puerto Rico all counties"), not broken into county-equivalents like the US states are - so it isn't directly comparable to individual county rows.

## Table Structure

### `veterans_disability`
The primary, analysis-ready table. Contains only real US state counties, with:
- Numeric columns cast to `INTEGER` (cleaned from comma-formatted text, e.g. `"11,464"` -> `11464`)
- Empty cells converted to true `NULL` values (not zero, not empty string)

### `veterans_disability_other`
Rows excluded from the main table because they don't represent a standard US county:
- `Unknown` location records
- `Other Foreign Countries`
- `US Territories (excluding Puerto Rico)`
- `Puerto Rico` (aggregated single row - see note above)

These were preserved in a separate table rather than deleted, so the full dataset remains available for reference or transparency reporting.

### `staging_va`
Raw import table with all columns as `TEXT`. Used only as an intermediate step to safely load the original CSV (which has commas in numbers and blank cells) before cleaning and casting into `veterans_disability`.

## Process
1. Imported raw CSV into a `TEXT`-only staging table to avoid failed imports from commas/blanks
2. Cleaned and cast data into a properly typed table using `REPLACE`, `NULLIF`, and `CAST`
3. Separated non-county rows (unknown, foreign, territories, Puerto Rico) into their own table
4. Validated row counts, spot-checked known values, and confirmed suppressed cells read as `NULL` rather than `0`

## Known Limitations
- Point-in-time snapshot (9/30/2025); does not reflect year-over-year change
- Excludes Veterans who left compensation status during FY2025
- Small-county figures are incomplete by design due to privacy suppression
- When ranking or sorting by columns that contain `NULL` (suppressed) values, PostgreSQL sorts `NULL` as the highest value by default in descending order - queries should explicitly filter with `WHERE column IS NOT NULL` before ranking, or suppressed rows will incorrectly appear at the top

## Findings
See [`findings/summary.md`](findings/summary.md) for key insights derived from this dataset, including disability rating rates by state, national age distribution, and county-level recipient patterns.
