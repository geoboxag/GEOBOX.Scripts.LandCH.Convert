----------------------------------------------------------------------
-- Planeinteilung entfernen
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
-- CHECK-ID: 021401
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_PL_PLAN' name, count(1) counts from LM_PL_PLAN
 union all
  select 'LM_PL_PLAN_TBL' name, count(1) counts from LM_PL_PLAN_TBL
 union all
  select 'LM_PL_PLAN_GEOMETRY' name, count(1) counts from LM_PL_PLAN_GEOMETRY
 union all
  select 'LM_PL_PLAN_GEOMETRY_L' name, count(1) counts from LM_PL_PLAN_GEOMETRY_L tab
);

-- *******************************************************************
-- CHECK-ID: 021402
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PL_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PL_PLAN_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PL_PLAN_GEOMETRY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PL_PLAN_GEOMETRY_L tab where tab.FID = jv.FID);
-- Topologie
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PLAN_TCEN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PLAN_TEDG tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PLAN_TISL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PLAN_TSUR tab where tab.FID = jv.FID);
-- Verschnitte
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_DPR_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_DPR_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_MINE_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_MINE_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_ESTATE_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IS_ESTATE_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_DPR_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_DPR_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_MINE_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_MINE_PLAN_TSER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_ESTATE_PLAN tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_IP_ESTATE_PLAN_TSER tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021403
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_PL_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PL_PLAN_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PL_PLAN_GEOMETRY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PL_PLAN_GEOMETRY_L tab where tab.FID = uf.FID);
-- Topologie
delete TB_UFID uf where EXISTS (select 1 from LM_PLAN_TCEN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PLAN_TEDG tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PLAN_TISL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PLAN_TSUR tab where tab.FID = uf.FID);
-- Verschnitte
delete TB_UFID uf where EXISTS (select 1 from LM_IS_DPR_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IS_DPR_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IS_MINE_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IS_MINE_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IS_ESTATE_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IS_ESTATE_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_DPR_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_DPR_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_MINE_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_MINE_PLAN_TSER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_ESTATE_PLAN tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_IP_ESTATE_PLAN_TSER tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021404
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_PLAN_TCEN_FID;
DROP TRIGGER LM_PLAN_TCEN_JAD;
DROP TRIGGER LM_PLAN_TCEN_JAU;
DROP TRIGGER LM_PLAN_TCEN_JBD;
DROP TRIGGER LM_PLAN_TCEN_JBU;
DROP TRIGGER LM_PLAN_TEDG_FID;
DROP TRIGGER LM_PLAN_TEDG_JAD;
DROP TRIGGER LM_PLAN_TEDG_JAU;
DROP TRIGGER LM_PLAN_TEDG_JBD;
DROP TRIGGER LM_PLAN_TEDG_JBU;
DROP TRIGGER LM_PLAN_TISL_FID;
DROP TRIGGER LM_PLAN_TISL_JAD;
DROP TRIGGER LM_PLAN_TISL_JAU;
DROP TRIGGER LM_PLAN_TISL_JBD;
DROP TRIGGER LM_PLAN_TISL_JBU;
DROP TRIGGER LM_PLAN_TSER_FID;
DROP TRIGGER LM_PLAN_TSER_JAD;
DROP TRIGGER LM_PLAN_TSER_JAU;
DROP TRIGGER LM_PLAN_TSER_JBD;
DROP TRIGGER LM_PLAN_TSER_JBU;
DROP TRIGGER LM_PLAN_TSUR_BIR;
DROP TRIGGER LM_PLAN_TSUR_BUR;
DROP TRIGGER LM_PLAN_TSUR_FID;
DROP TRIGGER LM_PLAN_TSUR_JAD;
DROP TRIGGER LM_PLAN_TSUR_JAU;
DROP TRIGGER LM_PLAN_TSUR_JBD;
DROP TRIGGER LM_PLAN_TSUR_JBU;
DROP TRIGGER LM_PL_PLANABUS;
DROP TRIGGER LM_PL_PLAN_AIS;
DROP TRIGGER LM_PL_PLAN_AUS;
DROP TRIGGER LM_PL_PLAN_BIR;
DROP TRIGGER LM_PL_PLAN_BIS;
DROP TRIGGER LM_PL_PLAN_BUR;
DROP TRIGGER LM_PL_PLAN_FID;
DROP TRIGGER LM_PL_PLAN_GEOMETRY_BDR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_BIR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_BUR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_FID; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_JAD; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_JAU; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_JBD; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_JBU; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_BDR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_BIR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_BUR; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_FID; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_JAD; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_JAU; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_JBD; 
DROP TRIGGER LM_PL_PLAN_GEOMETRY_L_JBU; 
DROP TRIGGER LM_PL_PLAN_JAD;
DROP TRIGGER LM_PL_PLAN_JAU;
DROP TRIGGER LM_PL_PLAN_JBD;
DROP TRIGGER LM_PL_PLAN_JBU;
DROP TRIGGER LM_PL_PLAN_TBL_BIR;
DROP TRIGGER LM_PL_PLAN_TBL_BUR;
DROP TRIGGER LM_PL_PLAN_TBL_FID;
DROP TRIGGER LM_PL_PLAN_TBL_JAD;
DROP TRIGGER LM_PL_PLAN_TBL_JAU;
DROP TRIGGER LM_PL_PLAN_TBL_JBD;
DROP TRIGGER LM_PL_PLAN_TBL_JBU;

DROP TRIGGER LM_IS_DPR_PLAN_ADR; 
DROP TRIGGER LM_IS_DPR_PLAN_BIR; 
DROP TRIGGER LM_IS_DPR_PLAN_BUR; 
DROP TRIGGER LM_IS_DPR_PLAN_FID; 
DROP TRIGGER LM_IS_DPR_PLAN_TSER_BIR;
DROP TRIGGER LM_IS_DPR_PLAN_TSER_BUR;
DROP TRIGGER LM_IS_DPR_PLAN_TSER_FID;
DROP TRIGGER LM_IS_ESTATE_PLAN_ADR;
DROP TRIGGER LM_IS_ESTATE_PLAN_BIR;
DROP TRIGGER LM_IS_ESTATE_PLAN_BUR;
DROP TRIGGER LM_IS_ESTATE_PLAN_FID;
DROP TRIGGER LM_IS_ESTATE_PLAN_TSER_BIR; 
DROP TRIGGER LM_IS_ESTATE_PLAN_TSER_BUR; 
DROP TRIGGER LM_IS_ESTATE_PLAN_TSER_FID; 
DROP TRIGGER LM_IS_MINE_PLAN_ADR;
DROP TRIGGER LM_IS_MINE_PLAN_BIR;
DROP TRIGGER LM_IS_MINE_PLAN_BUR;
DROP TRIGGER LM_IS_MINE_PLAN_FID;
DROP TRIGGER LM_IS_MINE_PLAN_TSER_BIR; 
DROP TRIGGER LM_IS_MINE_PLAN_TSER_BUR; 
DROP TRIGGER LM_IS_MINE_PLAN_TSER_FID; 

DROP TRIGGER LM_IP_DPR_PLAN_ADR; 
DROP TRIGGER LM_IP_DPR_PLAN_BIR; 
DROP TRIGGER LM_IP_DPR_PLAN_BUR; 
DROP TRIGGER LM_IP_DPR_PLAN_FID; 
DROP TRIGGER LM_IP_DPR_PLAN_TSER_BIR;
DROP TRIGGER LM_IP_DPR_PLAN_TSER_BUR;
DROP TRIGGER LM_IP_DPR_PLAN_TSER_FID;
DROP TRIGGER LM_IP_ESTATE_PLAN_ADR;
DROP TRIGGER LM_IP_ESTATE_PLAN_BIR;
DROP TRIGGER LM_IP_ESTATE_PLAN_BUR;
DROP TRIGGER LM_IP_ESTATE_PLAN_FID;
DROP TRIGGER LM_IP_ESTATE_PLAN_TSER_BIR; 
DROP TRIGGER LM_IP_ESTATE_PLAN_TSER_BUR; 
DROP TRIGGER LM_IP_ESTATE_PLAN_TSER_FID; 
DROP TRIGGER LM_IP_MINE_PLAN_ADR;
DROP TRIGGER LM_IP_MINE_PLAN_BIR;
DROP TRIGGER LM_IP_MINE_PLAN_BUR;
DROP TRIGGER LM_IP_MINE_PLAN_FID;
DROP TRIGGER LM_IP_MINE_PLAN_TSER_BIR; 
DROP TRIGGER LM_IP_MINE_PLAN_TSER_BUR; 
DROP TRIGGER LM_IP_MINE_PLAN_TSER_FID; 
commit;

-- *******************************************************************
-- CHECK-ID: 021405
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Verschnitte
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_DPR_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_DPR_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('DPR/PLAN');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_MINE_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_MINE_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('MINE/PLAN');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_ESTATE_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IS_ESTATE_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('REAL ESTATE/PLAN');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_DPR_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_DPR_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('DPR/PLAN PENDING');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_MINE_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_MINE_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('MINE/PLAN PENDING');

call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_ESTATE_PLAN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_IP_ESTATE_PLAN_TSER');
call &&mapsysname..Topic.DropTopic('REAL ESTATE/PLAN PENDING');
commit;

delete from TB_INTERSECTION where upper(NAME) in ('DPR/PLAN', 'DPR/PLAN PENDING', 'MINE/PLAN', 'MINE/PLAN PENDING', 'REAL ESTATE/PLAN', 'REAL ESTATE/PLAN PENDING');
commit;

-- Topologie entfernen
delete from TB_TOPOLOGY_DEF where TOPOLOGY_ID in (select ID from TB_TOPOLOGY where NAME in ('LM_PLAN'));
delete from TB_TOPOLOGY where NAME in ('LM_PLAN');
commit;

call &&mapsysname..FeatureClass.dropFeatureClass('LM_PLAN_TCEN');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PLAN_TEDG');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PLAN_TISL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PLAN_TSER');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PLAN_TSUR');
commit;

-- Objektklassen entfernen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PL_PLAN_GEOMETRY_L');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PL_PLAN_GEOMETRY');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PL_PLAN_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PL_PLAN');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_PL_CROSSHAIRTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_DESCRIPTIONTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_ISLAND_TYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_LAYOUTTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_LINETYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_PLAN_SCALE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_PLOTTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_PL_SURVEYOR_NAME_TBD');

-- Datenmodell-Topic entfernen
call &&mapsysname..Topic.DropTopic('LM_PLAN_REPARTITION');
commit;

-- Positionssuche / Objektsuche entfernen
delete from TB_POSITION_FINDER where ID = 6004;
commit;