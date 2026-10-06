----------------------------------------------------------------------
-- Job Versionen aller Objekte entfernen und bereinigen.
-- Es sollten möglichst alle Mutationen geschlossen (rechtsgültig sein) oder zurückmutieren.
----------------------------------------------------------------------
-- PUBLIC
-- Verwendung auf eigene Gefahr!
-- Script wird nicht supportet, es besteht kein Anspruch auf Vollständigkeit oder Korrektheit.
----------------------------------------------------------------------
-- [09.10.2024] V 1.1 / GEOBOX AG (USO) - Script verbessert.
----------------------------------------------------------------------
-- Job erstellen mit Mutationsperimeter (Rechteck über die ganze Gemeinde) >> Job-Vorlage ist grundsätzlich egal: Empfehlung Liegenschaftsmutation
-- Wichtig: IDENTIFICATION = 'DMAV Initialzustand' und die OID's sollten für alle Topic abgefüllt sein im Mutationsperimeter.
-- Job kann direkt in den Live zustand überführt werden...
-- Enstehung eintragen bei allen Objekten

-- Hilfstabelle erstellen
create table MIG_MUT_INFOS (F_CLASS_NAME varchar2(255), FID number(10), JOB_VERSION number(10), FID_AD_MUTPERIMETER number(10));

