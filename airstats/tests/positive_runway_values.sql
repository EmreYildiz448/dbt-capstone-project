SELECT * FROM {{ ref('silver_runways') }}
WHERE runway_length_ft < 0
OR runway_width_ft < 0