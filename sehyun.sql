
-- 클래스 테이블
CREATE TABLE TB_CLASS(
CLASS_NO NUMBER(6) NOT NULL,
TEACHER_NO NUMBER(6) NOT NULL,
CLASS_NAME VARCHAR2(100) NOT NULL,
CATEGORY_NO NUMBER(6) NOT NULL,
CLASS_REG_DATE DATE NOT NULL,
CLASS_UPDATE_DATE DATE NOT NULL,
CLASS_MEMBER_MAX NUMBER(5) NOT NULL
);
ALTER TABLE TB_CLASS ADD CONSTRAINT PK_TB_CLASS PRIMARY KEY(CLASS_NO);
ALTER TABLE TB_CLASS ADD CONSTRAINT FK_TEACHER_NO FOREIGN KEY(TEACHER_NO) REFERENCES TB_TEACHER(TEACHER_NO);
ALTER TABLE TB_CLASS ADD CONSTRAINT FK_CATEGORY_NO FOREIGN KEY(CATEGORY_NO) REFERENCES TB_CATEGORY(CATEGORY_NO);

-- 강사 테이블
CREATE TABLE TB_TEACHER(
TEACHER_NO NUMBER(6) NOT NULL,
TEACHER_ID VARCHAR2(100) NOT NULL,
TEACHER_NICKNAME VARCHAR2(100) NOT NULL,
TEACHER_EMAIL VARCHAR2(100) NOT NULL,
TEACHER_REG_DATE DATE NOT NULL,
TEACHER_UPDATE_DATE DATE NOT NULL,
TEACHER_PHONE VARCHAR2(15) NOT NULL
);
ALTER TABLE TB_TEACHER ADD CONSTRAINT PK_TB_TEACHER PRIMARY KEY(TEACHER_NO);

-- 사용자-클래스 매핑 테이블
CREATE TABLE TB_USER_CLASS(
USER_NO NUMBER(6) NOT NULL,
CLASS_NO NUMBER(6) NOT NULL,
TEACHER_NO NUMBER(6) NOT NULL
);
ALTER TABLE TB_USER_CLASS ADD CONSTRAINT PK_TB_USER_CLASS PRIMARY KEY(USER_NO,CLASS_NO,TEACHER_NO);
ALTER TABLE TB_USER_CLASS ADD CONSTRAINT FK_USER_NO FOREIGN KEY(USER_NO) REFERENCES TB_USER(USER_NO);
ALTER TABLE TB_USER_CLASS ADD CONSTRAINT FK_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO);
ALTER TABLE TB_USER_CLASS ADD CONSTRAINT FK_CLASS_TEACHER_NO FOREIGN KEY(TEACHER_NO) REFERENCES TB_TEACHER(TEACHER_NO);

-- 클래스 LIKE 테이블
CREATE TABLE TB_LIKE(
CLASS_NO NUMBER(6) NOT NULL,
USER_NO NUMBER(6) NOT NULL
);
ALTER TABLE TB_LIKE ADD CONSTRAINT PK_TB_LIKE PRIMARY KEY(CLASS_NO,USER_NO);
ALTER TABLE TB_LIKE ADD CONSTRAINT FK_LIKE_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO);
ALTER TABLE TB_LIKE ADD CONSTRAINT FK_LIKE_USER_NO FOREIGN KEY(USER_NO) REFERENCES TB_USER(USER_NO);

-- 지역 테이블
CREATE TABLE TB_CLASS_ADDR_PICK(
ADDR_NO NUMBER(6) NOT NULL,
CLASS_NO NUMBER(6) NOT NULL
);
ALTER TABLE TB_CLASS_ADDR_PICK ADD CONSTRAINT PK_TB_CLASS_ADDR_PICK PRIMARY KEY(ADDR_NO, CLASS_NO);
ALTER TABLE TB_CLASS_ADDR_PICK ADD CONSTRAINT FK_ADDR_NO FOREIGN KEY(ADDR_NO) REFERENCES TB_ADDR(ADDR_NO);
ALTER TABLE TB_CLASS_ADDR_PICK ADD CONSTRAINT FK_ADDR_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO);

-- 첨부파일 테이블
CREATE TABLE TB_FILE(
FILE_NO NUMBER(6) NOT NULL,
CLASS_NO NUMBER(6) NOT NULL,
FILE_ORIGIN VARCHAR2(100) NOT NULL,
FILE_SAVE VARCHAR2(100) NOT NULL,
FILE_EXTENSION VARCHAR2(100) NOT NULL,
FILE_SIZE VARCHAR2(100) NOT NULL,
FILE_REG_DATE DATE NOT NULL,
FILE_UPDATE_DATE DATE NOT NULL
);
ALTER TABLE TB_FILE ADD CONSTRAINT PK_TB_FILE PRIMARY KEY(FILE_NO);
ALTER TABLE TB_FILE ADD CONSTRAINT FK_FILE_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO);

-- 강사-카테고리 테이블
CREATE TABLE TB_TEACHER_CATEGORY(
CATEGORY_NO NUMBER(6) NOT NULL,
TEACHER_NO NUMBER(6) NOT NULL
);
ALTER TABLE TB_TEACHER_CATEGORY ADD CONSTRAINT PK_TB_TEACHER_CATEGORY PRIMARY KEY(CATEGORY_NO, TEACHER_NO);
ALTER TABLE TB_TEACHER_CATEGORY ADD CONSTRAINT FK_TEACHER_CATEGORY_NO FOREIGN KEY(CATEGORY_NO) REFERENCES TB_CATEGORY(CATEGORY_NO);
ALTER TABLE TB_TEACHER_CATEGORY ADD CONSTRAINT FK_TEACHER_CATEGORY_TEACHER_NO FOREIGN KEY(TEACHER_NO) REFERENCES TB_TEACHER(TEACHER_NO);

-- QNA 테이블
CREATE TABLE TB_CLASS_QNA(
CLASS_QNA_NO NUMBER(6) NOT NULL,
CLASS_NO NUMBER(6) NOT NULL,
TEACHER_NO NUMBER(6) NOT NULL,
CLASS_QNA_CONTENT VARCHAR2(700) NOT NULL,
CLASS_REG_DATE DATE NOT NULL,
CLASS_USER_NO NUMBER(6) NOT NULL,
CLASS_QNA_GROUP_NO NUMBER(6) NOT NULL,
CLASS_QNA_DEPTH NUMBER(1) NOT NULL,
CLASS_QNA_ORIGIN_NO NUMBER(6) NOT NULL
);
ALTER TABLE TB_CLASS_QNA ADD CONSTRAINT PK_TB_CLASS_QNA PRIMARY KEY(CLASS_QNA_NO);
ALTER TABLE TB_CLASS_QNA ADD CONSTRAINT FK_CLASS_QNA_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO);
ALTER TABLE TB_CLASS_QNA ADD CONSTRAINT FK_CLASS_QNA_TEACHER_NO FOREIGN KEY(TEACHER_NO) REFERENCES TB_TEACHER(TEACHER_NO);
ALTER TABLE TB_CLASS_QNA ADD CONSTRAINT FK_CLASS_QNA_USER_NO FOREIGN KEY(CLASS_USER_NO) REFERENCES TB_USER(USER_NO);