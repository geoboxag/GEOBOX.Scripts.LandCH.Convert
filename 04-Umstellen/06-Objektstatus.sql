----------------------------------------------------------------------
-- Setzt den Objektstatus bei den Objekten
-- Dies wird nur bei den aktuellen Objekten eingetragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 040601
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_STATE_OBJECTS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(1);

insert into MIG_STATE_OBJECTS (select 'LM_LC_SURFACE', FID, JOB_VERSION from LM_LC_SURFACE);
insert into MIG_STATE_OBJECTS (select 'LM_PI_PIPE_OBJECT', FID, JOB_VERSION from LM_PI_PIPE_OBJECT);
insert into MIG_STATE_OBJECTS (select 'LM_PI_SIGNAL_POINT', FID, JOB_VERSION from LM_PI_SIGNAL_POINT);
insert into MIG_STATE_OBJECTS (select 'LM_SO_SINGLE_OBJECT', FID, JOB_VERSION from LM_SO_SINGLE_OBJECT);
commit;

-- *******************************************************************
-- CHECK-ID: 040602
-- Objekte eintragen/aktualisieren
-- *******************************************************************
call job3.setjob(-1);

-- LM_LC_SURFACE
-- Umschreiben der bestehenden Werte:
update LM_LC_SURFACE tab set tab.ID_STATE = 2 where tab.ID_STATE = 5;
update LM_LC_SURFACE tab set tab.ID_STATE = 2 where tab.ID_STATE = 6;
update LM_LC_SURFACE tab set tab.ID_STATE = 3 where tab.ID_STATE = 7;
update LM_LC_SURFACE tab set tab.ID_STATE = 4 where tab.ID_STATE = 8;
-- Fehlende Werte eintragen
update LM_LC_SURFACE tab set tab.ID_STATE = 3 
 where exists (select 1 from TB_JOB_VERSION v where v.JOB_VERSION = tab.JOB_VERSION and v.JOB_OPERATION_ID != 3)
 and exists (select 1 from MIG_STATE_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION)
 and tab.ID_STATE is NULL;

-- LM_PI_PIPE_OBJECT;
-- Umschreiben der bestehenden Werte:
update LM_PI_PIPE_OBJECT tab set tab.ID_STATE = 2 where tab.ID_STATE = 5;
update LM_PI_PIPE_OBJECT tab set tab.ID_STATE = 2 where tab.ID_STATE = 6;
update LM_PI_PIPE_OBJECT tab set tab.ID_STATE = 3 where tab.ID_STATE = 7;
update LM_PI_PIPE_OBJECT tab set tab.ID_STATE = 4 where tab.ID_STATE = 8;
-- Fehlende Werte eintragen
update LM_PI_PIPE_OBJECT tab set tab.ID_STATE = 3 
 where exists (select 1 from TB_JOB_VERSION v where v.JOB_VERSION = tab.JOB_VERSION and v.JOB_OPERATION_ID != 3)
 and exists (select 1 from MIG_STATE_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION)
 and tab.ID_STATE is NULL;
 
-- LM_PI_SIGNAL_POINT;
-- Umschreiben der bestehenden Werte:
update LM_PI_SIGNAL_POINT tab set tab.ID_STATE = 2 where tab.ID_STATE = 5;
update LM_PI_SIGNAL_POINT tab set tab.ID_STATE = 2 where tab.ID_STATE = 6;
update LM_PI_SIGNAL_POINT tab set tab.ID_STATE = 3 where tab.ID_STATE = 7;
update LM_PI_SIGNAL_POINT tab set tab.ID_STATE = 4 where tab.ID_STATE = 8;
-- Fehlende Werte eintragen
update LM_PI_SIGNAL_POINT tab set tab.ID_STATE = 3 
 where exists (select 1 from TB_JOB_VERSION v where v.JOB_VERSION = tab.JOB_VERSION and v.JOB_OPERATION_ID != 3)
 and exists (select 1 from MIG_STATE_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION)
 and tab.ID_STATE is NULL;
 
-- LM_SO_SINGLE_OBJECT;
-- Umschreiben der bestehenden Werte:
update LM_SO_SINGLE_OBJECT tab set tab.ID_STATE = 2 where tab.ID_STATE = 5;
update LM_SO_SINGLE_OBJECT tab set tab.ID_STATE = 2 where tab.ID_STATE = 6;
update LM_SO_SINGLE_OBJECT tab set tab.ID_STATE = 3 where tab.ID_STATE = 7;
update LM_SO_SINGLE_OBJECT tab set tab.ID_STATE = 4 where tab.ID_STATE = 8;
-- Fehlende Werte eintragen
update LM_SO_SINGLE_OBJECT tab set tab.ID_STATE = 3 
 where exists (select 1 from TB_JOB_VERSION v where v.JOB_VERSION = tab.JOB_VERSION and v.JOB_OPERATION_ID != 3)
 and exists (select 1 from MIG_STATE_OBJECTS temp where temp.JOB_VERSION = tab.JOB_VERSION)
 and tab.ID_STATE is NULL;
 
commit;

-- *******************************************************************
-- CHECK-ID: 040603
-- Kontrolle (wenn hier Datensätze angezeigt werden, sind dies manuell zu beurteilen und zu attributieren)
-- *******************************************************************
call job3.setjob(2);

select * from LM_LC_SURFACE where ID_STATE is NULL;
select * from LM_PI_PIPE_OBJECT where ID_STATE is NULL;
select * from LM_PI_SIGNAL_POINT where ID_STATE is NULL;
select * from LM_SO_SINGLE_OBJECT where ID_STATE is NULL;

-- *******************************************************************
-- CHECK-ID: 040604
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_STATE_OBJECTS;
commit; 


-- *******************************************************************
-- CHECK-ID: 040605
-- Mutationsperimeter - Statuswerte umschreiben
-- *******************************************************************
call job3.setjob(-1);
update LM_AD_MUTPERIMETER set ID_STATE = 2 where ID_STATE in (5,6);
update LM_AD_MUTPERIMETER set ID_STATE = 3 where ID_STATE in (7);
update LM_AD_MUTPERIMETER set ID_STATE = 4 where ID_STATE in (8);
commit;

-- *******************************************************************
-- CHECK-ID: 040606
-- Statuswerte entfernen die es nicht mehr benötig
-- *******************************************************************
delete from LM_STATE_TBD where ID in (5,6,7,8);
commit;

-- *******************************************************************
-- HILFS-Scripts
-- Alle Tabellen mit dem entsprechenden Attribut suchen
-- select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'ID_STATE');
