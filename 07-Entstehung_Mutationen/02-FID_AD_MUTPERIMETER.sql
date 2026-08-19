----------------------------------------------------------------------
-- FID_AD_MUTPERIMETER behandeln
-- Informationen zusammentragen und eintragen.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [02.09.2025] V 1.3 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------

-- *******************************************************************
-- CHECK-ID: 070201
-- Hilfstabelle erstellen und die aktuellen Objekten eintragen
-- *******************************************************************
-- Hilfstabelle erstellen
create table MIG_MUT_INFOS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10), FID_AD_MUTPERIMETER number(10), FID_AD_MUTPERIMETER_PEND number(10));

-- *******************************************************************
-- CHECK-ID: 070202
-- Objekte eintragen
-- SQL zum Generieren im Helper
-- *******************************************************************
call job3.setjob(1);

insert into MIG_MUT_INFOS (select 'LM_AD_CANTON_BOUNDARY_L', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_CANTON_BOUNDARY_L);     
insert into MIG_MUT_INFOS (select 'LM_AD_DISTRICT_BOUNDARY_L', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_DISTRICT_BOUNDARY_L); 
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIPALITY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIPALITY);               
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUNDARY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIP_BOUNDARY);       
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUND_PROJ', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIP_BOUND_PROJ);   
insert into MIG_MUT_INFOS (select 'LM_BU_HOUSE_ENTRANCE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_BU_HOUSE_ENTRANCE);           
insert into MIG_MUT_INFOS (select 'LM_CP_ACP', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_CP_ACP);                                 
insert into MIG_MUT_INFOS (select 'LM_CP_PCP', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_CP_PCP);                                 
insert into MIG_MUT_INFOS (select 'LM_LC_SINGLE_POINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_LC_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_LC_SURFACE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_LC_SURFACE);                         
insert into MIG_MUT_INFOS (select 'LM_LO_LOCATION', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_LO_LOCATION);                       
insert into MIG_MUT_INFOS (select 'LM_LS_LAND_SLIDE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_LS_LAND_SLIDE);                   
insert into MIG_MUT_INFOS (select 'LM_NA_LOCAL_NAME', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_NA_LOCAL_NAME);                   
insert into MIG_MUT_INFOS (select 'LM_NA_NAMED_LOCALITY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_NA_NAMED_LOCALITY);           
insert into MIG_MUT_INFOS (select 'LM_NA_PLACE_NAME', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_NA_PLACE_NAME);                   
insert into MIG_MUT_INFOS (select 'LM_OW_BOUNDARYPOINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_BOUNDARYPOINT);             
insert into MIG_MUT_INFOS (select 'LM_OW_DPR', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_DPR);                                 
insert into MIG_MUT_INFOS (select 'LM_OW_MINE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_MINE);                               
insert into MIG_MUT_INFOS (select 'LM_OW_PROPERTY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_PROPERTY);                       
insert into MIG_MUT_INFOS (select 'LM_OW_REAL_ESTATE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_REAL_ESTATE);                 
insert into MIG_MUT_INFOS (select 'LM_PA_SO_PROJ', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_PA_SO_PROJ);                         
insert into MIG_MUT_INFOS (select 'LM_PA_SURFACE_PROJ', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_PA_SURFACE_PROJ);               
insert into MIG_MUT_INFOS (select 'LM_PI_PIPE_OBJECT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_PI_PIPE_OBJECT);                 
insert into MIG_MUT_INFOS (select 'LM_PI_SIGNAL_POINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_PI_SIGNAL_POINT);               
insert into MIG_MUT_INFOS (select 'LM_PI_SINGLE_POINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_PI_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_SE_SERVITUDE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_SE_SERVITUDE);                     
insert into MIG_MUT_INFOS (select 'LM_SO_SINGLE_OBJECT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_SO_SINGLE_OBJECT);             
insert into MIG_MUT_INFOS (select 'LM_SO_SINGLE_POINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_SO_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_TD_TOLERANCEDEGREE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_TD_TOLERANCEDEGREE);         


insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUNDARY_A', a.FID, a.JOB_VERSION, f.FID_AD_MUTPERIMETER, null
from
 LM_AD_MUNICIP_BOUNDARY_A a
 join LM_AD_MUNICIP_BOUNDARY f on a.FID_PARENT = f.FID);
 
insert into MIG_MUT_INFOS (select 'LM_LC_SURFACE_A', a.FID, a.JOB_VERSION, f.FID_AD_MUTPERIMETER, null
from
 LM_LC_SURFACE_A a
 join LM_LC_SURFACE f on a.FID_PARENT = f.FID);
 
insert into MIG_MUT_INFOS (select 'LM_OW_REAL_ESTATE_A', a.FID, a.JOB_VERSION, f.FID_AD_MUTPERIMETER, null
from
 LM_OW_REAL_ESTATE_A a
 join LM_OW_REAL_ESTATE f on a.FID_PARENT = f.FID);          

commit;

call job3.setjob(2);
insert into MIG_MUT_INFOS (select 'LM_AD_CANTON_BOUNDARY_L', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_CANTON_BOUNDARY_L tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));     
insert into MIG_MUT_INFOS (select 'LM_AD_DISTRICT_BOUNDARY_L', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_DISTRICT_BOUNDARY_L tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION)); 
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIPALITY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIPALITY tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));               
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUNDARY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIP_BOUNDARY tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));       
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUND_PROJ', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_AD_MUNICIP_BOUND_PROJ tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));   
insert into MIG_MUT_INFOS (select 'LM_LS_LAND_SLIDE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_LS_LAND_SLIDE tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                   
insert into MIG_MUT_INFOS (select 'LM_OW_BOUNDARYPOINT', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_BOUNDARYPOINT tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));             
insert into MIG_MUT_INFOS (select 'LM_OW_DPR', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_DPR tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                                 
insert into MIG_MUT_INFOS (select 'LM_OW_MINE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_MINE tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                               
insert into MIG_MUT_INFOS (select 'LM_OW_PROPERTY', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_PROPERTY tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                       
insert into MIG_MUT_INFOS (select 'LM_OW_REAL_ESTATE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_OW_REAL_ESTATE tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                 
insert into MIG_MUT_INFOS (select 'LM_SE_SERVITUDE', FID, JOB_VERSION, FID_AD_MUTPERIMETER, null from LM_SE_SERVITUDE tab where not exists (select 1 from MIG_MUT_INFOS mi where mi.JOB_VERSION = tab.JOB_VERSION));                     

commit;

-- *******************************************************************
-- CHECK-ID: 070203
-- Update leere FID_AD_MUTPERIMETER
-- *******************************************************************
update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER = 
 (select mp.FID from LM_AD_MUTPERIMETER mp join TB_JOB_VERSION jv on jv.JOB_ID = mp.ID_JOB where jv.JOB_VERSION = iup.JOB_VERSION)
where iup.FID_AD_MUTPERIMETER is NULL;
commit;
-- Update wenn die letzte Version ein Wartungsjob war
update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER = ( select mut.FID from
 TB_JOB_VERSION jv
 join TB_JOB_VERSION lv on jv.JOB_OLD_VERSION = lv.JOB_VERSION
 join TB_JOB job on lv.JOB_ID = job.ID
 join LM_AD_MUTPERIMETER mut on job.ID = mut.ID_JOB
 where jv.JOB_VERSION = iup.JOB_VERSION
)
where iup.FID_AD_MUTPERIMETER is NULL;
commit;
-- Update wenn die letzte beiden Version ein Wartungsjob war
update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER = ( select mut.FID from
 TB_JOB_VERSION jv
 join TB_JOB_VERSION zv on jv.JOB_OLD_VERSION = zv.JOB_VERSION
 join TB_JOB_VERSION lv on zv.JOB_OLD_VERSION = lv.JOB_VERSION
 join TB_JOB job on lv.JOB_ID = job.ID
 join LM_AD_MUTPERIMETER mut on job.ID = mut.ID_JOB
 where jv.JOB_VERSION = iup.JOB_VERSION
)
where iup.FID_AD_MUTPERIMETER is NULL;
commit;

-- Kontrolle
select * from MIG_MUT_INFOS where FID_AD_MUTPERIMETER is NULL;

-- Kontrolle Job, Wartungsjob und Perimeter
select DISTINCT job.ID, job.NAME, job.IS_MAINTENANCE, DECODE(mut.FID,NULL,'nein','ja') PERIMTER from
 TB_JOB_VERSION jv
 join TB_JOB job on job.ID = jv.JOB_ID
 left join LM_AD_MUTPERIMETER mut on mut.ID_JOB = job.ID
where exists (select 1 from MIG_MUT_INFOS i where i.FID_AD_MUTPERIMETER is NULL and i.JOB_VERSION = jv.JOB_VERSION);

-- *******************************************************************
-- CHECK-ID: 070204
-- Untergehende mit Mutperimeter PEND ergänzen
-- *******************************************************************
update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER_PEND = -1
 where exists (select 1 from MIG_MUT_INFOS mi join MIG_MUT_INFOS mii on mii.FID = mi.FID and mii.JOB_VERSION > mi.JOB_VERSION and mi.JOB_VERSION = iup.JOB_VERSION);

update MIG_MUT_INFOS iup set iup.FID_AD_MUTPERIMETER_PEND =
 (select mii.FID_AD_MUTPERIMETER from MIG_MUT_INFOS mii where mii.FID = iup.FID and mii.JOB_VERSION > iup.JOB_VERSION)
where iup.FID_AD_MUTPERIMETER_PEND = -1;

-- Kontrolle
select 
 mi.FID, mi.JOB_VERSION, mi.FID_AD_MUTPERIMETER, mi.FID_AD_MUTPERIMETER_PEND 
from
  MIG_MUT_INFOS mi
  join MIG_MUT_INFOS mii on mii.FID = mi.FID and mii.JOB_VERSION <> mi.JOB_VERSION 
order by mi.FID;

-- *******************************************************************
-- CHECK-ID: 070205
-- Hilfstabelle exportieren als Sicherstellung
-- *******************************************************************
excel select * from MIG_MUT_INFOS;

-- *******************************************************************
-- CHECK-ID: 070206
-- leere FID_AD_MUTPERMITER in den Objektklassen abfüllen
-- select 'update ' || F_CLASS_NAME || ' tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;' from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'FID_AD_MUTPERIMETER') order by F_CLASS_NAME;
-- *******************************************************************
call job3.setjob(-1);

update LM_AD_CANTON_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;   
update LM_AD_DISTRICT_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL; 
update LM_AD_MUNICIPALITY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_AD_MUNICIP_BOUNDARY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;    
update LM_AD_MUNICIP_BOUNDARY_A tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;  
update LM_AD_MUNICIP_BOUND_PROJ tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;  
update LM_BU_HOUSE_ENTRANCE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;      
update LM_CP_ACP tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;                 
update LM_CP_PCP tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;                 
update LM_LC_SINGLE_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_LC_SURFACE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;             
update LM_LC_SURFACE_A tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;           
update LM_LO_LOCATION tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;            
update LM_LS_LAND_SLIDE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;          
update LM_NA_LOCAL_NAME tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;          
update LM_NA_NAMED_LOCALITY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;      
update LM_NA_PLACE_NAME tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;          
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;       
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;                 
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;                
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;            
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;         
update LM_OW_REAL_ESTATE_A tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;       
update LM_PA_SO_PROJ tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;             
update LM_PA_SURFACE_PROJ tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_PI_PIPE_OBJECT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;         
update LM_PI_SIGNAL_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_PI_SINGLE_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_SE_SERVITUDE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;           
update LM_SO_SINGLE_OBJECT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;       
update LM_SO_SINGLE_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_TD_TOLERANCEDEGREE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;     

-- Leere FID_AD_MUTPERIMETER (gelöschte Objekte - für die Vollständigkeit) aktualisieren
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;

commit;

-- *******************************************************************
-- CHECK-ID: 070207
-- FID_AD_MUTPERMITER_PEND in den Objektklassen eintragen
-- select 'update ' || F_CLASS_NAME || ' tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);' from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME = 'FID_AD_MUTPERIMETER_PEND') order by F_CLASS_NAME;
-- *******************************************************************
call job3.setjob(-1);

update LM_AD_CANTON_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);   
update LM_AD_DISTRICT_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION); 
update LM_AD_MUNICIPALITY tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);        
update LM_AD_MUNICIP_BOUNDARY tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);    
update LM_AD_MUNICIP_BOUND_PROJ tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);  
update LM_LS_LAND_SLIDE tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);          
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);       
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);                 
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);                
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);            
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);         
update LM_SE_SERVITUDE tab set tab.FID_AD_MUTPERIMETER_PEND = (select info.FID_AD_MUTPERIMETER_PEND from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION);           

