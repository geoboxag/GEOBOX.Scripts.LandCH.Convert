----------------------------------------------------------------------
-- Datenprüfungen - Pendente Grudnstücke - Erstellen der Liegenschaftszentroide als Version für die Mutationen
-- ACHTUNG: Dieses Skript funktioniert nur Zuverlässig, wenn die Grundstücke (LM_OW_PROPERTY) jeweils mit der
-- Schaltfäche auf dem Formular der aktuellen Mutation zugewiesen wurde.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [29.10.2026] V 27.1 / GEOBOX AG (USO) - Skript erstellen.
----------------------------------------------------------------------
-- Anzeigen der pendenten Liegenschaftsmutationen - Information
select distinct
 j.NAME, j.COMMENTARY, t.NAME JOB_VORLAGE, topic.NAME TOPIC_NAME
from
 TB_JOB_VERSION v
 join TB_JOB j on v.JOB_ID = j.ID
 left join TB_JOB_TEMPLATE t on j.JOB_TEMPLATE_ID = t.ID
 left join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID
 left join TB_TOPIC topic on topic.ID = jt.TOPIC_ID 
where
 v.STATE in (2)
 AND topic.NAME in ('LM_OWNERSHIP')
ORDER BY NAME;

-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_PEND_INFOS (OW_FID number(10), OW_JOB_VERSION number(10), OW_JOB_ID number(10), OW_JOB_OP number(10), RE_FID number(10), RE_JOB_VERSION number(10), RE_JOB_ID number(10), RE_JOB_OP number(10));

-- Grundstücke von diesen Mutationen in die Hilfstabelle schreiben
call job3.setjob(-1);
insert into MIG_PEND_INFOS (OW_FID, OW_JOB_VERSION, OW_JOB_ID, OW_JOB_OP) (
select 
 ow.FID, ow.JOB_VERSION, owjv.JOB_ID, owjv.JOB_OPERATION_ID
from
 TB_JOB_VERSION owjv 
 left join LM_OW_PROPERTY ow on owjv.JOB_VERSION = ow.JOB_VERSION
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
));
commit;
-- Vorhandene Liegenschaftszentroid suchen und ergänzen (innerhalb derselben Mutation) >> bei diesen Datensätze muss nichts gemacht werden
update MIG_PEND_INFOS mpi set (mpi.RE_FID, mpi.RE_JOB_VERSION, mpi.RE_JOB_ID, mpi.RE_JOB_OP) = (
 select
  re.FID, re.JOB_VERSION, rejv.JOB_ID, rejv.JOB_OPERATION_ID
 from 
  LM_OW_REAL_ESTATE re
  left join TB_JOB_VERSION rejv on re.JOB_VERSION = rejv.JOB_VERSION
 where mpi.OW_FID = re.FID_OW_PROPERTY and mpi.OW_JOB_ID = rejv.JOB_ID
);
commit

-- select * from MIG_PEND_INFOS;
-- Letzte Version des Liegenschaftszentroid suchen und eintragen >> hier muss eine neue Version erstellt werden
call job3.setjob(2);
update MIG_PEND_INFOS mpi set (mpi.RE_FID, mpi.RE_JOB_VERSION) = (
 select FID, max(JOB_VERSION) from (select
  re.FID, re.JOB_VERSION
 from 
  LM_OW_REAL_ESTATE re
 where mpi.OW_FID = re.FID_OW_PROPERTY
)
group by FID
) where mpi.RE_FID is NULL;
commit

----------------------------------------------------------------------
-- Beheben - Wartungsjob erstellen 'DMAV Pendente Grundstuecke' (falls nicht schon vorhanden)
-- der Wartungsjob sollte anschliessend keine geänderten Objekte enthalten und kann anschliessend gelöscht werden
-- Die fehlenden Datensätze erstellen (UPDATE) und in den entsprechenden Job verschieben.
----------------------------------------------------------------------
-- JOB-ID des Wartungsjob auslesen:
select * from TB_JOB where NAME = 'DMAV Pendente Grundstuecke';

-- Wartungsjob-ID korrekt setzten
define jobID = 1422;

-- JOB-ID des Wartungsjob eintragen und in den Job-Wechseln
call job3.setjob(&&jobID);

-- Update Befehle erstellen
repeat
 select 'update LM_OW_REAL_ESTATE SET FID = FID where JOB_VERSION = $REJOBVERSION;
 update TB_JOB_VERSION set JOB_ID = $JOBID, STATE = $ID_OP, OS_USER_NAME = ''MIG DMAV''
  where JOB_VERSION = (select JOB_VERSION from LM_OW_REAL_ESTATE where FID_OW_PROPERTY = $FID_OW_PROP) and JOB_ID = &&jobID;' from DUAL
for
 select RE_JOB_VERSION REJOBVERSION, OW_JOB_ID JOBID, OW_JOB_OP ID_OP, OW_FID FID_OW_PROP from MIG_PEND_INFOS where RE_JOB_ID is NULL order by RE_FID, RE_JOB_VERSION;

-- Befehle anzeigen, das Resultat kopieren und ausführen...
select VALUE_1 from XSQLSHEET_RESULT order by ID;

-- Resultat als Text ausgeführt? und ein Commit (F9) gemacht?

-- *******************************************************************
-- Hilfstabelle löschen
drop table MIG_PEND_INFOS;
commit; 

----------------------------------------------------------------------
-- Kontrolle
-- Diese Anfrage sollte keine Datensätze mehr zurückliefern
----------------------------------------------------------------------
call job3.setjob(2);
select * from (
select 
 ow.FID, ow.PROPERTY_NUMBER, ow.FID_AD_MUTPERIMETER, mut.IDENTIFICATION,
 owjv.JOB_ID OW_JOB, ow.JOB_VERSION OW_VERSION, owjv.JOB_OPERATION_ID OW_OP,
 re.FID RE_FID, rejv.JOB_ID RE_JOB, re.JOB_VERSION RE_VERSION, rejv.JOB_OPERATION_ID RE_OP
from
 LM_OW_PROPERTY ow
 join TB_JOB_VERSION owjv on ow.JOB_VERSION = owjv.JOB_VERSION
 left join LM_AD_MUTPERIMETER mut on ow.FID_AD_MUTPERIMETER = mut.FID
 left join LM_OW_REAL_ESTATE re on re.FID_OW_PROPERTY = ow.FID
 left join TB_JOB_VERSION rejv on re.JOB_VERSION = rejv.JOB_VERSION
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
where ow_job <> re_job;