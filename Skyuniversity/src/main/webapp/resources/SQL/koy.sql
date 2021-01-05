show user;

select * from tab;

------------------------------- 2020-12-09 start -----------------------------------------
-------------------------- 게시판 종류 테이블 생성 ------------------------------
DROP TABLE tbl_boardKind;
CREATE TABLE tbl_boardKind (
    boardKindNo     NUMBER  NOT NULL,               -- 게시판 번호
    boardTypeNo     NUMBER(1) NOT NULL,             -- 게시판 타입번호 (학교 - 1, 커뮤니티 - 2, 관심사 - 3, 정보 - 4, 장터 - 5)
    boardName       VARCHAR2(50) NOT NULL,          -- 게시판 이름
    CONSTRAINT PK_tbl_boardKindNo PRIMARY KEY(boardKindNo)
);

drop sequence tbl_boardKind_seq;
create sequence tbl_boardKind_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '공지사항');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '학생회게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '전공게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '동아리게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '졸업생게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '학교비판게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '익명게시판', 'tbl_board_anonymous');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '자유게시판(반말)', 'tbl_board_informal');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '자유게시판(존대)', 'tbl_board_polite');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '유머게시판', 'tbl_board_humor');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '정치·사회·이슈', 'tbl_board_issue');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, 'MBTI');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '맛집');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '연애');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '취미');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '헬스');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '다이어트');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '스터디');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '자격증');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '취업');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '구인/구직');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '분실물');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '복덕복덕방');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '중고서점');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '중고거래');

COMMIT;

select * 
from tbl_boardKind;

delete from tbl_boardKind;

select * 
from tbl_commu_member;

select tableName, boardName
from tbl_boardKind
where boardkindno = 2;

-------------------------- 반말 게시판 테이블 생성 ------------------------------
drop table tbl_board_informal purge;
CREATE TABLE tbl_board_informal(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    fileExist         NUMBER(1)         NOT NULL,       -- 첨부파일 유무
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    CONSTRAINT PK_tbl_board_informal PRIMARY KEY(boardNo)
);
drop sequence tbl_board_informal_seq;
create sequence tbl_board_informal_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select *
from tbl_board_informal
order by boardNo desc;

insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 100, 1, '첫번째 게시물입니다.', '이히히 내가 첫번째다.', 0, '120.0.0.1');

insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '두번째 게시물입니다.', '이히히 내가 두번째다.', 0, '120.0.0.1');

insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '세번째 게시물입니다.', '이히히 내가 세번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '네번째 게시물입니다.', '이히히 내가 네번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '5번째 게시물입니다.', '이히히 내가 다섯번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '6번째 게시물입니다.', '이히히 내가 여섯번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '7번째 게시물입니다.', '이히히 내가 일곱번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '8번째 게시물입니다.', '이히히 내가 여덟번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '9번째 게시물입니다.', '이히히 내가 아홉번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '10번째 게시물입니다.', '이히히 내가 열번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '11번째 게시물입니다.', '이히히 내가 열한번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '12번째 게시물입니다.', '이히히 내가열두번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '13번째 게시물입니다.', '이히히 내가 열세번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '14번째 게시물입니다.', '이히히 내가 열네번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '15번째 게시물입니다.', '이히히 내가 열다섯번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '16번째 게시물입니다.', '이히히 내가 열여섯번째다.', 0, '120.0.0.1');
insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, fileExist, writerIp) 
values(tbl_board_informal_seq.nextval, 2, 101, 1, '17번째 게시물입니다.', '이히히 내가 열일곱번째다.', 0, '120.0.0.1');


commit;

-------------------------- 카테고리 테이블 생성 ------------------------------
drop table tbl_category purge;
CREATE TABLE tbl_category(
    categoryNo          NUMBER          NOT NULL,   -- 카테고리 번호
    fk_boardkindno      NUMBER          NOT NULL,   -- 게시판 번호
    categoryName        VARCHAR2(50)    NOT NULL,   -- 카테고리 이름
    CONSTRAINT PK_tbl_category PRIMARY KEY (categoryNo)
);
drop sequence tbl_category_seq;
create sequence tbl_category_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_category values(tbl_category_seq.nextval, 2, '자유');

select categoryNo, fk_boardkindno, categoryName 
from tbl_category
where fk_boardkindno = 2;
------------------------------- 2020-12-09 end -----------------------------------------
------------------------------- 2020-12-10 start ---------------------------------------
select *
from tbl_commu_member;

select *
from tbl_commu_member_level;

select boardNo, V.fk_boardKindNo, fk_memberNo, categoryName,  subject, regDate, editDate
         , content, readCount, status, fileExist, writerIp
from
(
    select boardNo, fk_boardKindNo, fk_memberNo, categoryNo, subject, regDate, editDate
         , content, readCount, status, fileExist, writerIp
    from tbl_board_informal
    order by boardNo desc
)V join tbl_category C 
on V.categoryNo = C.categoryNo;



select boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject, regDate, editDate
         , content, readCount, status, fileExist, writerIp
from tbl_category C join tbl_board_informal V 
on C.categoryNo = V.categoryNo
join tbl_commu_member M 
on V.fk_memberNo = M.fk_memberNo; 

select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname, categoryName, subject, regDate, editDate
         , content, readCount, status, fileExist, writerIp
from 
(
    select row_number() over(order by boardno asc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject
         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
         , content, readCount, status, fileExist, writerIp
    from tbl_category C join tbl_board_informal V 
    on C.categoryNo = V.categoryNo
    join tbl_commu_member M 
    on V.fk_memberNo = M.fk_memberNo
)T
where rno between 1 and 5
order by rno desc;

alter table tbl_board_informal rename column categoryNo to fk_categoryNo;

commit;


-------------------------- 존댓말 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_polite(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    fileExist         NUMBER(1)         NOT NULL,       -- 첨부파일 유무
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    CONSTRAINT PK_tbl_board_polite PRIMARY KEY(boardNo)
);

create sequence tbl_board_polite_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------------- 유머 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_humor(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    fileExist         NUMBER(1)         NOT NULL,       -- 첨부파일 유무
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    CONSTRAINT PK_tbl_board_humor PRIMARY KEY(boardNo)
);

create sequence tbl_board_humor_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 정치·사회·이슈 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_issue(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    fileExist         NUMBER(1)         NOT NULL,       -- 첨부파일 유무
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    CONSTRAINT PK_tbl_board_issue PRIMARY KEY(boardNo)
);

create sequence tbl_board_issue_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select *
from tbl_boardKind;

insert into tbl_category values(tbl_category_seq.nextval, 3, '자유');
insert into tbl_category values(tbl_category_seq.nextval, 4, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 4, '밈');
insert into tbl_category values(tbl_category_seq.nextval, 4, '개그');
insert into tbl_category values(tbl_category_seq.nextval, 5, '정치');
insert into tbl_category values(tbl_category_seq.nextval, 5, '사회');
insert into tbl_category values(tbl_category_seq.nextval, 5, '이슈');
insert into tbl_category values(tbl_category_seq.nextval, 5, '경제');

select categoryNo, fk_boardkindno, categoryName 
from tbl_category;

commit;


select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname, categoryName, subject, regDate, editDate
     , content, readCount, status, fileExist, writerIp
from 
(
    select row_number() over(order by boardno asc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject
         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
         , content, readCount, status, fileExist, writerIp
    from tbl_category C join tbl_board_informal V 
    on C.categoryNo = V.fk_categoryNo
    join tbl_commu_member M 
    on V.fk_memberNo = M.fk_memberNo
    where V.status = 1 and lower(nickname) like '%' || lower('오') || '%'
)T
where rno between 1 and 5
order by rno desc;

select *
from tbl_board_informal;

select *
from tbl_commu_member;
------------------------------- 2020-12-10 end -----------------------------------------
------------------------------- 2020-12-11 start ---------------------------------------
select *
from tbl_category;

insert into tbl_category values(0, 0, '공지사항');

commit;

delete from tbl_boardKind;
delete from tbl_category;
delete from tbl_board_notice;
delete from tbl_board_informal;

select * from tbl_boardKind;
select * from tbl_category;
select * from tbl_board_notice;
select * from tbl_board_informal;

alter table tbl_boardKind drop column tableName;

insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '공지사항');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '학생회게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '전공게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '동아리게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '졸업생게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 1, '학교비판게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '익명게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '자유게시판(반말)');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '자유게시판(존대)');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '유머게시판');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 2, '정치·사회·이슈');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, 'MBTI');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '맛집');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '연애');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '취미');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '헬스');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 3, '다이어트');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '스터디');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '자격증');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '취업');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '구인/구직');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 4, '분실물');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '복덕복덕방');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '중고서점');
insert into tbl_boardKind values(tbl_boardKind_seq.nextval, 5, '중고거래');

commit;

insert into tbl_category values(tbl_category_seq.nextval, 0, '공지사항');

