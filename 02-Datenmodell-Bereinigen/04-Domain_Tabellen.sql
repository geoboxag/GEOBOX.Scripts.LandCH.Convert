----------------------------------------------------------------------
-- Prüfen und Bereinigen von Domainwerten
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 020401
-- Qualität ID 13 prüfen
-- *******************************************************************
call job3.setjob(-1);
select * from LM_QUALITY_TBD where ID = 13;
delete LM_QUALITY_TBD where ID = 13;

-- *******************************************************************
-- CHECK-ID: 020402
-- Ursprung anapssen
-- *******************************************************************
delete from LM_ORIGIN_TBD where ID in (55,56); 
-- Deutsch
update LM_ORIGIN_TBD set value = 'unbestimmt', commentary = 'unbestimmt', short_value = 'SE' where ID = 10001;
update LM_ORIGIN_TBD set value = 'Planabgriff', commentary = 'grafisch', short_value = 'SE' where ID = 2;
update LM_ORIGIN_TBD set value = 'terrestrisch', commentary = 'numerisch', short_value = 'SE' where ID = 3;
update LM_ORIGIN_TBD set value = 'GPS', commentary = 'GPS', short_value = 'SE' where ID = 5;
update LM_ORIGIN_TBD set value = 'digitalisiert', commentary = 'grafisch', short_value = 'SE' where ID = 10;
commit;

-- *******************************************************************
-- CHECK-ID: 020403
-- Sprachen anapssen
-- *******************************************************************
-- Deutsch (ITA und FRA ist in Ordnung und muss nicht korrigiert werden)
update LM_LANGUAGE_TBD set value = 'Deutsch' where ID = 2;
update LM_LANGUAGE_TBD set value = 'Französisch' where ID = 3;
update LM_LANGUAGE_TBD set value = 'Italienisch' where ID = 4;
update LM_LANGUAGE_TBD set value = 'Rätoromanisch' where ID = 5;
commit;

-- *******************************************************************
-- CHECK-ID: 020404
-- Dienstbarkeit Linientyp anpassen
-- *******************************************************************
delete from LM_SE_LINETYPE_TBD where ID in (4,5); 
commit;

-- *******************************************************************
-- CHECK-ID: 020405
-- Bodenbeckung Symbol anpassen
-- *******************************************************************
delete from LM_LC_SYMBOL_TBD where ID in (7,8); 
commit;

-- *******************************************************************
-- CHECK-ID: 020406
-- Grenzpunkte Versicherungsart anpassen
-- *******************************************************************
-- Prüfen ob es Datensätze hat, die einen Wert aus der Domaine verwenden
call job3.setjob(-1);
select * from LM_OW_BOUNDARYPOINT where ID_POINT_MARK in (9,10,11,12,13,14,15,16,17,18,19);
-- spezial Fall ID 14 merken für späteres Update nachträgliche Vermarkung
alter table LM_OW_BOUNDARYPOINT add TEMP_DELAY number(1);
update LM_OW_BOUNDARYPOINT set TEMP_DELAY = 1 where ID_POINT_MARK = 14;
-- Werte korrigieren
update LM_OW_BOUNDARYPOINT set ID_POINT_MARK = 8 /*uv*/ where ID_POINT_MARK in (11 /*GB_Hilfspunkt*/,14 /*proj Punkt*/,18 /*andere*/,19 /*Kirchturm*/);
update LM_OW_BOUNDARYPOINT set ID_POINT_MARK = 2 /*Stein*/ where ID_POINT_MARK in (9 /*Stein_Kunstoffzeichen*/,12 /*SdR Punkt*/,13 /*schoener_Stein*/);
update LM_OW_BOUNDARYPOINT set ID_POINT_MARK = 7 /*Kreuz*/ where ID_POINT_MARK in (15 /*geschnitztes_Kreuz*/,16 /*Kreuz-Kreuz*/,17 /*Kreuz-eingemeisselt*/);
update LM_OW_BOUNDARYPOINT set ID_POINT_MARK = 4 /*Bolzen*/ where ID_POINT_MARK in (10 /*Bolzen_Pfahl_Rohr*/);
-- Werte entfernen
delete from LM_OW_POINT_MARK_TBD where ID in (9,10,11,12,13,14,15,16,17,18,19); 
commit;

