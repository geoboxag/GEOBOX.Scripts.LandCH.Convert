----------------------------------------------------------------------
-- Höhenfixpunkte Datenmodell anpassen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supported, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [25.03.2025] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzen
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 050401
-- Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_CP_ACP', 'ID_CATEGORY');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_CP_ACP_CATEGORY_TBD');

commit;