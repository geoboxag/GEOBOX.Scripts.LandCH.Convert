----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz - KantonsKit ZH
-- Deaktiviert das Datenmodell/Modul in der Fachschale.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [10.02.2026] V 1.1 / GEOBOX AG (USO) - Umstellen der Einstellungen.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- Modul deaktivieren
-- *******************************************************************
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.1';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.1';
commit;

-- *******************************************************************
-- Einstellungen (TB_SETTINGS) umschreiben auf neue Themen (ITEMTHEMA)
-- *******************************************************************
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.LandCH.EGRID' where ITEMTHEMA='AUTODESK.LANDCH.EGRID';
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.JobMapRenderer' where ITEMTHEMA='AC_JOBMAPRENDERER';
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

-- Darstellung
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_LC_SURFACE');
drop view LM_V_DSPZH_LC_SURFACE;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_LC_SURFACE_L');
drop view LM_V_DSPZH_LC_SURFACE_L;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_LC_SYMBOL');
drop view LM_V_DSPZH_LC_SYMBOL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_HO_ENT_TBL');
drop view LM_V_DSPZH_SO_HO_ENT_TBL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_HO_INS_TBL');
drop view LM_V_DSPZH_SO_HO_INS_TBL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_HO_NAME_TBL');
drop view LM_V_DSPZH_SO_HO_NAME_TBL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_L_ELEMENT');
drop view LM_V_DSPZH_SO_L_ELEMENT;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_OB_NAME_TBL');
drop view LM_V_DSPZH_SO_OB_NAME_TBL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_P_ELEMENT');
drop view LM_V_DSPZH_SO_P_ELEMENT;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_S_ELEMENT');
drop view LM_V_DSPZH_SO_S_ELEMENT;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPZH_SO_S_ELEMENT_L');
drop view LM_V_DSPZH_SO_S_ELEMENT_L;
commit;
