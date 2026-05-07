{% docs __overview__ %}
# Airstats pipeline

Welcome to the Airstats pipeline documentation. Please explore the lineage graph for a full understanding of the pipeline.

A brief explanation regarding the how the silver tables interconnect:

* silver_airports stores airport data, including the airport identification. This identification is referenced as the foreign key in the other two tables.
* silver_runways stores runway data. All runways belong to a specific airport, which can be identified via airport_ident.
* silver_airport_comments stores user comments regarding airports and runways. Similar to silver_runways, airport_ident can be used to identify the airport that the comment was made for.

{% enddocs %}