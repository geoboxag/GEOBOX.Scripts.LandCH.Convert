----------------------------------------------------------------------
-- Setzt den Wert Linienart bei der Bodenbeckungslinien aufgrund der Art im Zentroid
-- Dies wird nur bei den aktuellen Objekten eingetragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 040901
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_BB_LINETYPE (FID number(10), JOB_VERSION number(10), LC_TYPE1 number(10), LC_TYPE2 number(10), ID_LINETYPE number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(1);

insert into MIG_BB_LINETYPE
 select
  lc.FID, lc.JOB_VERSION, cs1.ID_LC_TYPE TYPE1, cs2.ID_LC_TYPE TYPE2, NULL
 from
  LM_LC_SURFACE_L lc
  left join LM_LAND_COVER_TEDG cte on cte.FID_EDGE = lc.FID
  left join LM_LAND_COVER_TCEN ctc1 on ABS(cte.EAREA) = ctc1.FID_TSUR
  left join LM_LC_SURFACE cs1 on ctc1.FID_CENTROID = cs1.FID
  left join LM_LAND_COVER_TCEN ctc2 on ABS(cte.SAREA) = ctc2.FID_TSUR
  left join LM_LC_SURFACE cs2 on ctc2.FID_CENTROID = cs2.FID
 where lc.ID_LINETYPE is NULL;
commit;
-- *******************************************************************
-- CHECK-ID: 040902
-- Linientypen ermitteln
-- ******************************************************************* 
update MIG_BB_LINETYPE set ID_LINETYPE = 13 where ID_LINETYPE is NULL and LC_TYPE1 = LC_TYPE2;
update MIG_BB_LINETYPE set ID_LINETYPE = 13 where ID_LINETYPE is NULL and LC_TYPE1 = 41 and LC_TYPE2 = 42;
update MIG_BB_LINETYPE set ID_LINETYPE = 13 where ID_LINETYPE is NULL and LC_TYPE1 = 42 and LC_TYPE2 = 41;

update MIG_BB_LINETYPE set ID_LINETYPE = 2 where ID_LINETYPE is NULL and (LC_TYPE1 in (2,11,15,16,18,19,40,41) or LC_TYPE2 in (2,11,15,16,18,19,40,41));

update MIG_BB_LINETYPE set ID_LINETYPE = 4 where ID_LINETYPE is NULL;
commit;
-- Tabelle abfragen
-- select * from MIG_BB_LINETYPE;

-- *******************************************************************
-- CHECK-ID: 040903
-- Objekte aktualisieren
-- *******************************************************************
call job3.setjob(-1);
update LM_LC_SURFACE_L tab set tab.IS_MANUAL_LINETYPE = 1 where tab.ID_LINETYPE IS NOT null;
commit;

update LM_LC_SURFACE_L tab set tab.ID_LINETYPE = (select ID_LINETYPE from MIG_BB_LINETYPE temp where temp.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from MIG_BB_LINETYPE lt where lt.JOB_VERSION = tab.JOB_VERSION);
commit;

-- *******************************************************************
-- CHECK-ID: 040904
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_BB_LINETYPE;
commit;
