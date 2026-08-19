----------------------------------------------------------------------
-- JOB-Topic und Objektklassen zuweisung bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 030301
-- JOB-Topic prüfen
-- *******************************************************************
-- CHECK-ID: 030301.1 Anzeigen
select * from TB_JOB_TOPIC jt 
 where not exists (select 1 from TB_TOPIC t where t.ID = jt.TOPIC_ID);

-- CHECK-ID: 030301.2 Löschen der Einträge
delete from
 TB_JOB_TOPIC jt
where not exists (
  select 1 from TB_TOPIC t where t.ID = jt.TOPIC_ID
 );
commit;

-- *******************************************************************
-- CHECK-ID: 030302
-- JOB-Objektklassen prüfen - in JOB-Topics
-- *******************************************************************
-- CHECK-ID: 030302.1 Anzeigen
select * from TB_JOB_FCLASS jfc 
 where not exists (select 1 from TB_JOB_TOPIC jt where jt.ID = jfc.JOB_TOPIC_ID);

-- CHECK-ID: 030302.2 Löschen der Einträge
delete from
 TB_JOB_FCLASS jfc 
where not exists (
 select 1 from TB_JOB_TOPIC jt where jt.ID = jfc.JOB_TOPIC_ID
);
commit;

-- *******************************************************************
-- CHECK-ID: 030303
-- JOB-Objektklassen prüfen - in TB-Dictionry
-- *******************************************************************
-- CHECK-ID: 030303.1 Anzeigen
select * from TB_JOB_FCLASS jfc 
 where not exists (select 1 from TB_DICTIONARY dict where dict.F_CLASS_ID = jfc.F_CLASS_ID);

-- CHECK-ID: 030303.2 Löschen der Einträge
delete from
 TB_JOB_FCLASS jfc 
where not exists (
 select 1 from TB_DICTIONARY dict where dict.F_CLASS_ID = jfc.F_CLASS_ID
);
commit;
