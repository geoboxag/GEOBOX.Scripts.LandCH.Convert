----------------------------------------------------------------------
-- Alte Bestandteile entfernen und bereinigen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
-- [30.04.2026] V 2025.2 / GEOBOX AG (USO) - Ergänzung für weitere System-Tabellen
----------------------------------------------------------------------

-- *******************************************************************
-- Job Migrationspaket prüfen und entfern
-- CHECK-ID: 010301
-- *******************************************************************
select * from USER_OBJECTS where OBJECT_TYPE = 'PACKAGE' AND UPPER(OBJECT_NAME) like 'TB2%';

-- Entfernen (Paketname korrekt eintragen)
drop package tb2jobmigrator_pkg;


-- *******************************************************************
-- TB2 Migration Systemtabelle entfernen
-- CHECK-ID: 010302
-- *******************************************************************
drop table TB_CENTROID_RELATIONS_IN_MUT;
drop table TB2_JOB_MIGRATION_ERROR; 
drop table TB_MUTATION; 
