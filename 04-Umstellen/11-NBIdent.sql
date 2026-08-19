----------------------------------------------------------------------
-- Erstellt den korrekten Wert für den NBIdent
-- Dies wird nur bei den aktuellen Objekten eingetragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 041101
-- Zusammengesetzer Wert eintragen
-- *******************************************************************
call job3.setjob(-1);

update LM_ND_NUMBER_DOMAIN nd set nd.NUMBERND = (select VALUE from LM_ND_CANTON_TBD tbd where tbd.ID = nd.ID_CANTON)||NUMBERND;

commit;