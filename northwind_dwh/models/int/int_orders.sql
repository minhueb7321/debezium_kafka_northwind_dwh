{{ config(
    materialized='incremental',
    unique_key=['order_id', 'product_id'],
    incremental_strategy='delete+insert'
) }}

SELECT

    -- ID
    a.order_id,
    a.customer_id,
    cus.company_name as customer_name,
    cus.contact_name as customer_contactname,
    cus.contact_title as customer_contacttitle,
    cus.city as city,
    cus.region as region,
    cus.country,

    a.employee_id,
    emp.full_name,
    emp.title,



    b.product_id,
    c.product_name,
    c.supplier_id,
    e.company_name as supplier_name,
    c.category_id,
    d.category_name,
    c.discontinued,

    -- DATE
    a.order_date,
    EXTRACT(YEAR FROM a.order_date)::INT AS order_year,
    EXTRACT(MONTH FROM a.order_date)::INT AS order_month,

    a.required_date,
    EXTRACT(YEAR FROM a.required_date)::INT AS required_year,
    EXTRACT(MONTH FROM a.required_date)::INT AS required_month,

    a.shipped_date,
    EXTRACT(YEAR FROM a.shipped_date)::INT AS shipped_year,
    EXTRACT(MONTH FROM a.shipped_date)::INT AS shipped_month,

    a.ship_via,

    -- KPI
    a.freight,
    b.unit_price,
    b.quantity,
    b.discount,

    round((b.unit_price * b.quantity)::NUMERIC,0) AS gross_revenue,

    round((b.unit_price * b.quantity * b.discount)::NUMERIC,0) AS discount_amount,

    round((b.unit_price * b.quantity * (1 - b.discount))::NUMERIC,0) AS net_revenue,

    -- SHIPPING
    a.ship_name,
    a.ship_address,
    a.ship_city,
    a.ship_region,
    a.ship_postal_code,
    a.ship_country

FROM 
    {{ ref('stg_orders') }} a 
     JOIN 
    {{ ref('stg_order_details') }} b on a.order_id = b.order_id
     JOIN 
    {{ ref('stg_products') }} c on b.product_id = c.product_id
     JOIN 
    {{ ref('stg_categories') }} d on c.category_id = d.category_id
    JOIN
    {{ ref('stg_suppliers') }} e on c.supplier_id = e.supplier_id
    JOIN
    {{ ref('stg_employees') }} emp on a.employee_id = emp.employee_id
    JOIN 
    {{ ref('stg_customers') }} cus on a.customer_id = cus.customer_id


{% if is_incremental() %}

WHERE a.order_date >= DATE_TRUNC(
    'month',
    (
        SELECT MAX(order_date)
        FROM {{ this }}
    ) - INTERVAL '2 months'
)

{% endif %}