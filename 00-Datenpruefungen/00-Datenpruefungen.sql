----------------------------------------------------------------------
-- Datenprüfungen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [24.09.2026] V 27.3 / GEOBOX AG (USO) - Kleinere Verbesserungen
----------------------------------------------------------------------
-- HINWEIS: die Prüfungen können wahlweise auf den pendenten Zustand oder auf alle (-1) Elemente angewendet werden.
-- bei der Prüfung mit dem pendeten Zustand können allenfalls pendet, gelöschte Objekte nicht geprüft werden.
-- Pendenter Zusatnd kontrollieren
call job3.setjob(2);
-- Alle Datensätze prüfen (auch gelöschte)
call job3.setjob(-1);

----------------------------------------------------------------------
-- Mutationsperimeter
----------------------------------------------------------------------
-- NBIdent abgefüllt
select * from LM_AD_MUTPERIMETER where FID_IDENTND is NULL;

-- Keine doppelten Versionen vorhanden (Resultat sollte NULL sein)
select * from LM_AD_MUTPERIMETER mut where exists (select 1 from LM_AD_MUTPERIMETER m where m.FID = mut.FID and m.JOB_VERSION <> mut.JOB_VERSION) order by FID;
-- Doppelte Mutationsperimeter können mit dem Script 01-Bereinigungen\diverses\FIX_doppleter_Mutperimeter.sql bereinigt werden.

-- Verteckte Zeichen in der Beschreibung suchen
select
 FID,
 IDENTIFICATION,
 ILI2_OID,
 REPLACE(REPLACE(DESCRIPTION , CHR(13), '\r'), CHR(10), '\n')
from
 LM_AD_MUTPERIMETER
where REGEXP_LIKE(DESCRIPTION, '[[:cntrl:]]');
-- UPDATE LM_AD_MUTPERIMETER SET DESCRIPTION = REGEXP_REPLACE(DESCRIPTION, '[[:cntrl:]]', '') WHERE REGEXP_LIKE(DESCRIPTION, '[[:cntrl:]]');

-- Vorgänger und Nachfolger prüfen
select 
 jv.FID Nachfolger_FID, jv.JOB_ID Nachfolger_Job, jv.OPERATION_DATE Nachfolger_Datum, jvdict.F_CLASS_NAME Nachfolger_Objektklasse,
 jo.FID Vorgaenger_FID, jo.JOB_ID Vorgaenger_Job, jo.OPERATION_DATE Vorgaenger_Datum, jodict.F_CLASS_NAME Vorgaenger_Objektklasse
from
 TB_JOB_VERSION jv
 join TB_JOB_VERSION jo on jv.JOB_OLD_VERSION = jo.JOB_VERSION
 left join TB_UFID jvufid on jv.FID = jvufid.FID
 left join TB_DICTIONARY jvdict on jvufid.F_CLASS_ID = jvdict.F_CLASS_ID
 left join TB_UFID joufid on jo.FID = joufid.FID
 left join TB_DICTIONARY jodict on joufid.F_CLASS_ID = jodict.F_CLASS_ID 
where
 jv.FID <> jo.FID;
 
-- Ungültige Geometrien prüfen:
SELECT * FROM LM_AD_MUTPERIMETER t WHERE GEOM is not NULL AND SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(t.GEOM, 0.0005) <> 'TRUE';
-- Versuchen automatisch zu korrigieren
call job3.setjob(-1);
update LM_AD_MUTPERIMETER a set a.geom = sdo_util.rectify_geometry(a.geom, 0.0005) where substr(sdo_geom.validate_geometry_with_context(a.geom, 0.0005),1,5) in ('13347', '13356', '13367','13349','13346');


