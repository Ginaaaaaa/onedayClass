--각 테이블의 PK 식별번호는 "create sequence" 대신 max+1 사용 고려 중
--한글은 3byte

--일반회원 테이블
DROP TABLE tb_user;
CREATE TABLE tb_user (
user_no NUMBER(6),
user_id VARCHAR2(20) NOT NULL,
user_pw VARCHAR2(16) NOT NULL,
user_name VARCHAR2(21) NOT NULL,
user_phone VARCHAR2(13) NOT NULL,
user_email VARCHAR2(300) NOT NULL,
user_regist_date DATE DEFAULT SYSDATE,
user_update_date DATE DEFAULT SYSDATE,
user_level VARCHAR2(1) DEFAULT '3',
CONSTRAINT tb_user_pk PRIMARY KEY(user_no),
CONSTRAINT tb_user_level_ck CHECK (user_level IN('1','2','3'))
);

COMMENT ON TABLE tb_user IS '기본회원 정보';
COMMENT ON COLUMN tb_user.user_no IS '회원번호';
COMMENT ON COLUMN tb_user.user_id IS '회원 아이디';
COMMENT ON COLUMN tb_user.user_pw IS '회원 비밀번호';
COMMENT ON COLUMN tb_user.user_name IS '회원이름';
COMMENT ON COLUMN tb_user.user_phone IS '회원 전화번호';
COMMENT ON COLUMN tb_user.user_email IS '회원 이메일';
COMMENT ON COLUMN tb_user.user_regist_date IS '회원 가입일';
COMMENT ON COLUMN tb_user.user_update_date IS '회원 수정일';
COMMENT ON COLUMN tb_user.user_level IS '회원 권한 등급(1:관리자, 2:강사+일반회원, 3:일반회원(기본값))';

--카테고리 테이블
CREATE TABLE tb_category(
category_no NUMBER(6),
category_name VARCHAR2(100) NOT NULL,
upper_category_no NUMBER(6),
category_level NUMBER NOT NULL,
CONSTRAINT tb_category_pk PRIMARY KEY(category_no)
);

COMMENT ON TABLE tb_category IS '카테고리 테이블(관심분야 설정 관련)';
COMMENT ON COLUMN tb_category.category_no IS '카테고리 번호';
COMMENT ON COLUMN tb_category.category_name IS '카테고리 이름';
COMMENT ON COLUMN tb_category.category_name IS '상위 카테고리 번호 ex.한식, 중식 있으면 음식이라는 상위 분류코드의 번호 입력';
COMMENT ON COLUMN tb_category.category_level IS '카테고리 트리 단계';


--회원,카테고리 연결 테이블
CREATE TABLE tb_user_category_conn(
user_no NUMBER(6),
category_no NUMBER(6),
CONSTRAINT tb_user_category_pk PRIMARY KEY(user_no, category_no),
CONSTRAINT tb_user_cate_ufk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE CASCADE, --user 삭제 시 정보 삭제
CONSTRAINT tb_user_cate_cfk FOREIGN KEY (category_no) REFERENCES tb_category(category_no) ON DELETE CASCADE  --category 삭제 시 정보 삭제
);

COMMENT ON TABLE tb_user_category_conn IS '회원-관심카테고리 정보 테이블';
COMMENT ON COLUMN tb_user_category_conn.user_no IS '회원번호. 회원테이블의 회원 삭제 시 함께 삭제';
COMMENT ON COLUMN tb_user_category_conn.category_no IS '카테고리 번호. 카테고리테이블의 카테고리 삭제 시 함께 삭제';


--지역 테이블
CREATE TABLE tb_addr(
addr_no NUMBER(6),
addr_name VARCHAR2(30) NOT NULL,  --"제주특별자치도"가 가장 긴 글자같아요
upper_addr_no NUMBER(6),
addr_level NUMBER NOT NULL,
CONSTRAINT tb_addr_pk PRIMARY KEY(addr_no)
);

