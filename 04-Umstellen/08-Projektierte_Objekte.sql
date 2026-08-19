----------------------------------------------------------------------
-- Setzt den Objektstatus bei den Objekten
-- Dies wird nur bei den aktuellen Objekten eingetragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------


-- *******************************************************************
-- CHECK-ID: 040801
-- Objekte eintragen/aktualisieren
-- *******************************************************************
call job3.setjob(-1);

-- LM_PA_SURFACE_PROJ (Projektierte BB)
update LM_PA_SURFACE_PROJ set ID_STATE = 2 where ID_STATE is NULL;

-- LM_PA_SO_PROJ (Projektierte EO)
update LM_PA_SO_PROJ  set ID_STATE = 2 where ID_STATE is NULL;
 
commit;

-- *******************************************************************
-- CHECK-ID: 040802
-- Prüfen ob es einträge hat die geändert werden müssen.
-- *******************************************************************
select * from LM_PA_SURFACE_PROJ where ID_STATE is NULL or ID_STATE <> 2;
select * from LM_PA_SO_PROJ  where ID_STATE is NULL or ID_STATE <> 2;