----------------------------------------------------------------------
-- Bodenbedeckung
----------------------------------------------------------------------
-- LAGEGENAUIGKEIT: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_LC_SINGLE_POINT where TB_ACCURACY_POSITION is NULL or TB_ACCURACY_POSITION < 0.001 or TB_ACCURACY_POSITION > 7.000;
-- LAGEGENAUIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0.001...7.000]!
-- update LM_LC_SINGLE_POINT set TB_ACCURACY_POSITION = x.x where TB_ACCURACY_POSITION is null;
-- ISTLAGEZUVERLAESSIG: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_LC_SINGLE_POINT where TB_POSITION_RELIABLE is NULL or TB_POSITION_RELIABLE > 1;
-- LAGEZUVERLÄSSIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0,1]!
-- update LM_LC_SINGLE_POINT set TB_POSITION_RELIABLE = x where TB_POSITION_RELIABLE is null;

-- Prüfung des zulässigen Wertebereichs der Höhe [-200..5000]:
select * from LM_LC_SINGLE_POINT where Z < -200 or Z > 5000;

-- Die Werte müssen Abgefüllt sein, wenn Höhe (Z) vorhanden:
-- CH091201: DEFINED(Hoehengeometrie)==DEFINED(Hoehengenauigkeit)
select * from LM_LC_SINGLE_POINT where TB_ACCURACY_HEIGHT is null and Z is not null;
-- Höhengenauigkeit mit Stadndardwerten abfüllen wenn leer und Höhe vorhanden. Standardwert noch eintragen [0.001...7.000]!
-- update LM_LC_SINGLE_POINT set TB_ACCURACY_HEIGHT = x.x where TB_ACCURACY_HEIGHT is null and z is not null;
-- CH091202: DEFINED(Hoehengeometrie)==DEFINED(IstHoehenzuverlaessig);
select * from LM_LC_SINGLE_POINT where TB_HEIGHT_RELIABLE is null and Z is not null;
-- LAGEZUVERLÄSSIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0,1]!
-- update LM_LC_SINGLE_POINT set TB_HEIGHT_RELIABLE = x where TB_HEIGHT_RELIABLE is null and z is not null;

-- Bodenbedeckungstyp DMAV prüfen (sind alle Werte gemäss DMAV eingetragen oder hat es andere?)
-- Zusammenstellung der verwendeten ID_LC_TYPE mit Bezeichnung und Anzahl:
select lc.ID_LC_TYPE, cat.VALUE, count(lc.FID)
 from LM_LC_SURFACE lc left join LM_LC_CATEGORY_TBD cat on lc.ID_LC_TYPE = cat.ID
 where lc.ID_LC_TYPE not in (2,11,15,16,17,18,19,29,30,31,32,36,39,40,41,42,43,46,47,48,49,53,54,55,58,59)
 group by ID_LC_TYPE, VALUE
 order by ID_LC_TYPE;
--Bei Bedarf können die einzelnen Datensätze angezeigt werden: 
--select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,15,16,17,18,19,29,30,31,32,36,39,40,41,42,43,46,47,48,49,53,54,55,58,59);

-- Typen KGK prüfen
-- select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,12,13,15,16,17,18,19,23,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,46,47,48,49,53,54,55,58,59,60,66);

-- Domain-Werte ID_LC_TYPE prüfen (ACTIVE = 0)
-- "--" Bei where-Zeile entfernen, um Standardzuweisungen auszuschliessen
select distinct lc.ID_LC_TYPE, TBD.VALUE, TBD.ACTIVE
 from LM_LC_SURFACE lc
 left join LM_LC_CATEGORY_TBD tbd on lc.ID_LC_TYPE = tbd.ID
 order by ID_LC_TYPE;
 
-- GUT beurteilen, ob die Zuweisung für das Update auf die eigenen Bedürfnisse passt >> Updates sind im Skript 04-Umstellen - 02-Updates

----------------------------------------------------------------------
-- Dienstbarkeiten
----------------------------------------------------------------------
-- NBIdent abgefüllt (neu Pflichtfeld im DMAV)
select * from LM_SE_SERVITUDE where FID_IDENTND is NULL;

