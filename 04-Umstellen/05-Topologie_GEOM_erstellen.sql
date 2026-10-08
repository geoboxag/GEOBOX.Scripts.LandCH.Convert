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

-- Wartungsjob-ID korrekt setzten
define jobID = 1422;

-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(&&jobID);

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


-- *******************************************************************
-- OW_REAL_ESTATE (Liegenschaften) >> Rechtskräftige Objekte
-- *******************************************************************
-- Temp Tabelle erstellen
CREATE TABLE MIG_OW_REAL_ESTATE_A (FID_PARENT NUMBER(10), GEOM MDSYS.SDO_GEOMETRY, AREA NUMBER(20,8), AREA_NOMINAL NUMBER(20,8), EXACT_AREA NUMBER(20,8), JOBID NUMBER(10), VERSION NUMBER(10), OPERATION_ID NUMBER(1));

call job3.setjob(1);
insert into MIG_OW_REAL_ESTATE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA, OPERATION_ID)
 select
 F.FID FID,
 TS.GEOM,
 TS.AREA,
 TS.AREA_NOMINAL,
 TS.EXACT_AREA,
 1
from
 LM_OW_REAL_ESTATE F
 join LM_REAL_ESTATE_TCEN TC on TC.FID_CENTROID = F.FID
 join LM_REAL_ESTATE_TSUR TS on TS.FID = TC.FID_TSUR;
 
-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(&&jobID);

insert into LM_OW_REAL_ESTATE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA)
 select
 F.FID_PARENT FID,
 F.GEOM,
 F.AREA,
 F.AREA_NOMINAL,
 F.EXACT_AREA
from
 MIG_OW_REAL_ESTATE_A F;
commit;

-- Datensätze auf den Live-Job setzten:
call job3.setjob(-1);
update TB_JOB_VERSION jv
 set jv.JOB_ID = 1, jv.STATE = 1, jv.OS_USER_NAME = 'MIG DMAV'
where exists (select 1 from LM_OW_REAL_ESTATE_A a where a.JOB_VERSION = jv.JOB_VERSION);
commit;

-- Update select JOB_VERSION vom Zentroid
CREATE TABLE MIG_JV_REAL_ESTATE_A (JOBVERSION NUMBER(10), JOBID NUMBER(10));
call job3.setjob(1);
insert into MIG_JV_REAL_ESTATE_A (JOBVERSION, JOBID)
select a.JOB_VERSION, rjv.JOB_ID from
 LM_OW_REAL_ESTATE_A a
 join TB_JOB_VERSION ajv on a.JOB_VERSION = ajv.JOB_VERSION
 join LM_OW_REAL_ESTATE r on a.FID_PARENT = r.FID
 join TB_JOB_VERSION rjv on r.JOB_VERSION = rjv.JOB_VERSION
where ajv.STATE = 1;
-- Update JOB_VERSION
call job3.setjob(-1);
update TB_JOB_VERSION jv
 set jv.JOB_ID = (select temp.JOBID from MIG_JV_REAL_ESTATE_A temp where temp.JOBVERSION = jv.JOB_VERSION)
 where exists (select 1 from MIG_JV_REAL_ESTATE_A temp where temp.JOBVERSION = jv.JOB_VERSION);
commit;

DROP TABLE MIG_JV_REAL_ESTATE_A;

-- *******************************************************************
-- OW_REAL_ESTATE (Liegenschaften) >> Pendente Objekte
-- *******************************************************************
-- Temp Tabelle leeren
DELETE MIG_OW_REAL_ESTATE_A;
commit;

-- Pendente Objekte eintragen (Operation UPDATE) - Pendent geändert
call job3.setjob(-1);
insert into MIG_OW_REAL_ESTATE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA, JOBID, VERSION, OPERATION_ID)
select
 F.FID FID,
 TS.GEOM,
 TS.AREA,
 TS.AREA_NOMINAL,
 TS.EXACT_AREA,
 JV.JOB_ID JOBID,
 TS.JOB_VERSION VERSION,
 2
from
 LM_REAL_ESTATE_TSUR TS
 join TB_JOB_VERSION jv on TS.JOB_VERSION = jv.JOB_VERSION and jv.JOB_OPERATION_ID != 3
 join LM_REAL_ESTATE_TCEN TC on TC.FID_TSUR = TS.FID
 join (select DISTINCT F.FID from LM_OW_REAL_ESTATE F) F on F.FID = TC.FID_CENTROID
