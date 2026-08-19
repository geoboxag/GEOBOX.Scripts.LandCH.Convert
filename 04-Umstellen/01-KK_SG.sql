----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz - KantonsKit SG
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
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.17';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.17';
commit;

-- *******************************************************************
-- Einstellungen (TB_SETTINGS) umschreiben auf neue Themen (ITEMTHEMA)
-- *******************************************************************
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.LandCH.EGRID' where ITEMTHEMA='AUTODESK.LANDCH.EGRID';
update TB_SETTINGS set ITEMTHEMA= 'GEOBOX.IM.CH.JobMapRenderer' where ITEMTHEMA='AC_JOBMAPRENDERER';
commit;

-- *******************************************************************
-- Job-Vorlagen umebennen für Update
-- *******************************************************************
update TB_JOB_TEMPLATE set NAME = 'Liegenschaftsmutation' where NAME = 'Liegenschaftsmutation';
update TB_JOB_TEMPLATE set NAME = 'Bestandesänderung' where NAME = 'Bestandesänderung';
update TB_JOB_TEMPLATE set NAME = 'Bauprojekte' where NAME = 'Bauprojekte';
update TB_JOB_TEMPLATE set NAME = 'Fixpunktmutation' where NAME = 'Fixpunktmutation';
update TB_JOB_TEMPLATE set NAME = 'Hoheitsgrenzen' where NAME = 'Hoheitsgrenzen';
update TB_JOB_TEMPLATE set NAME = 'Administrative Ebenen' where NAME = 'Administrative Ebenen';
update TB_JOB_TEMPLATE set NAME = 'Wartungsjob' where NAME = 'Wartungsjob';
update TB_JOB_TEMPLATE set NAME = 'Dienstbarkeiten' where NAME = 'Dienstbarkeiten';

-- *******************************************************************
-- Job-Vorlagen Bentuzerspezifische Konfiguration zurücksetzten
-- *******************************************************************
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Fixpunktmutation');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Liegenschaftsmutation');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Bestandesänderung');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Administrative Ebenen');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Bauprojekte');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Hoheitsgrenzen');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Dienstbarkeiten');
commit;
