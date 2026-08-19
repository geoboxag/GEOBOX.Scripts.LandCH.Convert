----------------------------------------------------------------------
-- Clean Utility-Model
-- Entfernt die Objekte vom Übertrag "Oracle Data Import" oder Migration
-- Ausgabe: keine
-- MAPSYS = Der Name der für den M3D-System-Benutzer auf der DB !!!!!!
----------------------------------------------------------------------
-- intern
-- Verwendung auf eigene Gefahr! Das Script ist nicht Supportet!
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- DATA_MODEL_CODE
-- Deaktiviert die Erweiterung "Oracle Data Import"
----------------------------------------------------------------------
delete from TB_VERSION where DATA_MODEL_CODE = '2.18.0';
delete from TB_DATAMODELCODE where  DATA_MODEL_CODE = '2.18.0';
commit;
----------------------------------------------------------------------
-- Remove TB2TB-Configuration
-- Entfernt die Konfiguration vom Daten-Übertrag
----------------------------------------------------------------------
delete from TB_MIG_CONFIG;
delete from TB_MIG_MAPPING_COLUMN;
delete from TB_MIG_MAPPING_DOMAIN;
delete from TB_MIG_MAPPING_DOMAIN_ENTRY;
delete from TB_MIG_MAPPING_TABLE;
delete from TB_MIG_PARAMETER;
delete from TB_MIG_POST_SQL;
delete from TB_MIG_PRE_SQL;
commit;

drop table TB_MIG_CONFIG;
drop table TB_MIG_MAPPING_COLUMN;
drop table TB_MIG_MAPPING_DOMAIN;
drop table TB_MIG_MAPPING_DOMAIN_ENTRY;
drop table TB_MIG_MAPPING_TABLE;
drop table TB_MIG_PARAMETER;
drop table TB_MIG_POST_SQL;
drop table TB_MIG_PRE_SQL;
commit;

----------------------------------------------------------------------
-- Remove T2T_* Columns
-- Entfernt in allen Objektklassen die T2T_* Felder
----------------------------------------------------------------------
repeat
 call mapsys.FeatureClass.dropColumnFromFeatureClass('$table_name', '$column_name')
for
 select table_name, column_name
 from user_tab_cols where column_name like 'T2T_%';
commit;
-- Create Scripts for remove Columns in Feature-Classes
--select 'call mapsys.FeatureClass.dropColumnFromFeatureClass('''||table_name||''', '''||column_name||''');' 
--from user_tab_cols where column_name like 'T2T_%';

----------------------------------------------------------------------
-- Remove TB2_* Columns
-- Entfernt in allen Objektklassen die TB2_* Felder
----------------------------------------------------------------------
repeat
 call mapsys.FeatureClass.dropColumnFromFeatureClass('$table_name', '$column_name')
for
 select table_name, column_name
 from user_tab_cols where column_name like 'TB2_%';
commit;
-- Create Scripts for remove Columns in Feature-Classes
--select 'call mapsys.FeatureClass.dropColumnFromFeatureClass('''||table_name||''', '''||column_name||''');' 
--from user_tab_cols where column_name like 'TB2_%';