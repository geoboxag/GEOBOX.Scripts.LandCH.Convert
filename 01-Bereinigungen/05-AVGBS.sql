----------------------------------------------------------------------
-- Entfernt die AVGBS Schnittstelle inkl. Objektklassen, diese werden neu angelegt.
-- Falls Daten vorhanden sind, sollten diese nach dem Update neu eingelesen werden.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt.
-- [30.04.2026] V 2025.2 / GEOBOX AG (USO) - Ergänzung Systemtabellen entfernen.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 010501
-- Modul deaktivieren und TB-Settings bereinigen
-- *******************************************************************
-- Modul deaktivieren
delete from TB_VERSION where DATA_MODEL_CODE = '3.3.2';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '3.3.2';
commit;

-- TB-Settings
delete from TB_SETTINGS where ITEMTHEMA = 'AVGBS';
delete from TB_SETTINGS_COLLECTION sc where not exists (select 1 from TB_SETTINGS s where s.ID = sc.SETTING_ID);

-- *******************************************************************
-- CHECK-ID: 010502
-- TB_JOB_VERSION bereinigen
-- *******************************************************************
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_COMMUNITY_PARTNER tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_ENFORCEMENT_STATE tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_PERSON tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_PERSON_OWNERSHIP tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_PROPERTY tab where tab.FID = jv.FID);
delete from TB_JOB_VERSION jv where EXISTS (select * from AVGBS_PROPERTY_OWNERSHIP tab where tab.FID = jv.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 010503
-- TB_UFID bereinigen
-- *******************************************************************
delete TB_UFID uf where EXISTS (select 1 from AVGBS_COMMUNITY_PARTNER tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from AVGBS_ENFORCEMENT_STATE tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from AVGBS_PERSON tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from AVGBS_PERSON_OWNERSHIP tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from AVGBS_PROPERTY tab where tab.FID = uf.FID);
delete TB_UFID uf where EXISTS (select 1 from AVGBS_PROPERTY_OWNERSHIP tab where tab.FID = uf.FID);
commit;

-- *******************************************************************
-- CHECK-ID: 010504
-- Trigger entfernen
-- *******************************************************************
DROP TRIGGER AVGBS_COMMUNITY_PARTNER_FID;
DROP TRIGGER AVGBS_ENFORCEMENT_STATE_FID;
DROP TRIGGER AVGBS_PERSON_FID;
DROP TRIGGER AVGBS_PERSON_OWNERSHIP_FID;
DROP TRIGGER AVGBS_PROPERTY_FID;
DROP TRIGGER AVGBS_PROPERTY_OWNERSHIP_FID;

commit;

-- *******************************************************************
-- CHECK-ID: 010505
-- Tabellen/Objektklassen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_COMMUNITY_PARTNER');
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_ENFORCEMENT_STATE');
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_PERSON');
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_PERSON_OWNERSHIP');
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_PROPERTY');
call &&mapsysname..FeatureClass.dropFeatureClass('AVGBS_PROPERTY_OWNERSHIP');

-- Relation entfernen
delete TB_RELATIONS where PARENT_TABLE_NAME like 'AVGBS_MUTATION_TYPE_TBD';

-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('AVGBS_ENF_STATE_TYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('AVGBS_GENDER_TBD');
call &&mapsysname..Domain.dropDomainTable('AVGBS_MUTATION_TYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('AVGBS_OWNERSHIP_TYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('AVGBS_PERSON_TYPE_TBD');
call &&mapsysname..Domain.dropDomainTable('AVGBS_PROPERTY_TYPE_TBD');

-- Datenmodell-Topic entfernen
call &&mapsysname..Topic.DropTopic('AVGBS');

-- Systemtabellen entfernen
drop table TB_AVGBS_DEL_JOBS;
drop table TB_AVGBS_PROP_EXPORT;
commit;