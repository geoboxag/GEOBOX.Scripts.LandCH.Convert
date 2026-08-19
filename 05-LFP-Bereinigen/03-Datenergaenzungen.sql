----------------------------------------------------------------------
-- Setzt die fehlenden Informationen bei den LFP's
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- *******************************************************************
-- CHECK-ID: 050301
-- Hilfstabelle erstellen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_LFP_OBJECTS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(1);

insert into MIG_LFP_OBJECTS (select 'LM_CP_PCP', FID, JOB_VERSION from LM_CP_PCP);
commit;

-- *******************************************************************
-- CHECK-ID: 050302
-- LFP aktiver Unterhalt setzten
-- *******************************************************************
call job3.setjob(-1);

-- LFP 3 auf TRUE
update LM_CP_PCP tab set tab.ACTIV_MAINTENANCE = 1 where ID_CATEGORY = 2 and exists (select 1 from MIG_LFP_OBJECTS lfp where lfp.JOB_VERSION = tab.JOB_VERSION);
-- Hilfsfixpunkte auf FLASE
update LM_CP_PCP tab set tab.ACTIV_MAINTENANCE = 0 where ID_CATEGORY = 3 and exists (select 1 from MIG_LFP_OBJECTS lfp where lfp.JOB_VERSION = tab.JOB_VERSION);

-- Kontrolle (wenn hier Datensätze angezeigt werden, sind dies manuell zu beurteilen und zu attributieren)
call job3.setjob(2);
select * from LM_CP_PCP where ACTIV_MAINTENANCE is NULL;
commit;

-- *******************************************************************
-- CHECK-ID: 050303
-- Genzpunktfunktion eintragen
-- *******************************************************************
call job3.setjob(1);
-- Hilfstabelle erstellen
create table MIG_COORD_OBJECTS (POINTTYPE varchar2(30), COORD varchar2(100));

-- Grenzpunkt
insert into MIG_COORD_OBJECTS (select 3, t.X||t.Y coord from LM_OW_REAL_ESTATE_L l, TABLE(SDO_UTIL.GETVERTICES(l.GEOM)) t);
-- Hoheitsgrenzpunkt - auf Kantonsgrenze
insert into MIG_COORD_OBJECTS (select 4, t.X||t.Y coord from LM_AD_CANTON_BOUNDARY_L l, TABLE(SDO_UTIL.GETVERTICES(l.GEOM)) t);
-- Hoheitsgrenzpunkt - auf Bezirksgrenze
insert into MIG_COORD_OBJECTS (select 4, t.X||t.Y coord from LM_AD_DISTRICT_BOUNDARY_L l, TABLE(SDO_UTIL.GETVERTICES(l.GEOM)) t);
-- Hoheitsgrenzpunkt - auf Gemeindegrenze
insert into MIG_COORD_OBJECTS (select 4, t.X||t.Y coord from LM_AD_MUNICIP_BOUNDARY_L l, TABLE(SDO_UTIL.GETVERTICES(l.GEOM)) t);
commit;

call job3.setjob(-1);
-- Grenzpunkt
update LM_CP_PCP p set p.ID_POINTTYPE = 3 where exists
 (select 1 from MIG_COORD_OBJECTS tab where tab.coord = p.GEOM.SDO_POINT.X||p.GEOM.SDO_POINT.Y and tab.POINTTYPE = 3)
 and exists (select 1 from MIG_LFP_OBJECTS o where o.JOB_VERSION = p.JOB_VERSION);

-- Hoheitsgrenzpunkt - auf Kantonsgrenze/Bezirksgrenze/Gemeindegrenze
update LM_CP_PCP p set p.ID_POINTTYPE = 4 where exists
 (select 1 from MIG_COORD_OBJECTS tab where tab.coord = p.GEOM.SDO_POINT.X||p.GEOM.SDO_POINT.Y and tab.POINTTYPE = 4)
 and exists (select 1 from MIG_LFP_OBJECTS o where o.JOB_VERSION = p.JOB_VERSION);

-- keine - wenn NULL
update LM_CP_PCP p set p.ID_POINTTYPE = 2 where p.ID_POINTTYPE is NULL and not exists
 (select 1 from MIG_COORD_OBJECTS tab where tab.coord = p.GEOM.SDO_POINT.X||p.GEOM.SDO_POINT.Y)
 and exists (select 1 from MIG_LFP_OBJECTS o where o.JOB_VERSION = p.JOB_VERSION);
-- IstHoheitsgrenzsteinAlt entfernen bei "kein" Hoheitsgrenzpunkt (FIX für MANDATORY CONSTRAINT CH020204: (Grenzpunktfunktion!=#keine)==DEFINED(IstHoheitsgrenzsteinAlt);)
update LM_CP_PCP set SPECIAL_OLD_MARK = NULL where ID_POINTTYPE in (2);

commit;

-- *******************************************************************
-- CHECK-ID: 050304
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_COORD_OBJECTS;
drop table MIG_LFP_OBJECTS;
commit; 