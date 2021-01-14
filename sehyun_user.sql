--�� ���̺��� PK �ĺ���ȣ�� "create sequence" ��� max+1 ��� ��� ��
--�ѱ��� 3byte

--�Ϲ�ȸ�� ���̺�
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

COMMENT ON TABLE tb_user IS '�⺻ȸ�� ����';
COMMENT ON COLUMN tb_user.user_no IS 'ȸ����ȣ';
COMMENT ON COLUMN tb_user.user_id IS 'ȸ�� ���̵�';
COMMENT ON COLUMN tb_user.user_pw IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN tb_user.user_name IS 'ȸ���̸�';
COMMENT ON COLUMN tb_user.user_phone IS 'ȸ�� ��ȭ��ȣ';
COMMENT ON COLUMN tb_user.user_email IS 'ȸ�� �̸���';
COMMENT ON COLUMN tb_user.user_regist_date IS 'ȸ�� ������';
COMMENT ON COLUMN tb_user.user_update_date IS 'ȸ�� ������';
COMMENT ON COLUMN tb_user.user_level IS 'ȸ�� ���� ���(1:������, 2:����+�Ϲ�ȸ��, 3:�Ϲ�ȸ��(�⺻��))';

--ī�װ� ���̺�
CREATE TABLE tb_category(
category_no NUMBER(6),
category_name VARCHAR2(100) NOT NULL,
upper_category_no NUMBER(6),
category_level NUMBER NOT NULL,
CONSTRAINT tb_category_pk PRIMARY KEY(category_no)
);

COMMENT ON TABLE tb_category IS 'ī�װ� ���̺�(���ɺо� ���� ����)';
COMMENT ON COLUMN tb_category.category_no IS 'ī�װ� ��ȣ';
COMMENT ON COLUMN tb_category.category_name IS 'ī�װ� �̸�';
COMMENT ON COLUMN tb_category.category_name IS '���� ī�װ� ��ȣ ex.�ѽ�, �߽� ������ �����̶�� ���� �з��ڵ��� ��ȣ �Է�';
COMMENT ON COLUMN tb_category.category_level IS 'ī�װ� Ʈ�� �ܰ�';


--ȸ��,ī�װ� ���� ���̺�
CREATE TABLE tb_user_category_conn(
user_no NUMBER(6),
category_no NUMBER(6),
CONSTRAINT tb_user_category_pk PRIMARY KEY(user_no, category_no),
CONSTRAINT tb_user_cate_ufk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE CASCADE, --user ���� �� ���� ����
CONSTRAINT tb_user_cate_cfk FOREIGN KEY (category_no) REFERENCES tb_category(category_no) ON DELETE CASCADE  --category ���� �� ���� ����
);

COMMENT ON TABLE tb_user_category_conn IS 'ȸ��-����ī�װ� ���� ���̺�';
COMMENT ON COLUMN tb_user_category_conn.user_no IS 'ȸ����ȣ. ȸ�����̺��� ȸ�� ���� �� �Բ� ����';
COMMENT ON COLUMN tb_user_category_conn.category_no IS 'ī�װ� ��ȣ. ī�װ����̺��� ī�װ� ���� �� �Բ� ����';


--���� ���̺�
CREATE TABLE tb_addr(
addr_no NUMBER(6),
addr_name VARCHAR2(30) NOT NULL,  --"����Ư����ġ��"�� ���� �� ���ڰ��ƿ�
upper_addr_no NUMBER(6),
addr_level NUMBER NOT NULL,
CONSTRAINT tb_addr_pk PRIMARY KEY(addr_no)
);

COMMENT ON TABLE tb_addr IS '���� ���̺�(�������� ���� ����)';
COMMENT ON COLUMN tb_addr.addr_no IS '���� ��ȣ';
COMMENT ON COLUMN tb_addr.addr_name IS '���� �̸�';
COMMENT ON COLUMN tb_addr.upper_addr_no IS '���� ���� ��ȣ ex.������,������ ������ ����Ư���ö�� �����з� �ڵ��� ��ȣ �Է�';
COMMENT ON COLUMN tb_addr.addr_level IS '���� Ʈ�� �ܰ�';


