----------------------------------------------------------------------
-- Kontrolliert und setzt die Einstellungen für die ILI2_OID für die amtliche Vermessung.
-- Wenn schon eine Einstellung gmeacht ist, muss das Script auf Update umgestellt werden.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------

-- *******************************************************************
-- OID Settings prüfen und korrekt einstellen
-- CHECK-ID: 060101
-- *******************************************************************
-- OID Settings prüfen - ist diese bereits gesetzt, wenn ja mit welchem TYPE
-- Für die Amtliche Vermessung muss UUIDOID eingestellt sein.
select * from TB_SETTINGS where ITEMTHEMA = 'GEOBOX.OID.SETTINGS';

-- Die Einstellung vornehmen
insert into TB_SETTINGS (ID, ITEMTHEMA, ITEMKEY, ITEMVALUE, USER_ID) values (TB_SETTINGS_S1.nextval, 'GEOBOX.OID.SETTINGS','OID-TYPE','UUIDOID','ALL');
commit;