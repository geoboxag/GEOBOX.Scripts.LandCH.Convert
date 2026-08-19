----------------------------------------------------------------------
-- Objektregeln prüfen und korrigieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------

-- *******************************************************************
-- Alle Objektregeln der GEOBOX entfernen, werden später neu angelegt und wieder zugewiesen
-- CHECK-ID: 010401
-- *******************************************************************
-- Gruppen
delete from TB_RULE_GROUP where ID in (select RULE_GROUP_ID from TB_RULE_DEF where ASSEMBLY like 'GEOBOX.%');
-- Paramter
delete from TB_RULE_PARAM where RULE_DEF_ID in (select ID from TB_RULE_DEF where ASSEMBLY like 'GEOBOX.%');
-- Base
delete from TB_RULE_BASE where RULE_DEF_ID in (select ID from TB_RULE_DEF where ASSEMBLY like 'GEOBOX.%');
-- Regeln
delete from TB_RULE_DEF where ASSEMBLY like 'GEOBOX.%';
commit;

-- *******************************************************************
-- Objektregeln prüfen >> wenn count > 0, dann korrigieren
-- CHECK-ID: 010402
-- *******************************************************************
select count(1) from TB_RULE_DEF where (NAME like 'Truncate%' or NAME like 'Compound%' or NAME like 'Validate intersection%') and ID < 999;

