select 
    employee_id,
    last_name,
    first_name,
    trim(concat(first_name, ' ', last_name)) as full_name,
    trim(regexp_replace(title, '\s+', ' ', 'g')) as title,
    title_of_courtesy, 
    
    birth_date, 
    TO_CHAR(birth_date, 'YYYY-MM') as birthdate_yearmonth,

    hire_date, 
    TO_CHAR(hire_date, 'YYYY-MM') as hiredate_yearmonth,

    trim(regexp_replace(address, '\s+', ' ', 'g')) as address , 
    city, 
    region, 
    
    trim(regexp_replace(postal_code, '\s+', ' ', 'g')) as postal_code,
     country, home_phone, extension, photo, 
     
     trim(regexp_replace(notes, '\s+', ' ', 'g')) as notes , 
     
     reports_to, photo_path 

from public.employees