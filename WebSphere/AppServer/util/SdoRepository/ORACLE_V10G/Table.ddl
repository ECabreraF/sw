CREATE TABLE SDOREP.BYTESTORE
  (NAME VARCHAR2(250) NOT NULL,
   BYTES LONG RAW NULL,
   TIMESTAMP1 NUMBER(38, 0) NOT NULL);

ALTER TABLE SDOREP.BYTESTORE
  ADD CONSTRAINT PK_BYTESTORE PRIMARY KEY (NAME);
