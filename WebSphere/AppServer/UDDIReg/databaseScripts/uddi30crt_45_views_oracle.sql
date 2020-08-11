-- Path, Component, Release:  UDDI/ws/code/uddi.install/src/database/uddi30crt_45_views_oracle.sql, UDDI, WAS855.UDDI, cf091607.02
-- Version:                   1.2
-- Last-changed:              06/01/09 08:05:55
--
-- @start_source_copyright@
-- Licensed Materials - Property of IBM                              
--                                                                   
-- 5724-I63, 5724-H88, 5655-N01, 5733-W60                                                           
--                                                                   
-- (C) COPYRIGHT IBM Corp., 2004, 2005 All Rights Reserved     
--                                                                   
-- US Government Users Restricted Rights - Use, duplication or       
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
-- @end_source_copyright@

------------------------------------------------------------
--
-- operationalinfo view
--
-- The column "modifiedchildvalid" is a means to determine
-- whether the "modifiedchild" column REALLY IS "modifiedchild"
-- or "current_timestamp".
--
-- The column tmodelHidden = 0 for any row OTHER THAN a
-- tmodel with a non-null DELETEDATE
--
------------------------------------------------------------
create view ibmudi30.voperatnlinfo_v3
(type, internalkey, v3key, owner, operator, createdate, changedate, modifiedchild, modifiedchildvalid, tmodelHidden)
as
select
   'business',
   business.businesskey,
   businesskeymap.v3businesskey,
   business.owner,
   business.operator,
   business.createdate,
   business.changedate,
   business.modifiedchild,
   1,
   0
from
  ibmudi30.business business
   inner join ibmudi30.businesskeymap businesskeymap on (business.businesskey = businesskeymap.businesskey)
union
select
   'service',
   bservice.servicekey,
   bservicekeymap.v3servicekey,
   business.owner,
   business.operator,
   bservice.createdate,
   bservice.changedate,
   bservice.modifiedchild,
   1,
   0
from
  ibmudi30.bservice bservice
    inner join ibmudi30.bservicekeymap bservicekeymap on (bservice.servicekey  = bservicekeymap.servicekey)
    inner join ibmudi30.business       business       on (bservice.businesskey = business.businesskey)
union
select
   'bindingtemplate',
   btemplate.bindingkey,
   btemplatekeymap.v3bindingkey,
   business.owner,
   business.operator,
   btemplate.createdate,
   btemplate.changedate,
   current_timestamp,
   0,
   0
from
  ibmudi30.btemplate btemplate
    inner join ibmudi30.btemplatekeymap btemplatekeymap on ( btemplate.bindingkey = btemplatekeymap.bindingkey )
    inner join ibmudi30.bservice        bservice        on ( btemplate.servicekey = bservice.servicekey )
    inner join ibmudi30.business        business        on ( bservice.businesskey = business.businesskey )
union
select
   'tmodel',
   tmodel.tmodelkey,
   tmodelkeymap.v3tmodelkey,
   tmodel.owner,
   tmodel.operator,
   tmodel.createdate,
   tmodel.changedate,
   current_timestamp,
   0,
   (CASE WHEN deletedate IS NULL THEN 0 ELSE 1 END)
from
  ibmudi30.tmodel tmodel
    inner join ibmudi30.tmodelkeymap tmodelkeymap on (tmodel.tmodelkey = tmodelkeymap.tmodelkey)
where
  tmodel.conditional is null;


--                                                    
-- Apply permissions
--
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbusiness_v3 to IBMUDDI;       
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbservice_v3 to IBMUDDI;       
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbservice_v3_s to IBMUDDI;     
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbtemplate_v3 to IBMUDDI;      
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbtemplate_v3_s to IBMUDDI;    
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vcontact_v2 to IBMUDDI;        
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.voperatnlinfo_v3 to IBMUDDI;   
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vtmodel_v3 to IBMUDDI;         
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vtminstanceinfo_v3 to IBMUDDI; 
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vpubassert_v3 to IBMUDDI;      
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbusinesscatbag_v3 to IBMUDDI; 
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbservicecatbag_v3 to IBMUDDI; 
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbtempltcatbag_v3 to IBMUDDI;  
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vtmodelcatbag_v3 to IBMUDDI;   
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vSVCCmbnCatbag_v3 to IBMUDDI;  
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vbusinessidbag_v3 to IBMUDDI;  
grant SELECT, INSERT, DELETE, UPDATE on ibmudi30.vtmodelidbag_v3 to IBMUDDI;    
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vactivepolicy to IBMUDDI;      
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vlimitvalue to IBMUDDI;        
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vusertier to IBMUDDI;          
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vuserentitlement to IBMUDDI;   
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vtierincdefault to IBMUDDI;    
grant SELECT, INSERT, DELETE, UPDATE on ibmuds30.vconfigproperty to IBMUDDI;    