-- Flächenelement mit korrektem Geometrie TYPE
SELECT
 g.FID, g.ILI2_OID,
 CASE MOD(g.geom.SDO_GTYPE, 100)
    WHEN 1 THEN 'Point'
    WHEN 2 THEN 'Line'
    WHEN 3 THEN 'Polygon'
    WHEN 4 THEN 'Collection'
    WHEN 5 THEN 'MultiPoint'
    WHEN 6 THEN 'MultiLine'
    WHEN 7 THEN 'MultiPolygon'
    ELSE 'Unknown'
  END AS geom_type
FROM 
 LM_SE_SURFACE_ELEMENT g
WHERE
 g.geom IS NOT NULL;
 
-- Beim Compound-Objekt könnte helfen, die Geomtrien nue zu erstellen
-- call job3.setjob(-1);
-- call MAPSYS.TBCompound.updateCompoundFeatureClass('LM_SE_SURFACE_ELEMENT');

-- Kontrolle ID - Vollständigkeit (neu Pflichtfeld im DMAV)
select * from LM_SE_SERVITUDE where ID_COMPLETENESS is NULL;

----------------------------------------------------------------------
-- Einzelobjekte
----------------------------------------------------------------------
-- LAGEGENAUIGKEIT: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_SO_SINGLE_POINT where TB_ACCURACY_POSITION is NULL or TB_ACCURACY_POSITION < 0.001 or TB_ACCURACY_POSITION > 7.000;
-- LAGEGENAUIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0.001...7.000]!
-- update LM_SO_SINGLE_POINT set TB_ACCURACY_POSITION = x.x where TB_ACCURACY_POSITION is null;
-- ISTLAGEZUVERLAESSIG: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_SO_SINGLE_POINT where TB_POSITION_RELIABLE is NULL or TB_POSITION_RELIABLE > 1;
-- LAGEZUVERLÄSSIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0,1]!
-- update LM_SO_SINGLE_POINT set TB_POSITION_RELIABLE = x where TB_POSITION_RELIABLE is null;

-- Prüfung des zulässigen Wertebereichs der Höhe [-200..5000]:
select * from LM_SO_SINGLE_POINT where Z < -200 or Z > 5000;

-- Die Werte müssen je nach dem Abgefüllt sein
-- CH091201: DEFINED(Hoehengeometrie)==DEFINED(Hoehengenauigkeit)
select * from LM_SO_SINGLE_POINT where TB_ACCURACY_HEIGHT is null and Z is not null;
-- Höhengenauigkeit mit Stadndardwerten abfüllen wenn leer und Höhe vorhanden. Standardwert noch eintragen [0.001...7.000]!
-- update LM_SO_SINGLE_POINT set TB_ACCURACY_HEIGHT = x.x where TB_ACCURACY_HEIGHT is null and z is not null;
-- CH091202: DEFINED(Hoehengeometrie)==DEFINED(IstHoehenzuverlaessig);
select * from LM_SO_SINGLE_POINT where TB_HEIGHT_RELIABLE is null and Z is not null;
-- LAGEZUVERLÄSSIGKEIT mit Standardwerten abfüllen wenn leer. Standardwert noch eintragen [0,1]!
-- update LM_SO_SINGLE_POINT set TB_HEIGHT_RELIABLE = x where TB_HEIGHT_RELIABLE is null and z is not null;

-- Einzelobjektart DMAV prüfen (sind alle Werte gemäss DMAV eingetragen oder hat es andere?)
-- Zusammenstellung der verwendeten ID_TYPE mit Bezeichnung und Anzahl:
select so.ID_TYPE, cat.VALUE, count(so.FID) 
 from LM_SO_SINGLE_OBJECT so left join LM_SO_OBJECT_CATEGORY_TBD cat on so.ID_TYPE = cat.id
 where so.ID_TYPE not in (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,65,70) 
 group by ID_TYPE, VALUE 
 order by ID_TYPE;
--Bei Bedarf können die einzelnen Datensätze angezeigt werden:
--select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE not in (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,65,70);

-- Typen KGK prüfen
-- select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE not in (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,59,60,61,65,70,73);

