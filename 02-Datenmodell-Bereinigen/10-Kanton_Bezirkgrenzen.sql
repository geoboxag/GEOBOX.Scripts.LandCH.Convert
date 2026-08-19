----------------------------------------------------------------------
-- Kantons- und Bezirkgrenzen Toplogie entfernen
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
-- CHECK-ID: 021001
-- TB-Dictionary anpassen
-- *******************************************************************
update TB_DICTIONARY set PARENT_F_CLASS_ID = NULL where F_CLASS_NAME = 'LM_AD_CANTON_BOUNDARY_L';
update TB_DICTIONARY set PARENT_F_CLASS_ID = NULL where F_CLASS_NAME = 'LM_AD_DISTRICT_BOUNDARY_L';
commit;

-- *******************************************************************
-- CHECK-ID: 021002
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_AD_CANTON_BOUNDARY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CANTON_TCEN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CANTON_TEDG tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CANTON_TISL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CANTON_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CANTON_TSUR tab where tab.FID = jv.FID);

delete from TB_JOB_VERSION jv where EXISTS (select * from LM_AD_DISTRICT_BOUNDARY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_DISTRICT_TCEN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_DISTRICT_TEDG tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_DISTRICT_TISL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_DISTRICT_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_DISTRICT_TSUR tab where tab.FID = jv.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 021003
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_AD_CANTON_BOUNDARY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CANTON_TCEN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CANTON_TEDG tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CANTON_TISL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CANTON_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CANTON_TSUR tab where tab.FID = uf.FID);

delete TB_UFID uf where EXISTS (select 1 from LM_AD_DISTRICT_BOUNDARY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_DISTRICT_TCEN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_DISTRICT_TEDG tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_DISTRICT_TISL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_DISTRICT_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_DISTRICT_TSUR tab where tab.FID = uf.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 021004
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_AD_CANTON_BOUNDARY_BDR;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_BIR;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_BUR;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_FID;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_JAD;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_JAU;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_JBD;
DROP TRIGGER LM_AD_CANTON_BOUNDARY_JBU;

DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_BDR;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_BIR;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_BUR;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_FID;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_JAD;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_JAU;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_JBD;
DROP TRIGGER LM_AD_DISTRICT_BOUNDARY_JBU;

DROP TRIGGER LM_CANTON_TCEN_FID;
DROP TRIGGER LM_CANTON_TCEN_JAD;
DROP TRIGGER LM_CANTON_TCEN_JAU;
DROP TRIGGER LM_CANTON_TCEN_JBD;
DROP TRIGGER LM_CANTON_TCEN_JBU;
DROP TRIGGER LM_CANTON_TEDG_FID;
DROP TRIGGER LM_CANTON_TEDG_JAD;
DROP TRIGGER LM_CANTON_TEDG_JAU;
DROP TRIGGER LM_CANTON_TEDG_JBD;
DROP TRIGGER LM_CANTON_TEDG_JBU;
DROP TRIGGER LM_CANTON_TISL_FID;
DROP TRIGGER LM_CANTON_TISL_JAD;
DROP TRIGGER LM_CANTON_TISL_JAU;
DROP TRIGGER LM_CANTON_TISL_JBD;
DROP TRIGGER LM_CANTON_TISL_JBU;
DROP TRIGGER LM_CANTON_TSER_FID;
DROP TRIGGER LM_CANTON_TSER_JAD;
DROP TRIGGER LM_CANTON_TSER_JAU;
DROP TRIGGER LM_CANTON_TSER_JBD;
DROP TRIGGER LM_CANTON_TSER_JBU;
DROP TRIGGER LM_CANTON_TSUR_BIR;
DROP TRIGGER LM_CANTON_TSUR_BUR;
DROP TRIGGER LM_CANTON_TSUR_FID;
DROP TRIGGER LM_CANTON_TSUR_JAD;
DROP TRIGGER LM_CANTON_TSUR_JAU;
DROP TRIGGER LM_CANTON_TSUR_JBD;
DROP TRIGGER LM_CANTON_TSUR_JBU;

DROP TRIGGER LM_DISTRICT_TCEN_FID;
DROP TRIGGER LM_DISTRICT_TCEN_JAD;
DROP TRIGGER LM_DISTRICT_TCEN_JAU;
DROP TRIGGER LM_DISTRICT_TCEN_JBD;
DROP TRIGGER LM_DISTRICT_TCEN_JBU;
DROP TRIGGER LM_DISTRICT_TEDG_FID;
DROP TRIGGER LM_DISTRICT_TEDG_JAD;
DROP TRIGGER LM_DISTRICT_TEDG_JAU;
DROP TRIGGER LM_DISTRICT_TEDG_JBD;
DROP TRIGGER LM_DISTRICT_TEDG_JBU;
DROP TRIGGER LM_DISTRICT_TISL_FID;
DROP TRIGGER LM_DISTRICT_TISL_JAD;
DROP TRIGGER LM_DISTRICT_TISL_JAU;
DROP TRIGGER LM_DISTRICT_TISL_JBD;
DROP TRIGGER LM_DISTRICT_TISL_JBU;
DROP TRIGGER LM_DISTRICT_TSER_FID;
DROP TRIGGER LM_DISTRICT_TSER_JAD;
DROP TRIGGER LM_DISTRICT_TSER_JAU;
DROP TRIGGER LM_DISTRICT_TSER_JBD;
DROP TRIGGER LM_DISTRICT_TSER_JBU;
DROP TRIGGER LM_DISTRICT_TSUR_BIR;
DROP TRIGGER LM_DISTRICT_TSUR_BUR;
DROP TRIGGER LM_DISTRICT_TSUR_FID;
DROP TRIGGER LM_DISTRICT_TSUR_JAD;
DROP TRIGGER LM_DISTRICT_TSUR_JAU;
DROP TRIGGER LM_DISTRICT_TSUR_JBD;
DROP TRIGGER LM_DISTRICT_TSUR_JBU;

commit;

-- *******************************************************************
-- CHECK-ID: 021005
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Topologie entfernen
delete from TB_TOPOLOGY_DEF where TOPOLOGY_ID in (select ID from TB_TOPOLOGY where NAME in ('LM_CANTON','LM_DISTRICT'));
delete from TB_TOPOLOGY where NAME in ('LM_CANTON','LM_DISTRICT');
commit;

-- Objektklassen entfernen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_AD_CANTON_BOUNDARY');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CANTON_TCEN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CANTON_TEDG');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CANTON_TISL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CANTON_TSER');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CANTON_TSUR');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_AD_DISTRICT_BOUNDARY');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_DISTRICT_TCEN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_DISTRICT_TEDG');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_DISTRICT_TISL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_DISTRICT_TSER');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_DISTRICT_TSUR');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_AD_DISTRICT_NAME_TBD');

commit;