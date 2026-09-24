----------------------------------------------------------------------
-- EGID Gebäudeeingang
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
-- CHECK-ID: 022001
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_LO_LOCALITY_GROUP' name, count(1) counts from LM_LO_LOCALITY_GROUP
 union all
  select 'LM_LO_LOCALITY' name, count(1) counts from LM_LO_LOCALITY
 union all
  select 'LM_LO_LOCALITY_NAME' name, count(1) counts from LM_LO_LOCALITY_NAME
 union all
  select 'LM_LO_LOCALITY_NAME_TBL' name, count(1) counts from LM_LO_LOCALITY_NAME_TBL tab
 union all
  select 'LM_LO_NPA6' name, count(1) counts from LM_LO_NPA6
);

-- *******************************************************************
-- CHECK-ID: 022002
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_LOCALITY_GROUP tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_LOCALITY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_LOCALITY_NAME tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_LOCALITY_NAME_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_LO_NPA6 tab where tab.FID = jv.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 022003
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_LO_LOCALITY_GROUP tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_LOCALITY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_LOCALITY_NAME tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_LOCALITY_NAME_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_LO_NPA6 tab where tab.FID = uf.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 022004
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_LO_LOCALITY_BDR;
DROP TRIGGER LM_LO_LOCALITY_BIR;
DROP TRIGGER LM_LO_LOCALITY_BUR;
DROP TRIGGER LM_LO_LOCALITY_FID;
DROP TRIGGER LM_LO_LOCALITY_GROUP_FID;
DROP TRIGGER LM_LO_LOCALITY_GROUP_JAD;
DROP TRIGGER LM_LO_LOCALITY_GROUP_JAU;
DROP TRIGGER LM_LO_LOCALITY_GROUP_JBD;
DROP TRIGGER LM_LO_LOCALITY_GROUP_JBU;
DROP TRIGGER LM_LO_LOCALITY_JAD;
DROP TRIGGER LM_LO_LOCALITY_JAU;
DROP TRIGGER LM_LO_LOCALITY_JBD;
DROP TRIGGER LM_LO_LOCALITY_JBU;
DROP TRIGGER LM_LO_LOCALITY_NAMEABUS;
DROP TRIGGER LM_LO_LOCALITY_NAME_AIS;
DROP TRIGGER LM_LO_LOCALITY_NAME_AUS;
DROP TRIGGER LM_LO_LOCALITY_NAME_BIR;
DROP TRIGGER LM_LO_LOCALITY_NAME_BIS;
DROP TRIGGER LM_LO_LOCALITY_NAME_BUR;
DROP TRIGGER LM_LO_LOCALITY_NAME_FID;
DROP TRIGGER LM_LO_LOCALITY_NAME_JAD;
DROP TRIGGER LM_LO_LOCALITY_NAME_JAU;
DROP TRIGGER LM_LO_LOCALITY_NAME_JBD;
DROP TRIGGER LM_LO_LOCALITY_NAME_JBU;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_BIR;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_BUR;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_FID;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_JAD;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_JAU;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_JBD;
DROP TRIGGER LM_LO_LOCALITY_NAME_TBL_JBU;
DROP TRIGGER LM_LO_NPA6_BDR;
DROP TRIGGER LM_LO_NPA6_BIR;
DROP TRIGGER LM_LO_NPA6_BUR;
DROP TRIGGER LM_LO_NPA6_FID;
DROP TRIGGER LM_LO_NPA6_JAD;
DROP TRIGGER LM_LO_NPA6_JAU;
DROP TRIGGER LM_LO_NPA6_JBD;
DROP TRIGGER LM_LO_NPA6_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 022005
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Verschnitte entfernen (wird später wieder korrekt angelegt)
call &&mapsysname..TBIntersection.dropIntersection('NPA6/House Entrance');
call &&mapsysname..TBIntersection.dropIntersection('NPA6/House Entrance Pending');
commit;

-- Objektklassen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LO_LOCALITY_GROUP');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LO_LOCALITY');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LO_LOCALITY_NAME');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_LO_LOCALITY_NAME_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_LO_NPA6');
commit;