----------------------------------------------------------------------
-- ID-Bewilligung (ID_APPROVAL) bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [17.04.2026] V 2025.12 / GEOBOX AG (USO) - Anpassungen an DMAV Version 1.1
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 022601
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_BU_HOUSE_ENTRANCE' name, count(1) counts from LM_BU_HOUSE_ENTRANCE where ID_APPROVAL is not NULL
 union all
  select 'LM_PI_PIPE_OBJECT' name, count(1) counts from LM_PI_PIPE_OBJECT where ID_APPROVAL is not NULL
 union all
  select 'LM_PA_SURFACE_PROJ' name, count(1) counts from LM_PA_SURFACE_PROJ where ID_APPROVAL is not NULL
 union all
  select 'LM_SO_SINGLE_OBJECT' name, count(1) counts from LM_SO_SINGLE_OBJECT where ID_APPROVAL is not NULL
);

-- *******************************************************************
-- CHECK-ID: 022602
-- Unnötige Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_BU_HOUSE_ENTRANCE', 'ID_APPROVAL');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PI_PIPE_OBJECT', 'ID_APPROVAL');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SURFACE_PROJ', 'ID_APPROVAL');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_SO_SINGLE_OBJECT', 'ID_APPROVAL');
commit;

-- *******************************************************************
-- CHECK-ID: 022603
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_APPROVAL_TBD');

commit;