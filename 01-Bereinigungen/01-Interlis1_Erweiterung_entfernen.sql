----------------------------------------------------------------------
-- Enterfernt die Interlis 1 Export Erweiterung aus einer Fachschale.
-- Die Interlis Export Konfigurationen müssen vorgängig aus der Fachschale gelöscht werden.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- Vorbereitung: Löschen der Interlis1 Export Konfiguration mit Autodesk Infrastructure Administrator

-- Modul deaktivieren
delete from TB_VERSION where DATA_MODEL_CODE = '2.17.2';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '2.17.2';
commit;

-- TB-Settings bereinigen
delete from TB_SETTINGS where ITEMTHEMA = 'GEOBOX.IM.CH.INTERLISEXPORT';
delete from TB_SETTINGS_COLLECTION sc where not exists (select 1 from TB_SETTINGS s where s.ID = sc.SETTING_ID);

-- Schnittstellentabellen entfernen
drop table ILI_ATTRIBUTE;
drop table ILI_EXPORT;
drop table ILI_LABELDEF;
drop table ILI_LINEATTR;
drop table ILI_MODEL;
drop table ILI_TABLE;
drop table ILI_TOPIC;
commit;

-- Datenmodell-Topic entfernen
delete from TB_TOPIC where TOPIC_ID = (select ID from TB_TOPIC where NAME like 'INTERLIS');
call &&mapsysname..Topic.DropTopic('INTERLIS');
commit;

-- Trigger entfernen
drop trigger ILI_EXPORT_BIR;
commit;