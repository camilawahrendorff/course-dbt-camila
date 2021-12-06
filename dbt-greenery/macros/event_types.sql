​​{% macro event_types(event_type) %}

   SUM(CASE WHEN event_type = '{{ event_type }}' THEN 1 ELSE 0 END)    AS  {{ event_type }}

{% endmacro %}