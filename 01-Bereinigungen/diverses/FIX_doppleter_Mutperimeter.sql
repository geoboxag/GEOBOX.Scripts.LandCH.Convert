----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Kann zur Korrektur der doppelten Versionen im LM_AD_MUTPERIMETER verwendet werden.
-- Stellt den neuen LM_AD_MUTPERIMETER Eintrag auf die ursprüngliche JOB_VERSION um und löscht den alten LM_AD_MUTPERIMETER sowie den neuen TB_JOB_VERSION Eintrag.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [29.10.2026] V 27.1 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
-- Hilfstabelle erstellen
create table MIG_MUT_PERIMETER (FID number(10), JOB_VERSION_OLD number(10), JOB_VERSION_NEW number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(-1);
insert into MIG_MUT_PERIMETER (select FID, JOB_VERSION, NULL from LM_AD_MUTPERIMETER mut where exists (select 1 from LM_AD_MUTPERIMETER m where m.FID = mut.FID and m.JOB_VERSION <> mut.JOB_VERSION));

-- Version ergänzen
update MIG_MUT_PERIMETER p1 set p1.JOB_VERSION_NEW = (select max(JOB_VERSION_OLD) from MIG_MUT_PERIMETER p2 where p1.FID = p2.FID);
-- Doppelte entfernen
delete from MIG_MUT_PERIMETER where JOB_VERSION_OLD = JOB_VERSION_NEW;

select * from MIG_MUT_PERIMETER order by FID, JOB_VERSION_OLD;

-- Alte Einträge in LM_AD_MUTPERIMETER löschen
delete from LM_AD_MUTPERIMETER where JOB_VERSION in (select JOB_VERSION_OLD from MIG_MUT_PERIMETER);
-- Update LM_AD_MUTPERIMETER auf alte JOB_VERSION 
update LM_AD_MUTPERIMETER m set m.JOB_VERSION = (select p.JOB_VERSION_OLD from MIG_MUT_PERIMETER p where p.JOB_VERSION_NEW = m.JOB_VERSION)
 where exists (select 1 from MIG_MUT_PERIMETER pp where m.FID = pp.FID);
-- Neuer Eintrag in JOB_VERSION löschen
delete from TB_JOB_VERSION where JOB_VERSION in (select JOB_VERSION_NEW from MIG_MUT_PERIMETER);

-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_MUT_PERIMETER;
commit;