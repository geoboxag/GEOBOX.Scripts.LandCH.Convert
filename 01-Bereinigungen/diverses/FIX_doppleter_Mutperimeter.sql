----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Kann zur Korrektur der doppelten Versionen im LM_AD_MUTPERIMETER verwendet werden.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [14.06.2024] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- Hilfstabelle erstellen
create table MIG_MUT_PERIMETER (FID number(10), JOB_VERSION number(10), NEW_VERSION number(10));

-- Rechtsgültige Objekte eintragen
call job3.setjob(-1);
insert into MIG_MUT_PERIMETER (select FID, JOB_VERSION, NULL from LM_AD_MUTPERIMETER mut where exists (select 1 from LM_AD_MUTPERIMETER m where m.FID = mut.FID and m.JOB_VERSION <> mut.JOB_VERSION));

-- Version ergänzen
update MIG_MUT_PERIMETER p1 set p1.NEW_VERSION = (select max(JOB_VERSION) from MIG_MUT_PERIMETER p2 where p1.FID = p2.FID);
-- Doppelte entfernen
delete from MIG_MUT_PERIMETER where JOB_VERSION = NEW_VERSION;

select * from MIG_MUT_PERIMETER;

delete from TB_JOB_VERSION where JOB_VERSION in (select NEW_VERSION from MIG_MUT_PERIMETER);
delete from LM_AD_MUTPERIMETER where JOB_VERSION in (select JOB_VERSION from MIG_MUT_PERIMETER);
update LM_AD_MUTPERIMETER m set m.JOB_VERSION = (select p.JOB_VERSION from MIG_MUT_PERIMETER p where p.NEW_VERSION = m.JOB_VERSION)
 where exists (select 1 from MIG_MUT_PERIMETER pp where m.FID = pp.FID);

-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_MUT_PERIMETER;
commit;