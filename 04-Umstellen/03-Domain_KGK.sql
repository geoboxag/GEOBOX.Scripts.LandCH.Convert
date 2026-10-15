----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz KGK
-- Korrigiert die Werte für die KGK Erweiterung
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [11.05.2026] V 1.1 / GEOBOX AG (USO) - Anpassungen die DMAV Version 1.1 Datenmodelle.
----------------------------------------------------------------------

-- WICHTIG: nur ausführen falls mit der KGK Erweiterung gearbeitet wird...
update LM_LC_CATEGORY_TBD set VALUE = 'im Bau' where ID = 38;                                  
commit;