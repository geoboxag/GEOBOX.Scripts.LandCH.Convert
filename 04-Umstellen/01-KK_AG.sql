----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz - KantonsKit AG
-- Deaktiviert das Datenmodell/Modul in der Fachschale.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supported, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [10.02.2026] V 1.1 / GEOBOX AG (USO) - Umstellen der Einstellungen.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- Modul deaktivieren
-- *******************************************************************
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.19';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.19';
commit;

-- *******************************************************************
-- Einstellungen (TB_SETTINGS) umschreiben auf neue Themen (ITEMTHEMA)
-- *******************************************************************
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.LandCH.EGRID' where ITEMTHEMA='GEOBOX.IM.CH.LANDCH.EGRID';
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.JobMapRenderer' where ITEMTHEMA='AC_JOBMAPRENDERER';
commit;

-- *******************************************************************
-- Job-Vorlagen umbenennen für Update
-- *******************************************************************
update TB_JOB_TEMPLATE set NAME = 'Fixpunktmutation' where NAME = 'Fixpunkte';
update TB_JOB_TEMPLATE set NAME = 'Liegenschaftsmutation' where NAME = 'Liegenschaftsmutation';
update TB_JOB_TEMPLATE set NAME = 'Bestandesänderung' where NAME = 'Bestandesänderung';
update TB_JOB_TEMPLATE set NAME = 'Administrative Ebenen' where NAME = 'Administrativ';
update TB_JOB_TEMPLATE set NAME = 'Bauprojekte' where NAME = 'Projekte';
update TB_JOB_TEMPLATE set NAME = 'Wartungsjob' where NAME = 'Wartungsjob';
commit;

-- *******************************************************************
-- Job-Vorlagen Bentuzerspezifische Konfiguration zurücksetzten
-- *******************************************************************
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Fixpunktmutation');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Liegenschaftsmutation');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Bestandesänderung');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Administrative Ebenen');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Bauprojekte');
commit;

-- *******************************************************************
-- Objektklassen entfernen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LMAG_LO_ROAD_SECTION_TBL tab where tab.FID = jv.FID);
delete TB_UFID uf where EXISTS (select 1 from LMAG_LO_ROAD_SECTION_TBL tab where tab.FID = uf.FID);
call &&mapsysname..FeatureClass.dropFeatureClass('LMAG_LO_ROAD_SECTION_TBL');

delete from TB_JOB_VERSION jv where EXISTS (select * from LMAG_PA_SO_LINE_TBL tab where tab.FID = jv.FID);
delete TB_UFID uf where EXISTS (select 1 from LMAG_PA_SO_LINE_TBL tab where tab.FID = uf.FID);
call &&mapsysname..FeatureClass.dropFeatureClass('LMAG_PA_SO_LINE_TBL');

delete from TB_JOB_VERSION jv where EXISTS (select * from LMAG_PA_SO_POINT_TBL tab where tab.FID = jv.FID);
delete TB_UFID uf where EXISTS (select 1 from LMAG_PA_SO_POINT_TBL tab where tab.FID = uf.FID);
call &&mapsysname..FeatureClass.dropFeatureClass('LMAG_PA_SO_POINT_TBL');

delete from TB_JOB_VERSION jv where EXISTS (select * from LMAG_PA_SO_SURFACE_TBL tab where tab.FID = jv.FID);
delete TB_UFID uf where EXISTS (select 1 from LMAG_PA_SO_SURFACE_TBL tab where tab.FID = uf.FID);
call &&mapsysname..FeatureClass.dropFeatureClass('LMAG_PA_SO_SURFACE_TBL');
commit;

-- *******************************************************************
-- Plot Views entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('GB_V_PLOT_AREA');
call &&mapsysname..FeatureClass.dropFeatureClass('GB_V_PLOT_ORIGIN');
commit;
drop view GB_V_PLOT_AREA;
drop view GB_V_PLOT_ORIGIN;
commit;

-- *******************************************************************
-- Systemtabellen entfernen
-- *******************************************************************
drop table TB_AG_UPDATELOG;
commit;

-- *******************************************************************
-- Veraltete KGWE Liste entfernen
-- *******************************************************************
drop table TB_KGWR_LIST;
commit;

-- *******************************************************************
-- KantonsKit spezifische Ansichten (Views) entfernen
-- *******************************************************************
-- GABMO
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPGABMO_HOUSE_ENTR');
drop view LM_V_DSPGABMO_HOUSE_ENTR;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPGABMO_LAND_COVER');
drop view LM_V_DSPGABMO_LAND_COVER;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPGABMO_ROAD_SECT');
drop view LM_V_DSPGABMO_ROAD_SECT;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPGABMO_SURFACE_PRO');
drop view LM_V_DSPGABMO_SURFACE_PRO;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPGABMO_SURF_LONAME');
drop view LM_V_DSPGABMO_SURF_LONAME;

-- Darstellung
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPAG_PA_SO_PO_TBL');
drop view LM_V_DSPAG_PA_SO_PO_TBL;
 