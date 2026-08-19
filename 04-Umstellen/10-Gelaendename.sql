----------------------------------------------------------------------
-- Geländename Punkte ab Label erstellen.
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
-- Punkt ab Label erstellen
-- *******************************************************************
insert into LM_NA_NAMED_LOCALITY_P (FID_NA_NAMED_LOCALITY, GEOM, ORIENTATION) 
select lo.FID, tbl.GEOM, tbl.ORIENTATION
 from
 LM_NA_NAMED_LOCALITY lo
 join LM_NA_NAMED_LOCALITY_TBL tbl on lo.FID = tbl.FID_PARENT
where
 tbl.LABEL_DEF_ID = 1238
 and tbl.job_version in (select min(l.job_version) from LM_NA_NAMED_LOCALITY_TBL l where lo.FID = l.FID_PARENT);
commit;
