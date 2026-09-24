----------------------------------------------------------------------
-- BB und EO Symbole Plankategorie entfernen
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
-- CHECK-ID: 022401
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_LC_SYMBOL' name, count(1) counts from LM_LC_SYMBOL where ID_PLAN_CATEGORY is not NULL
  union all
  select 'LM_SO_SYMBOL' name, count(1) counts from LM_SO_SYMBOL where ID_PLAN_CATEGORY is not NULL
);

-- *******************************************************************
-- CHECK-ID: 022402
-- Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_LC_SYMBOL', 'ID_PLAN_CATEGORY');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_SO_SYMBOL', 'ID_PLAN_CATEGORY');
commit;

-- *******************************************************************
-- CHECK-ID: 022403
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_SO_PLAN_CATEGORY_TBD');
commit;