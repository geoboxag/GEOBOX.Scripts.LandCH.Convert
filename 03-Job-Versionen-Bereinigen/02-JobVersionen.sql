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
-- CHECK-ID: 030201
-- Objekte mit einem Konflikt
-- *******************************************************************
select * from TB_JOB_VERSION where CONFLICT is not null;

-- *******************************************************************
-- CHECK-ID: 030202
-- Versionierungstabelle prüfen und korrigieren
-- *******************************************************************
-- CHECK-ID: 030202.1 Kontrolle
select * from 
 TB_JOB_VERSION jv
where
 not exists (select 1 from TB_UFID ufid where ufid.FID = jv.FID);

-- CHECK-ID: 030202.2 Löschen der Einträge
delete from
 TB_JOB_VERSION jv
where
 not exists (select 1 from TB_UFID ufid where ufid.FID = jv.FID);
commit;
-- CHECK-ID: 030202.1 wiederholen

-- *******************************************************************
-- CHECK-ID: 030203
-- Zirkuläre Job beziehungen
-- *******************************************************************
select distinct
 v1.job_id idNew,
 v2.job_id idOld
from
 TB_JOB_VERSION v1
 join TB_JOB_VERSION v2 on v1.JOB_OLD_VERSION = v2.JOB_VERSION
where exists (
 select 1 from
 TB_JOB_VERSION vv1
 join TB_JOB_VERSION vv2 on vv1.JOB_OLD_VERSION = vv2.JOB_VERSION
where vv1.job_id = v2.job_id and vv2.job_id = v1.job_id);

-- *******************************************************************
-- CHECK-ID: 030204
-- Vorgänger ist älter als der Nachfolger
-- *******************************************************************
select * from
(
select
 v.FID, v.JOB_VERSION,
 v.JOB_ID, j.NAME,
 v.EXPIRATION_DATE, v.OPERATION_DATE, j.DATE_CREATED,
 v.JOB_OLD_VERSION,
 ov.OPERATION_DATE OLD_OPERATION_DATE,
 ov.JOB_ID JOB_ID_OLD
from
 TB_JOB_VERSION v
 join tb_job j on v.JOB_ID = j.ID
 left join TB_JOB_VERSION ov on v.JOB_OLD_VERSION = ov.JOB_VERSION
where
 v.JOB_OLD_VERSION > 0
)
where OLD_OPERATION_DATE > OPERATION_DATE;


-- Korrigieren zum Beispiel von Hand in der Rasteransicht
grid select * from 
 TB_JOB_VERSION jv
where exists (
select * from
(
select
 v.FID, v.JOB_VERSION,
 v.JOB_ID, j.NAME,
 v.EXPIRATION_DATE, v.OPERATION_DATE, j.DATE_CREATED,
 v.JOB_OLD_VERSION,
 ov.OPERATION_DATE OLD_OPERATION_DATE,
 ov.JOB_ID JOB_ID_OLD
from
 TB_JOB_VERSION v
 join tb_job j on v.JOB_ID = j.ID
 left join TB_JOB_VERSION ov on v.JOB_OLD_VERSION = ov.JOB_VERSION
where
 v.JOB_OLD_VERSION > 0
) tab
where tab.OLD_OPERATION_DATE > tab.OPERATION_DATE
 and tab.JOB_VERSION = jv.JOB_VERSION);
