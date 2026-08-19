----------------------------------------------------------------------
-- Grundstückstypen bereinigen
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
select
 tbd.ID,
 tbd.VALUE,
 (select count(1) from LM_OW_PROPERTY prop where prop.ID_PROPERTY_TYPE = tbd.id) COUNTS
from
 LM_OW_PROP_CATEGORY_TBD tbd
order by tbd.ID;


-- *******************************************************************
-- CHECK-ID: 050103
-- Kategorien umschreiben
-- *******************************************************************
update LM_OW_PROPERTY set ID_PROPERTY_TYPE = 2 where ID_PROPERTY_TYPE in (10,11,12,13,14); -- Liegenschaften 
update LM_OW_PROPERTY set ID_PROPERTY_TYPE = 3 where ID_PROPERTY_TYPE in (4,5,6,7,9,15,16,17,18,19); -- SDR
update LM_OW_PROPERTY set ID_PROPERTY_TYPE = 4 where ID_PROPERTY_TYPE in (8); -- Bergwerke
commit;

-- *******************************************************************
-- CHECK-ID: 050104
-- Kategorien entfernen die es nicht mehr benötig
-- *******************************************************************
delete from LM_OW_PROP_CATEGORY_TBD where ID in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19);
commit;