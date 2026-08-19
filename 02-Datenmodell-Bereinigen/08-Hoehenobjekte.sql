----------------------------------------------------------------------
-- Hoehenobjekte behandeln
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
-- CHECK-ID: 020801
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_HE_CONTOUR_LINE' name, count(1) counts from LM_HE_CONTOUR_LINE
 union all
  select 'LM_HE_CONTOUR_LINE_TBL' name, count(1) counts from LM_HE_CONTOUR_LINE_TBL
 union all
  select 'LM_HE_CUT_OUT_SURFACE' name, count(1) counts from LM_HE_CUT_OUT_SURFACE
 union all
  select 'LM_HE_INDIV_POINT' name, count(1) counts from LM_HE_INDIV_POINT tab
 union all
  select 'LM_HE_INDIV_POINT_TBL' name, count(1) counts from LM_HE_INDIV_POINT_TBL
 union all
  select 'LM_HE_TERRAIN_EDGE' name, count(1) counts from LM_HE_TERRAIN_EDGE tab
);

-- *******************************************************************
-- CHECK-ID: 020802
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_CONTOUR_LINE tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_CONTOUR_LINE_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_CUT_OUT_SURFACE tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_INDIV_POINT tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_INDIV_POINT_TBL tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_HE_TERRAIN_EDGE tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020803
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_HE_CONTOUR_LINE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_HE_CONTOUR_LINE_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_HE_CUT_OUT_SURFACE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_HE_INDIV_POINT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_HE_INDIV_POINT_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_HE_TERRAIN_EDGE tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020804
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_HE_CONTOUR_LINEABUS;
DROP TRIGGER LM_HE_CONTOUR_LINE_AIS;
DROP TRIGGER LM_HE_CONTOUR_LINE_AUS;
DROP TRIGGER LM_HE_CONTOUR_LINE_BDR;
DROP TRIGGER LM_HE_CONTOUR_LINE_BIR;
DROP TRIGGER LM_HE_CONTOUR_LINE_BIS;
DROP TRIGGER LM_HE_CONTOUR_LINE_BUR;
DROP TRIGGER LM_HE_CONTOUR_LINE_FID;
DROP TRIGGER LM_HE_CONTOUR_LINE_JAD;
DROP TRIGGER LM_HE_CONTOUR_LINE_JAU;
DROP TRIGGER LM_HE_CONTOUR_LINE_JBD;
DROP TRIGGER LM_HE_CONTOUR_LINE_JBU;

DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_BIR;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_BUR;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_FID;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_JAD;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_JAU;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_JBD;
DROP TRIGGER LM_HE_CONTOUR_LINE_TBL_JBU;

DROP TRIGGER LM_HE_CUT_OUT_SURFACE_BDR;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_BIR;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_BUR;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_FID;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_JAD;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_JAU;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_JBD;
DROP TRIGGER LM_HE_CUT_OUT_SURFACE_JBU;

DROP TRIGGER LM_HE_INDIV_POINTABUS;
DROP TRIGGER LM_HE_INDIV_POINT_AIS;
DROP TRIGGER LM_HE_INDIV_POINT_AUS;
DROP TRIGGER LM_HE_INDIV_POINT_BDR;
DROP TRIGGER LM_HE_INDIV_POINT_BIR;
DROP TRIGGER LM_HE_INDIV_POINT_BIS;
DROP TRIGGER LM_HE_INDIV_POINT_BUR;
DROP TRIGGER LM_HE_INDIV_POINT_FID;
DROP TRIGGER LM_HE_INDIV_POINT_JAD;
DROP TRIGGER LM_HE_INDIV_POINT_JAU;
DROP TRIGGER LM_HE_INDIV_POINT_JBD;
DROP TRIGGER LM_HE_INDIV_POINT_JBU;

DROP TRIGGER LM_HE_INDIV_POINT_TBL_BIR;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_BUR;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_FID;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_JAD;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_JAU;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_JBD;
DROP TRIGGER LM_HE_INDIV_POINT_TBL_JBU;

DROP TRIGGER LM_HE_TERRAIN_EDGE_BDR;
DROP TRIGGER LM_HE_TERRAIN_EDGE_BIR;
DROP TRIGGER LM_HE_TERRAIN_EDGE_BUR;
DROP TRIGGER LM_HE_TERRAIN_EDGE_FID;
DROP TRIGGER LM_HE_TERRAIN_EDGE_JAD;
DROP TRIGGER LM_HE_TERRAIN_EDGE_JAU;
DROP TRIGGER LM_HE_TERRAIN_EDGE_JBD;
DROP TRIGGER LM_HE_TERRAIN_EDGE_JBU;

commit;

-- *******************************************************************
-- CHECK-ID: 020805
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_HE_CONTOUR_LINE');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_HE_CONTOUR_LINE_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_HE_CUT_OUT_SURFACE');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_HE_INDIV_POINT');
call &&mapsysname..FeatureClass.DropLabelFeatureClass('LM_HE_INDIV_POINT_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_HE_TERRAIN_EDGE');

-- Topic
call &&mapsysname..Topic.DropTopic('LM_HEIGHTS');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_HE_EQUIDISTANCE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_HE_HEIGHT_CLASS_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_HE_LINETYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_HE_ORIGIN_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_HE_SURFACETYPE_TBD');
commit;
