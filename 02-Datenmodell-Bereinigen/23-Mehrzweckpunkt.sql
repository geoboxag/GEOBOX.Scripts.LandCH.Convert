----------------------------------------------------------------------
-- Objektklasse Mehrzweckpunkt entfernen
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
-- CHECK-ID: 022301
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_PI_MULTIPURPOSE_POINT' name, count(1) counts from LM_PI_MULTIPURPOSE_POINT 
);

-- *******************************************************************
-- CHECK-ID: 022302
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PI_MULTIPURPOSE_POINT tab where tab.FID = jv.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 022303
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_PI_MULTIPURPOSE_POINT tab where tab.FID = uf.FID);

commit;

-- *******************************************************************
-- CHECK-ID: 022304
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_BDR; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_BIR; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_BUR; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_FID; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_JAD; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_JAU; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_JBD; 
DROP TRIGGER LM_PI_MULTIPURPOSE_POINT_JBU; 

commit;

-- *******************************************************************
-- CHECK-ID: 022305
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Objektklassen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PI_MULTIPURPOSE_POINT');
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_PI_MULTI_POINTTYPE_TBD');

commit;