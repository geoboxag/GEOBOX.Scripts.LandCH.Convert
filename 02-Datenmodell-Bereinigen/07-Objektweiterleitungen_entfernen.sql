----------------------------------------------------------------------
-- TB Info Redirect bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 020701
-- Einträge löschen - diese werden später wieder korrekt eingetragen
-- *******************************************************************
delete from TB_GN_INFO_REDIRECT;
commit;
