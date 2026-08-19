----------------------------------------------------------------------
-- Erstellt für jeden Mutationsperimeter eine OID für jedes Topic
-- dies für den Fall, dass der Kunde den Job-Verlauf jeweils löscht "Verlauf des aktuellen Jobs löschen, wenn der Stauts auf "Live" eingestellt ist"
-- Dieses Script erstellt OID's vom Typ UUIDOID.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [05.09.2025] V 1.1 / GEOBOX AG (USO) - Verbesserungen am Skript für die Hoheitsgrenzen.
----------------------------------------------------------------------
call job3.setjob(-1);
-- *******************************************************************
-- CHECK-ID: 060301
-- OID gemäss Topic eintragen
-- *******************************************************************
/* LM_CONTROL_POINTS */
update LM_AD_MUTPERIMETER m set ILI2_OID_ACP = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_AD_TERRETORIAL_BOUNDARY */
update LM_AD_MUTPERIMETER m set ILI2_OID_AD = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_BUILDING */
update LM_AD_MUTPERIMETER m set ILI2_OID_BU = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_LAND_COVER */
update LM_AD_MUTPERIMETER m set ILI2_OID_LC = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_LAND_SLIDE */
update LM_AD_MUTPERIMETER m set ILI2_OID_LS = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_NAMES */
update LM_AD_MUTPERIMETER m set ILI2_OID_NA = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_OWNERSHIP */
update LM_AD_MUTPERIMETER m set ILI2_OID_OW = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_CONTROL_POINTS */
update LM_AD_MUTPERIMETER m set ILI2_OID_PCP = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_PIPELINES */
update LM_AD_MUTPERIMETER m set ILI2_OID_PI = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_SERVITUDES */
update LM_AD_MUTPERIMETER m set ILI2_OID_SE = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_SINGLE_OBJECTS */
update LM_AD_MUTPERIMETER m set ILI2_OID_SO = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');
/* LM_TOLERANCE_DEGREE */
update LM_AD_MUTPERIMETER m set ILI2_OID_TD = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5');

commit;
