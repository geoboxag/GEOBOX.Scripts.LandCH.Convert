----------------------------------------------------------------------
-- Datenprüfungen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

/* Ergänzen mit:

- Domainwerten aus dem Script 02-Datenmodell-Bereinigen/04-Domain_Tabellen.sql
-- Grenzpunkte

call job3.setjob(-1);
select * from LM_OW_BOUNDARYPOINT where ID_POINT_MARK in (9,10,11,12,13,14,15,16,17,18,19);

9  Stein_Kunstoffzeichen                0                                                     
10 Bolzen_Pfahl_Rohr                    0                                                     
11 GP Hilfspunkt         Wunsch Kt. AG. 1                                                     
12 SdR_Punkt                            0                                                     
13 schoener_Stein        Stein          0                                                     
14 projektierter_Punkt   Wunsch Kt. AG  1                                                     
15 geschnitztes_Kreuz    Kreuz          0                                                     
16 Kreuz-Kreuz           Kreuz          0                                                     
17 Kreuz-eingemeisselt   Kreuz          0                                                     
18 weitere-andere        weitere        0                                                     
19 weitere-Kirchturm     weitere        0                                                     
11 Zeilen ausgewählt.

-- Symbol Typen
-- usw.
*/

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

-- Domain-Werte ID_LC_TYPE prüfen
select distinct lc.ID_LC_TYPE, TBD.VALUE, TBD.ACTIVE
 from LM_LC_SURFACE lc
 left join LM_LC_CATEGORY_TBD tbd on lc.ID_LC_TYPE = tbd.ID;
-- ACTIVE = 0 beurteilen und updaten:
-- call job3.setjob(-1);
-- update LM_LC_SURFACE set ID_LC_TYPE = 55 where ID_LC_TYPE in (22,78);
-- update LM_LC_SURFACE set ID_LC_TYPE = 29 where ID_LC_TYPE = 27;

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
prüfen 


update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER = 
 (select mp.FID from LM_AD_MUTPERIMETER mp join TB_JOB_VERSION jv on jv.JOB_ID = mp.ID_JOB where jv.JOB_VERSION = iup.JOB_VERSION)
where iup.FID_AD_MUTPERIMETER is NULL;
commit;