----------------------------------------------------------------------
-- Grenzpunkte bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [23.09.2026] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);


-- *******************************************************************
-- CHECK-ID: 022701
-- Prüfen, ob es Objekte mit einen Wert gibt
-- *******************************************************************
select name, counts from (
  select 'CANTON_POINT' name, count(1) counts from LM_OW_BOUNDARYPOINT where CANTON_POINT is not NULL
 union all
  select 'DISTRICT_POINT' name, count(1) counts from LM_OW_BOUNDARYPOINT where DISTRICT_POINT is not NULL
 union all
  select 'DISPLAY' name, count(1) counts from LM_OW_BOUNDARYPOINT where DISPLAY is not NULL
 union all
  select 'VALUE' name, count(1) counts from LM_OW_BOUNDARYPOINT where VALUE is not NULL
 union all
  select 'VALUE_2' name, count(1) counts from LM_OW_BOUNDARYPOINT where VALUE_2 is not NULL
 union all
  select 'MUTATION_NUMBER' name, count(1) counts from LM_OW_BOUNDARYPOINT where MUTATION_NUMBER is not NULL
);

-- *******************************************************************
-- CHECK-ID: 022702
-- Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'CANTON_POINT');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'DISTRICT_POINT');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'DISPLAY');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'VALUE');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'VALUE_2');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_OW_BOUNDARYPOINT', 'MUTATION_NUMBER');
commit;
