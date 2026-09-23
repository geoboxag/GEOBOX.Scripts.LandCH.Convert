----------------------------------------------------------------------
-- Job Versionen aller Objekte entfernen und bereinigen.
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.09.2026] V 1.3 / GEOBOX AG (USO) - Script verbessert.
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