-- Nicht zuweisbare Arten (diese müssen Manuell geändert werden)
select so.ID_TYPE, cat.VALUE, count(so.FID) 
 from LM_SO_SINGLE_OBJECT so left join LM_SO_OBJECT_CATEGORY_TBD cat on so.ID_TYPE = cat.id
 where so.ID_TYPE in (1,29,44,45,46,54,55,56,63,80,81,82,83,85,86,87,100,105,106,107,10000,10001);
 group by ID_TYPE, VALUE 
 order by ID_TYPE;
--Bei Bedarf können die einzelnen Datensätze angezeigt werden:
-- select * from LM_SO_SINGLE_OBJECT so where so.ID_TYPE in (1,29,44,45,46,54,55,56,63,80,81,82,83,85,86,87,100,105,106,107,10000,10001);

-- Domain-Werte ID_TYPE prüfen (ACTIVE = 0)
select distinct so.ID_TYPE, TBD.VALUE, TBD.ACTIVE
 from LM_SO_SINGLE_OBJECT so
 left join LM_SO_OBJECT_CATEGORY_TBD tbd on so.ID_TYPE = tbd.ID;
 
-- GUT beurteilen, ob die Zuweisung für das Update auf die eigenen Bedürfnisse passt >> Updates sind im Skript 04-Umstellen - 02-Updates

----------------------------------------------------------------------
-- Gebäudeadressen
----------------------------------------------------------------------
-- Hat jede Lokalisation eine Geometrie
SELECT lo.* 
FROM LM_LO_LOCATION lo
LEFT JOIN (
  SELECT FID_LO_LOCATION FROM LM_LO_ROAD_SECTION
  UNION
  SELECT FID_LO_LOCATION FROM LM_LO_NAMED_AREA
) linked
ON lo.FID = linked.FID_LO_LOCATION
WHERE linked.FID_LO_LOCATION IS NULL;

----------------------------------------------------------------------
-- Grundstücke
----------------------------------------------------------------------
-- Qualitätststandand (neu Pflichtfeld im DMAV)
select * from LM_OW_PROPERTY where ID_QUALITY is NULL;

-- Grenzpunkte
-- prüfen sind alle Werte gemäss DMAV eingetragen oder hat es andere?
select bp.ID_POINT_MARK, cat.VALUE, count(bp.FID) 
 from LM_OW_BOUNDARYPOINT bp left join LM_OW_POINT_MARK_TBD cat on bp.ID_POINT_MARK = cat.ID
where bp.ID_POINT_MARK in (9,10,11,12,13,14,15,16,17,18,19)
group by bp.ID_POINT_MARK, cat.VALUE
order by bp.ID_POINT_MARK;
--Bei Bedarf können die einzelnen Datensätze angezeigt werden:
-- select * from LM_OW_BOUNDARYPOINT where ID_POINT_MARK in (9,10,11,12,13,14,15,16,17,18,19);

-- LAGEGENAUIGKEIT: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_OW_BOUNDARYPOINT where TB_ACCURACY_POSITION is NULL or TB_ACCURACY_POSITION < 0.001 or TB_ACCURACY_POSITION > 7.000;
-- ISTLAGEZUVERLAESSIG: Die Werte müssen abegüllt sein und in einem gültigen Bereich:
select * from LM_OW_BOUNDARYPOINT where TB_POSITION_RELIABLE is NULL or TB_POSITION_RELIABLE > 1;

-- Die Werte müssen je nach dem Abgefüllt sein
-- CH040201: DEFINED(Hoehengeometrie)==DEFINED(Hoehengenauigkeit)
select * from LM_OW_BOUNDARYPOINT where TB_ACCURACY_HEIGHT is null and Z is not null;
-- CH040202: DEFINED(Hoehengeometrie)==DEFINED(IstHoehenzuverlaessig);
select * from LM_OW_BOUNDARYPOINT where TB_HEIGHT_RELIABLE is null and Z is not null;