insert into tbl_category values(tbl_category_seq.nextval, 2, '홍보');
insert into tbl_category values(tbl_category_seq.nextval, 2, '문의');
insert into tbl_category values(tbl_category_seq.nextval, 2, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 3, '정경대');
insert into tbl_category values(tbl_category_seq.nextval, 3, '인문대');
insert into tbl_category values(tbl_category_seq.nextval, 3, '공대');
insert into tbl_category values(tbl_category_seq.nextval, 3, '예체능');
insert into tbl_category values(tbl_category_seq.nextval, 4, '홍보');
insert into tbl_category values(tbl_category_seq.nextval, 4, '문의');
insert into tbl_category values(tbl_category_seq.nextval, 4, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 5, '취업');
insert into tbl_category values(tbl_category_seq.nextval, 5, '졸업');
insert into tbl_category values(tbl_category_seq.nextval, 5, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 6, '자유');
insert into tbl_category values(tbl_category_seq.nextval, 6, '신고');
insert into tbl_category values(tbl_category_seq.nextval, 10, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 10, '밈');
insert into tbl_category values(tbl_category_seq.nextval, 10, '개그');
insert into tbl_category values(tbl_category_seq.nextval, 11, '정치');
insert into tbl_category values(tbl_category_seq.nextval, 11, '사회');
insert into tbl_category values(tbl_category_seq.nextval, 11, '이슈');
insert into tbl_category values(tbl_category_seq.nextval, 11, '경제');
insert into tbl_category values(tbl_category_seq.nextval, 13, '정보');
insert into tbl_category values(tbl_category_seq.nextval, 13, '번개');
insert into tbl_category values(tbl_category_seq.nextval, 14, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 14, '질문');
insert into tbl_category values(tbl_category_seq.nextval, 14, '고민');
insert into tbl_category values(tbl_category_seq.nextval, 15, '등산');
insert into tbl_category values(tbl_category_seq.nextval, 15, '게임');
insert into tbl_category values(tbl_category_seq.nextval, 15, '운동');
insert into tbl_category values(tbl_category_seq.nextval, 15, '독서');
insert into tbl_category values(tbl_category_seq.nextval, 16, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 16, '질문');
insert into tbl_category values(tbl_category_seq.nextval, 16, '헬린이');
insert into tbl_category values(tbl_category_seq.nextval, 16, '홈트');
insert into tbl_category values(tbl_category_seq.nextval, 16, '요가');
insert into tbl_category values(tbl_category_seq.nextval, 17, '일반');
insert into tbl_category values(tbl_category_seq.nextval, 17, '질문');
insert into tbl_category values(tbl_category_seq.nextval, 18, '취업');
insert into tbl_category values(tbl_category_seq.nextval, 18, '고시');
insert into tbl_category values(tbl_category_seq.nextval, 18, '공무원');
insert into tbl_category values(tbl_category_seq.nextval, 18, '영어');
insert into tbl_category values(tbl_category_seq.nextval, 19, '토익');
insert into tbl_category values(tbl_category_seq.nextval, 19, '기사');
insert into tbl_category values(tbl_category_seq.nextval, 19, '한국사');
insert into tbl_category values(tbl_category_seq.nextval, 20, '정보');
insert into tbl_category values(tbl_category_seq.nextval, 20, '자유');
insert into tbl_category values(tbl_category_seq.nextval, 21, '구인공고');
insert into tbl_category values(tbl_category_seq.nextval, 21, '인턴십');
insert into tbl_category values(tbl_category_seq.nextval, 22, '습득');
insert into tbl_category values(tbl_category_seq.nextval, 22, '분실');
insert into tbl_category values(tbl_category_seq.nextval, 23, '삽니다');
insert into tbl_category values(tbl_category_seq.nextval, 23, '팝니다');
insert into tbl_category values(tbl_category_seq.nextval, 24, '삽니다');
insert into tbl_category values(tbl_category_seq.nextval, 24, '팝니다');
insert into tbl_category values(tbl_category_seq.nextval, 24, '무료나눔');
insert into tbl_category values(tbl_category_seq.nextval, 25, '삽니다');
insert into tbl_category values(tbl_category_seq.nextval, 25, '팝니다');
insert into tbl_category values(tbl_category_seq.nextval, 25, '무료나눔');


ALTER TABLE tbl_board_polite MODIFY content NVARCHAR2(2000);

commit;
---------------------------------------------------------------
alter table tbl_board_informal drop column fileExist; -- 테이블 컬럼 삭제

alter table tbl_board_issue add fileSize varchar2(50); -- 테이블 컬럼 추가

-------------------------- mbti 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_mbti(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_mbti PRIMARY KEY(boardNo)
);

create sequence tbl_board_mbti_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 맛집 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_food(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_food PRIMARY KEY(boardNo)
);

create sequence tbl_board_food_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 연애 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_love(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_love PRIMARY KEY(boardNo)
);

create sequence tbl_board_love_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 취미 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_hobby(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_hobby PRIMARY KEY(boardNo)
);

create sequence tbl_board_hobby_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 헬스 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_health(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_health PRIMARY KEY(boardNo)
);

create sequence tbl_board_health_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 다이어트 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_diet(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    fk_memberNo       NUMBER            NOT NULL,       -- 작성회원 번호
    fk_categoryNo     NUMBER            NOT NULL,       -- 카테고리 번호
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    fileName          VARCHAR2(50),                     -- 첨부파일 저장명
    orgFilename       VARCHAR2(200),                    -- 첨부파일 원본명
    fileSize          VARCHAR2(50),                     -- 첨부파일 사이즈
    CONSTRAINT PK_tbl_board_diet PRIMARY KEY(boardNo)
);