call job3.setjob(1);
insert into MIG_MUT_INFOS (select 'LM_AD_CANTON_BOUNDARY_L', FID, JOB_VERSION, null from LM_AD_CANTON_BOUNDARY_L);     
insert into MIG_MUT_INFOS (select 'LM_AD_DISTRICT_BOUNDARY_L', FID, JOB_VERSION, null from LM_AD_DISTRICT_BOUNDARY_L); 
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIPALITY', FID, JOB_VERSION, null from LM_AD_MUNICIPALITY);               
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUNDARY', FID, JOB_VERSION, null from LM_AD_MUNICIP_BOUNDARY);       
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUNDARY_A', FID, JOB_VERSION, null from LM_AD_MUNICIP_BOUNDARY_A);   
insert into MIG_MUT_INFOS (select 'LM_AD_MUNICIP_BOUND_PROJ', FID, JOB_VERSION, null from LM_AD_MUNICIP_BOUND_PROJ);   
insert into MIG_MUT_INFOS (select 'LM_AD_MUNI_CLOSE_BOUNDARY', FID, JOB_VERSION, null from LM_AD_MUNI_CLOSE_BOUNDARY); 
insert into MIG_MUT_INFOS (select 'LM_BU_HOUSE_ENTRANCE', FID, JOB_VERSION, null from LM_BU_HOUSE_ENTRANCE);           
insert into MIG_MUT_INFOS (select 'LM_CP_ACP', FID, JOB_VERSION, null from LM_CP_ACP);                                 
insert into MIG_MUT_INFOS (select 'LM_CP_PCP', FID, JOB_VERSION, null from LM_CP_PCP);                                 
insert into MIG_MUT_INFOS (select 'LM_LC_SINGLE_POINT', FID, JOB_VERSION, null from LM_LC_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_LC_SURFACE', FID, JOB_VERSION, null from LM_LC_SURFACE);                         
insert into MIG_MUT_INFOS (select 'LM_LC_SURFACE_A', FID, JOB_VERSION, null from LM_LC_SURFACE_A);                     
insert into MIG_MUT_INFOS (select 'LM_LO_LOCATION', FID, JOB_VERSION, null from LM_LO_LOCATION);                       
insert into MIG_MUT_INFOS (select 'LM_LS_LAND_SLIDE', FID, JOB_VERSION, null from LM_LS_LAND_SLIDE);                   
insert into MIG_MUT_INFOS (select 'LM_NA_LOCAL_NAME', FID, JOB_VERSION, null from LM_NA_LOCAL_NAME);                   
insert into MIG_MUT_INFOS (select 'LM_NA_NAMED_LOCALITY', FID, JOB_VERSION, null from LM_NA_NAMED_LOCALITY);           
insert into MIG_MUT_INFOS (select 'LM_NA_PLACE_NAME', FID, JOB_VERSION, null from LM_NA_PLACE_NAME);                   
insert into MIG_MUT_INFOS (select 'LM_OW_BOUNDARYPOINT', FID, JOB_VERSION, null from LM_OW_BOUNDARYPOINT);             
insert into MIG_MUT_INFOS (select 'LM_OW_DPR', FID, JOB_VERSION, null from LM_OW_DPR);                                 
insert into MIG_MUT_INFOS (select 'LM_OW_MINE', FID, JOB_VERSION, null from LM_OW_MINE);                               
insert into MIG_MUT_INFOS (select 'LM_OW_PROPERTY', FID, JOB_VERSION, null from LM_OW_PROPERTY);                       
insert into MIG_MUT_INFOS (select 'LM_OW_REAL_ESTATE', FID, JOB_VERSION, null from LM_OW_REAL_ESTATE);                 
insert into MIG_MUT_INFOS (select 'LM_OW_REAL_ESTATE_A', FID, JOB_VERSION, null from LM_OW_REAL_ESTATE_A);             
insert into MIG_MUT_INFOS (select 'LM_PA_SO_PROJ', FID, JOB_VERSION, null from LM_PA_SO_PROJ);                         
insert into MIG_MUT_INFOS (select 'LM_PA_SURFACE_PROJ', FID, JOB_VERSION, null from LM_PA_SURFACE_PROJ);               
insert into MIG_MUT_INFOS (select 'LM_PI_PIPE_OBJECT', FID, JOB_VERSION, null from LM_PI_PIPE_OBJECT);                 
insert into MIG_MUT_INFOS (select 'LM_PI_SIGNAL_POINT', FID, JOB_VERSION, null from LM_PI_SIGNAL_POINT);               
insert into MIG_MUT_INFOS (select 'LM_PI_SINGLE_POINT', FID, JOB_VERSION, null from LM_PI_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_SE_SERVITUDE', FID, JOB_VERSION, null from LM_SE_SERVITUDE);                     
insert into MIG_MUT_INFOS (select 'LM_SE_SINGLE_POINT', FID, JOB_VERSION, null from LM_SE_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_SO_SINGLE_OBJECT', FID, JOB_VERSION, null from LM_SO_SINGLE_OBJECT);             
insert into MIG_MUT_INFOS (select 'LM_SO_SINGLE_POINT', FID, JOB_VERSION, null from LM_SO_SINGLE_POINT);               
insert into MIG_MUT_INFOS (select 'LM_TD_TOLERANCEDEGREE', FID, JOB_VERSION, null from LM_TD_TOLERANCEDEGREE);         


update MIG_MUT_INFOS set FID_AD_MUTPERIMETER = (select FID from LM_AD_MUTPERIMETER where IDENTIFICATION = 'DMAV Initialzustand');
commit;

call job3.setjob(-1);
-- Alle aktuellen FID_AD_MUTPERIMETER entfernen
repeat
 update $className set FID_AD_MUTPERIMETER = null
for
select dict.F_CLASS_NAME className
from
 TB_ATTRIBUTE attr 
 join TB_DICTIONARY dict on attr.F_CLASS_ID = dict.F_CLASS_ID
where attr.NAME = 'FID_AD_MUTPERIMETER';
commit;

-- Update der FID_AD_MUTPERIMETER
update LM_AD_CANTON_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;   
update LM_AD_DISTRICT_BOUNDARY_L tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL; 
update LM_AD_MUNICIPALITY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_AD_MUNICIP_BOUNDARY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;    
update LM_AD_MUNICIP_BOUNDARY_A tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;  
update LM_AD_MUNICIP_BOUND_PROJ tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;  
update LM_AD_MUNI_CLOSE_BOUNDARY tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL; 
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
update LM_SE_SINGLE_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_SO_SINGLE_OBJECT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;       
update LM_SO_SINGLE_POINT tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;        
update LM_TD_TOLERANCEDEGREE tab set tab.FID_AD_MUTPERIMETER = (select info.FID_AD_MUTPERIMETER from MIG_MUT_INFOS info where info.JOB_VERSION = tab.JOB_VERSION) where tab.FID_AD_MUTPERIMETER is NULL;     
commit;