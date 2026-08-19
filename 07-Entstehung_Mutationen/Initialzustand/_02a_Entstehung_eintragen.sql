----------------------------------------------------------------------
-- Job Versionen aller Objekte entfernen und bereinigen.
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [09.10.2024] V 1.1 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
-- Job erstellen mit Mutationsperimeter (Rechteck über die ganze Gemeinde) >> Job-Vorlage ist grundsätzlich egal: Empfehlung Liegenschaftsmutation
-- Wichtig: IDENTIFICATION = 'DMAV Initialzustand' und die OID's sollten für alle Topic abgefüllt sein im Mutationsperimeter.
-- Job kann direkt in den Live zustand überführt werden...
-- Enstehung eintragen bei allen Objekten
call job3.setjob(-1);
repeat
 update $className set FID_AD_MUTPERIMETER = (select FID from LM_AD_MUTPERIMETER where IDENTIFICATION = 'DMAV Initialzustand')
for
select dict.F_CLASS_NAME className
from
 TB_ATTRIBUTE attr 
 join TB_DICTIONARY dict on attr.F_CLASS_ID = dict.F_CLASS_ID
where attr.NAME = 'FID_AD_MUTPERIMETER';
commit;


---------------------------------------------------------------------------------

repeat
 select '$className', count(1) from $className where FID_AD_MUTPERIMETER is null
for
select dict.F_CLASS_NAME className
from
 TB_ATTRIBUTE attr 
 join TB_DICTIONARY dict on attr.F_CLASS_ID = dict.F_CLASS_ID
where attr.NAME = 'FID_AD_MUTPERIMETER';
commit;


call job3.setjob(-1);
update LM_AD_MUNICIP_BOUNDARY_A a set a.FID_AD_MUTPERIMETER = (select f.FID_AD_MUTPERIMETER from LM_AD_MUNICIP_BOUNDARY f where f.FID = a.FID_PARENT) where a.FID_AD_MUTPERIMETER is null;
update LM_LC_SURFACE_A a set a.FID_AD_MUTPERIMETER = (select f.FID_AD_MUTPERIMETER from LM_LC_SURFACE f where f.FID = a.FID_PARENT) where a.FID_AD_MUTPERIMETER is null;
update LM_OW_REAL_ESTATE_A a set a.FID_AD_MUTPERIMETER = (select max(f.FID_AD_MUTPERIMETER) from LM_OW_REAL_ESTATE f where f.FID = a.FID_PARENT) where a.FID_AD_MUTPERIMETER is null;



create table MIG_OW_INFOS (F_CLASS_NAME varchar2(255), JOB_VERSION number(10), FID_AD_MUTPERIMETER number(10), FID_AD_MUTPERIMETER_OW number(10), PROPERTY_NUMBER varchar2(12));

call job3.setjob(1);
insert into MIG_OW_INFOS (select 'LM_OW_REAL_ESTATE', r.JOB_VERSION, r.FID_AD_MUTPERIMETER, p.FID_AD_MUTPERIMETER, p.PROPERTY_NUMBER from LM_OW_REAL_ESTATE r join LM_OW_PROPERTY p on r.FID_OW_PROPERTY = p.FID);
insert into MIG_OW_INFOS (select 'LM_OW_DPR', r.JOB_VERSION, r.FID_AD_MUTPERIMETER, p.FID_AD_MUTPERIMETER, p.PROPERTY_NUMBER from LM_OW_DPR r join LM_OW_PROPERTY p on r.FID_OW_PROPERTY = p.FID); 
insert into MIG_OW_INFOS (select 'LM_OW_MINE', r.JOB_VERSION, r.FID_AD_MUTPERIMETER, p.FID_AD_MUTPERIMETER, p.PROPERTY_NUMBER from LM_OW_MINE r join LM_OW_PROPERTY p on r.FID_OW_PROPERTY = p.FID); 
commit;

call job3.setjob(-1);
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER_OW from MIG_OW_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER_OW from MIG_OW_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER_OW from MIG_OW_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);
commit;


select * from MIG_OW_INFOS2 where FID_AD_MUTPERIMETER <> FID_AD_MUTPERIMETER_OW;