----------------------------------------------------------------------
-- Erstellt in jeder Objektklasse mit dem Attribut ILI2_OID eine neue OID falls diese leer ist.
-- Dieses Script erstellt OID's vom Typ UUIDOID.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 060201
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_OID_OBJECTS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10));

-- *******************************************************************
-- CHECK-ID: 060202
-- Objekte eintragen
-- *******************************************************************
-- Rechtsgültige Objekte eintragen
call job3.setjob(1);
repeat
  insert into MIG_OID_OBJECTS (select '$FCLASSNAME', FID, JOB_VERSION from $FCLASSNAME)
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'ILI2_OID') and F_CLASS_NAME not like 'LM_WS_%';
commit;

-- Pendente Objekte hinzufügen
call job3.setjob(2);
repeat
  insert into MIG_OID_OBJECTS (select '$FCLASSNAME', FID, JOB_VERSION from $FCLASSNAME tab where not exists (select 1 from MIG_OID_OBJECTS mi where mi.JOB_VERSION = tab.JOB_VERSION))
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'ILI2_OID') and F_CLASS_NAME not like 'LM_WS_%';
commit;

select * from (
select fid, count(1) c from MIG_OID_OBJECTS group by fid) tab where c > 1
-- select * from MIG_OID_OBJECTS;

-- *******************************************************************
-- CHECK-ID: 060203
-- Objekte aktualisieren
-- *******************************************************************
call job3.setjob(-1);

repeat
  update $FCLASSNAME tab set ILI2_OID = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
  where exists (select 1 from MIG_OID_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION and temp.F_CLASS_NAME like '$FCLASSNAME') and ILI2_OID is NULL
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'ILI2_OID') and F_CLASS_NAME not like 'LM_WS_%';
commit;

-- *******************************************************************
-- CHECK-ID: 060204
-- Kontrolle (wenn hier Datensätze angezeigt werden, sind dies manuell zu beurteilen und zu attributieren)
-- *******************************************************************
call job3.setjob(2);
repeat
  select '$FCLASSNAME', count(1) from $FCLASSNAME where ILI2_OID is NULL
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'ILI2_OID') and F_CLASS_NAME not like 'LM_WS_%';

select * from XSQLSHEET_RESULT where VALUE_2 > 0;

-- *******************************************************************
-- CHECK-ID: 060205
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_OID_OBJECTS;
commit;