--ȸ��,���� ���� ���̺�
CREATE TABLE tb_user_addr_pick(
user_no NUMBER(6),
addr_no NUMBER(6),
CONSTRAINT tb_user_addr_pick_pk PRIMARY KEY (user_no, addr_no),
CONSTRAINT tb_user_addr_pick_ufk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE CASCADE,
CONSTRAINT tb_user_addr_pick_afk FOREIGN KEY (addr_no) REFERENCES tb_addr(addr_no) ON DELETE CASCADE
);


COMMENT ON TABLE tb_user_addr_pick IS 'ȸ��-�������� ���� ���̺�';
COMMENT ON COLUMN tb_user_addr_pick.user_no IS 'ȸ����ȣ. ȸ�����̺��� ȸ�� ���� �� �Բ� ����';
COMMENT ON COLUMN tb_user_addr_pick.category_no IS '���� ��ȣ. ī�װ����̺��� ī�װ� ���� �� �Բ� ����';


--ȸ�� ������ ���̺�
CREATE TABLE tb_class_review(
class_review_no NUMBER(6),
class_no NUMBER(6) NOT NULL,
--teacher_no NUMBER(6), --ȸ�����̺� �ϳ��� �����ϱ�� ������ user_no �ϳ�..?
user_no NUMBER(6) NOT NULL,
class_review_point NUMBER NOT NULL,
class_review_content VARCHAR2(4000) NOT NULL, --�Ǵ� CLOB
class_review_reg_date DATE Default SYSDATE,
CONSTRAINT tb_class_review_pk PRIMARY KEY (user_no, class_review_no),

);


--������ �̿빮�� ���̺�
CREATE TABLE tb_admin_qna(
admin_qna_no NUMBER(6),
user_no NUMBER(6),
admin_qna_writer_id VARCHAR2(20),
admin_qna_title VARCHAR2(600),   --���� ��Դ� 200�� ���� ���� �� ���ƿ�.
admin_qna_content VARCHAR2(4000),--�ϴ��� 4000byte�ε�, CLOB�̶�� ������������ ���� ���� ���� �� ���ƿ�
admin_qna_writer_level VARCHAR2(1),
admin_qna_reg_date DATE DEFAULT SYSDATE,
admin_qna_group_no NUMBER(6),
admin_qna_depth NUMBER(6),
admin_qna_origin_no NUMBER(6),
CONSTRAINT tb_admin_qna_pk PRIMARY KEY(admin_qna_no),
CONSTRAINT tb_admin_qna_user_fk FOREIGN KEY (user_no) REFERENCES tb_user(user_no) ON DELETE SET NULL
);

COMMENT ON TABLE tb_admin_qna IS '������/�������� �̿빮�� ���̺�';
COMMENT ON COLUMN tb_admin_qna.admin_qna_no IS '���Ǳ� ��ȣ';
COMMENT ON COLUMN tb_admin_qna.user_no IS '���Ǳ� �ۼ��� ȸ����ȣ';
COMMENT ON COLUMN tb_admin_qna.admin_qna_writer_id IS '���Ǳ� �ۼ��� ���̵�';
COMMENT ON COLUMN tb_admin_qna.admin_qna_title IS '���Ǳ� ����';
COMMENT ON COLUMN tb_admin_qna.admin_qna_content IS '���Ǳ� ����';
COMMENT ON COLUMN tb_admin_qna.admin_qna_writer_level IS '���Ǳ� ȸ�� ����';
COMMENT ON COLUMN tb_admin_qna.admin_qna_reg_date IS '���Ǳ� �ۼ���';
COMMENT ON COLUMN tb_admin_qna.admin_qna_group_no IS '���Ǳ� ������ �׷�no';
COMMENT ON COLUMN tb_admin_qna.admin_qna_depth IS '���Ǳ� ������ depth(�����ܰ�)';
COMMENT ON COLUMN tb_admin_qna.admin_qna_origin_no IS '���Ǳ� ������ �θ��';


