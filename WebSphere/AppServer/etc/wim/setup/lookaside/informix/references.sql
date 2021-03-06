--------------- Begin Copyright - Do not add comments here --------------
--
-- Licensed Materials - Property of IBM
--
-- Restricted Materials of IBM
--
-- Virtual Member Manager
--
-- (C) Copyright IBM Corp. 2005, 2010
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with
-- IBM Corp.
--
----------------------------- End Copyright -----------------------------
ALTER TABLE @dbschema.@LAPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_52);


ALTER TABLE @dbschema.@LAPROPENT ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_53);


ALTER TABLE @dbschema.@LALONGPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_54);
			
			
ALTER TABLE @dbschema.@LALONGPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_55);


ALTER TABLE @dbschema.@LALONGPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_56);
			
			
ALTER TABLE @dbschema.@LALONGPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_57);
			
			
ALTER TABLE @dbschema.@LABLOBPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_58);
			
			
ALTER TABLE @dbschema.@LABLOBPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_59);


ALTER TABLE @dbschema.@LABLOBPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_60);
			
			
ALTER TABLE @dbschema.@LABLOBPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_61);


ALTER TABLE @dbschema.@LADBLPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_62);
			
			
ALTER TABLE @dbschema.@LADBLPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_63);


ALTER TABLE @dbschema.@LADBLPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_64);
			
			
ALTER TABLE @dbschema.@LADBLPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_65);


ALTER TABLE @dbschema.@LATSPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_66);
			
			
ALTER TABLE @dbschema.@LATSPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_67);


ALTER TABLE @dbschema.@LATSPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_68);
			
			
ALTER TABLE @dbschema.@LATSPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_69);


ALTER TABLE @dbschema.@LAINTPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_70);
			
			
ALTER TABLE @dbschema.@LAINTPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_71);


ALTER TABLE @dbschema.@LAINTPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_72);
			
			
ALTER TABLE @dbschema.@LAINTPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_73);


ALTER TABLE @dbschema.@LAREFPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_74);
			
			
ALTER TABLE @dbschema.@LAREFPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_75);


ALTER TABLE @dbschema.@LAREFPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_76);
			
			
ALTER TABLE @dbschema.@LAREFPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_77);


ALTER TABLE @dbschema.@LASTRPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_78);
			
			
ALTER TABLE @dbschema.@LASTRPROP ADD CONSTRAINT 
	(FOREIGN KEY(TYPE_ID) REFERENCES @dbschema.@LAPROPTYPE
	CONSTRAINT WIMF_79);


ALTER TABLE @dbschema.@LASTRPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_80);
			
			
ALTER TABLE @dbschema.@LASTRPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_81);


ALTER TABLE @dbschema.@LACOMPREL ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_82);


ALTER TABLE @dbschema.@LACOMPREL ADD CONSTRAINT 
	(FOREIGN KEY(COMPONENT_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_83);
			
			
ALTER TABLE @dbschema.@LACOMPPROP ADD CONSTRAINT 
	(FOREIGN KEY(PROP_ID) REFERENCES @dbschema.@LAPROP
	ON DELETE CASCADE CONSTRAINT WIMF_84);
			
ALTER TABLE @dbschema.@LACOMPPROP ADD CONSTRAINT 
	(FOREIGN KEY(ENTITY_ID) REFERENCES @dbschema.@LAENTITY
	ON DELETE CASCADE CONSTRAINT WIMF_85);
			
ALTER TABLE @dbschema.@LACOMPPROP ADD CONSTRAINT 
	(FOREIGN KEY(COMPOSITE_ID) REFERENCES @dbschema.@LACOMPPROP
	ON DELETE CASCADE CONSTRAINT WIMF_86);
