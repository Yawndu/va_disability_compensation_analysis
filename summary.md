# Findings: VA Disability Compensation Recipients by County

Analysis based on the cleaned `veterans_disability` table (county-level data, US states only, as of 9/30/2025).

## 1. Rate of 100% disability ratings is highest in Southern and Southeastern states
When measured as a **rate** (100%-rated recipients ÷ total recipients per state) rather than raw count, North Carolina leads at **35.19%**, followed by Texas (34.85%), Nevada (34.42%), Georgia (34.07%), and Virginia (33.67%). The top 10 states cluster tightly between 31-35%, and are mostly Southern/Southeastern, with Nevada as the geographic outlier.

This matters because ranking by raw count instead would tell a different, less accurate story - large states like Texas and Florida have huge total recipient counts, but rank lower by rate (34.85% and 31.64% respectively) than smaller-population North Carolina. The rate isolates which states have a disproportionately severe disability burden among their veteran population, rather than which states simply have more veterans.

## 2. Nearly 4 in 10 recipients are 65 or older
Nationally, **37.8%** of disability compensation recipients fall in the 65+ age group (2,364,269 veterans) - the largest of the three age bands, ahead of 45-64 (33.3%, 2,081,720) and 17-44 (28.8%, 1,799,602).

This skew toward older recipients likely reflects both the accumulation of service-connected conditions over time and the large population of Vietnam-era and earlier veterans still receiving compensation. It's a relevant data point for understanding future demand on the VA compensation system as this cohort ages further.

## 3. Raw county-level counts are driven by population size, not disability rate
Looking at total recipients by county (not rate), the highest counts are concentrated in large-population states - counties in California (up to 98,159 recipients), Texas (up to 95,255), and Arizona (78,855) top the list, with California and Texas appearing repeatedly in the top 20.

This is a useful contrast to finding #1: the states with the *most* recipients (CA, TX) are not the same as the states with the *highest rate* of severe (100%) disability ratings (NC, TX, NV, GA, VA) - Texas is the one state that appears prominently in both lists.

## Data quality note
An earlier version of the county-ranking query (finding #3) initially returned counties with `NULL` total_recipients at the top of the list, because PostgreSQL sorts `NULL` as the highest value by default in descending order. This was corrected by explicitly filtering out `NULL` values (`WHERE total_recipients IS NOT NULL`) before ranking. This is a reminder that the suppressed/missing data in this dataset (see README) requires deliberate handling, not just at the cleaning stage but at every analysis step downstream.