create sequence tbl_board_diet_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-----------------------------------------------------
select *
from tbl_boardKind;

insert into tbl_board_informal(boardNo, fk_boardKindNo, fk_memberNo, fk_categoryNo, subject, content, writerIp)
values(tbl_board_informal_seq.nextval, ${}, ${}, ${}, #{}, #{}, #{});

alter table tbl_board_informal MODIFY fk_categoryNo null;
alter table tbl_board_polite MODIFY fk_categoryNo null;

commit;

select *
from tbl_board_informal;

select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname, subject, regDate, editDate
		         , content, readCount, status
from 
(
	    select row_number() over(order by boardno asc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, subject
	         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
	         , content, readCount, status
	    from tbl_commu_member M join tbl_board_informal V  
	    on V.fk_memberNo = M.fk_memberNo
	    where V.status = 1
	)T
where rno between 1 and 15
order by rno desc;

select * 
from tbl_commu_member;

select * 
from tbl_commu_member_level;


update tbl_commu_member set point = point + ${}
where fk_memberNo = #{}; 

select fk_memberNo, fk_levelno, point
     , lead(levelno) over(order by levelno) as nextlevelno, lead(levelpoint) over(order by levelpoint) as nextlevelpoint
from tbl_commu_member M join tbl_commu_member_level L
on M.fk_levelno = L.levelno
where fk_memberNo = 101;

select levelno, levelpoint
from
(
    select fk_memberNo, fk_levelno, point
    from tbl_commu_member M
    where fk_memberNo = 101
)V join tbl_commu_member_level L
on V.fk_levelno = (L.levelno-1);


select fk_memberNo, fk_levelNo, point, levelNo as nextLevelNo, levelPoint as nextLevelPoint
from tbl_commu_member M join tbl_commu_member_level L
on M.fk_levelNo = (L.levelNo - 1)
where fk_memberNo = 102;


update tbl_commu_member set fk_levelno = 21, point = 20000
where fk_memberno = 102;

update tbl_commu_member set fk_levelno = 4, point = 3000
where fk_memberno = 101;

commit;

select *
from tbl_board_humor;

select count(*)
from tbl_board_humor V join tbl_commu_member M
on V.fk_memberNo = M.fk_memberNo
where status = 1 
and lower(subject) like '%' || lower('테') || '%'
and fk_categoryNo = 17;


select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname as fk_nickname, categoryName as fk_categoryName, subject, regDate, editDate
		         , content, readCount, status
		from 
		(
		    select row_number() over(order by boardno asc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject
		         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
		         , content, readCount, status
		    from tbl_category C join tbl_board_humor V 
		    on C.categoryNo = V.fk_categoryNo
		    join tbl_commu_member M 
		    on V.fk_memberNo = M.fk_memberNo
		    where V.status = 1
            and lower(subject) like '%' || lower('테') || '%'
	        and fk_categoryNo = 17
		)T
where rno between 1 and 15
order by rno desc;



select boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, subject, V.fk_categoryNo, C.categoryName
     , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
	 , content, readCount, status
from tbl_commu_member M join tbl_board_humor V  
on V.fk_memberNo = M.fk_memberNo
join tbl_category C
on V.fk_categoryNo = C.categoryNo
where V.status = 1 and boardNo = 5;


------------- 게시물 추천 테이블 생성 -------------
drop table tbl_board_bad purge;
CREATE TABLE tbl_board_good(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_board_good PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_memberNo)
);

------------- 게시물 비추천 테이블 생성 -------------
CREATE TABLE tbl_board_bad(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_board_bad PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_memberNo)
);

------------- 게시물 신고 테이블 생성 -------------
CREATE TABLE tbl_board_report(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_report PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_memberNo)
);

update tbl_board_health set readCount = readCount + 1
where boardNo = 2;

select *
from tbl_board_issue;

insert into tbl_board_good values(11, 18, 101);
insert into tbl_board_good values(11, 18, 103);
insert into tbl_board_good values(11, 17, 103);
insert into tbl_board_bad values(11, 18, 104);
insert into tbl_board_bad values(11, 18, 105);
insert into tbl_board_bad values(11, 18, 106);


commit;


select count(*) as upCount
from tbl_board_good
group by fk_boardKindNo, fk_boardNo
having fk_boardKindNo = 11 and fk_boardNo = 20; 

select count(*)
from tbl_board_bad
where fk_boardKindNo = 11 and fk_boardNo = 18 and fk_memberNo = 101;

select *
from tbl_board_humor
order by boardNo desc;

