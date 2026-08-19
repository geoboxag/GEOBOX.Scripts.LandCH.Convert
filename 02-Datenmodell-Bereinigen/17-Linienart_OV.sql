----------------------------------------------------------------------
-- Linienart OV bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 021701
-- Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_LC_SURFACE_L', 'ID_LINETYPE_OV');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SURFACE_PROJ_L', 'ID_LINETYPE_OV');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_SO_LINE_ELEMENT', 'ID_LINETYPE_OV');
commit;

-- *******************************************************************
-- CHECK-ID: 021702
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_LC_LINETYPE_OV_TBD');
call &&mapsysname..Domain.dropDomainTable('LM_SO_LINETYPE_OV_TBD');
commit;
