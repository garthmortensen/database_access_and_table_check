# database access and table check

This is a database agnostic approach to checking if you can access all required databases and table/views. You define requirements in the .yaml, and the py cost tests everything defined therein. It does for me, at least.

## output

``` bash
+++
database type: sqllite
connection string: sqlite:///standup_db/costs.db
Connected to sqllite database.
---
Access PASSED for: concrete_projected (table for projected concrete costs)
Access PASSED for: steel_projected (table for projected steel costs)
Access PASSED for: shingles_projected (table for projected shingle costs)
+++
database type: None
connection string: None
Failed to connect to None database: Expected string or URL object, got None
---
```