delete from tbl_board_bad
where fk_boardKindNo = 11 and fk_boardNo = 18 and fk_memberNo = 101;

select *
from tbl_board_good;

select *
from tbl_board_bad;

select *
from tbl_board_report;




select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname as fk_nickname, categoryName as fk_categoryName, subject, regDate, editDate
		         , content, readCount, status, upCount
		from 
		(
		    select row_number() over(order by boardno desc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject
		         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
		         , content, readCount, status
                 , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
		    from tbl_category C join tbl_board_humor V 
		    on C.categoryNo = V.fk_categoryNo
		    join tbl_commu_member M 
		    on V.fk_memberNo = M.fk_memberNo
            where V.status = 1
		)T
where rno between 1 and 30
order by rno asc;

select count(*)
from tbl_board_good  
where fk_boardKindNo =  and fk_boardNo = ;


select *
from tbl_board_humor;

select boardNo, V.fk_boardKindNo, V.fk_memberNo, nickname as fk_nickname, subject
		     , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
			 , content, readCount, status
             , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
             , (select count(*) from tbl_board_bad where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as downCount
from tbl_commu_member M join tbl_board_humor V  
on V.fk_memberNo = M.fk_memberNo
where V.status = 1 and boardNo = 3;
------------------------------- 2020-12-14 end ---------------------------------------

select * 
from tbl_commu_member;

select * 
from tbl_commu_member_level;


select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname as fk_nickname, subject, regDate, editDate
		         , content, readCount, status, upCount, levelImg
		from 
		(
		    select row_number() over(order by boardno desc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, subject
		         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
		         , content, readCount, status
		         , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
                 , levelImg
		    from tbl_commu_member M join tbl_board_informal V  
	    	on V.fk_memberNo = M.fk_memberNo
		    join tbl_commu_member_level L
            on M.fk_levelNo = L.levelNo
            where V.status = 1
		)T
where rno between 1 and 35
order by rno asc;




select * 
from tbl_board_bad
where fk_boardKindNo = 9 and fk_boardNo = 11;

select count(*)
from tbl_board_report
where fk_boardKindNo = 9 and fk_boardNo = 11;

update tbl_board_Humor set status = 0
where boardNo = 23;

commit;


select *
from tbl_board_polite
where fk_boardKindNo = 9 and boardNo = 10;

update tbl_board_polite set status = 1
where boardNo = 11;


select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname as fk_nickname, subject, regDate, editDate
		         , content, readCount, status, upCount, levelImg
		from 
		(
		    select row_number() over(order by boardno desc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, subject
		         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
		         , content, readCount, status
		         , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
		         , levelImg
		    from tbl_commu_member M join tbl_board_polite V  
	    	on V.fk_memberNo = M.fk_memberNo
	    	join tbl_commu_member_level L
            on M.fk_levelNo = L.levelNo
		    where V.status = 1
)T
order by rno asc;

delete from tbl_board_report
where fk_boardKindNo = 9 and fk_boardNo = 11 and fk_memberNo = 105;
rollback;
commit;

select *
from tbl_board_report
where fk_boardKindNo = 9 and fk_boardNo = 11 and fk_memberNo = 105;
------------------------------- 2020-12-14 end -------------------------------------
------------------------------- 2020-12-15 start -------------------------------------
select *
from tbl_board_humor;

update tbl_board_humor set editDate = sysdate
where boardNo = 31;

rollback;
------------------------------- 2020-12-15 end -------------------------------------
------------------------------- 2020-12-17 start -------------------------------------
select *
from tbl_notice;

-------------------------- 자유게시판(반말) 댓글 테이블 생성 ------------------------------
drop table tbl_comment_informal purge;
create table tbl_comment_informal(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_informal PRIMARY KEY(commentNo)
);

create sequence tbl_comment_informal_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 자유게시판(존대) 댓글 테이블 생성 ------------------------------
create table tbl_comment_polite(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_polite PRIMARY KEY(commentNo)
);

create sequence tbl_comment_polite_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 유머게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_humor(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_humor PRIMARY KEY(commentNo)
);

create sequence tbl_comment_humor_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 정치,사회,이슈게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_issue(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_issue PRIMARY KEY(commentNo)
);

create sequence tbl_comment_issue_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- mbti게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_mbti(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_mbti PRIMARY KEY(commentNo)
);

create sequence tbl_comment_mbti_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 맛집게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_food(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_food PRIMARY KEY(commentNo)
);

create sequence tbl_comment_food_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 연애게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_love(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_love PRIMARY KEY(commentNo)
);

create sequence tbl_comment_love_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 취미게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_hobby(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_hobby PRIMARY KEY(commentNo)
);

create sequence tbl_comment_hobby_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 헬스 댓글 테이블 생성 ------------------------------
create table tbl_comment_health(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent     VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_health PRIMARY KEY(commentNo)
);

create sequence tbl_comment_health_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 다이어트 댓글 테이블 생성 ------------------------------
create table tbl_comment_diet(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_diet PRIMARY KEY(commentNo)
);

create sequence tbl_comment_diet_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE TBL_COMMENT_INFORMAL RENAME COLUMN content TO cmtContent;

select *
from tbl_comment_humor;


select rno, commentNo, fk_boardNo, fk_memberNo, fk_nickname
     , levelImg, cmtContent, regDate
     , (select count(*) from tbl_comment_humor where status = 1 and fk_boardNo = 39) AS totalCount
from 
(
    select row_number() over(order by commentNo desc) AS rno, V.commentNo, V.fk_boardNo
         , V.fk_memberNo, M.nickname AS fk_nickname, L.levelImg, cmtContent
         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate
        
	from tbl_commu_member M join tbl_comment_humor V  
	on V.fk_memberNo = M.fk_memberNo
	join tbl_commu_member_level L
    on M.fk_levelNo = L.levelNo
	where V.status = 1 and fk_boardNo = 39
)T
order by rno asc;


select boardNo, V.fk_boardKindNo, V.fk_memberNo, nickname as fk_nickname, subject
		     , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
			 , content, readCount, status, fileName, orgFilename, fileSize
			 , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
             , (select count(*) from tbl_board_bad where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as downCount
             , levelImg
        from tbl_commu_member M join tbl_board_informal V  
		on V.fk_memberNo = M.fk_memberNo
        join tbl_commu_member_level L
        on M.fk_levelNo = L.levelNo
		where V.status = 1 and boardNo = 13;

select *
from tbl_board_good
where fk_boardKindNo = 10 and fk_boardNo = 39;


------------- 댓글 추천 테이블 생성 -------------
drop table tbl_comment_bad purge;
CREATE TABLE tbl_comment_good(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_commentNo     NUMBER     NOT NULL,       -- 댓글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_comment_good PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_commentNo, fk_memberNo)
);

------------- 댓글 비추천 테이블 생성 -------------
CREATE TABLE tbl_comment_bad(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_commentNo     NUMBER     NOT NULL,       -- 댓글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_comment_bad PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_commentNo, fk_memberNo)
);

------------- 댓글 신고 테이블 생성 -------------
CREATE TABLE tbl_comment_report(
    fk_boardKindNo   NUMBER     NOT NULL,       -- 게시판 종류 번호
    fk_boardNo       NUMBER     NOT NULL,       -- 게시글 번호
    fk_commentNo     NUMBER     NOT NULL,       -- 댓글 번호
    fk_memberNo      NUMBER     NOT NULL,       -- 회원 번호
    CONSTRAINT PK_tbl_comment_report PRIMARY KEY(fk_boardKindNo, fk_boardNo, fk_commentNo, fk_memberNo)
);


select *
from tbl_comment_humor;


		select rno, commentNo, fk_boardNo, fk_memberNo, fk_nickname
		     , levelImg, cmtContent, regDate
		     , (select count(*) from tbl_comment_humor where status = 1 and fk_boardNo = 39) AS totalCount
		     , (select count(*) from tbl_comment_good where fk_boardKindNo = 10 and fk_boardNo = 39 and fk_commentNo = commentNo) as cmtUpCount
             , (select count(*) from tbl_comment_bad where fk_boardKindNo = 10 and fk_boardNo = 39 and fk_commentNo = commentNo) as cmtDownCount
		from 
		(
		    select row_number() over(order by commentNo desc) AS rno, V.commentNo, V.fk_boardNo
		         , V.fk_memberNo, M.nickname AS fk_nickname, L.levelImg, cmtContent
		         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate
			from tbl_commu_member M join tbl_comment_humor V  
			on V.fk_memberNo = M.fk_memberNo
			join tbl_commu_member_level L
		    on M.fk_levelNo = L.levelNo
			where V.status = 1 and fk_boardNo = 39
		)T
where rno between 1 and 22
order by rno asc;

select *
from tbl_comment_humor;

select *
from tbl_comment_report;

insert into tbl_comment_report
values(10, 39, 24, 110);

commit;

ALTER TABLE tbl_comment_diet MODIFY(cmtContent NVARCHAR2(200));

select rno, boardNo, fk_boardKindNo, fk_memberNo, nickname as fk_nickname, categoryName as fk_categoryName, subject, regDate, editDate
		         , content, readCount, status, upCount, levelImg, cmtCount
from 
(
    select row_number() over(order by boardno desc)  as rno, boardNo, V.fk_boardKindNo, V.fk_memberNo, M.nickname, C.categoryName, subject
         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
         , content, readCount, status
         , (select count(*) from tbl_board_good where fk_boardKindNo = V.fk_boardKindNo and fk_boardNo = boardNo) as upCount
         , levelImg
         , (select count(*) from tbl_comment_humor where fk_boardNo = V.boardNo) as cmtCount
    from tbl_category C join tbl_board_humor V 
    on C.categoryNo = V.fk_categoryNo
    join tbl_commu_member M 
    on V.fk_memberNo = M.fk_memberNo
    join tbl_commu_member_level L
    on M.fk_levelNo = L.levelNo
    where V.status = 1
)T
where rno between 1 and 15
order by rno asc;

select * 
from tbl_comment_humor
where fk_boardNo = 39 and status = 1;

select *
from tbl_commu_member;

select * 
from tbl_member;

update tbl_member set pwd = 'qwer1234$';

commit;



-------------------------- 다이어트 댓글 테이블 생성 ------------------------------
create table tbl_comment_diet(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_diet PRIMARY KEY(commentNo)
);

create sequence tbl_comment_diet_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_comment_humor;

create table tbl_board_anonymous(
    
);
------------------------------- 2020-12-17 end -------------------------------------
------------------------------- 2020-12-24 start -----------------------------------
-------------------- 익명 닉네임1 게시판 ---------------------------
create table tbl_anonymous_firstnick(
    seqNo        number         not null,       -- 닉네임 번호
    firstNick    varchar2(20)   not null,       -- 닉네임
    constraint PK_tbl_anonymous_firstnick primary key(seqNo)
);

create sequence tbl_anonymous_firstnick_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------- 익명 닉네임2 게시판 ---------------------------
create table tbl_anonymous_secondnick(
    seqNo        number         not null,       -- 닉네임 번호
    secondNick    varchar2(20)   not null,      -- 닉네임
    constraint PK_tbl_anonymous_secondnick primary key(seqNo)
);

create sequence tbl_anonymous_secondnick_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 닉네임 테이블 데이터 삽입 ----------------------------
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '광적인 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '귀여운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '깜찍한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '소중한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '아름다운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '졸린 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '화난 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '분노한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '행복한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '신난 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '신기한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '망측한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '해괴한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '차가운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '냉소적인 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '친근한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '똘똘한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '멍청한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '소심한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '시끄러운 ');

insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '피카츄');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '내루미');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '또가스');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '고라파덕 ');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '이브이');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '꼬부기');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '단데기');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '리자드');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '뿔충이');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '버터플');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '꼬렛');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '모래두지');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '삐삐');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '푸린');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '뚜벅초');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '닥트리오');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '수륙챙이');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '알통몬');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '롱스톤');
insert into tbl_anonymous_secondnick values(tbl_anonymous_secondnick_seq.nextval, '탕구리');

