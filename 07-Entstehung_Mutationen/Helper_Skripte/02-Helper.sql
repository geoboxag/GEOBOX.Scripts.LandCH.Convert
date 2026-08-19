----------------------------------------------------------------------
-- FID_AD_MUTPERIMETER Helper Skript
-- Informationen zusammentragen und eintragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

select SQL from (
select 
  d.F_CLASS_NAME TABNAME,
  'insert into MIG_MUT_INFOS (select ''' || d.F_CLASS_NAME || ''', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from ' || d.F_CLASS_NAME || ');' sql
from TB_DICTIONARY d
where d.F_CLASS_ID in (
  select a.F_CLASS_ID from TB_ATTRIBUTE a where NAME = 'FID_AD_MUTPERIMETER'
)
order by TABNAME);

-- JOB 2
select SQL from (
select 
  d.F_CLASS_NAME TABNAME,
  'insert into MIG_MUT_INFOS (select ''' || d.F_CLASS_NAME || ''', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from ' || d.F_CLASS_NAME || ' tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));' sql
from TB_DICTIONARY d
where d.F_CLASS_ID in (
  select a.F_CLASS_ID from TB_ATTRIBUTE a where NAME = 'FID_AD_MUTPERIMETER_PEND'
)
order by TABNAME);