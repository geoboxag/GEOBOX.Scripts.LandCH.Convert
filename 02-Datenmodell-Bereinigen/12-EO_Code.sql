----------------------------------------------------------------------
-- EO Code entfernen (wurde nur im Katon FR verwendet)
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
-- CHECK-ID: 021201
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_SO_CODE' name, count(1) counts from LM_SO_CODE
);

-- *******************************************************************
-- CHECK-ID: 021202
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_SO_CODE tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021203
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_SO_CODE tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021204
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_SO_CODE_FID;
commit;

-- *******************************************************************
-- CHECK-ID: 021205
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_SO_CODE');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_SO_OBJECT_NUMBER', 'FID_SO_CODE');
commit;