-- *******************************************************************
-- CHECK-ID: 020407
-- Bodenbedeckung Linienarten
-- *******************************************************************
call job3.setjob(-1);
update LM_LC_SURFACE_L set ID_LINETYPE = 20000 + ID_LINETYPE where ID_LINETYPE is not NULL;
-- Werte korrigieren KGK
-- update LM_LC_SURFACE_L set ID_LINETYPE = 10 where ID_LINETYPE in (20003,20011,20015); /* offen, weicher Übergang */
-- update LM_LC_SURFACE_L set ID_LINETYPE = 11 where ID_LINETYPE in (20004); /* unterirdisch */
-- update LM_LC_SURFACE_L set ID_LINETYPE = 12 where ID_LINETYPE in (20014); /* harter Übergang  */
-- Werte korrigieren CH
update LM_LC_SURFACE_L set ID_LINETYPE = 2 where ID_LINETYPE in (20002,20006,20007,20013,20014,20025); /* ausgezogen */
update LM_LC_SURFACE_L set ID_LINETYPE = 3 where ID_LINETYPE in (20004,20016); /* punktiert */
update LM_LC_SURFACE_L set ID_LINETYPE = 4 where ID_LINETYPE in (20005,20010,20011,20015,20028); /* gestrichelt1 */
update LM_LC_SURFACE_L set ID_LINETYPE = 5 where ID_LINETYPE in (20003,20012,20018); /* gestrichelt2 */
update LM_LC_SURFACE_L set ID_LINETYPE = 8 where ID_LINETYPE in (20017); /* strichpunktiert1 */
update LM_LC_SURFACE_L set ID_LINETYPE = 13 where ID_LINETYPE in (20008,20019,20020,20021,20022,20023,20024,20026,20027,20029,20030,20031); /* unterdrückt virtuell */
update LM_LC_SURFACE_L set ID_LINETYPE = 1 where ID_LINETYPE in (20001);
update LM_LC_SURFACE_L set ID_LINETYPE = 10000 where ID_LINETYPE in (30000);
update LM_LC_SURFACE_L set ID_LINETYPE = 10001 where ID_LINETYPE in (30001);
-- Werte entfernen
delete from LM_LC_LINETYPE_TBD where ID in (14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31);
commit;

-- *******************************************************************
-- CHECK-ID: 020408
-- Einzelobjekt Linienarten
-- *******************************************************************
call job3.setjob(-1);
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 30000 + ID_LINETYPE where ID_LINETYPE is not NULL;
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 30000 + ID_LINETYPE where ID_LINETYPE is not NULL;
-- Werte korrigieren KGK
-- update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 10 where ID_LINETYPE in (30021,30027,30028,30029,30034); /* sichtbar, geschlossen, abgestuft */
-- update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 11 where ID_LINETYPE in (30016); /* offen */
-- update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 12 where ID_LINETYPE in (30004,30026,30030,30033); /* unterirdisch  */
-- update LM_SO_LINE_ELEMENT set ID_LINETYPE = 10 where ID_LINETYPE in (30021,30027,30028,30029,30034); /* sichtbar, geschlossen, abgestuft */
-- update LM_SO_LINE_ELEMENT set ID_LINETYPE = 11 where ID_LINETYPE in (30016); /* offen */
-- update LM_SO_LINE_ELEMENT set ID_LINETYPE = 12 where ID_LINETYPE in (30004,30026,30030,30033); /* unterirdisch  */

-- Werte korrigieren CH
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 2 where ID_LINETYPE in (30002,30012,30017,30019,30021,30024,30025,30027,30028,30029,30031,30034,30039); /* ausgezogen */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 3 where ID_LINETYPE in (30005,30007,30018,30020,30026,30030,30032,30033,30037); /* punktiert */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 4 where ID_LINETYPE in (30013); /* gestrichelt1 */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 5 where ID_LINETYPE in (30003,30016); /* gestrichelt2 */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 8 where ID_LINETYPE in (30008); /* strichpunktiert1 */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 9 where ID_LINETYPE in (30009); /* strichpunktiert2 */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 13 where ID_LINETYPE in (30014,30035,30040); /* unterdrückt virtuell */
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 1 where ID_LINETYPE in (30001,30010,30011,30022,30023,30036,30038,30041,30042);
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 10000 where ID_LINETYPE in (40000);
update LM_SO_SURFACE_ELEMENT_L set ID_LINETYPE = 10001 where ID_LINETYPE in (40001);

update LM_SO_LINE_ELEMENT set ID_LINETYPE = 2 where ID_LINETYPE in (30002,30012,30017,30019,30021,30024,30025,30027,30028,30029,30031,30034,30039); /* ausgezogen */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 3 where ID_LINETYPE in (30005,30007,30018,30020,30026,30030,30032,30033,30037); /* punktiert */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 4 where ID_LINETYPE in (30013); /* gestrichelt1 */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 5 where ID_LINETYPE in (30003,30016); /* gestrichelt2 */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 8 where ID_LINETYPE in (30008); /* strichpunktiert1 */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 9 where ID_LINETYPE in (30009); /* strichpunktiert2 */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 13 where ID_LINETYPE in (30014,30035,30040); /* unterdrückt virtuell */
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 1 where ID_LINETYPE in (30001,30010,30011,30022,30023,30036,30038,30041,30042);
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 10000 where ID_LINETYPE in (40000);
update LM_SO_LINE_ELEMENT set ID_LINETYPE = 10001 where ID_LINETYPE in (40001);

-- Werte entfernen
delete from LM_SO_LINETYPE_TBD where ID in (14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42);
commit;


