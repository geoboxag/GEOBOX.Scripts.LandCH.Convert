----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Deaktiviert das Datenmodell/Modul in der Fachschale.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [28.02.2026] V 1.1 / GEOBOX AG (USO) - Anpassungen AVGBS.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 040101
-- Modul deaktivieren
-- *******************************************************************
-- Modul LMCH deaktivieren
delete from TB_VERSION where DATA_MODEL_CODE = '2.9.2';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '2.9.2';
commit;

-- *******************************************************************
-- CHECK-ID: 040102
-- Workflows entfernen
-- *******************************************************************
delete from TB_WORKFLOW;
commit;

-- *******************************************************************
-- CHECK-ID: 040103
-- Modul AVGBS deaktivieren
-- *******************************************************************
-- Modul deaktivieren
delete from TB_VERSION where DATA_MODEL_CODE = '3.3.2';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '3.3.2';
commit;
