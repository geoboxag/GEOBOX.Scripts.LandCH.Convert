----------------------------------------------------------------------
-- Job Versionen aller Objekte entfernen und bereinigen.
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 030101
-- Jobs "in Bearbeitung" - darf es keine haben
-- *******************************************************************
select distinct
 j.NAME, j.COMMENTARY, t.NAME JOB_VORLAGE
from
 TB_JOB_VERSION v,
 TB_JOB j,
 TB_JOB_TEMPLATE t
where
 v.JOB_ID = j.ID and
 j.JOB_TEMPLATE_ID = t.ID and
 v.STATE in (3)
ORDER BY NAME;

-- *******************************************************************
-- CHECK-ID: 030102
-- Gesperrte Objekte in Jobs
-- *******************************************************************
select 'Gesperrte Jobs:' CHECKS, count(1) RESULTS from TB_JOB where IS_LOCKED = 1 and ID not in (1,2)
union all
select 'Gesperrte Objekte:' CHECKS, count(1) RESULTS from TB_JOB_LOCKING;  

-- *******************************************************************
-- CHECK-ID: 030103
-- Jobs in Kontrolle nur Grundstücksmutationen erlaubt
-- *******************************************************************
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
 AND topic.NAME not in ('LM_OWNERSHIP','LM_ADMINISTRATIVE','LM_CONTROL_POINTS')
ORDER BY NAME;

-- *******************************************************************
-- CHECK-ID: 030104
-- Jobs ohne geänderte Objekten
-- *******************************************************************
-- Check
select * from TB_JOB j where not exists (select 1 from TB_JOB_VERSION jv where jv.job_id = j.id) and j.id not in (1,2,3);

-- Löschen der Jobs 
delete from TB_JOB j where not exists (select 1 from TB_JOB_VERSION jv where jv.job_id = j.id) and j.id not in (1,2,3);

-- *******************************************************************
-- CHECK-ID: 030105
-- Jobs mit mehr als einem Job-Status
-- *******************************************************************
select * from (
select
 j.ID,
 j.NAME,
(select count(1) from TB_JOB_VERSION v where v.STATE = 1 and v.JOB_ID = j.ID) as STATE1,
(select count(1) from TB_JOB_VERSION v where v.STATE = 2 and v.JOB_ID = j.ID) as STATE2,
(select count(1) from TB_JOB_VERSION v where v.STATE = 3 and v.JOB_ID = j.ID) as STATE3
from
 TB_JOB j)
where STATE1 > 0 and STATE2 > 0 and STATE3 > 0;
