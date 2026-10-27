----------------------------------------------------------------------
-- Datenprüfungen - Pendente Grudnstücke
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [24.09.2026] V 2025.2 / GEOBOX AG (USO) - Weitere Prüfungen hinzugefügt
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Potenzielle Kandidaten suchen
-- Es sollte jeweils eine Version der Grundstücke, Liegenschaft und TSUR im selben Job vorhanden sein.
----------------------------------------------------------------------
call job3.setjob(2);
select * from (
select 
 ow.FID, ow.PROPERTY_NUMBER, ow.FID_AD_MUTPERIMETER, mut.IDENTIFICATION,
 owjv.JOB_ID OW_JOB, ow.JOB_VERSION OW_VERSION, owjv.JOB_OPERATION_ID OW_OP,
 re.FID RE_FID, rejv.JOB_ID RE_JOB, re.JOB_VERSION RE_VERSION, rejv.JOB_OPERATION_ID RE_OP,
 tsur.FID TSUR_FID, tsurjv.JOB_ID TSUR_JOB, tsur.JOB_VERSION TSUR_VERSION, tsurjv.JOB_OPERATION_ID TSUR_OP
from
 LM_OW_PROPERTY ow
 join TB_JOB_VERSION owjv on ow.JOB_VERSION = owjv.JOB_VERSION
 left join LM_AD_MUTPERIMETER mut on ow.FID_AD_MUTPERIMETER = mut.FID
 left join LM_OW_REAL_ESTATE re on re.FID_OW_PROPERTY = ow.FID
 left join TB_JOB_VERSION rejv on re.JOB_VERSION = rejv.JOB_VERSION
 left join LM_REAL_ESTATE_TCEN tcen on re.FID = tcen.FID_CENTROID
 left join LM_REAL_ESTATE_TSUR tsur on tcen.FID_TSUR = tsur.FID
 left join TB_JOB_VERSION tsurjv on tsur.JOB_VERSION = tsurjv.JOB_VERSION
where ow.ID_PROPERTY_TYPE = 2 AND
owjv.JOB_ID in (
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
order by ow.FID, owjv.JOB_VERSION)
where ow_job <> re_job or ow_job <> tsur_job or re_job <> tsur_job;

----------------------------------------------------------------------
-- Einzeles Grundstück anzeigen
-- Zeigt anhand der FID des Grundstückes die Datensätze mit den Versionen und Mutationen an.
-- Es sollte pro Mutation ein Datensatz vorhanden sein mit der jeweilg passsenden Operation ID.
----------------------------------------------------------------------
call job3.setjob(-1); -- diese Prüfung mit der JOB ID 2 sollte jeweils ein Datensatz ergeben in derselben Mutation

define fidOW = 54540;

select ow.FID, ow.JOB_VERSION, ow.PROPERTY_NUMBER, jv.JOB_ID, jv.JOB_OPERATION_ID, jv.STATE, j.NAME
from
 LM_OW_PROPERTY ow
 left join TB_JOB_VERSION jv on ow.JOB_VERSION = jv.JOB_VERSION
 left join TB_JOB j on jv.JOB_ID = j.ID
where ow.FID = &&fidOW;

select re.FID, re.JOB_VERSION, jv.JOB_ID, jv.JOB_OPERATION_ID, jv.STATE, j.NAME
from
 LM_OW_REAL_ESTATE re
 left join TB_JOB_VERSION jv on re.JOB_VERSION = jv.JOB_VERSION
 left join TB_JOB j on jv.JOB_ID = j.ID
where re.FID_OW_PROPERTY = &&fidOW;


select tsur.FID, tsur.JOB_VERSION, re.FID FID_RE, jv.JOB_ID, jv.JOB_OPERATION_ID, jv.STATE, j.NAME
from
 LM_REAL_ESTATE_TSUR tsur
 left join TB_JOB_VERSION jv on tsur.JOB_VERSION = jv.JOB_VERSION
 left join TB_JOB j on jv.JOB_ID = j.ID
 left join LM_REAL_ESTATE_TCEN tcen on tsur.FID = tcen.FID_TSUR
 left join LM_OW_REAL_ESTATE re on tcen.FID_CENTROID = re.FID
where re.FID_OW_PROPERTY = &&fidOW;

----------------------------------------------------------------------
-- Beheben - Wartungsjob erstellen 'DMAV Pendente Grundstuecke'
-- Die fehlenden Datensätze erstellen (UPDATE) und in den entsprechenden Job verschieben
-- oder die entsprechenden Datensätze löschen (je nach Resultat).
----------------------------------------------------------------------
-- JOB-ID des Wartungsjob auslesen:
select * from TB_JOB where NAME = 'DMAV Pendente Grundstuecke';

-- Wartungsjob-ID korrekt setzten
define jobID = 1422;

-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(&&jobID);

define fidOBJ = 56659;

UPDATE LM_OW_REAL_ESTATE set ILI2_OID = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where FID = &&fidOBJ;
-- Resultat müssten nun zwei Datensätze sein.
select * from TB_JOB_VERSION where FID = &&fidOBJ;

-- Umschreiben auf die gewünscht Job ID
define newJob = 1415;
-- die neue Job-Version aus dem "select" verwenden
define jobVersion = 324291;

 update TB_JOB_VERSION set JOB_ID = &&newJob, STATE = 2, OS_USER_NAME = 'MIG DMAV'
  where JOB_VERSION = &&jobVersion;
  
----------------------------------------------------------------------
-- Beheben - Wartungsjob erstellen 'DMAV Pendente Grundstuecke'
-- Die entsprechenden Datensätze verschieben oder entfernen
----------------------------------------------------------------------

-- Beispiel:
SQL> define fidOW = 54541
SQL> select ... from  LM_OW_PROPERTY ow ...;

FID   JOB_VERSION PROPERTY_NUMBER JOB_ID JOB_OPERATION_ID STATE NAME   
----- ----------- --------------- ------ ---------------- ----- ------ 
54541 53237       671             3      1                1     1      
54541 312607      671             1415   2                2     1168LS 
2 rows selected.

SQL> select ... from  LM_OW_REAL_ESTATE re ...;

FID   JOB_VERSION JOB_ID JOB_OPERATION_ID STATE NAME 
----- ----------- ------ ---------------- ----- ---- 
56659 55355       3      1                1     1    
>>> Datensatz verdoppel mit UPDATE und der JOB_VERSION der JOB_ID 1415 zuweisen.
1 rows selected.

SQL> select ... from  LM_REAL_ESTATE_TSUR tsur ...;

FID     JOB_VERSION FID_RE JOB_ID JOB_OPERATION_ID STATE NAME   
------- ----------- ------ ------ ---------------- ----- ------ 
1471113 296632      56659  1      -1               1     Live   
1471113 312632      56659  1415   3                2     1168LS 
1676851 312648      56659  1415   1                2     1168LS 
3 rows selected.
