----------------------------------------------------------------------
-- Entfernt die Ploterweiterung inkl. Objektklassen
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
-- CHECK-ID: 010601
-- Modul deaktivieren
-- *******************************************************************
-- Modul deaktivieren
delete from TB_VERSION where DATA_MODEL_CODE = '2.12.0';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '2.12.0';
commit;

-- *******************************************************************
-- CHECK-ID: 010602
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_COVER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_CROSSHAIR tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_DECORATION tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_DECORATION_TBL tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_DECORATION_TEXT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_GRID tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_GRID_EXTLINE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_GRID_FRAME tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_GROUP tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_GROUP_PLOT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_IMAGE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_ISLAND_COVER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_LEGEND tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_MAP tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_NA tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_SCALE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_SCALEBAR tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_TEXT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from PLT_PLOT_TEXT_TBL tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 010603
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER PLT_PLOT_FID;
DROP TRIGGER PLT_PLOT_COVER_FID;
DROP TRIGGER PLT_PLOT_CROSSHAIR_FID;
DROP TRIGGER PLT_PLOT_DECORATION_FID;
DROP TRIGGER PLT_PLOT_DECORATION_TBL_FID;
DROP TRIGGER PLT_PLOT_DECORATION_TEXT_FID;
DROP TRIGGER PLT_PLOT_GRID_FID;
DROP TRIGGER PLT_PLOT_GRID_EXTLINE_FID;
DROP TRIGGER PLT_PLOT_GRID_FRAME_FID;
DROP TRIGGER PLT_PLOT_GROUP_FID;
DROP TRIGGER PLT_PLOT_GROUP_PLOT_FID;
DROP TRIGGER PLT_PLOT_IMAGE_FID;
DROP TRIGGER PLT_PLOT_ISLAND_COVER_FID;
DROP TRIGGER PLT_PLOT_LEGEND_FID;
DROP TRIGGER PLT_PLOT_MAP_FID;
DROP TRIGGER PLT_PLOT_NA_FID;
DROP TRIGGER PLT_PLOT_SCALE_FID;
DROP TRIGGER PLT_PLOT_SCALEBAR_FID;
DROP TRIGGER PLT_PLOT_TEXT_FID;
DROP TRIGGER PLT_PLOT_TEXT_TBL_FID;
commit;

-- *******************************************************************
-- CHECK-ID: 010505
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_DECORATION_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_DECORATION_TEXT');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_DECORATION');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_COVER');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_CROSSHAIR');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_GROUP_PLOT');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_GROUP');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_GRID_EXTLINE');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_GRID');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_GRID_FRAME');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_IMAGE');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_ISLAND_COVER');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_LEGEND');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_MAP');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_NA');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_SCALE');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_SCALEBAR');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_TEXT_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT_TEXT');
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_PLOT');

-- Views entfernen
call &&mapsysname..FeatureClass.dropFeatureClass('PLT_V_GRID_EXTLINE_TBL');
drop view PLT_V_GRID_EXTLINE_TBL;
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSP_CROSSHAIR');
drop view LM_V_DSP_CROSSHAIR;

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_DECOTYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_GRIDCROSS_LABEL_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_GRIDCROSS_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_HPOSITION_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_IMG_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_LEGEND_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_MAP_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_NA_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_SB_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_TEXT_SIZE_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_TEXT_STYLE_TBD');
call &&mapsysname..Domain.dropDomainTable('PLT_PLOT_VPOSITION_TBD');

-- Datenmodell-Topic entfernen
call &&mapsysname..Topic.DropTopic('19B98053-1E6E-45E1-B2E5-6B80F072EE82');
call &&mapsysname..Topic.DropTopic('679B157D-5D95-429D-A286-F64A486111AD');
commit;