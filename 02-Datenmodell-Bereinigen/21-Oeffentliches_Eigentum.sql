----------------------------------------------------------------------
-- Topic Oeffentliches Eigentum entfernen
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
-- CHECK-ID: 022101
-- Daten prüfen
-- *******************************************************************
select name, counts from (
  select 'LM_PO_FOREST_LIMIT' name, count(1) counts from LM_PO_FOREST_LIMIT
 union all
  select 'LM_PO_FOREST_LIMIT_PROJ' name, count(1) counts from LM_PO_FOREST_LIMIT_PROJ
);

-- *******************************************************************
-- CHECK-ID: 022102
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PO_FOREST_LIMIT tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_PO_FOREST_LIMIT_PROJ tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 022103
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from LM_PO_FOREST_LIMIT tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from LM_PO_FOREST_LIMIT_PROJ tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 022104
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER LM_PO_FOREST_LIMIT_BDR;
DROP TRIGGER LM_PO_FOREST_LIMIT_BIR;
DROP TRIGGER LM_PO_FOREST_LIMIT_BUR;
DROP TRIGGER LM_PO_FOREST_LIMIT_FID;
DROP TRIGGER LM_PO_FOREST_LIMIT_JAD;
DROP TRIGGER LM_PO_FOREST_LIMIT_JAU;
DROP TRIGGER LM_PO_FOREST_LIMIT_JBD;
DROP TRIGGER LM_PO_FOREST_LIMIT_JBU;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_BDR;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_BIR;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_BUR;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_FID;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_JAD;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_JAU;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_JBD;
DROP TRIGGER LM_PO_FOREST_LIMIT_PROJ_JBU;
commit;

-- *******************************************************************
-- CHECK-ID: 022005
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
-- Objektklassen
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PO_FOREST_LIMIT');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_PO_FOREST_LIMIT_PROJ');
commit;

-- Topic
call &&mapsysname..Topic.DropTopic('LM_PUBLIC_OWNERSHIP');

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_PO_FOREST_TYPE_TBD');
commit;