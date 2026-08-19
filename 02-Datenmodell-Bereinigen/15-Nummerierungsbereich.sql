----------------------------------------------------------------------
-- Nummerierungsbereich bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 021501
-- Nicht mehr benötigte Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_ND_NUMBER_DOMAIN', 'DATE_LEGALIZED');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_ND_NUMBER_DOMAIN', 'NAME_SCAD');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_ND_NUMBER_DOMAIN', 'NAME_SECTOR');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_ND_NUMBER_DOMAIN', 'TECHDOSSIER');
commit;

-- *******************************************************************
-- CHECK-ID: 021502
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_ND_NDGEOMETRY' name, count(1) counts from LM_ND_NDGEOMETRY
);

-- *******************************************************************
-- CHECK-ID: 021503
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_ND_NDGEOMETRY tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021504
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_ND_NDGEOMETRY tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 021505
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_ND_NDGEOMETRY_BDR;
DROP TRIGGER LM_ND_NDGEOMETRY_BIR;
DROP TRIGGER LM_ND_NDGEOMETRY_BUR;
DROP TRIGGER LM_ND_NDGEOMETRY_FID;
DROP TRIGGER LM_ND_NDGEOMETRY_JAD;
DROP TRIGGER LM_ND_NDGEOMETRY_JAU;
DROP TRIGGER LM_ND_NDGEOMETRY_JBD;
DROP TRIGGER LM_ND_NDGEOMETRY_JBU;

commit;

-- *******************************************************************
-- CHECK-ID: 021506
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_ND_NDGEOMETRY');

commit;