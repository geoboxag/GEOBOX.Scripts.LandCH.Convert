-- *******************************************************************
-- CHECK-ID: 070201
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_MUT_LS_INFOS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10), FID_AD_MUTPERIMETER number(10), FID_AD_MUTPERIMETER_PEND number(10));


-- *******************************************************************
-- CHECK-ID: 070202
-- Objekte eintragen
-- SQL zum Generieren im Helper
-- *******************************************************************
call job3.setjob(1);

insert into MIG_MUT_LS_INFOS (select 
  'LM_OW_REAL_ESTATE', re.FID, re.JOB_VERSION, prop.FID_AD_MUTPERIMETER, null 
 from
  LM_OW_REAL_ESTATE re 
  join LM_OW_PROPERTY prop on prop.FID = re.FID_OW_PROPERTY and prop.FID_AD_MUTPERIMETER <> re.FID_AD_MUTPERIMETER);
commit;
  
insert into MIG_MUT_LS_INFOS (select 'LM_OW_REAL_ESTATE_A', a.FID, a.JOB_VERSION, f.FID_AD_MUTPERIMETER, null
from
 LM_OW_REAL_ESTATE_A a
 join MIG_MUT_LS_INFOS f on a.FID_PARENT = f.FID);
commit; 
 
-- *******************************************************************
-- CHECK-ID: 070206
-- die FID_AD_MUTPERIMETER werden überschrieben
-- *******************************************************************
call job3.setjob(-1);

update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_LS_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);         
update LM_OW_REAL_ESTATE_A tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_LS_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);       
commit;

-- *******************************************************************
-- CHECK-ID: 070208
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_MUT_LS_INFOS;
commit; 