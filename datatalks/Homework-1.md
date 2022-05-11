```sql
-- Question 3. Count records

-- How many taxi trips were there on January 15?

-- Consider only trips that started on January 15.

SELECT COUNT(tpep_pickup_datetime) AS Jan15_Trips
FROM yellow_taxi_data
WHERE CAST(tpep_pickup_datetime AS date) = '2021-01-15' --tpep_pickup_datetime::date = '2021-01-15'

-- Question 4. Largest tip for each day

-- Find the largest tip for each day. On which day it was the largest tip in January?

-- Use the pick up time for your calculations.

-- (note: it's not a typo, it's "tip", not "trip")

SELECT 
DATE_TRUNC('day', tpep_pickup_datetime),
MAX(tip_amount)
FROM yellow_taxi_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- Question 5. Most popular destination

-- What was the most popular destination for passengers picked up in central park on January 14?

-- Use the pick up time for your calculations.

-- Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"

SELECT COALESCE(dzone."Zone", 'Unknown') AS dropoff_location, COUNT(*) AS TotalDrops 
FROM yellow_taxi_data AS trip
INNER JOIN taxi_zones AS pzone ON trip."PULocationID" = pzone."LocationID"
LEFT JOIN taxi_zones AS dzone ON trip."DOLocationID" = dzone."LocationID"
WHERE tpep_pickup_datetime::date = '2021-01-14'
AND pzone."Zone" ILIKE 'central park'
GROUP BY 1
ORDER BY 2 DESC

-- Question 6. Most expensive locations

-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?

-- Enter two zone names separated by a slash

-- For example:

-- "Jamaica Bay / Clinton East"

-- If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".

SELECT CONCAT(COALESCE(pzone."Zone", 'Unknown'), '/', COALESCE(dzone."Zone", 'Unknown')) AS Pickup_Dropoff, 
AVG(total_amount)
FROM yellow_taxi_data AS trips
LEFT JOIN taxi_zones AS pzone ON trips."PULocationID" = pzone."LocationID"
LEFT JOIN taxi_zones AS dzone ON trips."DOLocationID" = dzone."LocationID"
GROUP BY 1
ORDER BY 2 DESC
```
