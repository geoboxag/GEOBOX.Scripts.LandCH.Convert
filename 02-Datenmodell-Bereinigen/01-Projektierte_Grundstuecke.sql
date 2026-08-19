----------------------------------------------------------------------
-- Projektierte Grundstuecke entfernen
-- Waren für den Interlis 1 Import als temporäre Tabellen notwendig.
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
-- CHECK-ID: 020101
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_PROP_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_PROP_PROJ_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_PROP_PROJ_TBL_L tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_DPR_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_DPR_PROJ_L tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_DPR_PROJ_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_DPR_PROJ_TBL_L tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_MINE_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_MINE_PROJ_L tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_PROP_ADDRESS_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_RE_PROJ tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_RE_PROJ_L tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_RE_PROJ_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_OW_RE_PROJ_TBL_L tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020102
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_OW_PROP_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_PROP_PROJ_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_PROP_PROJ_TBL_L tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_DPR_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_DPR_PROJ_L tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_DPR_PROJ_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_DPR_PROJ_TBL_L tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_MINE_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_MINE_PROJ_L tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_PROP_ADDRESS_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_RE_PROJ tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_RE_PROJ_L tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_RE_PROJ_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_OW_RE_PROJ_TBL_L tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020103
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_OW_DPR_PROJAAUS;
DROP TRIGGER LM_OW_DPR_PROJ_ADS;
DROP TRIGGER LM_OW_DPR_PROJ_AIS;
DROP TRIGGER LM_OW_DPR_PROJ_BDR;
DROP TRIGGER LM_OW_DPR_PROJ_BDS;
DROP TRIGGER LM_OW_DPR_PROJ_BIR;
DROP TRIGGER LM_OW_DPR_PROJ_BIS;
DROP TRIGGER LM_OW_DPR_PROJ_BUR;
DROP TRIGGER LM_OW_DPR_PROJ_BUS;
DROP TRIGGER LM_OW_DPR_PROJ_FID;
DROP TRIGGER LM_OW_DPR_PROJ_JAD;
DROP TRIGGER LM_OW_DPR_PROJ_JAU;
DROP TRIGGER LM_OW_DPR_PROJ_JBD;
DROP TRIGGER LM_OW_DPR_PROJ_JBU;
DROP TRIGGER LM_OW_DPR_PROJ_L_ADR;
DROP TRIGGER LM_OW_DPR_PROJ_L_ADS;
DROP TRIGGER LM_OW_DPR_PROJ_L_AIS;
DROP TRIGGER LM_OW_DPR_PROJ_L_AUS;
DROP TRIGGER LM_OW_DPR_PROJ_L_BDR;
DROP TRIGGER LM_OW_DPR_PROJ_L_BIR;
DROP TRIGGER LM_OW_DPR_PROJ_L_BUR;
DROP TRIGGER LM_OW_DPR_PROJ_L_FID;
DROP TRIGGER LM_OW_DPR_PROJ_L_JAD;
DROP TRIGGER LM_OW_DPR_PROJ_L_JAU;
DROP TRIGGER LM_OW_DPR_PROJ_L_JBD;
DROP TRIGGER LM_OW_DPR_PROJ_L_JBU;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_BIR;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_BUR;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_FID;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_JAD;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_JAU;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_JBD;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_JBU;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_BDR;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_BIR;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_BUR;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_FID;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_JAD;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_JAU;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_JBD;
DROP TRIGGER LM_OW_DPR_PROJ_TBL_L_JBU;
DROP TRIGGER LM_OW_MINE_PROJ_ADS;
DROP TRIGGER LM_OW_MINE_PROJ_BDR;
DROP TRIGGER LM_OW_MINE_PROJ_BDS;
DROP TRIGGER LM_OW_MINE_PROJ_BIR;
DROP TRIGGER LM_OW_MINE_PROJ_BUR;
DROP TRIGGER LM_OW_MINE_PROJ_FID;
DROP TRIGGER LM_OW_MINE_PROJ_JAD;
DROP TRIGGER LM_OW_MINE_PROJ_JAU;
DROP TRIGGER LM_OW_MINE_PROJ_JBD;
DROP TRIGGER LM_OW_MINE_PROJ_JBU;
DROP TRIGGER LM_OW_MINE_PROJ_L_ADR;
DROP TRIGGER LM_OW_MINE_PROJ_L_ADS;
DROP TRIGGER LM_OW_MINE_PROJ_L_AIS;
DROP TRIGGER LM_OW_MINE_PROJ_L_AUS;
DROP TRIGGER LM_OW_MINE_PROJ_L_BDR;
DROP TRIGGER LM_OW_MINE_PROJ_L_BIR;
DROP TRIGGER LM_OW_MINE_PROJ_L_BUR;
DROP TRIGGER LM_OW_MINE_PROJ_L_FID;
DROP TRIGGER LM_OW_MINE_PROJ_L_JAD;
DROP TRIGGER LM_OW_MINE_PROJ_L_JAU;
DROP TRIGGER LM_OW_MINE_PROJ_L_JBD;
DROP TRIGGER LM_OW_MINE_PROJ_L_JBU;
DROP TRIGGER LM_OW_PROP_ADDRESS_PROJ_FID;
DROP TRIGGER LM_OW_PROP_ADDRESS_PROJ_JAD;
DROP TRIGGER LM_OW_PROP_ADDRESS_PROJ_JAU;
DROP TRIGGER LM_OW_PROP_ADDRESS_PROJ_JBD;
DROP TRIGGER LM_OW_PROP_ADDRESS_PROJ_JBU;
DROP TRIGGER LM_OW_PROP_PROJABUS;
DROP TRIGGER LM_OW_PROP_PROJ_AIS;
DROP TRIGGER LM_OW_PROP_PROJ_AUS;
DROP TRIGGER LM_OW_PROP_PROJ_BIR;
DROP TRIGGER LM_OW_PROP_PROJ_BIS;
DROP TRIGGER LM_OW_PROP_PROJ_BUR;
DROP TRIGGER LM_OW_PROP_PROJ_FID;
DROP TRIGGER LM_OW_PROP_PROJ_JAD;
DROP TRIGGER LM_OW_PROP_PROJ_JAU;
DROP TRIGGER LM_OW_PROP_PROJ_JBD;
DROP TRIGGER LM_OW_PROP_PROJ_JBU;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_BIR;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_BUR;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_FID;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_JAD;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_JAU;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_JBD;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_JBU;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_BDR;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_BIR;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_BUR;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_FID;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_JAD;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_JAU;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_JBD;
DROP TRIGGER LM_OW_PROP_PROJ_TBL_L_JBU;
DROP TRIGGER LM_OW_RE_PROJAAUS;
DROP TRIGGER LM_OW_RE_PROJ_ADS;
DROP TRIGGER LM_OW_RE_PROJ_AIS;
DROP TRIGGER LM_OW_RE_PROJ_BDR;
DROP TRIGGER LM_OW_RE_PROJ_BDS;
DROP TRIGGER LM_OW_RE_PROJ_BIR;
DROP TRIGGER LM_OW_RE_PROJ_BIS;
DROP TRIGGER LM_OW_RE_PROJ_BUR;
DROP TRIGGER LM_OW_RE_PROJ_BUS;
DROP TRIGGER LM_OW_RE_PROJ_FID;
DROP TRIGGER LM_OW_RE_PROJ_JAD;
DROP TRIGGER LM_OW_RE_PROJ_JAU;
DROP TRIGGER LM_OW_RE_PROJ_JBD;
DROP TRIGGER LM_OW_RE_PROJ_JBU;
DROP TRIGGER LM_OW_RE_PROJ_L_ADR;
DROP TRIGGER LM_OW_RE_PROJ_L_ADS;
DROP TRIGGER LM_OW_RE_PROJ_L_AIS;
DROP TRIGGER LM_OW_RE_PROJ_L_AUS;
DROP TRIGGER LM_OW_RE_PROJ_L_BDR;
DROP TRIGGER LM_OW_RE_PROJ_L_BIR;
DROP TRIGGER LM_OW_RE_PROJ_L_BUR;
DROP TRIGGER LM_OW_RE_PROJ_L_FID;
DROP TRIGGER LM_OW_RE_PROJ_L_JAD;
DROP TRIGGER LM_OW_RE_PROJ_L_JAU;
DROP TRIGGER LM_OW_RE_PROJ_L_JBD;
DROP TRIGGER LM_OW_RE_PROJ_L_JBU;
DROP TRIGGER LM_OW_RE_PROJ_TBL_BIR;
DROP TRIGGER LM_OW_RE_PROJ_TBL_BUR;
DROP TRIGGER LM_OW_RE_PROJ_TBL_FID;
DROP TRIGGER LM_OW_RE_PROJ_TBL_JAD;
DROP TRIGGER LM_OW_RE_PROJ_TBL_JAU;
DROP TRIGGER LM_OW_RE_PROJ_TBL_JBD;
DROP TRIGGER LM_OW_RE_PROJ_TBL_JBU;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_BDR;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_BIR;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_BUR;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_FID;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_JAD;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_JAU;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_JBD;
DROP TRIGGER LM_OW_RE_PROJ_TBL_L_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 020102
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_PROP_PROJ');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_OW_PROP_PROJ_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_PROP_PROJ_TBL_L');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_DPR_PROJ');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_DPR_PROJ_L');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_OW_DPR_PROJ_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_DPR_PROJ_TBL_L');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_MINE_PROJ');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_MINE_PROJ_L');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_PROP_ADDRESS_PROJ');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_RE_PROJ');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_RE_PROJ_L');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_OW_RE_PROJ_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_OW_RE_PROJ_TBL_L');

commit;