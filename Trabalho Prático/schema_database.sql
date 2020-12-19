
  CREATE TABLE "MONITOR"."DB_MONITOR" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"URL" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"USERNAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "DB_MONITOR_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "MONITOR"."DB_MONITOR_TRG" 
BEFORE INSERT ON DB_MONITOR 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "MONITOR"."DB_MONITOR_TRG" ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "MONITOR"."DB_MONITOR_TRG1" 
BEFORE INSERT ON DB_MONITOR 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT DB_MONITOR_SEQ1.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "MONITOR"."DB_MONITOR_TRG1" ENABLE;


  CREATE TABLE "MONITOR"."TABLESPACES" 
   (	"TABLESPACE_NAME" VARCHAR2(250 BYTE) NOT NULL ENABLE, 
	"TABLESPACE_SIZE" NUMBER(10,2) NOT NULL ENABLE, 
	"FREE" NUMBER(10,2) NOT NULL ENABLE, 
	"USED" NUMBER(10,2) NOT NULL ENABLE, 
	"PERC_FREE" NUMBER(10,2) NOT NULL ENABLE, 
	"PERC_USED" NUMBER(10,2) NOT NULL ENABLE, 
	"STATUS" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"ALLOCATION_TYPE" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"CONTENTS" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"SEGMENT_SPACE_MANAGEMENT" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	"DB" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TABLESPACES_PK" PRIMARY KEY ("TABLESPACE_NAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "TABLESPACES_FK1" FOREIGN KEY ("DB")
	  REFERENCES "MONITOR"."DB_MONITOR" ("ID") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;




  CREATE TABLE "MONITOR"."DATAFILES" 
   (	"FILENAME" VARCHAR2(500 BYTE) NOT NULL ENABLE, 
	"FILE_ID" NUMBER NOT NULL ENABLE, 
	"TABLESPACE_NAME" VARCHAR2(250 BYTE) NOT NULL ENABLE, 
	"BYTES" NUMBER NOT NULL ENABLE, 
	"BLOCKS" NUMBER NOT NULL ENABLE, 
	"STATUS" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"AUTOEXTENSIBLE" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"MAXBYTES" NUMBER NOT NULL ENABLE, 
	"MAXBLOCKS" NUMBER NOT NULL ENABLE, 
	"ONLINE_STATUS" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "DATAFILES_PK" PRIMARY KEY ("TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "DATAFILES_FK1" FOREIGN KEY ("TABLESPACE_NAME", "TIMESTAMP")
	  REFERENCES "MONITOR"."TABLESPACES" ("TABLESPACE_NAME", "TIMESTAMP") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;



  CREATE TABLE "MONITOR"."USERS" 
   (	"USERNAME" VARCHAR2(250 BYTE) NOT NULL ENABLE, 
	"ACCOUNT_STATUS" VARCHAR2(150 BYTE) NOT NULL ENABLE, 
	"EXPIRY_DATE" DATE NOT NULL ENABLE, 
	"DEFAULT_TABLESPACE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"TEMPORARY_TABLESPACE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"PROFILE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"CREATED" DATE NOT NULL ENABLE, 
	"COMMON" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "USERS_PK" PRIMARY KEY ("USERNAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "USERS_FK1" FOREIGN KEY ("DEFAULT_TABLESPACE", "TIMESTAMP")
	  REFERENCES "MONITOR"."TABLESPACES" ("TABLESPACE_NAME", "TIMESTAMP") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;



  CREATE TABLE "MONITOR"."SESSIONS" 
   (	"SID" NUMBER NOT NULL ENABLE, 
	"USERNAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"STATUS" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"SERVER" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"SCHEMANAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"OSUSER" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"MACHINE" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"PORT" NUMBER NOT NULL ENABLE, 
	"TYPE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"WAIT_TIME_MICRO" NUMBER NOT NULL ENABLE, 
	"LOGON_TIME" DATE NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "SESSIONS_PK" PRIMARY KEY ("SID", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "SESSIONS_FK1" FOREIGN KEY ("USERNAME", "TIMESTAMP")
	  REFERENCES "MONITOR"."USERS" ("USERNAME", "TIMESTAMP") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;




  CREATE TABLE "MONITOR"."ROLES" 
   (	"ROLE_ID" NUMBER NOT NULL ENABLE, 
	"ROLE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"AUTHENTICATION_TYPE" VARCHAR2(200 BYTE), 
	 CONSTRAINT "ROLES_PK" PRIMARY KEY ("ROLE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;


  CREATE TABLE "MONITOR"."USERS_ROLES" 
   (	"ROLE_NAME" VARCHAR2(500 BYTE) NOT NULL ENABLE, 
	"USERNAME" VARCHAR2(500 BYTE) NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "USERS_ROLES_PK" PRIMARY KEY ("ROLE_NAME", "USERNAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "USERS_ROLES_FK1" FOREIGN KEY ("USERNAME", "TIMESTAMP")
	  REFERENCES "MONITOR"."USERS" ("USERNAME", "TIMESTAMP") ENABLE, 
	 CONSTRAINT "USERS_ROLES_FK2" FOREIGN KEY ("ROLE_NAME")
	  REFERENCES "MONITOR"."ROLES" ("ROLE") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;


  CREATE TABLE "MONITOR"."PROGRAM_GLOBAL_AREA" 
   (	"NAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"USED" NUMBER NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	"DB" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "PROGRAM_GLOBAL_AREA_PK" PRIMARY KEY ("NAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "PROGRAM_GLOBAL_AREA_FK1" FOREIGN KEY ("DB")
	  REFERENCES "MONITOR"."DB_MONITOR" ("ID") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;


  CREATE TABLE "MONITOR"."SYSTEM_GLOBAL_AREA" 
   (	"NAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"VALUE" NUMBER NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	"DB" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "SYSTEM_GLOBAL_AREA_PK" PRIMARY KEY ("NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "SYSTEM_GLOBAL_AREA_FK1" FOREIGN KEY ("DB")
	  REFERENCES "MONITOR"."DB_MONITOR" ("ID") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;


  CREATE TABLE "MONITOR"."CPU" 
   (	"USERNAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"USAGE" NUMBER NOT NULL ENABLE, 
	"TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE, 
	"DB" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "CPU_PK" PRIMARY KEY ("USERNAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SYSTEM"  ENABLE, 
	 CONSTRAINT "CPU_FK1" FOREIGN KEY ("DB")
	  REFERENCES "MONITOR"."DB_MONITOR" ("ID") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SYSTEM" ;