where JV.JOB_ID in (
 select distinct
  j.ID
 from
  TB_JOB_VERSION v
  join TB_JOB j on v.JOB_ID = j.ID
  left join TB_JOB_TEMPLATE t on j.JOB_TEMPLATE_ID = t.ID
  left join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID
  left join TB_TOPIC topic on topic.ID = jt.TOPIC_ID 
 where
  v.STATE in (2) AND topic.NAME in ('LM_OWNERSHIP')
)
order by TS.FID, TS.JOB_VERSION;

-- Datensätze ändern die neu Eingetragen werden sollen (Operation INSERT) - Pendent erstellt
update MIG_OW_REAL_ESTATE_A a set a.OPERATION_ID = 1
where exists (select 1 from TB_JOB_VERSION jv where jv.JOB_VERSION = a.VERSION and jv.JOB_OPERATION_ID = 1)
and a.VERSION not in (
select 
 tv2.JOB_VERSION
from 
 LM_REAL_ESTATE_TSUR tsur
 join TB_JOB_VERSION tv on tv.JOB_VERSION = tsur.JOB_VERSION and tv.JOB_OPERATION_ID = 3 and tv.STATE = 2
 join LM_REAL_ESTATE_TCEN tcen on tsur.FID = tcen.FID_TSUR
 join LM_REAL_ESTATE_TCEN tc2 on tcen.FID_CENTROID = tc2.FID_CENTROID
 join LM_REAL_ESTATE_TSUR tsur2 on tc2.FID_TSUR = tsur2.FID
 join TB_JOB_VERSION tv2 on tsur2.JOB_VERSION = tv2.JOB_VERSION
where tc2.FID_TSUR != tcen.FID_TSUR);
commit;

-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(&&jobID);
-- Pendent erstellte Einträge erstellen
insert into LM_OW_REAL_ESTATE_A (FID_PARENT, GEOM, AREA, AREA_NOMINAL, EXACT_AREA)
select
 F.FID_PARENT FID,
 F.GEOM,
 F.AREA,
 F.AREA_NOMINAL,
 F.EXACT_AREA
from
 MIG_OW_REAL_ESTATE_A F
where
 F.OPERATION_ID = 1;
commit;

-- Datensätze der korrekten Mutation zuweisen und auf den Status pendent
update TB_JOB_VERSION ujv set 
 ujv.JOB_ID = (
  select ma.JOBID from
   TB_JOB_VERSION jv
   join LM_OW_REAL_ESTATE_A rea on jv.JOB_VERSION = rea.JOB_VERSION
   join MIG_OW_REAL_ESTATE_A ma on rea.FID_PARENT = ma.FID_PARENT and ma.OPERATION_ID = 1
  where jv.JOB_VERSION = ujv.JOB_VERSION),
 ujv.STATE = 2, ujv.OS_USER_NAME = 'MIG DMAV'
where ujv.JOB_ID = &&jobID;
commit;

-- Update Befehle erstellen
repeat
 select 'update LM_OW_REAL_ESTATE_A SET ( GEOM ,AREA ,AREA_NOMINAL ,EXACT_AREA ) =
  (select GEOM,AREA,AREA_NOMINAL,EXACT_AREA from MIG_OW_REAL_ESTATE_A where VERSION = $VERSION)
  where FID_PARENT = $FID_PARENT;
 update TB_JOB_VERSION set JOB_ID = $JOBID, STATE = 2, OS_USER_NAME = ''MIG DMAV''
  where JOB_VERSION = (select JOB_VERSION from LM_OW_REAL_ESTATE_A where FID_PARENT = $FID_PARENT) and JOB_ID = &&jobID;' from DUAL
for
 select FID_PARENT, JOBID, VERSION from MIG_OW_REAL_ESTATE_A where OPERATION_ID = 2 order by VERSION;

-- Befehle anzeigen, das Resultat kopieren und ausführen...
select VALUE_1 from XSQLSHEET_RESULT order by ID;

-- Resultat als Text ausgeführt? und ein Commit (F9) gemacht?

DROP TABLE MIG_OW_REAL_ESTATE_A;