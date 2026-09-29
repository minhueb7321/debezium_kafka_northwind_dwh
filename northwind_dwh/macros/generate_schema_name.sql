{% macro generate_schema_name(custom_schema_name, node) %}

    {% set folder = node.fqn[1] %}

    {% if folder == 'stg' %}
        stg

    {% elif folder == 'int' %}
        int

    {% elif folder == 'mart' %}
        mart

    {% else %}
        {{ target.schema }}
    {% endif %}

{% endmacro %}