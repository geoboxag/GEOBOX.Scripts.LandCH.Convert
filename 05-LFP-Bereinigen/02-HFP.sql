----------------------------------------------------------------------
-- LFP-Tabelle Bereinigen - HFP 1 und 2 löschen
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 050201
-- Höhenfixpunkte der Kategorie 1 und 2 entfernen (neu aus Servicedaten)
-- *******************************************************************
call job3.setjob(-1);
-- Erstellt eine Übersicht
select (select value from LM_CP_ACP_CATEGORY_TBD tbd where tbd.id = ID_CATEGORY) Type, ID_CATEGORY ID, count(1) from LM_CP_ACP acp group by ID_CATEGORY;

-- Löschen der Punkte
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CP_ACP tab where tab.FID = jv.FID and tab.ID_CATEGORY in (2,3));
delete TB_UFID uf where EXISTS (select 1 from LM_CP_ACP tab where tab.FID = uf.FID and tab.ID_CATEGORY in (2,3));
delete from LM_CP_ACP where ID_CATEGORY in (2,3);
commit;
-- Löschen der Labels
delete from TB_JOB_VERSION jv where EXISTS (select * from LM_CP_ACP_TBL tab where tab.FID = jv.FID and not exists (select 1 from LM_CP_ACP acp where acp.FID = tab.FID_PARENT));
delete TB_UFID uf where EXISTS (select 1 from LM_CP_ACP_TBL tab where tab.FID = uf.FID and not exists (select 1 from LM_CP_ACP acp where acp.FID = tab.FID_PARENT));
delete from LM_CP_ACP_TBL tbl where not exists (select 1 from LM_CP_ACP acp where acp.FID = tbl.FID_PARENT);
commit;
