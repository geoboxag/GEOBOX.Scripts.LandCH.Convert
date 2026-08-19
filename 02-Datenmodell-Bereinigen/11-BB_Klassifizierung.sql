----------------------------------------------------------------------
-- BB Klassifizierung entfernen (wurde nur im Katon FR verwendet)
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
-- CHECK-ID: 021101
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_LC_CLASSIFICATION' name, count(1) counts from LM_LC_CLASSIFICATION
 union all
  select 'LM_LC_CLASSIFICATION_PROJ' name, count(1) counts from LM_LC_CLASSIFICATION_PROJ
 union all
  select 'LM_LC_CODE' name, count(1) counts from LM_LC_CODE
);

-- *******************************************************************
-- CHECK-ID: 021102
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LC_CLASSIFICATION tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LC_CLASSIFICATION_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LC_CODE tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021103
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_LC_CLASSIFICATION tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LC_CLASSIFICATION_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LC_CODE tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021104
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_LC_CLASSIFICATION_FID;
DROP TRIGGER LM_LC_CLASSIFICATION_JAD;
DROP TRIGGER LM_LC_CLASSIFICATION_JAU;
DROP TRIGGER LM_LC_CLASSIFICATION_JBD;
DROP TRIGGER LM_LC_CLASSIFICATION_JBU;

DROP TRIGGER LM_LC_CLASSIFICATION_PROJ_FID;
DROP TRIGGER LM_LC_CLASSIFICATION_PROJ_JAD;
DROP TRIGGER LM_LC_CLASSIFICATION_PROJ_JAU;
DROP TRIGGER LM_LC_CLASSIFICATION_PROJ_JBD;
DROP TRIGGER LM_LC_CLASSIFICATION_PROJ_JBU;

DROP TRIGGER LM_LC_CODE_FID;
DROP TRIGGER LM_LC_CODE_JAD;
DROP TRIGGER LM_LC_CODE_JAU;
DROP TRIGGER LM_LC_CODE_JBD;
DROP TRIGGER LM_LC_CODE_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 021105
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LC_CLASSIFICATION');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LC_CLASSIFICATION_PROJ');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LC_CODE');

commit;
