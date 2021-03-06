
-- either create the SDOREPVC catalog or change the next line to use an existing catalog.
CREATE STOGROUP SDOREPSG VOLUMES('*') VCAT SDOREPVC;

CREATE DATABASE SDOREPDB STOGROUP SDOREPSG BUFFERPOOL BP0;

CREATE TABLESPACE SDOREPTS IN SDOREPDB USING STOGROUP SDOREPSG
  PRIQTY 3200 SECQTY 320 PCTFREE 0 SEGSIZE 32 LOCKSIZE ROW CLOSE NO;

CREATE TABLE SDOREP.BYTESTORE
 (ROW_ID ROWID GENERATED ALWAYS NOT NULL,
  NAME VARCHAR(250) NOT NULL,
  BYTES BLOB(1G),
  TIMESTAMP1 DECIMAL(19, 0) NOT NULL,
  CONSTRAINT PK_BYTESTORE PRIMARY KEY(NAME))
 IN SDOREPDB.SDOREPTS;

CREATE UNIQUE INDEX SDOREP.BYTESTORE
 ON SDOREP.BYTESTORE (NAME)
 USING STOGROUP SDOREPSG PRIQTY 200 SECQTY 20;

CREATE LOB TABLESPACE SDOREPLS IN SDOREPDB USING STOGROUP SDOREPSG
 PRIQTY 32000 SECQTY 3200 LOCKSIZE LOB;

CREATE AUXILIARY TABLE SDOREP.AUXTABLE
 IN SDOREPDB.SDOREPLS
 STORES SDOREP.BYTESTORE COLUMN BYTES;

CREATE UNIQUE INDEX SDOREP.AUXIX ON SDOREP.AUXTABLE
 USING STOGROUP SDOREPSG PRIQTY 200 SECQTY 20;
