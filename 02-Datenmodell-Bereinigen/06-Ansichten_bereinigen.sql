----------------------------------------------------------------------
-- Ansichten entfernen, diese werden später korrigiert eingetragen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

-- *******************************************************************
-- CHECK-ID: 020601
-- Aus dem TB-Dictionry entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSP_PROPERTY_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSP_PROP_LIVE_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSP_PROP_PEND_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_PROP_LIVE_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_PROP_PEND_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_ACP_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_PCP_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_BOUNDARYP_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_LC_SYMBOL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPCH_CROSSHAIR');
commit;

-- *******************************************************************
-- CHECK-ID: 020602
-- Entfernen der Ansichten aus dem Datenmodell
-- *******************************************************************
drop view LM_V_DSP_PROPERTY_TBL;
drop view LM_V_DSP_PROP_LIVE_TBL;
drop view LM_V_DSP_PROP_PEND_TBL;
drop view LM_V_DSPCH_PROP_LIVE_TBL;
drop view LM_V_DSPCH_PROP_PEND_TBL;
drop view LM_V_DSPCH_ACP_TBL;
drop view LM_V_DSPCH_PCP_TBL;
drop view LM_V_DSPCH_BOUNDARYP_TBL;
drop view LM_V_DSPCH_LC_SYMBOL;
drop view LM_V_DSPCH_CROSSHAIR;
commit;

-- *******************************************************************
-- CHECK-ID: 020603
-- Ansichten aus verschiedenen Datenmodellen entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSP_LFP4');
drop view LM_V_DSP_LFP4;
commit;

-- *******************************************************************
-- CHECK-ID: 020604
-- Ansichten aus KantonsKit Bern entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPBE_PROP_DPR_TBL');
call &&mapsysname..FeatureClass.dropFeatureClass('LM_V_DSPBE_PROP_RE_TBL');
commit;

drop view LM_V_DSPBE_PROP_DPR_TBL;
drop view LM_V_DSPBE_PROP_RE_TBL;
commit;