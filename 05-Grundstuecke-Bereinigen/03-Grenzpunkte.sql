----------------------------------------------------------------------
-- Grenzpunkte anpassen
-- Nachträgliche Vermarkung
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [28.09.2026] V 1.1 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 050301
-- Updaten des Attribut anhand des temporären Attributes
-- *******************************************************************
call job3.setjob(-1);

-- spezial Fall ID 14 nachträgliche Vermarkung aktualisieren
update LM_OW_BOUNDARYPOINT set DELAYED_MONUMENTATION = TEMP_DELAY where TEMP_DELAY is not NULL;
commit;

-- *******************************************************************
-- CHECK-ID: 050302
-- Temporäre Spalte entfernen.
-- *******************************************************************
alter table LM_OW_BOUNDARYPOINT drop column TEMP_DELAY;
commit;