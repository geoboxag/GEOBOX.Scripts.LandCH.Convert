----------------------------------------------------------------------
-- Projektierte Objekte bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 021801
-- Kontrolle ob es Art != BB hat
-- *******************************************************************
select * from LM_PA_SURFACE_PROJ where ID_TYPE in (1,3,10000,10001);

-- *******************************************************************
-- CHECK-ID: 021802
-- Kontrolle ob es Nummernwerte im Objektname hat
-- *******************************************************************
select * from LM_PA_OBJECT_NAME_PROJ where OBJECT_NUMBER is not NULL;

-- *******************************************************************
-- CHECK-ID: 021803
-- Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SURFACE_PROJ', 'ID_TYPE');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_OBJECT_NAME_PROJ', 'OBJECT_NUMBER');
commit;
