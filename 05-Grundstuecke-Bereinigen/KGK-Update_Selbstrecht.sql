----------------------------------------------------------------------
-- [KGK] Selbstrechttypen ergänzen
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [28.08.2026] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 05KGK01
-- Anzeigen der verwendetn Grundstücksarten (Kategorien)
-- *******************************************************************
call job3.setjob(-1);
-- Erstellt eine Übersicht
select
 tbd.ID,
 tbd.VALUE,
 (select count(1) from LM_OW_PROPERTY prop where prop.ID_PROPERTY_TYPE = tbd.id) COUNTS
from
 LM_OW_PROP_CATEGORY_TBD tbd
 where tbd.ID in (3,4,5,9,15,16,17,18,19)
order by tbd.ID;

-- *******************************************************************
-- CHECK-ID: 05KGK02
-- Kategorien umschreiben
-- *******************************************************************
update LM_OW_DPR dpr set dpr.ID_DPR_TYPE = 2 where exists (select 1 from LM_OW_PROPERTY prop where prop.FID = dpr.FID_OW_PROPERTY and prop.ID_PROPERTY_TYPE in (3,19)); -- Baurecht 
update LM_OW_DPR dpr set dpr.ID_DPR_TYPE = 3 where exists (select 1 from LM_OW_PROPERTY prop where prop.FID = dpr.FID_OW_PROPERTY and prop.ID_PROPERTY_TYPE in (4,15,16)); -- Quellenrecht
update LM_OW_DPR dpr set dpr.ID_DPR_TYPE = 4 where exists (select 1 from LM_OW_PROPERTY prop where prop.FID = dpr.FID_OW_PROPERTY and prop.ID_PROPERTY_TYPE in (9,17)); -- Konzession
update LM_OW_DPR dpr set dpr.ID_DPR_TYPE = 10000 where exists (select 1 from LM_OW_PROPERTY prop where prop.FID = dpr.FID_OW_PROPERTY and prop.ID_PROPERTY_TYPE in (5,18)); -- Weitere
commit;