-- *******************************************************************
-- Korrigieren der Objektregeln
-- CHECK-ID: 010403
-- select 'update TB_RULE_DEF set DESCRIPTION = '''||DESCRIPTION||''', NAME = '''||NAME||''' where NAME like '''||ID||''';' from TB_RULE_DEF where ID < 999;
-- select 'update TB_RULE_GROUP set NAME = '''||NAME||''' where NAME like '''||ID||''';' from TB_RULE_GROUP where ID < 999;
-- select 'update TB_RULE_PARAM set NAME = '''||NAME||''' where NAME like '''||ID||''';' from TB_RULE_PARAM where RULE_DEF_ID < 999;
-- *******************************************************************
-- Regeln
update TB_RULE_DEF set DESCRIPTION = 'Kaskadierendes Löschen der untergeordneten Objekte zusammen mit TB_RELATIONS', NAME = 'Delete (Collect FIDs)' where NAME like 'Delete (Collect FIDs)';
update TB_RULE_DEF set DESCRIPTION = 'Kaskadierendes Löschen der untergeordneten Objekte zusammen mit TB_RELATIONS', NAME = 'Delete (Batch)' where NAME like 'Delete (Batch)';
update TB_RULE_DEF set DESCRIPTION = 'Abgeschnittene Polygonfläche (aus Feld FLÄCHE) in Feld AREA_NOMINAL berechnen', NAME = 'Fläche abschneiden' where NAME like 'Truncate area';
update TB_RULE_DEF set DESCRIPTION = 'Abgeschnittene Polygonfläche (aus Feld Genaue_Fläche) in Feld AREA_NOMINAL berechnen', NAME = 'Genaue_Fläche abschneiden' where NAME like 'Truncate exact_area';
update TB_RULE_DEF set DESCRIPTION = 'Geometrie auf angegebene Dezimalstellen runden', NAME = 'Geometrie runden' where NAME like 'Round geometry';
update TB_RULE_DEF set DESCRIPTION = 'Überprüft, ob sich ein Objekt im ausgewählten Umfang befindet; wenn nicht, wird eine Ausnahme ausgelöst', NAME = 'Umfang prüfen' where NAME like 'Check Perimeter';
update TB_RULE_DEF set DESCRIPTION = 'Bestimmte Geometrietypen aus einer Oracle-Objektsammlung (für Oracle 10g und höher) extrahieren', NAME = 'Aus Sammlung extrahieren (10g und höher)' where NAME like 'Extract from collection (10g and higher)';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittpolygon validieren und ungültige Geometrien in Objektklasse _TSER verschieben (für Oracle 10g und höher)', NAME = 'Verschnittpolygon validieren - Haupt (Locator)' where NAME like 'Validate intersection polygon - main (Locator)';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittpolygon validieren und ungültige Geometrien in Objektklasse _TSER verschieben (für Oracle 10g und höher)', NAME = 'Verschnittpolygon validieren - AD (Locator)' where NAME like 'Validate intersection polygon - AD (Locator)';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittlinie validieren und ungültige Geometrien in Objektklasse _TSER verschieben (für Oracle 10g und höher)', NAME = 'Verschnittlinie validieren - Haupt' where NAME like 'Validate intersection line - main';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittlinie validieren und ungültige Geometrien in Objektklasse _TSER verschieben (für Oracle 10g und höher)', NAME = 'Verschnittlinie validieren - AD' where NAME like 'Validate intersection line - AD';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittobjekte validieren und korrigieren und ungültige Polygon-Geometrie verschieben (nur für Oracle 10g oder höher und Spatial-Lizenz)', NAME = 'Verschnittpolygon validieren - Haupt (Spatial)' where NAME like 'Validate intersection polygon - main (Spatial)';
update TB_RULE_DEF set DESCRIPTION = 'Verschnittobjekte validieren und korrigieren und ungültige Polygon-Geometrie verschieben (nur für Oracle 10g oder höher und Spatial-Lizenz)', NAME = 'Verschnittpolygon validieren - AD (Spatial)' where NAME like 'Validate intersection polygon - AD (Spatial)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (BI)' where NAME like 'Compound Row (BI)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (BU)' where NAME like 'Compound Row (BU)';
update TB_RULE_DEF set DESCRIPTION = 'Markierung für das Aktualisieren untergeordneter Objekte setzen.  Dadurch wird die Neuberechnung von Verbunden beim Löschen des übergeordneten Objekts verhindert.', NAME = 'Verbund löschen (BD)' where NAME like 'Delete compound (BD)';
update TB_RULE_DEF set DESCRIPTION = 'Markierung für das Aktualisieren untergeordneter Objekte setzen.  Dadurch wird die Neuberechnung von Verbunden beim Löschen des übergeordneten Objekts verhindert.', NAME = 'Verbund löschen (AD)' where NAME like 'Delete compound (AD)'; 
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (AD)' where NAME like 'Compound Row (AD)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AI)' where NAME like 'Compound Statement (AI)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AU)' where NAME like 'Compound Statement (AU)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polygon aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AD)' where NAME like 'Compound Statement (AD)';
update TB_RULE_DEF set DESCRIPTION = 'Geometrie vor dem Einfügen validieren und Ausnahme auslösen, falls ungültig', NAME = 'Geometrie validieren' where NAME like 'Validate geometry';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (BI)' where NAME like 'Compound Row (BI)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (BU)' where NAME like 'Compound Row (BU)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbundzeile (AD)' where NAME like 'Compound Row (AD)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AI)' where NAME like 'Compound Statement (AI)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AU)' where NAME like 'Compound Statement (AU)';
update TB_RULE_DEF set DESCRIPTION = 'Verbund-Polylinie aus untergeordneten Linien erzeugen', NAME = 'Verbund-Anweisung (AD)' where NAME like 'Compound Statement (AD)';
update TB_RULE_DEF set DESCRIPTION = 'Automatische Labels erstellen, Label-Text aktualisieren und ggf. Labels verschieben', NAME = 'Label (Attribut bearbeiten)' where NAME like 'Label (edit attribute)';
update TB_RULE_DEF set DESCRIPTION = 'Automatische Labels erstellen, Label-Text aktualisieren und ggf. Labels verschieben', NAME = 'Label (Geometrie bearbeiten)' where NAME like 'Label (edit geometry)';
update TB_RULE_DEF set DESCRIPTION = 'Automatische Labels erstellen, Label-Text aktualisieren und ggf. Labels verschieben', NAME = 'Label (nach Anweisung)' where NAME like 'Label (after statement)';
update TB_RULE_DEF set DESCRIPTION = 'Automatische Labels erstellen, Label-Text aktualisieren und ggf. Labels verschieben', NAME = 'Label (vor Anweisung)' where NAME like 'Label (before statement)';
commit;
-- Gruppen
update TB_RULE_GROUP set NAME = 'Untergeordnete Objekte löschen' where NAME like 'Delete child features';
update TB_RULE_GROUP set NAME = 'Verschnittpolygon validieren (mit Locator-Lizenz)' where NAME like 'Validate intersection polygon (with locator license)';
update TB_RULE_GROUP set NAME = 'Verschnittlinie validieren (10g und höher)' where NAME like 'Validate intersection line (10g and higher)';
update TB_RULE_GROUP set NAME = 'Verschnittpolygon validieren (Spatial)' where NAME like 'Validate intersection polygon (Spatial)';
update TB_RULE_GROUP set NAME = 'Verbund-Polygon erzeugen' where NAME like 'Generate compound polygon';
update TB_RULE_GROUP set NAME = 'Verbund löschen' where NAME like 'Delete compound';
update TB_RULE_GROUP set NAME = 'Verbund-Polylinie erzeugen' where NAME like 'Generate compound linestring';
update TB_RULE_GROUP set NAME = 'Label' where NAME like 'Label';
commit;
-- Paramter
update TB_RULE_PARAM set NAME = 'Anzahl der zu verwerfenden Dezimalstellen' where NAME like 'number of decimals to truncate';
update TB_RULE_PARAM set NAME = 'Anzahl der Dezimalstellen zum Runden' where NAME like 'number of decimals to round'; 
update TB_RULE_PARAM set NAME = 'Objektklassenname' where NAME like 'feature class name';
update TB_RULE_PARAM set NAME = 'falscher Objektklassenname' where NAME like 'error feature class name';
update TB_RULE_PARAM set NAME = 'Extraktionstyp (1-Punkt,2-Linie,3-Polygon)' where NAME like 'extract type (1- Point,2-Line,3-Polygon)';
update TB_RULE_PARAM set NAME = 'Name des Verschnitts' where NAME like 'name of the intersection';
update TB_RULE_PARAM set NAME = 'Extraktionstyp (5-Multipunkt,6-Multilinie,7-Multipolygon)' where NAME like 'extract type (5-MultiPoint,6-MultiLine,7-MultiPolygon)';
commit;