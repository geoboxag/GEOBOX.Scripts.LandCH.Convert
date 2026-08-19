----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Wird für das Erstellen des Scriptes ab der Vorlage verwendet
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [14.06.2024] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------

select 'DROP TRIGGER '||OBJECT_NAME||';' from user_objects where OBJECT_TYPE = 'TRIGGER' and OBJECT_NAME like 'LM_IS_%_PLAN_%'
