----------------------------------------------------------------------
-- LFP-Tabelle Bereinigen - LFP 1 und 2 löschen
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 050101
-- Lagefixpunkte der Kategorie 1 und 2 entfernen (neu aus Servicedaten)
-- *******************************************************************
call job3.setjob(-1);
-- Erstellt eine Übersicht über verwendete Fixpunktarten
select (select value from LM_CP_PCP_CATEGORY_TBD tbd where tbd.id = pcp.ID_CATEGORY) Type, pcp.ID_CATEGORY ID, count(1) from LM_CP_PCP pcp group by ID_CATEGORY;

-- Löschen der Punkte und Labels der LFP Kat. 1 und Kat. 2
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CP_PCP tab where tab.FID = jv.FID and tab.ID_CATEGORY in (2,3));
delete TB_UFID uf where EXISTS (select 1 from LM_CP_PCP tab where tab.FID = uf.FID and tab.ID_CATEGORY in (2,3));
delete from LM_CP_PCP where ID_CATEGORY in (2,3);
commit;
-- Löschen der Labels
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CP_PCP_TBL tab where tab.FID = jv.FID and not exists (select 1 from LM_CP_PCP pcp where pcp.FID = tab.FID_PARENT));
delete TB_UFID uf where EXISTS (select 1 from LM_CP_PCP_TBL tab where tab.FID = uf.FID and not exists (select 1 from LM_CP_PCP pcp where pcp.FID = tab.FID_PARENT));
delete from LM_CP_PCP_TBL tbl where not exists (select 1 from LM_CP_PCP pcp where pcp.FID = tbl.FID_PARENT);
commit;

-- *******************************************************************
-- CHECK-ID: 050102
-- Kategorien anpassen
-- *******************************************************************
-- Deutsch
update LM_CP_PCP_CATEGORY_TBD set designer = null where ID in (1,10000,10001);

-- *******************************************************************
-- CHECK-ID: 050103
-- Kategorien umschreiben Lagefixpunkte der Kategorie 4 sind neu Hilfsfixpunkte
-- *******************************************************************
update LM_CP_PCP set ID_CATEGORY = 2 where ID_CATEGORY = 4; /* LFP 3 */
update LM_CP_PCP set ID_CATEGORY = 3 where ID_CATEGORY = 5; /* LFP 4 auf Hilfsfixpunkt */
update LM_CP_PCP set ID_CATEGORY = 3 where ID_CATEGORY = 7; /* Hilfsfixpunkt */
commit;

-- *******************************************************************
-- CHECK-ID: 050104
-- Kategorien entfernen die es nicht mehr benötig
-- *******************************************************************
delete from LM_CP_PCP_CATEGORY_TBD where ID in (4,5,6,7);
commit;

-- *******************************************************************
-- CHECK-ID: 050103
-- Schutzart umschreiben
-- *******************************************************************
update LM_CP_PCP set ID_PROTECTION_TYPE = 4 where ID_PROTECTION_TYPE = 6; /* ueberdeckt */
commit;

-- *******************************************************************
-- CHECK-ID: 050104
-- Schutzarten entfernen die es nicht mehr benötig
-- *******************************************************************
delete from LM_CP_PROTECTIONTYPE_TBD where ID in (5,6,7,8,9,10,11);
commit;

-- *******************************************************************
-- CHECK-ID: 050103
-- Vermarkungprüfen
-- *******************************************************************
-- Hilfspunkt (CR, PN) neu >> Pfahl
select * from LM_CP_PCP where ID_POINT_MARK = 7;
-- Hoheitsgrenzstein neu >> Kunststoffzeichen
select * from LM_CP_PCP where ID_POINT_MARK = 8;

-- *******************************************************************
-- CHECK-ID: 050103
-- Vermarkung umschreiben
-- *******************************************************************
update LM_CP_PCP set ID_POINT_MARK = 7 where ID_POINT_MARK = 19; /* Pfahl */
update LM_CP_PCP set ID_POINT_MARK = 8 where ID_POINT_MARK = 11; /* Kunststoffzeichen */
commit;

-- *******************************************************************
-- CHECK-ID: 050104
-- Vermarkungsarten entfernen die es nicht mehr benötig
-- *******************************************************************
delete from LM_CP_PCP_MARK_TBD where ID in (9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);
commit;