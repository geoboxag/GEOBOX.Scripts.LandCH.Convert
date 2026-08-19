----------------------------------------------------------------------
-- EGID Gebäudeeingang
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [17.04.2026] V 2025.12 / GEOBOX AG (USO) - Anpassungen an DMAV Version 1.1
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 021901
-- Prüfen
-- *******************************************************************
-- Prüfen ob beide Werte übereinstimmen
select * from LM_BU_HOUSE_ENTRANCE en where exists (select 1 from LM_BU_BUILDING bu where bu.FID = en.FID_BU_BUILDING and bu.REGBL_EGID != en.REGBL_EGID and bu.REGBL_EGID is not NULL) and en.REGBL_EGID is not NULL;
-- wenn nicht ist dies von Hand zur Prüfen und korrigieren.
select * from LM_BU_BUILDING bu where exists (select 1 from LM_BU_HOUSE_ENTRANCE en where bu.FID = en.FID_BU_BUILDING and en.REGBL_EGID is not NULL) and bu.REGBL_EGID is NULL;

-- *******************************************************************
-- CHECK-ID: 021902
-- Update der Werte
-- *******************************************************************
update LM_BU_BUILDING bu set bu.REGBL_EGID = 
 (select max(en.REGBL_EGID) from LM_BU_HOUSE_ENTRANCE en where bu.FID = en.FID_BU_BUILDING and en.REGBL_EGID is not NULL) 
where bu.REGBL_EGID is NULL;

-- *******************************************************************
-- CHECK-ID: 021903
-- Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_HOUSE_ENTRANCE', 'REGBL_EGID');
commit;

-- *******************************************************************
-- CHECK-ID: 021904
-- Adressformat - Unnötiges Attribut entfernen
-- *******************************************************************
-- Prüfen ob es Werte hat (Optional)
-- select * from LM_BU_HOUSE_ENTRANCE where ADDRESS_CODE is not NULL;
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_HOUSE_ENTRANCE', 'ADDRESS_CODE');
commit;

-- *******************************************************************
-- CHECK-ID: 021905
-- Polizeinummer - Prüfen
-- *******************************************************************
-- Prüfen ob das Attribut leer ist (wenn ja, kann direkt mit dem Entfernen weitergemacht werden)
select count(1) from LM_BU_HOUSE_ENTRANCE where POLICE_NUMBER is not NULL;
-- Prüfen ob beide Werte übereinstimmen (wenn keine Datensätze angezeigt werden, kann direkt mit dem Entfernen weitergefahren werden)
select FID, JOB_VERSION, POLICE_NUMBER, HOUSE_NUMBER from LM_BU_HOUSE_ENTRANCE where POLICE_NUMBER is not NULL and POLICE_NUMBER != HOUSE_NUMBER;
-- sonst die Werte beurteilen und in das Attribut HOUSE_NUMBER übertragen
-- update LM_BU_HOUSE_ENTRANCE set HOUSE_NUMBER =POLICE_NUMBER where POLICE_NUMBER is not NULL and POLICE_NUMBER != HOUSE_NUMBER and HOUSE_NUMBER is NULL;

-- *******************************************************************
-- CHECK-ID: 021906
-- Polizeinummer - Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_HOUSE_ENTRANCE', 'POLICE_NUMBER');
commit;

-- *******************************************************************
-- CHECK-ID: 021907
-- ID-Typen Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_BUILDING_INSURANCE', 'ID_BUILDING_TYPE_1');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_BUILDING_INSURANCE', 'ID_BUILDING_TYPE_2');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_BUILDING_INSURANCE', 'ID_BUILDING_TYPE_3');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_BUILDING_INSURANCE', 'ID_BUILDING_TYPE_4');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_BUILDING_INSURANCE', 'ID_BUILDING_TYPE_5');
commit;

-- *******************************************************************
-- CHECK-ID: 021908
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_BU_BUILDING_CATEGORY_TBD');
commit;