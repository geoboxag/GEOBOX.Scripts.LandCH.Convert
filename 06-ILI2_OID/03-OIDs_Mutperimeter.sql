----------------------------------------------------------------------
-- Erstellt in jeder Objektklasse mit dem Attribut ILI2_OID eine neue OID falls diese leer ist.
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
update LM_AD_MUTPERIMETER m set ILI2_OID_ACP = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_CONTROL_POINTS');
/* LM_AD_TERRETORIAL_BOUNDARY */
update LM_AD_MUTPERIMETER m set ILI2_OID_AD = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_JOB_FCLASS jfc on jfc.JOB_TOPIC_ID = jt.ID join TB_DICTIONARY dict on dict.F_CLASS_ID = jfc.F_CLASS_ID where m.ID_JOB = j.ID and dict.F_CLASS_NAME in ('LM_AD_CANTON_BOUNDARY_L', 'LM_AD_DISTRICT_BOUNDARY_L', 'LM_AD_MUNICIPALITY', 'LM_AD_MUNICIPALITY_TBL', 'LM_AD_MUNICIP_BOUNDARY', 'LM_AD_MUNICIP_BOUNDARY_A', 'LM_AD_MUNICIP_BOUNDARY_L', 'LM_AD_MUNICIP_BOUND_PROJ'));
/* LM_BUILDING */
update LM_AD_MUTPERIMETER m set ILI2_OID_BU = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_BUILDING');
/* LM_LAND_COVER */
update LM_AD_MUTPERIMETER m set ILI2_OID_LC = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_LAND_COVER');
/* LM_LAND_SLIDE */
update LM_AD_MUTPERIMETER m set ILI2_OID_LS = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_LAND_SLIDE');
/* LM_NAMES */
update LM_AD_MUTPERIMETER m set ILI2_OID_NA = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_NAMES');
/* LM_OWNERSHIP */
update LM_AD_MUTPERIMETER m set ILI2_OID_OW = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_OWNERSHIP');
/* LM_CONTROL_POINTS */
update LM_AD_MUTPERIMETER m set ILI2_OID_PCP = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_CONTROL_POINTS');
/* LM_PIPELINES */
update LM_AD_MUTPERIMETER m set ILI2_OID_PI = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_PIPELINES');
/* LM_SERVITUDES */
update LM_AD_MUTPERIMETER m set ILI2_OID_SE = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_SERVITUDES');
/* LM_SINGLE_OBJECTS */
update LM_AD_MUTPERIMETER m set ILI2_OID_SO = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_SINGLE_OBJECTS');
/* LM_TOLERANCE_DEGREE */
update LM_AD_MUTPERIMETER m set ILI2_OID_TD = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
 where exists (select 1 from TB_JOB j join TB_JOB_TOPIC jt on jt.JOB_ID = j.ID join TB_TOPIC t on t.ID = jt.TOPIC_ID where m.ID_JOB = j.ID and t.NAME = 'LM_TOLERANCE_DEGREE');

commit;
