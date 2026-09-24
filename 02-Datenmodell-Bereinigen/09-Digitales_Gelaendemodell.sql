----------------------------------------------------------------------
-- Digitales Geländemodell behandeln
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
-- CHECK-ID: 020901
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_CO_CONS_LINE' name, count(1) counts from LM_CO_CONS_LINE
 union all
  select 'LM_CO_CONS_LINE_TBL' name, count(1) counts from LM_CO_CONS_LINE_TBL
 union all
  select 'LM_CO_CONS_POINT' name, count(1) counts from LM_CO_CONS_POINT
 union all
  select 'LM_CO_CONS_POINT_TBL' name, count(1) counts from LM_CO_CONS_POINT_TBL tab
 union all
  select 'LM_CO_DTM_EDGE' name, count(1) counts from LM_CO_DTM_EDGE
 union all
  select 'LM_CO_DTM_EDGE_TBL' name, count(1) counts from LM_CO_DTM_EDGE_TBL tab
 union all
  select 'LM_CO_DTM_POINT' name, count(1) counts from LM_CO_DTM_POINT tab
 union all
  select 'LM_CO_DTM_POINT_TBL' name, count(1) counts from LM_CO_DTM_POINT_TBL tab
);

-- *******************************************************************
-- CHECK-ID: 020902
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_CONS_LINE tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_CONS_LINE_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_CONS_POINT tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_CONS_POINT_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_DTM_EDGE tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_DTM_EDGE_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_DTM_POINT tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CO_DTM_POINT_TBL tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020903
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_CO_CONS_LINE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_CONS_LINE_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_CONS_POINT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_CONS_POINT_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_DTM_EDGE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_DTM_EDGE_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_DTM_POINT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_CO_DTM_POINT_TBL tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020904
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_CO_CONS_LINEABUS;
DROP TRIGGER LM_CO_CONS_LINE_AIS;
DROP TRIGGER LM_CO_CONS_LINE_AUS;
DROP TRIGGER LM_CO_CONS_LINE_BDR;
DROP TRIGGER LM_CO_CONS_LINE_BIR;
DROP TRIGGER LM_CO_CONS_LINE_BIS;
DROP TRIGGER LM_CO_CONS_LINE_BUR;
DROP TRIGGER LM_CO_CONS_LINE_FID;
DROP TRIGGER LM_CO_CONS_LINE_JAD;
DROP TRIGGER LM_CO_CONS_LINE_JAU;
DROP TRIGGER LM_CO_CONS_LINE_JBD;
DROP TRIGGER LM_CO_CONS_LINE_JBU;

DROP TRIGGER LM_CO_CONS_LINE_TBL_BIR;
DROP TRIGGER LM_CO_CONS_LINE_TBL_BUR;
DROP TRIGGER LM_CO_CONS_LINE_TBL_FID;
DROP TRIGGER LM_CO_CONS_LINE_TBL_JAD;
DROP TRIGGER LM_CO_CONS_LINE_TBL_JAU;
DROP TRIGGER LM_CO_CONS_LINE_TBL_JBD;
DROP TRIGGER LM_CO_CONS_LINE_TBL_JBU;

DROP TRIGGER LM_CO_CONS_POINTABUS;
DROP TRIGGER LM_CO_CONS_POINT_AIS;
DROP TRIGGER LM_CO_CONS_POINT_AUS;
DROP TRIGGER LM_CO_CONS_POINT_BDR;
DROP TRIGGER LM_CO_CONS_POINT_BIR;
DROP TRIGGER LM_CO_CONS_POINT_BIS;
DROP TRIGGER LM_CO_CONS_POINT_BUR;
DROP TRIGGER LM_CO_CONS_POINT_FID;
DROP TRIGGER LM_CO_CONS_POINT_JAD;
DROP TRIGGER LM_CO_CONS_POINT_JAU;
DROP TRIGGER LM_CO_CONS_POINT_JBD;
DROP TRIGGER LM_CO_CONS_POINT_JBU;

DROP TRIGGER LM_CO_CONS_POINT_TBL_BIR;
DROP TRIGGER LM_CO_CONS_POINT_TBL_BUR;
DROP TRIGGER LM_CO_CONS_POINT_TBL_FID;
DROP TRIGGER LM_CO_CONS_POINT_TBL_JAD;
DROP TRIGGER LM_CO_CONS_POINT_TBL_JAU;
DROP TRIGGER LM_CO_CONS_POINT_TBL_JBD;
DROP TRIGGER LM_CO_CONS_POINT_TBL_JBU;

DROP TRIGGER LM_CO_DTM_EDGEABUS;
DROP TRIGGER LM_CO_DTM_EDGE_AIS;
DROP TRIGGER LM_CO_DTM_EDGE_AUS;
DROP TRIGGER LM_CO_DTM_EDGE_BDR;
DROP TRIGGER LM_CO_DTM_EDGE_BIR;
DROP TRIGGER LM_CO_DTM_EDGE_BIS;
DROP TRIGGER LM_CO_DTM_EDGE_BUR;
DROP TRIGGER LM_CO_DTM_EDGE_FID;
DROP TRIGGER LM_CO_DTM_EDGE_JAD;
DROP TRIGGER LM_CO_DTM_EDGE_JAU;
DROP TRIGGER LM_CO_DTM_EDGE_JBD;
DROP TRIGGER LM_CO_DTM_EDGE_JBU;

DROP TRIGGER LM_CO_DTM_EDGE_TBL_BIR;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_BUR;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_FID;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_JAD;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_JAU;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_JBD;
DROP TRIGGER LM_CO_DTM_EDGE_TBL_JBU;

DROP TRIGGER LM_CO_DTM_POINTABUS;
DROP TRIGGER LM_CO_DTM_POINT_AIS;
DROP TRIGGER LM_CO_DTM_POINT_AUS;
DROP TRIGGER LM_CO_DTM_POINT_BDR;
DROP TRIGGER LM_CO_DTM_POINT_BIR;
DROP TRIGGER LM_CO_DTM_POINT_BIS;
DROP TRIGGER LM_CO_DTM_POINT_BUR;
DROP TRIGGER LM_CO_DTM_POINT_FID;
DROP TRIGGER LM_CO_DTM_POINT_JAD;
DROP TRIGGER LM_CO_DTM_POINT_JAU;
DROP TRIGGER LM_CO_DTM_POINT_JBD;
DROP TRIGGER LM_CO_DTM_POINT_JBU;

DROP TRIGGER LM_CO_DTM_POINT_TBL_BIR;
DROP TRIGGER LM_CO_DTM_POINT_TBL_BUR;
DROP TRIGGER LM_CO_DTM_POINT_TBL_FID;
DROP TRIGGER LM_CO_DTM_POINT_TBL_JAD;
DROP TRIGGER LM_CO_DTM_POINT_TBL_JAU;
DROP TRIGGER LM_CO_DTM_POINT_TBL_JBD;
DROP TRIGGER LM_CO_DTM_POINT_TBL_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 020905
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CO_CONS_LINE');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_CO_CONS_LINE_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CO_CONS_POINT');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_CO_CONS_POINT_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CO_DTM_EDGE');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_CO_DTM_EDGE_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CO_DTM_POINT');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_CO_DTM_POINT_TBL');

-- Topic
call &&mapsysname..Topic.DropTopic('LM_CONSTRUCTION');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_CO_CONS_LINETYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_CO_CONS_POINTTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_CO_DTM_LINETYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_CO_DTM_POINTTYPE_TBD');
commit;