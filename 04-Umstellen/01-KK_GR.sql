----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz - KantonsKit GR
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
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.18';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.18';
commit;

-- *******************************************************************
-- Einstellungen (TB_SETTINGS) umschreiben auf neue Themen (ITEMTHEMA)
-- *******************************************************************
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.LandCH.EGRID' where ITEMTHEMA='AUTODESK.LANDCH.EGRID';
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.JobMapRenderer' where ITEMTHEMA='AC_JOBMAPRENDERER';
commit;
