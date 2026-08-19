----------------------------------------------------------------------
-- JOB-Infos und FID-Mutationsperiemter als Sicherstellung
-- Die Infos werden für eine Sicherung zusammengetragen und gespeichert.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 080101
-- Benutzereinstellungen entfernen
-- *******************************************************************
delete from TB_GN_DIALOG_USER;
commit;

-- *******************************************************************
-- CHECK-ID: 080102
-- Formulardefinitionen entfernen
-- *******************************************************************
delete from TB_GN_DIALOG;
delete from TB_GN_CONTROL;
delete from TB_GN_DIALOG_DETAIL;
delete from TB_GN_DIALOG_FILTER;
delete from TB_GN_DIALOG_MACHINE_USER;
delete from TB_GN_DIALOG_SCRIPTCODE;
delete from TB_GN_DIALOG_USER;
commit; 