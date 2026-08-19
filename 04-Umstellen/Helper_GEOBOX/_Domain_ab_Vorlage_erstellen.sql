----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Wird für das Erstellen des Scriptes ab der Vorlage verwendet
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [14.06.2024] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- COMMENTARY
repeat
 select 'update $TABLE_NAME set COMMENTARY = '''||COMMENTARY||''' where ID = '||ID||';' from $TABLE_NAME where COMMENTARY is not NULL
for
 select * from TB_DOMAIN where (TABLE_NAME not like 'TB_%' and TABLE_NAME not like 'PLT_%') order by TABLE_NAME;

select VALUE_1 from XSQLSHEET_RESULT;
-- DESIGNER
repeat
 select 'update $TABLE_NAME set DESIGNER = '''||DESIGNER||''' where ID = '||ID||';' from $TABLE_NAME where DESIGNER is not NULL
for
 select * from TB_DOMAIN where (TABLE_NAME not like 'TB_%' and TABLE_NAME not like 'PLT_%') order by TABLE_NAME;

select VALUE_1 from XSQLSHEET_RESULT;
-- SHORT_VALUE
repeat
 select 'update $TABLE_NAME set SHORT_VALUE = '''||SHORT_VALUE||''' where ID = '||ID||';' from $TABLE_NAME where SHORT_VALUE is not NULL
for
 select * from TB_DOMAIN where (TABLE_NAME not like 'TB_%' and TABLE_NAME not like 'PLT_%') order by TABLE_NAME;

select VALUE_1 from XSQLSHEET_RESULT;
-- ACTIVE
repeat
 select 'update $TABLE_NAME set ACTIVE = '''||ACTIVE||''' where ID = '||ID||';' from $TABLE_NAME where ACTIVE is not NULL
for
 select * from TB_DOMAIN where (TABLE_NAME not like 'TB_%' and TABLE_NAME not like 'PLT_%') order by TABLE_NAME;

select VALUE_1 from XSQLSHEET_RESULT;
-- VALUE
repeat
 select 'update $TABLE_NAME set VALUE = '''||VALUE||''' where ID = '||ID||';' from $TABLE_NAME where VALUE is not NULL
for
 select * from TB_DOMAIN where (TABLE_NAME not like 'TB_%' and TABLE_NAME not like 'PLT_%' and TABLE_NAME not like 'LM_AD_PLAN_SCALE_TBD') order by TABLE_NAME;

select VALUE_1 from XSQLSHEET_RESULT;

