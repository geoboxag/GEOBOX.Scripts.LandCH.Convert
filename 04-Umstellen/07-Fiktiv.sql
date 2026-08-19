----------------------------------------------------------------------
-- Setzt den Wert FIKTIV bei den Objekten
-- Dies wird nur bei den aktuellen Objekten eingetragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 040701
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_FICTIONAL_OBJECTS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(2);
repeat
  insert into MIG_FICTIONAL_OBJECTS (select '$FCLASSNAME', FID, JOB_VERSION from $FCLASSNAME)
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'IS_FICTIONAL');
commit;

-- select * from MIG_FICTIONAL_OBJECTS;

-- *******************************************************************
-- CHECK-ID: 040702
-- Objekte aktualisieren
-- *******************************************************************
call job3.setjob(-1);

repeat
  update $FCLASSNAME tab set IS_FICTIONAL = 0 where exists (select 1 from MIG_FICTIONAL_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION and temp.F_CLASS_NAME like '$FCLASSNAME')
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'IS_FICTIONAL');
commit;

-- *******************************************************************
-- CHECK-ID: 040703
-- Kontrolle (wenn hier Datensätze angezeigt werden, sind dies manuell zu beurteilen und zu attributieren)
-- *******************************************************************
call job3.setjob(2);
repeat
  select '$FCLASSNAME', count(1) from $FCLASSNAME where IS_FICTIONAL is NULL
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'IS_FICTIONAL');

-- *******************************************************************
-- CHECK-ID: 040704
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_FICTIONAL_OBJECTS;
commit;

-- Hilfs-Scripte
-- select * from TB_ATTRIBUTE where NAME = 'IS_FICTIONAL';
-- select 'define tablename = '||F_CLASS_NAME||';' from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'IS_FICTIONAL') order by F_CLASS_NAME;
