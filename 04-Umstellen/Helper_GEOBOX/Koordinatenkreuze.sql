----------------------------------------------------------------------
-- Koordiantenkreuze erstellen
-- Dieses Script funktiniert nur im SQLPlus direkt (!!! nicht im SQL-Sheet ausführen)
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
call job3.setjob(24);

-- Parameter min und max anpassen (jeweils gerundet auf 500m)
-- Abstände pro Massstab anpassen
-- ID 1: 1:200 >> 20
-- ID 2: 1:250 >> 25
-- ID 3: 1:500 >> 50
-- ID 4: 1:1'000 >> 100
-- ID 5: 1:2'000 >> 200
-- ID 6: 1:2'500 >> 250
-- ID 7: 1:5'000 >> 500

INSERT INTO LM_AD_COORDINATE_CRUX ( ID_PLAN_SCALE, GEOM)
WITH params AS (
    SELECT 
        2580000 AS min_x, 2600000 AS max_x, 
        1220000 AS min_y, 1230000 AS max_y,
        500 AS step -- Massstab
    FROM dual
),
x_coords AS (
    SELECT 
        min_x + (level - 1) * step AS x
    FROM 
        params
    CONNECT BY 
        level <= ((max_x - min_x) / step) + 1
),
y_coords AS (
    SELECT 
        min_y + (level - 1) * step AS y
    FROM 
        params
    CONNECT BY 
        level <= ((max_y - min_y) / step) + 1
)
SELECT 
	7 AS ID_PLAN_SCALE, -- ID_PLAN_SCALE
    SDO_GEOMETRY(
        2001,       -- 2D Point type
        2056,       -- SRID
        SDO_POINT_TYPE(x.x, y.y, NULL),
        NULL,
        NULL
    ) AS geom
FROM 
    x_coords x
CROSS JOIN 
    y_coords y;