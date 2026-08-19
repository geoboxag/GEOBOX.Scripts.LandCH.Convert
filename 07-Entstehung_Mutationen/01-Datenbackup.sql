----------------------------------------------------------------------
-- JOB-Infos und FID-Mutationsperiemter als Sicherstellung
-- Die Infos werden für eine Sicherung zusammengetragen und gespeichert.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 070101
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_BK_INFOS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10), FID_AD_MUTPERIMETER number(10), ILI2_OID VARCHAR(36));

-- Objekte eintragen
call job3.setjob(-1);

repeat
  insert into MIG_BK_INFOS (select '$FCLASSNAME', FID, JOB_VERSION, FID_AD_MUTPERIMETER, ILI2_OID from $FCLASSNAME)
FOR
  select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'FID_AD_MUTPERIMETER');
commit;

-- *******************************************************************
-- CHECK-ID: 070102
-- Export der Hilfstabelle
-- *******************************************************************
excel select * from MIG_BK_INFOS;

-- *******************************************************************
-- CHECK-ID: 070103
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_BK_INFOS;
commit; 