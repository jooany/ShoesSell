CREATE TABLE free_comment(
   num NUMBER PRIMARY KEY, --댓글의 글번호
   writer VARCHAR2(100), --댓글 작성자의 아이디
   content VARCHAR2(500), --댓글 내용
   target_id VARCHAR2(100), --댓글의 대상자 아이디
   ref_group NUMBER,
   comment_group NUMBER,
   deleted CHAR(3) DEFAULT 'no',
   regdate DATE
);
CREATE SEQUENCE free_comment_seq;

CREATE TABLE share_comment(
   num NUMBER PRIMARY KEY, --댓글의 글번호
   writer VARCHAR2(100), --댓글 작성자의 아이디
   content VARCHAR2(500), --댓글 내용
   target_id VARCHAR2(100), --댓글의 대상자 아이디
   ref_group NUMBER,
   comment_group NUMBER,
   deleted CHAR(3) DEFAULT 'no',
   regdate DATE
);
CREATE SEQUENCE share_comment_seq;

CREATE TABLE resell_comment(
   num NUMBER PRIMARY KEY, --댓글의 글번호
   writer VARCHAR2(100), --댓글 작성자의 아이디
   content VARCHAR2(500), --댓글 내용
   target_id VARCHAR2(100), --댓글의 대상자 아이디
   ref_group NUMBER,
   comment_group NUMBER,
   deleted CHAR(3) DEFAULT 'no',
   regdate DATE
);
CREATE SEQUENCE resell_comment_seq;

CREATE TABLE users(
   id VARCHAR2(100) PRIMARY KEY,
   pwd VARCHAR2(100) NOT NULL,
   email VARCHAR2(100),
   profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
   regdate DATE -- 가입일
);

CREATE TABLE board_share(
   num NUMBER PRIMARY KEY,
   writer VARCHAR2(100) NOT NULL,
   title VARCHAR2(100) NOT NULL,
   orgFileName VARCHAR2(100) NOT NULL, -- 원본 파일명
   saveFileName VARCHAR2(100) NOT NULL, -- 서버에 실제로 저장된 파일명
   fileSize NUMBER NOT NULL, -- 파일의 크기 
   regdate DATE
);
CREATE SEQUENCE share_seq;

CREATE TABLE free(
   num NUMBER PRIMARY KEY, --글번호
   writer VARCHAR2(100) NOT NULL, --작성자 (로그인된 아이디)
   title VARCHAR2(100) NOT NULL, --제목
   content CLOB, --글 내용
   viewCount NUMBER, -- 조회수
   regdate DATE --글 작성일
);
CREATE SEQUENCE free_seq;

CREATE TABLE resell(
   num NUMBER PRIMARY KEY, --글번호
   writer VARCHAR2(100) NOT NULL, --작성자 (로그인된 아이디)
   title VARCHAR2(100) NOT NULL, --제목
   content CLOB, --글 내용
   viewCount NUMBER, -- 조회수
   regdate DATE --글 작성일,
   imagePath VARCHAR2(100) --이미지 경로
);
CREATE SEQUENCE resell_seq;