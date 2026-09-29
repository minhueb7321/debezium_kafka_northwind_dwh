select 
    customer_id, 
    trim(regexp_replace(company_name, '\s+', ' ', 'g')) as company_name, 
    trim(regexp_replace(contact_name, '\s+', ' ', 'g')) as contact_name,
    trim(regexp_replace(contact_title, '\s+', ' ', 'g')) as  contact_title ,
    trim(regexp_replace(address, '\s+', ' ', 'g')) as address,
    city, 
    trim(upper(region)) as region, 
    postal_code, 
    trim(upper(country)) as country, phone, fax 
    
from public.customers