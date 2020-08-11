--------------- Begin Copyright - Do not add comments here --------------
--
-- Licensed Materials - Property of IBM
--
-- Restricted Materials of IBM
--
-- Virtual Member Manager
--
-- Copyright IBM Corp. 2005, 2010
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with
-- IBM Corp.
--
----------------------------- End Copyright -----------------------------
CREATE TABLE @dbschema.@DBENTITY (
	ENTITY_ID		BIGINT NOT NULL,
	ENTITY_TYPE		VARGRAPHIC(36) CCSID 13488 NOT NULL,
	UNIQUE_ID		CHAR(36) NOT NULL,
	UNIQUE_NAME		VARGRAPHIC(1000) CCSID 13488 NOT NULL,
	UNIQUE_NAME_KEY		VARGRAPHIC(236) CCSID 13488 NOT NULL
);


CREATE TABLE @dbschema.@DBPROPTYPE (
	TYPE_ID			CHAR(16) NOT NULL,
	DESCRIPTION		VARGRAPHIC(254) CCSID 13488
);



CREATE TABLE @dbschema.@DBPROP (
	PROP_ID			INTEGER NOT NULL,
	NAME			VARGRAPHIC(200) CCSID 13488 NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	META_NAME		VARGRAPHIC(36) CCSID 13488 DEFAULT 'DEFAULT' NOT NULL,
	IS_COMPOSITE		INTEGER DEFAULT 0,
	VALUE_LENGTH		INTEGER,
	READ_ONLY		INTEGER DEFAULT 0,
	MULTI_VALUED		INTEGER DEFAULT 1,
	CASE_EXACT_MATCH	INTEGER DEFAULT 1,
	CLASSNAME		VARGRAPHIC(512) CCSID 13488 ,
	DESCRIPTION		VARGRAPHIC(512) CCSID 13488 ,
	APPLICATION_ID		VARGRAPHIC(254) CCSID 13488 DEFAULT 'com.ibm.websphere.wim' NOT NULL
);


CREATE TABLE @dbschema.@DBPROPENT (
	PROP_ID			INTEGER	NOT NULL,
	APPLICABLE_ENTTYPE	VARGRAPHIC(36) CCSID 13488 NOT NULL,
	REQUIRED_ENTTYPE	INTEGER DEFAULT 0 NOT NULL
);


CREATE TABLE @dbschema.@DBLONGPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		BIGINT,
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBBLOBPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		BLOB(10000000),
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBDBLPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		DOUBLE,
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBINTPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		INTEGER,
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBREFPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	REF_UNAME_KEY		VARGRAPHIC(236) CCSID 13488 NOT NULL,
	REF_UNAME		VARGRAPHIC(1000) CCSID 13488 NOT NULL,
	REF_EXT_ID		VARGRAPHIC(200) CCSID 13488 NOT NULL,
	REF_FULL_EXT_ID		VARGRAPHIC(1000) CCSID 13488 NOT NULL,
	REF_REPOS_ID		CHAR(36) NOT NULL,
	META_VALUE		VARGRAPHIC(36)
);


CREATE TABLE @dbschema.@DBSTRPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		VARGRAPHIC(1500) CCSID 13488,
	VALUE_KEY		VARGRAPHIC(1500) CCSID 13488,
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBTSPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	TYPE_ID			CHAR(16) NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE		BIGINT,
	PROPVALUE		TIMESTAMP,
	META_VALUE		VARGRAPHIC(36) CCSID 13488
);


CREATE TABLE @dbschema.@DBCOMPREL (
	COMPOSITE_ID		INTEGER NOT NULL,
	COMPONENT_ID		INTEGER NOT NULL,
	IS_REQUIRED		INTEGER DEFAULT 0 NOT NULL,
	IS_KEY			INTEGER DEFAULT 0 NOT NULL
);


CREATE TABLE @dbschema.@DBCOMPPROP (
	VALUE_ID		BIGINT NOT NULL,
	PROP_ID			INTEGER NOT NULL,
	ENTITY_ID		BIGINT NOT NULL,
	COMPOSITE_ID		BIGINT,
	META_VALUE		VARGRAPHIC(36) CCSID 13488 
);


CREATE TABLE @dbschema.@DBENTREL (
	DESCENDANT_ID		BIGINT NOT NULL,
	ANCESTOR_ID		BIGINT NOT NULL
);


CREATE TABLE @dbschema.@DBKEYS (
	KEYS_ID			INTEGER NOT NULL,
	TABLENAME		VARGRAPHIC(256) CCSID 13488 NOT NULL,
	COLUMNNAME		VARGRAPHIC(18) CCSID 13488 NOT NULL,
	COUNTER			BIGINT NOT NULL,
	PREFETCH_SIZE		BIGINT DEFAULT 20,
	LOWER_BOUND		BIGINT DEFAULT 0,
	UPPER_BOUND		BIGINT DEFAULT 2147483648
);


CREATE TABLE @dbschema.@DBGRPREL (
	GRP_ID			BIGINT NOT NULL,
	REPOS_ID		CHAR(36) NOT NULL,
	EXT_ID			VARGRAPHIC(200) CCSID 13488 NOT NULL,
	FULL_EXT_ID		VARGRAPHIC(1000) CCSID 13488 NOT NULL
);


CREATE TABLE @dbschema.@DBACCT (
	ENTITY_ID		BIGINT NOT NULL, 
	PASSWORD		CHAR(128) FOR BIT DATA,
	SALT			VARGRAPHIC(254) CCSID 13488,
	EXT_ID			VARGRAPHIC(200) CCSID 13488,
	FULL_EXT_ID		VARGRAPHIC(1000) CCSID 13488,
	REPOS_ID		CHAR(36)
);

