----------------------------------------------------------------------
-- Landesgrenze entfernen (wird mit einer Web Datenservice Objektklasse ersetzt)
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
-- CHECK-ID: 020201
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_AD_COUNTRY_BOUNDARY tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020202
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_AD_COUNTRY_BOUNDARY tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 020203
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_BDR;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_BIR;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_BUR;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_FID;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_JAD;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_JAU;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_JBD;
DROP TRIGGER LM_AD_COUNTRY_BOUNDARY_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 020204
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_AD_COUNTRY_BOUNDARY');
commit;