commit;
select *
from tbl_anonymous_firstnick;

select *
from tbl_anonymous_secondnick;

delete from tbl_anonymous_secondnick;
drop sequence tbl_anonymous_secondnick_seq;


select (firstNick + secondNick)
from
(
select firstNick
from tbl_anonymous_firstnick
where seqno = 1
)V join 
(
select secondNick
from tbl_anonymous_secondnick
where seqno = 20
)T;

-------------------------- 익명 게시판 테이블 생성 ------------------------------
CREATE TABLE tbl_board_anonymous(
    boardNo           NUMBER            NOT NULL,       -- 게시글 번호
    fk_boardKindNo    NUMBER            NOT NULL,       -- 게시판 번호
    nickname          VARCHAR2(50)      NOT NULL,       -- 작성자 닉네임
    subject           VARCHAR2(200)     NOT NULL,       -- 글제목
    password          VARCHAR2(200)     NOT NULL,       -- 글비밀번호
    regDate           DATE              DEFAULT SYSDATE,-- 등록일자
    editDate          DATE,                             -- 수정일자
    content           NVARCHAR2(2000)   NOT NULL,       -- 글내용
    readCount         NUMBER            DEFAULT 0,      -- 조회수
    status            NUMBER(1)         DEFAULT 1,      -- 게시글 상태
    writerIp          VARCHAR2(50)      NOT NULL,       -- 작성자 ip
    upCount           NUMBER            DEFAULT 0,      -- 추천수
    downCount         NUMBER            DEFAULT 0,      -- 비추천수
    reportCount       NUMBER            DEFAULT 0,      -- 신고수
    CONSTRAINT PK_tbl_board_anonymous PRIMARY KEY(boardNo)
);

