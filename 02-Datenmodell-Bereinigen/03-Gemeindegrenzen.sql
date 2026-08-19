----------------------------------------------------------------------
-- Gemeindegrenzen bereinigen
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [26.03.2025] V 2025.1 / GEOBOX AG (USO) - Script für Umstellung DMAV erstellt
----------------------------------------------------------------------
-- MAPSYS Name korrekt setzten
define mapsysname = MAPSYS;

call job3.setjob(-1);

-- *******************************************************************
-- CHECK-ID: 020301
-- TB-Dictionary anpassen
-- *******************************************************************
update TB_DICTIONARY
 set PARENT_F_CLASS_ID = (select F_CLASS_ID from TB_DICTIONARY where F_CLASS_NAME = 'LM_AD_MUNICIPALITY')
where F_CLASS_NAME = 'LM_AD_MUNICIP_BOUND_PROJ';
commit;


-- *******************************************************************
-- CHECK-ID: 020302
-- Unnötiges Attribut entfernen
-- *******************************************************************
call &&mapsysname..FeatureClass.dropColumnFromFeatureClass('LM_AD_MUNICIP_BOUNDARY_L', 'FID_AD_MUTPERIMETER');
commit;