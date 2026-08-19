----------------------------------------------------------------------
-- Nomenklatur bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);


-- *******************************************************************
-- CHECK-ID: 022501
-- Prüfen ob jedes Objekte einen Wert haben.
-- *******************************************************************
-- Falls diese Prüfung NULL Datensätze zurück gibt, kann das Attribut entfernt werden.
select * from LM_NA_LOCAL_NAME where GRUDA_NUMBER is not NULL;
-- Prüft, ob es Datensätze hat, die schonen einen Wert in der LN-Nummer haben, dann können die Werte nicht von der Grunda Nummer in dieses Attrbut kopiert werden.
select * from LM_NA_LOCAL_NAME where GRUDA_NUMBER is not NULL and LN_NUMBER is not NULL;

-- Falls diese Prüfung NULL Datensätze zurück gibt, kann das Attribut entfernt werden.
select * from LM_NA_NAMED_LOCALITY where GRUDA_NUMBER is not NULL;
-- Prüft, ob es Datensätze hat, die schonen einen Wert in der LN-Nummer haben, dann können die Werte nicht von der Grunda Nummer in dieses Attrbut kopiert werden.
select * from LM_NA_NAMED_LOCALITY where GRUDA_NUMBER is not NULL and NL_NUMBER is not NULL;

-- Falls diese Prüfung NULL Datensätze zurück gibt, kann das Attribut entfernt werden.
select * from LM_NA_PLACE_NAME where GRUDA_NUMBER is not NULL;
-- Prüft, ob es Datensätze hat, die schonen einen Wert in der LN-Nummer haben, dann können die Werte nicht von der Grunda Nummer in dieses Attrbut kopiert werden.
select * from LM_NA_PLACE_NAME where GRUDA_NUMBER is not NULL and PL_NUMBER is not NULL;

-- *******************************************************************
-- CHECK-ID: 022502
-- Schreibt die Werte von der Gruda Numer in das Attribut *-Nummer
-- *******************************************************************
update LM_NA_LOCAL_NAME set LN_NUMBER = GRUDA_NUMBER where GRUDA_NUMBER is not NULL and LN_NUMBER is NULL;
update LM_NA_NAMED_LOCALITY set NL_NUMBER = GRUDA_NUMBER where GRUDA_NUMBER is not NULL and NL_NUMBER is NULL;
update LM_NA_PLACE_NAME set PL_NUMBER = GRUDA_NUMBER where GRUDA_NUMBER is not NULL and PL_NUMBER is NULL;
commit;

-- *******************************************************************
-- CHECK-ID: 022503
-- Unnötige Attribute entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_NA_LOCAL_NAME', 'GRUDA_NUMBER');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_NA_NAMED_LOCALITY', 'GRUDA_NUMBER');
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_NA_PLACE_NAME', 'GRUDA_NUMBER');
commit;