-- Untergehende Objekte nachtragen (OLD Version)
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);

-- Untergehende Objekte nachtragen (OLD Version)
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER_OLD = nvl((select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION),-1)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 2 and STATE = 1);
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER_OLD = nvl((select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION),-1)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 2 and STATE = 1);
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER_OLD = nvl((select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION),-1)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 2 and STATE = 1);
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER_OLD = nvl((select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION),-1)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 2 and STATE = 1);
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER_OLD = nvl((select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION),-1)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 2 and STATE = 1);

-- Untergehende Objekte nachtragen (Version)
update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER_OLD = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_VERSION = tab.JOB_VERSION and JOB_OPERATION_ID = 3 and STATE = 1);


update LM_OW_BOUNDARYPOINT tab set tab.FID_AD_MUTPERIMETER_PEND = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and STATE = 2);
update LM_OW_DPR tab set tab.FID_AD_MUTPERIMETER_PEND = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and STATE = 2);
update LM_OW_MINE tab set tab.FID_AD_MUTPERIMETER_PEND = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and STATE = 2);
update LM_OW_PROPERTY tab set tab.FID_AD_MUTPERIMETER_PEND = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and STATE = 2);
update LM_OW_REAL_ESTATE tab set tab.FID_AD_MUTPERIMETER_PEND = (select m.FID from TB_JOB_VERSION v JOIN LM_AD_MUTPERIMETER m on v.JOB_ID = m.ID_JOB where v.JOB_OLD_VERSION = tab.JOB_VERSION)
 where exists (select 1 from TB_JOB_VERSION where JOB_OLD_VERSION = tab.JOB_VERSION and STATE = 2);

