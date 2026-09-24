----------------------------------------------------------------------
-- Datenprüfungen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [24.09.2026] V 2025.2 / GEOBOX AG (USO) - Weitere Prüfungen hinzugefügt
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Mutationsperimeter
----------------------------------------------------------------------
-- NBIdent abgefüllt
select * from LM_AD_MUTPERIMETER where FID_IDENTND is NULL;
-- Keine doppelten Versionen vorhanden (Resultat sollte NULL sein)
call job3.setjob(-1);
select * from LM_AD_MUTPERIMETER mut where exists (select 1 from LM_AD_MUTPERIMETER m where m.FID = mut.FID and m.JOB_VERSION <> mut.JOB_VERSION) order by FID;

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
 jv.FID <> jo.FID

----------------------------------------------------------------------
-- Bodenbedeckung
----------------------------------------------------------------------
-- CH091201: DEFINED(Hoehengeometrie)==DEFINED(Hoehengenauigkeit)
select * from LM_LC_SINGLE_POINT where TB_ACCURACY_HEIGHT is null and Z is not null;
-- CH091202: DEFINED(Hoehengeometrie)==DEFINED(IstHoehenzuverlaessig);
select * from LM_LC_SINGLE_POINT where TB_RELIABILITY_HEIGHT is null and Z is not null;

-- Bodenbedeckungstyp DMAV prüfen (sind alle Werte gemäss DMAV eingetragen oder hat es andere?)
select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,15,16,17,18,19,29,30,31,32,36,39,40,41,42,43,46,47,48,49,53,54,55,58,59);

-- Typen KGK prüfen
-- select * from LM_LC_SURFACE lc where lc.ID_LC_TYPE not in (2,11,12,13,15,16,17,18,19,23,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,46,47,48,49,53,54,55,58,59,60,66);

-- Domain-Werte ID_LC_TYPE prüfen (ACTIVE = 0)
select distinct lc.ID_LC_TYPE, TBD.VALUE, TBD.ACTIVE
 from LM_LC_SURFACE lc
 left join LM_LC_CATEGORY_TBD tbd on lc.ID_LC_TYPE = tbd.ID;
 
-- GUT beurteilen, ob die Zuweisung für das Update auf die eigenen Bedürfnisse passt
-- call job3.setjob(-1);
-- Gebäude
-- update LM_LC_SURFACE set ID_LC_TYPE = 2 where ID_LC_TYPE in (3,4,5,6,7,8,9,10,65);
-- Strasse (für KGK nur die ID's 14,66)
-- update LM_LC_SURFACE set ID_LC_TYPE = 11 where ID_LC_TYPE in (12,13,14,66,67,68,69,70);
-- Wasserbecken (KGK ohne die ID's 60)
-- update LM_LC_SURFACE set ID_LC_TYPE = 19 where ID_LC_TYPE in (60,61);
-- Acker, Wiese, Weide
-- update LM_LC_SURFACE set ID_LC_TYPE = 29 where ID_LC_TYPE in (27,28);
-- Übrige Intensivkultur
-- update LM_LC_SURFACE set ID_LC_TYPE = 31 where ID_LC_TYPE in (56);
-- Gartenanlage (KGK nicht ausführen)
-- update LM_LC_SURFACE set ID_LC_TYPE = 32 where ID_LC_TYPE in (33,34,35,79);
-- Übrige humusierte
-- update LM_LC_SURFACE set ID_LC_TYPE = 39 where ID_LC_TYPE in (37,38,71,80);
-- Fliessendes Gewässer
-- update LM_LC_SURFACE set ID_LC_TYPE = 41 where ID_LC_TYPE in (57,72,73,82);
-- Übrige bestockte
-- update LM_LC_SURFACE set ID_LC_TYPE = 46 where ID_LC_TYPE in (44,45,74);
-- Abbau, Deponie
-- update LM_LC_SURFACE set ID_LC_TYPE = 53 where ID_LC_TYPE in (50,51,52,75,81);
-- Übrige vegetationslose
-- update LM_LC_SURFACE set ID_LC_TYPE = 54 where ID_LC_TYPE in (63,64,76,77,83);
-- Übrige befestigte (KGK ohne ID's 23)
-- update LM_LC_SURFACE set ID_LC_TYPE = 55 where ID_LC_TYPE in (20,21,22,23,24,25,26,78);

----------------------------------------------------------------------
-- Dienstbarkeiten
----------------------------------------------------------------------
-- NBIdent abgefüllt
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

----------------------------------------------------------------------
-- Einzelobjekte
----------------------------------------------------------------------
-- CH091201: DEFINED(Hoehengeometrie)==DEFINED(Hoehengenauigkeit)
select * from LM_SO_SINGLE_POINT where TB_ACCURACY_HEIGHT is null and Z is not null;
-- CH091202: DEFINED(Hoehengeometrie)==DEFINED(IstHoehenzuverlaessig);
select * from LM_SO_SINGLE_POINT where TB_RELIABILITY_HEIGHT is null and Z is not null;

-- Domain-Werte ID_LC_TYPE prüfen

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
-- Grenzpunkte
call job3.setjob(-1);
select * from LM_OW_BOUNDARYPOINT where ID_POINT_MARK in (9,10,11,12,13,14,15,16,17,18,19);
