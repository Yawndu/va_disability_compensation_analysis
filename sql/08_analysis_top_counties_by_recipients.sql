select state county_name, total_recipients 
from veterans_disability 
where total_recipients is not null
order by total_recipients desc
limit 20;