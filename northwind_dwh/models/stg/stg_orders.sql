select 
    order_id, customer_id, employee_id, 
    order_date, 
    extract(year from order_date) as order_year,
    extract(month from order_date) as order_month,

    required_date, 
    extract(year from required_date) as required_year,
    extract(month from required_date) as required_month,

    shipped_date,
    extract(year from shipped_date) as shipped_year,
    extract(month from shipped_date) as shipped_month, 
    
    ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, 
    trim(upper(ship_country)) as ship_country
    
from public.orders