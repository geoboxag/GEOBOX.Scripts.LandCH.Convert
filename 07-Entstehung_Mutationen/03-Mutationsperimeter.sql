----------------------------------------------------------------------
-- Mutationsperimeter behandeln
-- Informationen zusammentragen und eintragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [01.04.2025] V 1.2 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- Prüfen ob das Attribut vorhanden ist:
select * from TB_ATTRIBUTE where NAME = 'ID_MUTATION_TYPE';

-- *******************************************************************
-- CHECK-ID: 070301
-- Werte an die neue Domaine anpassen (darf nur einmal durchgeführt werden)
-- *******************************************************************
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 10000 where ID_MUTATION_TYPE = 2;
commit;
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 10001 where ID_MUTATION_TYPE = 3;
commit;
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 2 where ID_MUTATION_TYPE = 4;
commit;
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 3 where ID_MUTATION_TYPE = 5;
commit;
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 4 where ID_MUTATION_TYPE = 6;
commit;

-- Prüfen ob Daten abgefüllt wurden:
select * from LM_AD_MUTPERIMETER where ID_MUTATION_TYPE is NULL;
-- Standardwert 3 = Normal eintragen
update LM_AD_MUTPERIMETER set ID_MUTATION_TYPE = 3 where ID_MUTATION_TYPE is null;

-- *******************************************************************
-- CHECK-ID: 070302
-- inkorrekter Typ entfernen
-- *******************************************************************
-- Relation entfernen
delete TB_RELATIONS where PARENT_TABLE_NAME like 'LM_AD_MUTTYPE_TBD';
-- Domain Tabellen
call &&mapsysname..Domain.dropDomainTable('LM_AD_MUTTYPE_TBD');
-- Attribut entfernen
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_AD_MUTPERIMETER', 'ID_MUTTYPE');
commit;

-- *******************************************************************
-- CHECK-ID: 070303
-- Geometrietypen prüfen
-- *******************************************************************
SELECT
 ad.FID, ad.ILI2_OID, ad.IDENTIFICATION,
 CASE MOD(ad.geom.SDO_GTYPE, 100)
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
 LM_AD_MUTPERIMETER ad
WHERE
 ad.geom IS NOT NULL
 and ad.geom.SDO_GTYPE != 2003;

