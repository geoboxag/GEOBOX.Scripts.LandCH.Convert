----------------------------------------------------------------------
-- Objektklasse Los Grenze entfernen
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
-- CHECK-ID: 022201
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_AD_LOT' name, count(1) counts from LM_AD_LOT 
);

-- *******************************************************************
-- CHECK-ID: 022202
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_AD_LOT tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 022203
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_AD_LOT tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 022204
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_AD_LOT_BDR;
DROP TRIGGER LM_AD_LOT_BIR;
DROP TRIGGER LM_AD_LOT_BUR;
DROP TRIGGER LM_AD_LOT_FID;
DROP TRIGGER LM_AD_LOT_JAD;
DROP TRIGGER LM_AD_LOT_JAU;
DROP TRIGGER LM_AD_LOT_JBD;
DROP TRIGGER LM_AD_LOT_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 022205
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Objektklassen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_AD_LOT');
commit;