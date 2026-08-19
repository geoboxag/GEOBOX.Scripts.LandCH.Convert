----------------------------------------------------------------------
-- Lagefixpunkte - prüfen ob es LFP3 UV hat (sind nicht erlaubt)
-- Auf wunsch können diese in Hilfsfixpunkte geändert werden
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supported, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [05.09.2025] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzen
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 050501
-- Prüfen auf LFP3 mit der Versicherungsart "unversichert"
-- *******************************************************************
select * from LM_CP_PCP where ID_CATEGORY = 2 and ID_POINT_MARK = 5;

-- *******************************************************************
-- CHECK-ID: 050502
-- Alle Punkte mit der Versicherungsart "unversichert" auf Hilfsfixpunkt umschreiben
-- *******************************************************************
update LM_CP_PCP set ID_CATEGORY = 3 where ID_CATEGORY = 2 and ID_POINT_MARK = 5;

commit;