COMMENT ON TABLE tb_addr IS '지역 테이블(관심지역 설정 관련)';
COMMENT ON COLUMN tb_addr.addr_no IS '지역 번호';
COMMENT ON COLUMN tb_addr.addr_name IS '지역 이름';
COMMENT ON COLUMN tb_addr.upper_addr_no IS '상위 지역 번호 ex.강서구,강동구 있으면 서울특별시라는 상위분류 코드의 번호 입력';
COMMENT ON COLUMN tb_addr.addr_level IS '지역 트리 단계';


--회원,지역 연결 테이블
CREATE TABLE tb_user_addr_pick(
user_no NUMBER(6),
addr_no NUMBER(6),
CONSTRAINT tb_user_addr_pick_pk PRIMARY KEY (user_no, addr_no),
CONSTRAINT tb_user_addr_pick_ufk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE CASCADE,
CONSTRAINT tb_user_addr_pick_afk FOREIGN KEY (addr_no) REFERENCES tb_addr(addr_no) ON DELETE CASCADE
);


COMMENT ON TABLE tb_user_addr_pick IS '회원-관심지역 정보 테이블';
COMMENT ON COLUMN tb_user_addr_pick.user_no IS '회원번호. 회원테이블의 회원 삭제 시 함께 삭제';
COMMENT ON COLUMN tb_user_addr_pick.category_no IS '지역 번호. 카테고리테이블의 카테고리 삭제 시 함께 삭제';


--회원 수강평 테이블
CREATE TABLE tb_class_review(
class_review_no NUMBER(6),
class_no NUMBER(6) NOT NULL,
--teacher_no NUMBER(6), --회원테이블 하나로 통합하기로 했으니 user_no 하나..?
user_no NUMBER(6) NOT NULL,
class_review_point NUMBER NOT NULL,
class_review_content VARCHAR2(4000) NOT NULL, --또는 CLOB
class_review_reg_date DATE Default SYSDATE,
CONSTRAINT tb_class_review_pk PRIMARY KEY (user_no, class_review_no),

);


--관리자 이용문의 테이블
CREATE TABLE tb_admin_qna(
admin_qna_no NUMBER(6),
user_no NUMBER(6),
admin_qna_writer_id VARCHAR2(20),
admin_qna_title VARCHAR2(600),   --보통 길게는 200자 정도 들어가는 것 같아요.
admin_qna_content VARCHAR2(4000),--일단은 4000byte인데, CLOB이라는 데이터형식이 나을 수도 있을 것 같아요
admin_qna_writer_level VARCHAR2(1),
admin_qna_reg_date DATE DEFAULT SYSDATE,
admin_qna_group_no NUMBER(6),
admin_qna_depth NUMBER(6),
admin_qna_origin_no NUMBER(6),
CONSTRAINT tb_admin_qna_pk PRIMARY KEY(admin_qna_no),
CONSTRAINT tb_admin_qna_user_fk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE SET NULL
);

COMMENT ON TABLE tb_admin_qna IS '관리자/웹페이지 이용문의 테이블';
COMMENT ON COLUMN tb_admin_qna.admin_qna_no IS '문의글 번호';
COMMENT ON COLUMN tb_admin_qna.user_no IS '문의글 작성자 회원번호';
COMMENT ON COLUMN tb_admin_qna.admin_qna_writer_id IS '문의글 작성자 아이디';
COMMENT ON COLUMN tb_admin_qna.admin_qna_title IS '문의글 제목';
COMMENT ON COLUMN tb_admin_qna.admin_qna_content IS '문의글 내용';
COMMENT ON COLUMN tb_admin_qna.admin_qna_writer_level IS '문의글 회원 레벨';
COMMENT ON COLUMN tb_admin_qna.admin_qna_reg_date IS '문의글 작성일';
COMMENT ON COLUMN tb_admin_qna.admin_qna_group_no IS '문의글 계층형 그룹no';
COMMENT ON COLUMN tb_admin_qna.admin_qna_depth IS '문의글 계층형 depth(계층단계)';
COMMENT ON COLUMN tb_admin_qna.admin_qna_origin_no IS '문의글 계층형 부모글';