create sequence tbl_board_anonymous_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_board_anonymous MODIFY password VARCHAR2(200);

select * from TBL_MEMBER;

desc TBL_MEMBER;

select rno, boardNo, fk_boardKindNo, fk_nickname, subject, regDate, editDate
         , content, readCount, status
from 
(
    select row_number() over(order by boardno desc)  as rno, boardNo, fk_boardKindNo, fk_nickname, subject
         , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
         , content, readCount, status
    from tbl_board_anonymous
	where status = 1
)T
where rno between 1 and 15
order by rno asc;

alter table tbl_comment_anonymous rename column downCount to cmtDownCount;

select *
from tbl_board_anonymous;

-------------------------- 익명게시판 댓글 테이블 생성 ------------------------------
create table tbl_comment_anonymous(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    nickname       VARCHAR2(50)   NOT NULL,         -- 작성자 닉네임  
    password       VARCHAR2(200)  NOT NULL,         -- 글비밀번호
    cmtContent     VARCHAR2(200)  NOT NULL,         -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    cmtUpCount        NUMBER         DEFAULT 0,     -- 추천수
    cmtDownCount      NUMBER         DEFAULT 0,     -- 비추천수
    reportCount    NUMBER         DEFAULT 0,        -- 신고수
    CONSTRAINT PK_tbl_comment_anonymous PRIMARY KEY(commentNo)
);

