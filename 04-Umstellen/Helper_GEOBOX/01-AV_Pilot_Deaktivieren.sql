----------------------------------------------------------------------
-- Amtliche Vermessung Schweiz
-- Deaktiviert das Datenmodell/Modul in der Fachschale.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supported, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [14.06.2024] V 1.0 / GEOBOX AG (USO) - Script erstellt.
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = mapsys;

-- Diese Script ist nur temporär verfügbar und nur auf den Pilot-Projekten anwendbar.
-- DMAV Pilot deaktivieren (falls Modul einmal aktiviert wurde).
delete from TB_VERSION where DATA_MODEL_CODE = '84.9.90';
delete from TB_DATAMODELCODE where DATA_MODEL_CODE = '84.9.90';
commit;

-- nur für Pilot
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CP_ACP1');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CP_ACP2');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CP_PCP1');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_CP_PCP2');

commit;

call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SO_PROJ', 'ID_TYPE');
commit;

-- PLAN Categorie entfernen
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SO_PROJ_SYMBOL', 'ID_PLAN_CATEGORY');

commit;

-- ID Bewilligung bei Proj EO entfernen
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_PA_SO_PROJ', 'ID_APPROVAL');

commit;