commit;

-- OID auf den Untergehenden Objekten nachtragen:
repeat
  update $FCLASSNAME tab set ILI2_OID = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
  where JOB_VERSION = $JOBVERSION and ILI2_OID is NULL
FOR
  select F_CLASS_NAME FCLASSNAME, JOB_VERSION JOBVERSION from MIG_MUT_INFOS where FID_AD_MUTPERIMETER_PEND is not NULL;
commit;

repeat
 update $FCLASSNAME tab set ILI2_OID = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
  where FID_AD_MUTPERIMETER_OLD is not NULL and ILI2_OID is NULL
for
 select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME in ('ILI2_OID', 'FID_AD_MUTPERIMETER_OLD') GROUP BY F_CLASS_ID HAVING COUNT(F_CLASS_ID) = 2) and F_CLASS_NAME not like 'LM_WS_%';

repeat
 update $FCLASSNAME tab set ILI2_OID = regexp_replace(LOWER(sys_guid()), '([A-Za-z0-9]{8})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{4})([A-Za-z0-9]{12})', '\1-\2-\3-\4-\5')
  where FID_AD_MUTPERIMETER_PEND is not NULL and ILI2_OID is NULL
for
 select F_CLASS_NAME FCLASSNAME from TB_DICTIONARY where F_CLASS_ID in (select F_CLASS_ID from TB_ATTRIBUTE where NAME in ('ILI2_OID', 'FID_AD_MUTPERIMETER_PEND') GROUP BY F_CLASS_ID HAVING COUNT(F_CLASS_ID) = 2) and F_CLASS_NAME not like 'LM_WS_%';


-- *******************************************************************
-- CHECK-ID: 070208
-- Hilfstabelle löschen
-- *******************************************************************
drop table MIG_MUT_INFOS;
commit; 