create sequence tbl_comment_anonymous_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


ALTER TABLE tbl_comment_anonymous ADD reportCount NUMBER DEFAULT 0;

desc tbl_comment_anonymous;

------------------------------- 2020-12-27 end ---------------------------------------
------------------------------- 2020-12-28 start -------------------------------------
select * from tbl_comment_anonymous;

select upCount, downCount, reportCount
		from tbl_board_anonymous
		where boardNo = 8;

update tbl_anonymous_firstnick set firstNick = '광적인' where seqNo = 1;
update tbl_anonymous_firstnick set firstNick = '귀여운' where seqNo = 2;
update tbl_anonymous_firstnick set firstNick = '소중한' where seqNo = 3;
update tbl_anonymous_firstnick set firstNick = '아름다운' where seqNo = 4;
update tbl_anonymous_firstnick set firstNick = '졸린' where seqNo = 5;
update tbl_anonymous_firstnick set firstNick = '화난' where seqNo = 6;
update tbl_anonymous_firstnick set firstNick = '분노한' where seqNo = 7;
update tbl_anonymous_firstnick set firstNick = '행복한' where seqNo = 8;
update tbl_anonymous_firstnick set firstNick = '신난' where seqNo = 9;
update tbl_anonymous_firstnick set firstNick = '신기한' where seqNo = 10;
update tbl_anonymous_firstnick set firstNick = '망측한' where seqNo = 11;
update tbl_anonymous_firstnick set firstNick = '해괴한' where seqNo = 12;
update tbl_anonymous_firstnick set firstNick = '차가운' where seqNo = 13;
update tbl_anonymous_firstnick set firstNick = '냉소적인' where seqNo = 14;
update tbl_anonymous_firstnick set firstNick = '친근한' where seqNo = 15;
update tbl_anonymous_firstnick set firstNick = '똘똘한' where seqNo = 16;
update tbl_anonymous_firstnick set firstNick = '멍청한' where seqNo = 17;
update tbl_anonymous_firstnick set firstNick = '소심한' where seqNo = 18;
update tbl_anonymous_firstnick set firstNick = '깜찍한' where seqNo = 19;
update tbl_anonymous_firstnick set firstNick = '시끄러운' where seqNo = 20;

commit;
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '귀여운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '깜찍한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '소중한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '아름다운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '졸린 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '화난 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '분노한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '행복한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '신난 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '신기한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '망측한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '해괴한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '차가운 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '냉소적인 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '친근한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '똘똘한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '멍청한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '소심한 ');
insert into tbl_anonymous_firstnick values(tbl_anonymous_firstnick_seq.nextval, '시끄러운 ');

select *
from tbl_comment_anonymous;


select rno, boardNo, fk_boardKindNo, nickname as fk_nickname, subject, regDate, editDate
     , content, readCount, status, upCount, cmtCount, writerIp
from 
(
    select row_number() over(order by boardno desc)  as rno, boardNo, fk_boardKindNo, nickname, subject
         , case when to_char(sysdate , 'yyyymmdd') - to_char(regDate , 'yyyymmdd') >= 1 then to_char(regDate, 'yyyy-mm-dd')
                when to_char(sysdate, 'hh24') - to_char(regDate, 'hh24') >= 1 then to_char(to_char(sysdate, 'hh24') - to_char(regDate, 'hh24'))||'시간 전'
                else to_char(to_char(sysdate, 'mi') - to_char(regDate, 'mi'))||'분 전' end as regDate
         , to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
         , content, readCount, status, upCount, writerIp
         , (select count(*) from tbl_comment_anonymous where fk_boardNo = boardNo and status = 1) as cmtCount
    from tbl_board_anonymous
    where status = 1
)T
order by rno asc;

select boardNo, regDate, (sysdate - regDate), to_char(sysdate , 'yyyymmdd') - to_char(regDate , 'yyyymmdd')
from tbl_board_anonymous;
------------------------------- 2020-12-28 end -------------------------------------


