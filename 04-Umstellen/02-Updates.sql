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
-- Tabellen
update TB_DICTIONARY set TOPIC_ID = (select ID from TB_TOPIC where NAME like 'LM_AD_TERRETORIAL_BOUNDARY')
 where F_CLASS_NAME like 'LM_AD_MUNICIPALITY%';

-- Topologie Klassen
update TB_DICTIONARY set TOPIC_ID = (select ID from TB_TOPIC where NAME = 'LM_AD_TERRETORIAL_BOUNDARY')
 where F_CLASS_NAME like 'LM_MUNICIP%';
commit;

-- JOB Vorlagen anpassen
update TB_JOB_TOPIC set TOPIC_ID = (select ID from TB_TOPIC where NAME = 'LM_AD_TERRETORIAL_BOUNDARY')
 where ID in (select JOB_TOPIC_ID from TB_JOB_FCLASS where F_CLASS_ID in (select F_CLASS_ID from tb_dictionary where F_CLASS_NAME like 'LM_MUNICIP%'));
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

-- *******************************************************************
-- CHECK-ID: 040205
-- BB - Bodenbedeckungstyp prüfen und umschreiben
-- *******************************************************************
-- Typen DMAV prüfen (sind alle Werte gemäss DMAV eingetragen oder hat es andere?)
select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,15,16,17,18,19,29,30,31,32,36,39,40,41,42,43,46,47,48,49,53,54,55,58,59);
-- Typen KGK prüfen
-- select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,12,13,15,16,17,18,19,23,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,46,47,48,49,53,54,55,58,59,60,66);
 
-- GUT beurteilen, ob die Zuweisung für das Update auf die eigenen Bedürfnisse passt
call job3.setjob(-1);
-- Gebäude
update LM_LC_SURFACE set ID_LC_TYPE = 2 where ID_LC_TYPE in (3,4,5,6,7,8,9,10,65);
-- Strasse (für KGK nur die ID's 14,66)
update LM_LC_SURFACE set ID_LC_TYPE = 11 where ID_LC_TYPE in (12,13,14,66,67,68,69,70);
-- Wasserbecken (KGK ohne die ID's 60)
update LM_LC_SURFACE set ID_LC_TYPE = 19 where ID_LC_TYPE in (60,61);
-- Acker, Wiese, Weide
update LM_LC_SURFACE set ID_LC_TYPE = 29 where ID_LC_TYPE in (27,28);
-- Übrige Intensivkultur
update LM_LC_SURFACE set ID_LC_TYPE = 31 where ID_LC_TYPE in (56);
-- Gartenanlage (KGK nicht ausführen)
update LM_LC_SURFACE set ID_LC_TYPE = 32 where ID_LC_TYPE in (33,34,35,79);
-- Übrige humusierte
update LM_LC_SURFACE set ID_LC_TYPE = 39 where ID_LC_TYPE in (37,38,71,80);
-- Fliessendes Gewässer
update LM_LC_SURFACE set ID_LC_TYPE = 41 where ID_LC_TYPE in (57,72,73,82);
-- Übrige bestockte
update LM_LC_SURFACE set ID_LC_TYPE = 46 where ID_LC_TYPE in (44,45,74);
-- Abbau, Deponie
update LM_LC_SURFACE set ID_LC_TYPE = 53 where ID_LC_TYPE in (50,51,52,75,81);
-- Übrige vegetationslose
update LM_LC_SURFACE set ID_LC_TYPE = 54 where ID_LC_TYPE in (63,64,76,77,83);
-- Übrige befestigte (KGK ohne ID's 23)
update LM_LC_SURFACE set ID_LC_TYPE = 55 where ID_LC_TYPE in (20,21,22,23,24,25,26,78);
commit;

-- *******************************************************************
-- CHECK-ID: 040206
-- EO - Einzelobjektarten prüfen und umschreiben
-- *******************************************************************
-- Einzelobjektart DMAV prüfen (sind alle Werte gemäss DMAV eingetragen oder hat es andere?)
select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE not in (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,65,70);

-- Typen KGK prüfen
-- select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE not in (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,59,60,61,65,70,73);
 
-- Nicht zuweisbare Arten (diese müssen Manuell geändert werden)
select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE in (1,29,44,45,46,54,55,56,63,80,81,82,83,85,86,87,100,105,106,107,10000,10001);
 
-- GUT beurteilen, ob die Zuweisung für das Update auf die eigenen Bedürfnisse passt
call job3.setjob(-1);
-- Mauer
update LM_SO_SINGLE_OBJECT set ID_TYPE = 2 where ID_TYPE in (66,90,101);
-- Unterirdisches Gebäude
update LM_SO_SINGLE_OBJECT set ID_TYPE = 3 where ID_TYPE in (93,108,109);
-- Übriger Gebäudeteil (für KGK ohne die ID's 61)
update LM_SO_SINGLE_OBJECT set ID_TYPE = 4 where ID_TYPE in (47,48,52,61,77,78,91,92,102);
-- Brücke, Passerelle (für KGK ohne die ID's 59, 60)
update LM_SO_SINGLE_OBJECT set ID_TYPE = 8 where ID_TYPE in (59,60);
-- Silo, Turm, Gasometer  (für KGK ohne die ID's 73)
update LM_SO_SINGLE_OBJECT set ID_TYPE = 13 where ID_TYPE in (73,103);
-- Mast, Antenne
update LM_SO_SINGLE_OBJECT set ID_TYPE = 16 where ID_TYPE in (94,95);
-- Uferverbauung
update LM_SO_SINGLE_OBJECT set ID_TYPE = 18 where ID_TYPE in (99);
-- Schwelle
update LM_SO_SINGLE_OBJECT set ID_TYPE = 19 where ID_TYPE in (74,75);
-- Einzelner Fels
update LM_SO_SINGLE_OBJECT set ID_TYPE = 24 where ID_TYPE in (84,98);
-- Schmale bestockte Fläche
update LM_SO_SINGLE_OBJECT set ID_TYPE = 25 where ID_TYPE in (49,51,57);
-- Rinnsal
update LM_SO_SINGLE_OBJECT set ID_TYPE = 26 where ID_TYPE in (62,96);
-- Schmaler Weg
update LM_SO_SINGLE_OBJECT set ID_TYPE = 27 where ID_TYPE in (28,50,76,88,89,97);
-- Bahngeleise
update LM_SO_SINGLE_OBJECT set ID_TYPE = 32 where ID_TYPE in (53,68);
-- Achse
update LM_SO_SINGLE_OBJECT set ID_TYPE = 39 where ID_TYPE in (64,69,104);
-- Jauchegrube, Mistlege
update LM_SO_SINGLE_OBJECT set ID_TYPE = 70 where ID_TYPE in (71,72);