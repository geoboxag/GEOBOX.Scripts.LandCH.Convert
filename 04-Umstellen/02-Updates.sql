----------------------------------------------------------------------
-- Diverese Updates nach dem aktiveren des neuen Datenmodelles
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [12.02.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 040201
-- Gemeindegrenzen in das neue Topic fertigstellen
-- *******************************************************************
update TB_DICTIONARY set TOPIC_ID = (select ID from TB_TOPIC where NAME like 'LM_AD_TERRETORIAL_BOUNDARY')
 where F_CLASS_NAME like 'LM_AD_MUNICIPALITY%';
commit;

-- *******************************************************************
-- CHECK-ID: 040202
-- BB Projektierte Fläche direkt im Topic anzeigen
-- *******************************************************************
update TB_DICTIONARY set PARENT_F_CLASS_ID = NULL where F_CLASS_NAME like 'LM_PA_SURFACE_PROJ';
commit;

-- *******************************************************************
-- CHECK-ID: 040203
-- BB Projektierter Objektname - Attribut Objektname in Name/Nummer konsolidieren
-- *******************************************************************
call job3.setjob(-1);
update LM_PA_OBJECT_NAME_PROJ set NAME_NUMBER = OBJECT_NAME;
commit;

call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_OBJECT_NAME_PROJ', 'OBJECT_NAME');
commit;


-- *******************************************************************
-- CHECK-ID: 040204
-- EO Objektnummer - Attribut Objektnummer (SEQUENCE_NUMBER) umbennen in (OBJECT_NUMBER)
-- *******************************************************************
call job3.setjob(-1);
update LM_SO_OBJECT_NUMBER set OBJECT_NUMBER = SEQUENCE_NUMBER;
commit;

call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_SO_OBJECT_NUMBER', 'SEQUENCE_NUMBER');
commit;