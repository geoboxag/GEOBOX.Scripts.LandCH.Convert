----------------------------------------------------------------------
-- Attribut UFID entfernene
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
-- CHECK-ID: 020501
-- Skripts zum Prüfen ob es Werte hat (in der Regel ist diese Prüfung nicht notwendig)
-- *******************************************************************
repeat
 select count(1) from $table_name where $column_name is not NULL
for
 select table_name, column_name
 from user_tab_cols where column_name like 'UFID';

select VALUE_1,PARAMETER_1,PARAMETER_2,sql_statment from XSQLSHEET_RESULT where VALUE_1 > 0;

-- *******************************************************************
-- CHECK-ID: 020502
-- Entfernen der Attribute
-- *******************************************************************
repeat
 call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('$table_name', '$column_name')
for
 select table_name, column_name
 from user_tab_cols where column_name like 'UFID';
commit;

-- Create Scripts for remove Columns in Feature-Classes
--select 'call MAPSYS.FeatureClass.dropColumnFromFeatureClass('''||table_name||''', '''||column_name||''');' 
--from user_tab_cols where column_name like 'UFID';