----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz - KantonsKit BE
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
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.2';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.2';
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

/* Niveaux administratifs
Droits distincts et permanents
Limites territoire
Tâche de maintenance immeubles
Mutation de bien-fonds
Tâche de maintenance
-->>> ??? Mise à jour couverture du sol
Mutation de point fixe
Projets de construction */

/* FRA */
update TB_JOB_TEMPLATE set NAME = 'Niveaux administratifs' where NAME = 'Niveaux administratifs';
update TB_JOB_TEMPLATE set NAME = 'Mutation de bien-fonds' where NAME = 'Mutation de bien-fonds';
update TB_JOB_TEMPLATE set NAME = 'Projets de construction' where NAME = 'Projets de construction';
update TB_JOB_TEMPLATE set NAME = 'Mutation de point fixe' where NAME = 'Mutation de point fixe';
update TB_JOB_TEMPLATE set NAME = 'Limites territoire' where NAME = 'Limites territoire';
update TB_JOB_TEMPLATE set NAME = 'Tâche de maintenance' where NAME = 'Tâche de maintenance';
update TB_JOB_TEMPLATE set NAME = 'Tâche de maintenance immeubles' where NAME = 'Tâche de maintenance immeubles';
update TB_JOB_TEMPLATE set NAME = 'Droits distincts et permanents' where NAME = 'Droits distincts et permanents';
update TB_JOB_TEMPLATE set NAME = 'Mise à jour couverture du sol' where NAME = 'Mise à jour couverture du sol';


-- *******************************************************************
-- Job-Vorlagen Bentuzerspezifische Konfiguration zurücksetzten
-- *******************************************************************
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Mutation de point fixe');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Mutation de bien-fonds');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Mise à jour couverture du sol');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Niveaux administratifs');
delete from TB_JOB_TEMPLATE_DEF where JOB_TEMPLATE_ID = (select ID from TB_JOB_TEMPLATE where NAME = 'Projets de construction');
commit;