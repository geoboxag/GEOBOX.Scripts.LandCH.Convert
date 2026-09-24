----------------------------------------------------------------------
-- Lokalisation bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 021601
-- Domainwerte anpassen
-- *******************************************************************
-- Deutsch
delete from LM_LO_NAMETYPE_TBD where ID = 5; 
update LM_LO_NAMETYPE_TBD set value = 'Benanntes Gebiet', commentary = 'BenanntesGebiet' where ID = 2;
update LM_LO_NAMETYPE_TBD set value = 'Strasse', commentary = 'Strasse' where ID = 3;
update LM_LO_NAMETYPE_TBD set value = 'Platz', commentary = 'Platz' where ID = 4;
commit;

-- *******************************************************************
-- CHECK-ID: 021602
-- Werte übertragen (DM.01 Interlis Decode)
-- *******************************************************************
update LM_LO_LOCATION set ID_NAME_TYPE = 10000 where ID_NAME_TYPE in (3,4);
update LM_LO_LOCATION set ID_NAME_TYPE = 3 where ID_NAME_TYPE in (5);
update LM_LO_LOCATION set ID_NAME_TYPE = 2 where ID_TYPE in (6) and ID_NAME_TYPE is NULL;
update LM_LO_LOCATION set ID_NAME_TYPE = 3 where ID_TYPE in (2,3,4,5,7) and ID_NAME_TYPE is NULL;
update LM_LO_LOCATION set ID_NAME_TYPE = 4 where ID_TYPE in (8) and ID_NAME_TYPE is NULL;
commit;

-- *******************************************************************
-- CHECK-ID: 021603
-- Unnötiges Attribut und Domaine entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_LO_LOCATION', 'ID_TYPE');
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_LO_STREET_CATEGORY_TBD');
commit;

-- *******************************************************************
-- CHECK-ID: 021604
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_LO_WAY' name, count(1) counts from LM_LO_WAY
 union all
  select 'LM_LO_ROAD_CLASSIFICATION' name, count(1) counts from LM_LO_ROAD_CLASSIFICATION
 union all
  select 'LM_LO_TARGET_POINT' name, count(1) counts from LM_LO_TARGET_POINT
 union all
  select 'LM_LO_TARGET_POINT_TBL' name, count(1) counts from LM_LO_TARGET_POINT_TBL
);

-- *******************************************************************
-- CHECK-ID: 021605
-- TB_JOB_VERSION und TB_UFID bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_WAY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_ROAD_CLASSIFICATION tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_TARGET_POINT tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_TARGET_POINT_TBL tab where tab.FID = jv.FID);

delete TB_UFID uf where EXISTS (select 1 from LM_LO_WAY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_ROAD_CLASSIFICATION tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_TARGET_POINT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_TARGET_POINT_TBL tab where tab.FID = uf.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 021606
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_LO_WAY_BDR;
DROP TRIGGER LM_LO_WAY_BIR;
DROP TRIGGER LM_LO_WAY_BUR;
DROP TRIGGER LM_LO_WAY_FID;
DROP TRIGGER LM_LO_WAY_JAD;
DROP TRIGGER LM_LO_WAY_JAU;
DROP TRIGGER LM_LO_WAY_JBD;
DROP TRIGGER LM_LO_WAY_JBU;

DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_BDR;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_BIR;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_BUR;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_FID;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_JAD;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_JAU;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_JBD;
DROP TRIGGER LM_LO_ROAD_CLASSIFICATION_JBU;

DROP TRIGGER LM_LO_TARGET_POINT_BDR;
DROP TRIGGER LM_LO_TARGET_POINT_BIR;
DROP TRIGGER LM_LO_TARGET_POINT_BUR;
DROP TRIGGER LM_LO_TARGET_POINT_FID;
DROP TRIGGER LM_LO_TARGET_POINT_JAD;
DROP TRIGGER LM_LO_TARGET_POINT_JAU;
DROP TRIGGER LM_LO_TARGET_POINT_JBD;
DROP TRIGGER LM_LO_TARGET_POINT_JBU;

DROP TRIGGER LM_LO_TARGET_POINT_TBL_BDR;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_BIR;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_BUR;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_FID;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_JAD;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_JAU;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_JBD;
DROP TRIGGER LM_LO_TARGET_POINT_TBL_JBU;

commit;

-- *******************************************************************
-- CHECK-ID: 021607
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LO_WAY');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_LO_ROAD_CLASSIFICATION');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_LO_TARGET_POINT');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_LO_TARGET_POINT_TBL');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_LO_WAYTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_LO_STREET_CLASS_TBD');
commit;

-- *******************************************************************
-- CHECK-ID: 021608
-- Prüfen ob jedes Objekt eine passende Geometrie besitzt
-- *******************************************************************
-- Strassen ohne Geometrie
select * from
 LM_LO_LOCATION lo
where
 lo.ID_NAME_TYPE = 3
 and not exists (select 1 from LM_LO_ROAD_SECTION rs where rs.FID_LO_LOCATION = lo.FID);

-- Platz ohne Geometrie
select * from
 LM_LO_LOCATION lo
where
 lo.ID_NAME_TYPE = 4
 and not exists (select 1 from LM_LO_ROAD_SECTION rs where rs.FID_LO_LOCATION = lo.FID);

-- Platz mit falscher Geometrie
select * from
 LM_LO_LOCATION lo
where
 lo.ID_NAME_TYPE = 4
 and exists (select 1 from LM_LO_NAMED_AREA rs where rs.FID_LO_LOCATION = lo.FID);

-- Bennantes Gebiet ohne Geometrie
select * from
 LM_LO_LOCATION lo
where
 lo.ID_NAME_TYPE = 2
 and not exists (select 1 from LM_LO_NAMED_AREA rs where rs.FID_LO_LOCATION = lo.FID);

-- *******************************************************************
-- CHECK-ID: 021609
-- Prüfen ob jedes Objekte einen Wert haben.
-- *******************************************************************
-- Falls diese Prüfung NULL Datensätze zurück gibt, kann das Attribut entfernt werden.
select * from LM_LO_LOCATION where GRUDA_NUMBER is not NULL;
-- Prüft, ob es Datensätze hat, die schonen einen Wert in der LN-Nummer haben, dann können die Werte nicht von der Grunda Nummer in dieses Attrbut kopiert werden.
select * from LM_LO_LOCATION where GRUDA_NUMBER is not NULL and LOCATION_NUMBER is not NULL;

-- *******************************************************************
-- CHECK-ID: 021610
-- Schreibt die Werte von der Gruda Numer in das Attribut LN-Nummer
-- *******************************************************************
update LM_LO_LOCATION set LOCATION_NUMBER = GRUDA_NUMBER where GRUDA_NUMBER is not NULL and LOCATION_NUMBER is NULL;

-- *******************************************************************
-- CHECK-ID: 021611
-- Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_LO_LOCATION', 'GRUDA_NUMBER');
commit;
