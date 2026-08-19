----------------------------------------------------------------------
-- Job Versionen aller Objekte entfernen und bereinigen.
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [12.02.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 040101
-- Wartungsjob suchen und in diesen Wechseln
-- *******************************************************************
-- JOB-ID des Wartungsjob auslesen:
select * from TB_JOB where NAME = 'DMAV Korrekturmutation';
-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(1419);

-- *******************************************************************
-- CHECK-ID: 040102
-- Polygone erstellen
-- *******************************************************************
-- AD_MUNICIPALITY (Gemeindegrenze)
insert into LM_AD_MUNICIP_BOUNDARY_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA)
 select
 F.FID FID,
 TS.GEOM,
 TS.AREA,
 TS.AREA_NOMINAL,
 TS.EXACT_AREA 
from
 LM_AD_MUNICIP_BOUNDARY F
 join LM_MUNICIPALITY_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_MUNICIPALITY_TSUR TS on TS.FID = TC.FID_TSUR;
 
-- LC_SURFACE (Bodenbedeckung)
insert into LM_LC_SURFACE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA)
 select
 F.FID FID,
 TS.GEOM,
 TS.AREA,
 TS.AREA_NOMINAL,
 TS.EXACT_AREA
from
 LM_LC_SURFACE F
 join LM_LAND_COVER_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_LAND_COVER_TSUR TS on TS.FID = TC.FID_TSUR;

-- OW_REAL_ESTATE (Liegenschaften)
insert into LM_OW_REAL_ESTATE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA)
 select
 F.FID FID,
 TS.GEOM,
 TS.AREA,
 TS.AREA_NOMINAL,
 TS.EXACT_AREA
from
 LM_OW_REAL_ESTATE F
 join LM_REAL_ESTATE_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_REAL_ESTATE_TSUR TS on TS.FID = TC.FID_TSUR;

commit;


-- OW_REAL_ESTATE (Liegenschaften)
create table MIG_OW_A (FID number(10), JOB_VERSION number(10), FID_TSUR number(10), JOB_VERSION_TSUR number(10), FID_AD_MUTPERIMETER number(10), JOB_STATE number(10));
-- alle Rechtskräftigen eintragen
call job3.setjob(1);
insert into MIG_OW_A (FID, JOB_VERSION, FID_TSUR, JOB_VERSION_TSUR, FID_AD_MUTPERIMETER, JOB_STATE)
 select
 F.FID FID,
 F.JOB_VERSION JOB_VERSION,
 TS.FID FID_TSUR,
 TS.JOB_VERSION JOB_VERSION_TSUR,
 F.FID_AD_MUTPERIMETER, 1
from
 LM_OW_REAL_ESTATE F
 join LM_REAL_ESTATE_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_REAL_ESTATE_TSUR TS on TS.FID = TC.FID_TSUR;
commit;
-- mit Pendenten ergänzen
call job3.setjob(2);
insert into MIG_OW_A (FID, JOB_VERSION, FID_TSUR, JOB_VERSION_TSUR, FID_AD_MUTPERIMETER, JOB_STATE)
 select
 F.FID FID,
 F.JOB_VERSION JOB_VERSION,
 TS.FID FID_TSUR,
 TS.JOB_VERSION JOB_VERSION_TSUR,
 F.FID_AD_MUTPERIMETER, 2
from
 LM_OW_REAL_ESTATE F
 join LM_REAL_ESTATE_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_REAL_ESTATE_TSUR TS on TS.FID = TC.FID_TSUR
where not exists (select 1 from MIG_OW_A a where a.JOB_VERSION = f.JOB_VERSION);

call job3.setjob(-1);

update LM_OW_REAL_ESTATE_A a set a.FID_AD_MUTPERIMETER = (select m.FID_AD_MUTPERIMETER from MIG_OW_A m where m.FID = a.FID_PARENT and m.JOB_STATE = 1) where a.FID_AD_MUTPERIMETER is NULL;

FID + mit TB2_FID und dann zustellen
