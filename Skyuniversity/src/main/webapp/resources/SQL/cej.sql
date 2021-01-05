show user;
select * from tab;

------------------------------------------------------
-- 학적 테이블 생성
create table tbl_school_reg
(
regSeq      number       not null     
,status     varchar2(20) not null
,constraint PK_tbl_schoolreg_regSeq  primary key(regSeq)
)
insert into tbl_school_reg(regSeq, status)
values(tbl_school_reg_seq.nextval, '재학');
insert into tbl_school_reg(regSeq, status)
values(tbl_school_reg_seq.nextval, '휴학');
insert into tbl_school_reg(regSeq, status)
values(tbl_school_reg_seq.nextval, '졸업');
insert into tbl_school_reg(regSeq, status)
values(tbl_school_reg_seq.nextval, '졸업연기');
commit
-- 학적 시퀀스 생성
create sequence tbl_school_reg_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_member
------------------------------------------------------

------------------------------------------------------
-- 학과 테이블 생성
create table tbl_dept
(
deptSeq     number not null
,deptName   varchar2(20) not null
,constraint PK_tbl_dept_deptSeq primary key(deptSeq)
)
-- 학과 시퀀스 생성
create sequence tbl_dept_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 학과 테이블 데이터 insert
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '경영학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '컴퓨터공학부');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '국어국문학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '영어영문학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '심리아동학부');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '경제학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '수리금융학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '응용통계학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '정보통신학부');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '특수체육학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '사회복지학과');
insert into tbl_dept(deptSeq, deptName)
values(tbl_dept_seq.nextval, '교양');

select *
from tbl_dept;

commit
------------------------------------------------------

------------------------------------------------------
-- 학생 테이블 생성
create table tbl_member
(memberNo            number                 not null   -- 학번
,pwd                 VARCHAR2(200)          not null   -- 비밀번호
,name                varchar2(20)           not null   -- 성명
,mobile              VARCHAR2(200)          not null   -- 연락처
,email               varchar2(200)          not null   -- 이메일
,birth               varchar2(20)                      -- 생년월일
,jubun               varchar2(200)          not null   -- 주민번호
,engName             varchar2(30)                      -- 영문성명
,chinaName           varchar2(30)                      -- 한자성명
,img                 VARCHAR2(200)                     -- 사진
,grade               number(5)                         -- 학년
,totalSemester       number(5)                         -- 현재이수학기
,enterDay            DATE default sysdate              -- 입학날짜
,graduateDay         DATE                              -- 졸업날짜
,postcode            varchar2(5)                       -- 우편번호
,address             varchar2(200)                     -- 주소
,detailaddress       VARCHAR2(50)                      -- 상세주소
,extraaddress        VARCHAR2(50)                      -- 참고주소
,absenceCnt          number(2) default 0               -- 휴학횟수
,graduateok          number(2) default 0               -- 졸업가능여부
,fk_regSeq           number              not null      -- 학적번호
,fk_deptSeq          number              not null      -- 학과번호
,constraint PK_tbl_member_memberNo primary key(memberNo)
,constraint FK_tbl_member_regSeq foreign key(fk_regSeq)
                                 references tbl_school_reg(regSeq)
,constraint FK_tbl_membert_deptSeq foreign key(fk_deptSeq) 
                                   references tbl_dept(deptSeq) 
);

desc tbl_member

-- 학생 테이블 시퀀스 생성
create sequence tbl_member_seq
start with 100
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 학생 테이블 데이터 insert
insert into tbl_member(memberNo, pwd, name, mobile, email, birth, jubun, fk_regSeq, fk_deptSeq)
values(tbl_member_seq.nextval, 'qwer1234$', '홍길동', '010-1234-5678', 'hongkd@naver.com', '1997-01-27', '970127112 5678', '1', '1');
insert into tbl_member(memberNo, pwd, name, mobile, email, birth, jubun, fk_regSeq, fk_deptSeq)
values(tbl_member_seq.nextval, 'qwer1234$', '이순신', '010-9898-0101', 'leess@naver.com', '1995-03-11', '9503111324148', '1', '2');
insert into tbl_member(memberNo, pwd, name, mobile, email, birth, jubun, fk_regSeq, fk_deptSeq)
values(tbl_member_seq.nextval, 'qwer1234$', '안세형', '010-1122-9988', 'anpopo@naver.com', '1990-09-24', '9009241152119', '1', '11');
insert into tbl_member(memberNo, pwd, name, mobile, email, birth, jubun, fk_regSeq, fk_deptSeq)
values(tbl_member_seq.nextval, 'qwer1234$', '최은지', '010-2246-6435', 'ejejc@naver.com', '1997-01-24', '9701241455161', '1', '2');
insert into tbl_member(memberNo, pwd, name, mobile, email, birth, jubun, fk_regSeq, fk_deptSeq)
values(tbl_member_seq.nextval, 'qwer1234$', '권오윤', '010-2156-6331', 'ky@naver.com', '1998-04-14', '9804141445351', '1', '2');
-- 학생 테이블 전체 select
select *
from tbl_member

update tbl_member set grade = 1 where memberno='101'
update tbl_member set CURRENTSEMESTER = 1 where memberno='101'
commit

ALTER TABLE TBL_MEMBER DROP COLUMN totalsemester;
ALTER TABLE TBL_MEMBER ADD CURRENTSEMESTER NUMBER(2);

select currentSemester, name, memberNo, deptName
from tbl_member M
inner join tbl_dept D
on M.fk_deptseq = D.deptseq
where memberno = '101'
------------------------------------------------------

------------------------------------------------------ 
-- 증명서 테이블 생성
create table tbl_certificate
(seq                number           not null
,kind               varchar2(20)
,grantstatus        number           default 0 
,grantdate          date             default sysdate
,returnreason       varchar2(200)
,fk_memberno        number
,constraint PK_tbl_certificate_seq primary key(seq)
,constraint FK_tbl_certificate_memberno foreign key(fk_memberno) 
                                   references tbl_member(memberno)
);

-- 증명서 테이블 시퀀스 생성
create sequence tbl_certificate_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
------------------------------------------------------ 

------------------------------------------------------ 
-- 수강 테이블 생성
create table tbl_course
(
courseno        number          not null
,semester       number(10)      not null
,courseyear     varchar2(10)    not null    
,score          varchar2(10)
,recourse       number(5)       default 0
,fk_memberno    number          not null
,fk_subjectNo   varchar2(20)    not null
,constraint PK_tbl_course_courseno primary key(courseno)
,constraint FK_tbl_course_memberno foreign key(fk_memberno) 
                                   references tbl_member(memberno)
,constraint FK_tbl_course_subjectNo foreign key(fk_subjectNo) 
                                   references tbl_subject(subjectNo)                                   
);

-- 수강 테이블 시퀀스 생성
create sequence tbl_course_seq
start with 10
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_course

insert into tbl_course(courseno,semester,courseyear, fk_memberno, fk_subjectNo)
values(tbl_course_seq.nextval, '1', '2021', '105','NE104')
insert into tbl_course(courseno,semester,courseyear, fk_memberno, fk_subjectNo)
values(tbl_course_seq.nextval, '1', '2021', '106','NE104')
insert into tbl_course(courseno,semester,courseyear, fk_memberno, fk_subjectNo)
values(tbl_course_seq.nextval, '1', '2021', '106','NE104')
insert into tbl_course(courseno,semester,courseyear, fk_memberno, fk_subjectNo)
values(tbl_course_seq.nextval, '1', '2021', '101','EB103')

ALTER TABLE tbl_course ADD CONSTRAINT UQ_tbl_course UNIQUE(semester, courseyear, fk_memberno,fk_subjectNo );

select *
from tbl_subject
------------------------------------------------------ 

------------------------------------------------------ 
-- 건물 테이블 생성
create table tbl_building
(
buildno      number          
,buildname   varchar2(20)    not null
,constraint PK_tbl_tbl_building_buildno primary key(buildno)
);
-- 건물 테이블 시퀀스 생성
create sequence tbl_building_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_building(buildno, buildname)
values(tbl_building_seq.nextval, '60주년기념관');
insert into tbl_building(buildno, buildname)
values(tbl_building_seq.nextval, '만우관');
insert into tbl_building(buildno, buildname)
values(tbl_building_seq.nextval, '송암관');
insert into tbl_building(buildno, buildname)
values(tbl_building_seq.nextval, '장공관');
insert into tbl_building(buildno, buildname)
values(tbl_building_seq.nextval, '경삼관');
commit

select *
from tbl_building
------------------------------------------------------ 

------------------------------------------------------ 
-- 강의실 테이블 생성
create table tbl_classroom
(
classno         number not null
,fk_buildno     number not null
,constraint PK_tbl_tbl_classroom_classno primary key(classno)
,constraint FK_tbl_classroom_buildno foreign key(fk_buildno) 
                                   references tbl_building(buildno)
);

insert into tbl_classroom(classno, fk_buildno)
values('18101', '1')
insert into tbl_classroom(classno, fk_buildno)
values('18102', '1')
insert into tbl_classroom(classno, fk_buildno)
values('18103', '1')
insert into tbl_classroom(classno, fk_buildno)
values('18104', '1')
insert into tbl_classroom(classno, fk_buildno)
values('18105', '1')
insert into tbl_classroom(classno, fk_buildno)
values('18501', '1');
insert into tbl_classroom(classno, fk_buildno)
values('18502', '1');
insert into tbl_classroom(classno, fk_buildno)
values('18503', '1');
insert into tbl_classroom(classno, fk_buildno)
values('18504', '1');
insert into tbl_classroom(classno, fk_buildno)
values('18505', '1');
insert into tbl_classroom(classno, fk_buildno)
values('7101', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7102', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7103', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7104', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7105', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7201', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7202', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7203', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7204', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7205', '2')
insert into tbl_classroom(classno, fk_buildno)
values('7301', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7302', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7303', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7304', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7305', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7401', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7402', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7403', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7404', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7405', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7501', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7502', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7503', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7504', '2');
insert into tbl_classroom(classno, fk_buildno)
values('7505', '2');

insert into tbl_classroom(classno, fk_buildno)
values('4101', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4102', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4103', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4104', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4105', '3');

insert into tbl_classroom(classno, fk_buildno)
values('4201', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4202', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4203', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4204', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4205', '3');

insert into tbl_classroom(classno, fk_buildno)
values('4301', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4302', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4303', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4304', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4305', '3');

insert into tbl_classroom(classno, fk_buildno)
values('4401', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4402', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4403', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4404', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4405', '3');

insert into tbl_classroom(classno, fk_buildno)
values('4501', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4502', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4503', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4504', '3');
insert into tbl_classroom(classno, fk_buildno)
values('4505', '3');

insert into tbl_classroom(classno, fk_buildno)
values('1101', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1102', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1103', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1104', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1105', '4');

insert into tbl_classroom(classno, fk_buildno)
values('1201', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1202', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1203', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1204', '4');
insert into tbl_classroom(classno, fk_buildno)
values('1205', '4');

insert into tbl_classroom(classno, fk_buildno)
values('8501', '5');
insert into tbl_classroom(classno, fk_buildno)
values('8502', '5');
insert into tbl_classroom(classno, fk_buildno)
values('8503', '5');
insert into tbl_classroom(classno, fk_buildno)
values('8504', '5');
insert into tbl_classroom(classno, fk_buildno)
values('8505', '5');
commit
------------------------------------------------------

------------------------------------------------------
-- 교수 테이블 생성
create table tbl_professor
(
professorno      number         -- 교수번호
,phonenum        varchar2(20)   -- 전화번호
,name            varchar2(20)   -- 이름
,roomno          number(5)      -- 교수실번호
,email           varchar2(20)   -- 이메일
,constraint PK_tbl_professor_professorno primary key(professorno)
)

-- 교수 테이블 시퀀스 생성
create sequence tbl_professor_seq
start with 10
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0123', '윤효석', '18310', 'yhs@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0632', '이성구', '18413', 'ksg@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0574', '염건', '8414', 'fish@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0575', '오창호', '8415', 'compino@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0576', '이건범', '8413', 'kblee@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0639', '강영경', '18415', 'ykang@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0635', '김성기', '18404', 'skkim@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0611', '김대수', '18410', 'daesu@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0341', '나근식', '18411', 'nsg@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0632', '박성진', '18409', 'sj@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0644', '류승택', '18407', 'stryoo@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0636', '장재건', '18405', 'jchang@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0403', '김동식', '8203', 'nolme@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0405', '한재영', '8204', 'hanjjyy@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0404', '유문선', '8228', 'msyouu@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0417', '박미선', '8216', 'mspark@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0416', '서강목', '8307', 'jjyoung@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0419', '이향미', '8212', 'hyangmilee@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0392', '강순원', '8329', 'kangsw@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0671', '오현숙', '8224', 'hyunsookoh@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0673', '박은희', '3420', 'psypeh@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0502', '강남훈', '8409', 'nkang@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0506', '성낙선', '8331', 'nssung@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0504', '정건화', '8408', 'gunna@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0604', '박기현', '7204', 'ghpark@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0606', '윤성식', '7310', 'ssyun@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0605', '양춘우', '7314', 'chyang@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0615', '박동련', '7205', 'drpark@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0614', '이승천', '7206', 'seung@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0616', '변종석', '7208', 'jsbyun@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0654', '김현경', '18514', 'hkim@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0659', '손승일', '18504', 'saisonh@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0657', '이경옥', '18512', 'golee@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0625', '민경훈', '8829', 'minkh@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0626', '조규청', '8222', 'kcc@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0624', '서연태', '8202', 'syt@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0518', '김예랑', '8312', 'yrkim@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0516', '주경희', '8315', 'macoj2@hs.ac.kr')
insert into tbl_professor(professorno, phonenum, name, roomno, email) 
values(tbl_professor_seq.nextval, '031-379-0517', '장익현', '8314', 'skking@hs.ac.kr')
commit

select *
from tbl_subject
------------------------------------------------------

------------------------------------------------------
-- 과목 테이블 생성
commit
ALTER TABLE TBL_subject ADD subssemester number(5) default 1;
ALTER TABLE TBL_SUBJECT DROP COLUMN semester;
create table tbl_subject
(
subjectNo           varchar2(20)    not null    -- 과목코드
,subjectName        varchar2(20)    not null    -- 과목명
,credits            number(2)       not null    -- 학점
,grade              number(5)       not null    -- 이수학년
,mustStatus         number(2)       default 1 not null  -- 필수여부
,day                varchar2(20)    not null    -- 요일
,period             varchar2(40)    not null    -- 교시
,peopleCnt          number(5)                   -- 수강인원
,fk_classNo         number          not null    -- 강의실번호
,fk_professorNo     number          not null    -- 교수번호
,fk_deptSeq         number          not null    -- 학과코드
,constraint PK_tbl_subject_subjectNo primary key(subjectNo)
,constraint FK_tbl_subject_classNo foreign key(fk_classNo) 
                                   references tbl_classroom(classno)
,constraint FK_tbl_subject_professorNo foreign key(fk_professorNo) 
                                   references tbl_professor(professorno)
,constraint FK_tbl_subject_deptSeq foreign key(fk_deptSeq) 
                                   references tbl_dept(deptSeq) 
);
select *
from tbl_course
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE104', '컴퓨터개론', '3', '1', '월,수', '01,02,03,04','30','18101','14', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE113', '프로그래밍입문', '3', '1', '월,수', '01,02,03,04','35','18102','13', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE106', '수리과학기초', '3', '1', '화,목', '05,06,07,08','32','18205','13', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE114', '미적분학', '3', '1', '화,목', '01,02,03,04','40','18105','42', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE115', '확률과통계', '3', '1', '화,목', '01,02,03,04','40','18203','14', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE201', '윈도우프로그래밍', '3', '2', '월', '03,04','40','18301','47', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE202', '고급프로그래밍', '3', '2', '화,수', '08,09','40','18302','47', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE203', '자료구조', '3', '2', '목', '07,08,09,10','35','18302','47', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE220', '논리회로설계', '3', '2', '월,수', '11,12,13,14','40','18303','48', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE224', '창의공학설계', '3', '2', '금', '01,02,03,04','40','18402','48', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE223', '모바일웹프로그래밍', '3', '2', '화,목', '01,02','40','18202','45', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE302', '알고리즘', '3', '3', '월,수', '01,02','40','18202','45', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE306', '인터넷프로토콜', '3', '3', '월', '03,04','38','18402','13', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE308', '오토마타', '3', '3', '수', '03,04','40','18205','42', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE317', '소프트웨어공학', '3', '3', '월,수', '01,02,03,04','40','18305','46', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE320', '정보보호론', '3', '3', '월,수', '07,08','40','18501','14', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE325', '데이터베이스프로그래밍', '3', '3', '월,수', '09,10','40','18502','45', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE329', '리눅스프로그래밍', '3', '3', '월', '11,12','40','18503','48', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE334', '빅데이터 시스템', '3', '3', '수', '11,12','40','18502','47', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE335', '네트워크보안프로젝트', '3', '3', '화,목', '01,02','35','18102','13', '2')

insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE403', '게임프로그래밍', '3', '4', '화,목', '03,04','40','18302','47', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE406', '소프트웨어특론', '3', '4', '화', '01,02','38','18303','46', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE410', '패턴인식', '3', '4', '목', '01,02','35','18301','46', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE447', '캡스톤디자인1', '3', '4', '화', '07,08,09,10','30','18205','43', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('NE448', '캡스톤디자인2', '3', '4', '목', '07,08','30','18305','44', '2');

insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE101', 'C프로그래밍', '3', '1', '월,수', '07,08','35','18101','42', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE103', '멀티미디어시스템', '3', '1', '수', '09,10','35','18102','43', '2', '2')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE116', '선형대수', '3', '1', '월', '09,10','40','18103','44', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE117', '이산수학', '3', '1', '월,수', '01,02','40','18104','45', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE118', '웹프로그래밍기초', '3', '1', '월,수', '03,04','40','18105','46', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE119', 'C로배우는프로그래밍', '3', '1', '월,수', '01,02,03,04','40','18201','47', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE208', '운영체제', '3', '2', '월,수', '11,12,13,14','40','18202','48', '2', '2');

insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE209', '컴퓨터구조', '3', '2', '월,금', '07,08','40','18203','13', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE210', '데이터베이스', '3', '2', '금', '01,02','45','18204','14', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE221', '네트워크및데이터통신', '3', '2', '화,목', '01,02','40','18205','42', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE255', '보안프로그래밍', '3', '2', '화,목', '03,04','40','18301','43', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE309', '인공지능', '3', '2', '화', '07,08','40','18302','44', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE314', '네트워크프로그래밍', '3', '2', '목', '07,08','40','18303','45', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE322', '컴퓨터그래픽스', '3', '3', '화,목', '01,02,03,04','40','18304','46', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE324', 'DBMS활용및실습', '3', '3', '금', '01,02,03,04','40','18305','47', '2', '2');

insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE327', '공학통계학', '3', '3', '화,금', '03,04','40','18401','48', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE331', '안드로이드프로그래밍', '3', '3', '월,금', '07,08,09,10','40','18402','13', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE332', 'IOT프로그래밍', '3', '3', '화,목', '11,12','40','18403','14', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE333', '빅데이터분석', '3', '3', '화,목', '13,14','40','18404','42', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE336', 'R프로젝트', '3', '3', '월,화', '01,02','40','18405','43', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE337', '가상현실과증강현실', '3', '3', '화,수', '07,08,09,10','45','18501','44', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE402', '시스템분석설계', '3', '4', '월,수', '01,02','40','18502','45', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE405', '디지털영상처리', '3', '4', '월,수', '03,04','40','18503','45', '2', '2');
update tbl_subject set subssemester ='2' where subjectno='NE421';
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester,mustStatus)
values('NE419', '졸업논문', '3', '4', '목', '11,12,13,14','30','18504','46', '2', '2','0');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE426', '컴퓨터애니메이션', '3', '4', '화,금', '03,04','40','18505','47', '2', '2');
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq, semester)
values('NE421', '디지털포렌식', '3', '4', '금', '01,02,03,04','40','18101','48', '2', '2');
commit;
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('EB103', '경영수학', '3', '1', '화,목', '01,02,03,04','35','18202','11', '1');
select *
from tbl_subject
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AA101', '결혼과가족', '3', '1', '금', '01,02','50','18204','41', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AA102', '독서와토론', '2', '1', '금', '07,08,09,10','25','18201','40', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AA103', '영화와종교문화', '2', '1', '월', '01,02','45','8101','41', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AA104', '민주시민교육', '2', '1', '월', '03,04','30','8102','10', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AA105', '미국경제론', '3', '1', '화', '11,12,13,14','35','8103','12', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AB201', '글쓰기의기초', '2', '1', '금', '01,02,03,14','15','7101','18', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AB202', '영어1', '3', '1', '수', '01,02','30','7102','19', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AB203', '다큐멘터리만들기', '2', '1', '화', '09,10','20','7103','20', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AB204', '수재수학', '2', '1', '화,목', '13,14','60','7104','21', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AB205', '생활법률', '3', '1', '금', '13,14','60','7105','22', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AC301', '연기와마음치료', '2', '1', '수', '07,08','15','4101','23', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AC302', '한국미술과문화', '3', '1', '월,수', '03,04','60','4102','24', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AC303', '오르간연주법', '3', '1', '금', '07,08,09,10','20','4103','25', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AC304', '건강과다이어트', '3', '1', '목', '11,12,13,14','30','4104','26', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AC305', '수원의역사와문화', '3', '1', '화,목', '01,02','60','4201','27', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AD401', '아시아공동체론', '2', '1', '수', '11,12','60','4202','28', '23')
insert into tbl_subject(subjectno, subjectname, credits, grade, day, period, peoplecnt, fk_classno, fk_professorno, fk_deptseq)
values('AD402', '물리및실험', '3', '1', '월,목', '09,10,11','35','4203','29', '23')



ALTER TABLE TBL_SUBJECT DROP COLUMN SUBJECTNAME;
ALTER TABLE TBL_SUBJECT ADD SUBJECTNAME VARCHAR2(100);
ALTER TABLE TBL_SUBJECT ADD curPeopleCnt number(5) default 0;
COMMIT
update tbl_subject set period = '07080910' where subjectname='확률과통계'
select subjectname
from tbl_subject S
inner join tbl_dept D
on S.fk_deptseq = D.deptseq
where deptname = '경영학과'



select subjectname
from tbl_subject
update tbl_subject set subjectname = '컴퓨터공학개론'
update tbl_subject set muststatus='0' where subjectno = 'AB201'
COMMIT
select *
from tbl_subject

select *
from tbl_course
delete from tbl_course where courseno ='73'
commit

update tbl_subject set period='11121314' where subjectname = '프로그래밍입문'
------------------------------------------------------

------------------------------------------------------
-- 학과 공지사항 테이블 생성
create table tbl_dept_notice
(
noticeNo          number          
,contents         varchar2(500)   
,subject          varchar2(500)
,writeDay         DATE            default sysdate
,fk_deptSeq       number          not null
,constraint PK_tbl_dept_notice_noticeNo primary key(noticeNo)
,constraint FK_tbl_dept_notice_deptSeq foreign key(fk_deptSeq) 
                                   references tbl_dept(deptSeq) 
);

-- 학과 공지사항 테이블 시퀀스 생성
create sequence tbl_dept_notice_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
------------------------------------------------------

------------------------------------------------------
-- 과제 테이블 생성
create table tbl_homework
(
workNo              number          not null
, subject           varchar2(500)
, contents          varchar2(500)
, startDate         date            default sysdate
, endDate           date            
, fk_subjectNo      varchar2(20)    not null
,constraint PK_tbl_homework_workNo primary key(workNo)
,constraint FK_tbl_homework_subjectNo foreign key(fk_subjectNo) 
                                   references tbl_subject(subjectNo)
);

create sequence tbl_homework_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

------------- 수강신청 join -------------

select deptname, subjectname, subjectno, name, credits, day, period, peoplecnt, grade, curpeoplecnt
from
(
select p.name, subjectno, subjectname, credits, day, period, peoplecnt, fk_deptseq, grade, curpeoplecnt
from tbl_subject S
inner join tbl_professor P
on S.fk_professorno = p.professorno
) V
inner join tbl_dept D
on V.fk_deptseq = D.deptseq
where deptname = '경영학과' and subjectname = '컴퓨터공학개론' and grade = '1'


select count(*)
from tbl_course C
inner join tbl_subject S
on c.fk_subjectno = S.subjectno
where fk_memberno = '102' and subjectno = 'NE104' and recourse = '0'

update tbl_subject set curpeoplecnt = 1 where subjectname='경영수학'
commit

select *
from tbl_official_leave
--------------------------------------------------
insert into tbl_official_leave(leaveno, startdate, enddate, starttime, endtime, reason, fk_memberno)
values(tbl_official_leave_seq.nextval, '2010-10-10', '2010-10-10', '1', '2', '1', '102')
rollback

commit
select *
from tbl_dept
update tbl_member set grade = '1' where memberno = '102'
select name, filename, orgfilename, filesize, leaveNo, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(endDate, 'yyyy-mm-dd') as endDate, reason, approve, approveDate, noReason, to_char(regdate, 'yyyy-mm-dd') as regdate
from tbl_official_leave O
inner join tbl_member M
on O.fk_memberno = M.memberno
where fk_memberno = '102';

select name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, endDate, reason, approve, approveDate, noReason, regdate, regyear, regmonth
from
(
select leaveno, name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, regyear, regmonth, endDate, reason, approve, approveDate, noReason, regdate
from
(
    select leaveno, name,memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(regdate, 'yyyy') as regyear,to_char(regdate, 'mm') as regmonth, to_char(endDate, 'yyyy-mm-dd') as endDate, reason, approve, approveDate, noReason, to_char(regdate, 'yyyy-mm-dd') as regdate
    from 
    (
    select name, memberno, grade, deptname
    from tbl_member M
    inner join tbl_dept D
    on M.fk_deptseq = D.deptseq
    )V
    inner join tbl_official_leave O
    on V.memberno = O.fk_memberno
    where fk_memberno = '102'
    order by regdate desc
)Z
where approve in ('승인완료','승인취소') and regyear = '2020' and regmonth in (09,12,11)
)
where rno between 1 and 3

select H.leaveno, name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, endDate, reason, approve, approveDate, noReason
		from
		(
		select W.leaveno, name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, endDate, reason, approve, approveDate, noReason, regdate, regyear, regmonth
		from
		(
		    select rownum as rno, name, O.leaveno, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(regdate, 'yyyy') as regyear,to_char(regdate, 'mm') as regmonth, to_char(endDate, 'yyyy-mm-dd') as endDate, reason, approve, approveDate, noReason, to_char(regdate, 'yyyy-mm-dd') as regdate
		    from 
		    (
		    select name, memberno, grade, deptname
		    from tbl_member M
		    inner join tbl_dept D
		    on M.fk_deptseq = D.deptseq
		    )V
		    inner join tbl_official_leave O
		    on V.memberno = O.fk_memberno
		    where fk_memberno = '102'
		    order by regdate desc
		)W
		where approve in ('승인완료','승인취소') and regyear = '2020'
		)H
		where rno between 1 and 3

select *
from tbl_official_leave
desc  tbl_official_leave
update tbl_official_leave set approve='승인완료' where leaveno = '5'
commit


select name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, endDate, reason, approve, approveDate, noReason
		from
		(
		select rownum as rno, name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, startDate, endDate, reason, approve, approveDate, noReason, regdate, regyear, regmonth
		from
		(
		    select name, memberno, grade, deptname,leaveno, filename, orgfilename, filesize, leaveNo, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(regdate, 'yyyy') as regyear,to_char(regdate, 'mm') as regmonth, to_char(endDate, 'yyyy-mm-dd') as endDate, reason, approve, approveDate, noReason, to_char(regdate, 'yyyy-mm-dd') as regdate
		    from 
		    (
		    select name, memberno, grade, deptname
		    from tbl_member M
		    inner join tbl_dept D
		    on M.fk_deptseq = D.deptseq
		    )V
		    inner join tbl_official_leave O
		    on V.memberno = O.fk_memberno
		    where fk_memberno = '102'
		    order by regdate desc
		)
		where approve in ('승인완료','승인취소') and regyear = '2020' and regmonth in ('12')
		)
		where rno between 1 and 3
        
        select startDate, endDate, reason, approve, noReason, approveDate, fileName, orgFileName, fileSize, regdate, fk_memberNo
        from tbl_official_leave
        where leaveNo='5'
        
        select *
        from tbl_official_leave
        desc tbl_girl_leave
        delete from tbl_girl_leave
        commit
        
        select girlleaveno, regdate, startDate, startTime, endTime, approve, noreason
        from tbl_girl_leave
        where fk_memberno = '102'
        
            select count(*)
            from tbl_girl_leave
            where fk_memberno = '102' and to_char(startDate,'yyyy')='2020' and to_char(startDate,'mm') = '12'
        
        delete from tbl_girl_leave where firlleaveno =
        
        update tbl_girl_leave set approve = '승인완료'
        commit
        
        
		select name, fk_memberno, reason
		from
		(
		    select name, memberno, grade, deptname, filename, orgfilename, filesize, leaveNo, to_char(startDate, 'yyyy-mm-dd') as startDate, to_char(regdate, 'yyyy') as regyear,to_char(regdate, 'mm') as regmonth, to_char(endDate, 'yyyy-mm-dd') as endDate, reason, approve, approveDate, noReason, to_char(regdate, 'yyyy-mm-dd') as regdate
		    from 
		    (
		    select name, memberno, grade, deptname
		    from tbl_member M
		    inner join tbl_dept D
		    on M.fk_deptseq = D.deptseq
		    )V
		    inner join tbl_official_leave O
		    on V.memberno = O.fk_memberno
		    where fk_memberno = '102'
		    order by regdate desc
		) H
        inner join tbl_girl_leave G 
        on H.memberno = G.fk_memberno
		where approve in ('승인완료','승인취소') and regyear = '2020' and regmonth in ('12')
        
        select *
        from tbl_course
        
        update tbl_member set currentsemester = '2' where memberno='102'
		commit
        
        select courseyear, semester, fk_subjectno, subjectname, name, courseno, classchk
        from
        (
        select courseno, courseyear, semester, fk_subjectno, subjectname, fk_professorno, classchk
        from tbl_course C
        inner join tbl_subject S
        on C.fk_subjectno = S.subjectno 
        where C.fk_memberno = '102' and courseyear='2020' and semester = '2'
        ) V
        inner join tbl_professor p
        on V.fk_professorno = P.professorno
        
        select *
        from tbl_member
        commit
        update tbl_member set jubun='9804142445351' where name='권오윤'
        
        select name, mobile, email, birth, jubun, grade, currentsemester, absencecnt
        from tbl_member
        
        select courseyear, semester, subjectname
        from tbl_course C
        inner join tbl_subject S
        on C.fk_subjectno = S.subjectno
        where courseno='20'
        select * from tbl_course
        
        desc tbl_course
        
        create table tbl_class_check
        ( fk_courseno   number          not null
        , firstqs       varchar2(10)    not null
        , secondqs      varchar2(10)    not null
        , thirdqs       varchar2(10)    not null
        , fourqs        varchar2(10)    not null
        , fiveqs        varchar2(10)    not null
        , sixqs         varchar2(10)    not null
        , sevenqs       varchar2(10)    not null
        , eightqs       varchar2(10)    not null
        , etc           varchar2(300)
        , regdate       date    default sysdate
        , checkKind     varchar2(20)    not null
        ,constraint PK_tbl_class_check_fk_courseno  primary key(fk_courseno)
        ,constraint FK_tbl_class_check_fk_courseno foreign key(fk_courseno) 
                                   references tbl_course(courseno)
        );
        
        insert into tbl_class_check(fk_courseno, firstqs, secondqs, thirdqs, fourqs, fiveqs, sixqs, sevenqs, eightqs, etc, checkKind)
        values()
        
        select *
        from tbl_class_check
          select *
        from tbl_course
        
        desc tbl_course
        delete from tbl_class_check
        ALTER TABLE TBL_course ADD classchk number(2) default 0;
        commit
        
        update tbl_course set classchk = '1' where courseno = ''
        
        select *
        from tbl_member
        update tbl_member set extraaddress='안양동, 래미안 안양 메가트리아' where memberno ='102'
        commit
        select currentSemester, name, memberNo, deptName, birth, grade, mobile, email, address, detailaddress, extraaddress,status
        from 
        (
        select currentSemester, name, memberNo, deptName, birth, grade, mobile, email, address, detailaddress, extraaddress, fk_regseq
		from tbl_member M
		inner join tbl_dept D
		on M.fk_deptseq = D.deptseq
        where memberNo = '102'
        )V
        inner join tbl_school_reg R
        on V.fk_regseq = R.regseq
        
        select *
        from tbl_member
        
        desc tbl_official_leave
        ------------------------------------------------------------------------------------
        -- 휴학 테이블 만들기
        create table tbl_leave_school
        (schoolLvNo    number
        ,fk_regSeq     number
        ,constraint PK_tbl_leave_school_schoolLvNo  primary key(schoolLvNo)
        ,constraint FK_tbl_leave_school_regSeq  foreign key(fk_regSeq) 
                                   references tbl_school_reg(regSeq)
        );
        create sequence tbl_leave_school_seq
        start with 1
        increment by 1
        nomaxvalue
        nominvalue
        nocycle
        nocache;
        drop table tbl_leave_school
            drop sequence tbl_leave_school_seq
        drop table tbl_school_leave
        -- 군휴학 테이블 만들기
        create table tbl_school_leave
        (   schoolLvNo number
            ,armytype   varchar2(50)    
            ,armyStartDate date         
            ,armyEndDate date           
            ,startSemester  varchar2(30)
            ,endSemester    varchar2(30) 
            , filename  varchar2(255)   
            , orgfilename   varchar2(255)   
            , filesize      number
            , regdate       date    default sysdate not null 
            , approve       varchar2(20) default '승인전'
            , noreason      varchar2(500)
            , reason        varchar2(800)
            , fk_memberno number  not null
            ,constraint PK_tbl_school_leave_schoolLvNo  primary key(schoolLvNo)
            ,constraint FK_tbl_school_leave_memberno  foreign key(fk_memberno) 
                                   references tbl_member(memberno)
        );
ALTER TABLE tbl_school_leave DROP COLUMN comeSemester;
ALTER TABLE tbl_school_leave ADD type varchar2(30) 
ALTER TABLE tbl_school_leave ADD comeSemester varchar2(30) 
ALTER TABLE tbl_school_leave ADD comeSchool number default 0
commit
        create sequence tbl_school_leave_seq
        start with 1
        increment by 1
        nomaxvalue
        nominvalue
        nocycle
        nocache;
        
        select *
        from tbl_course
        delete from tbl_school_leave
        insert into tbl_school_leave(schoolLvNo, armytype, armystartdate, armyenddate, filename, orgfilename, filesize, comeSemester, fk_regSeq, type)
        values(tbl_school_leave_seq.nextval, ?, ?, ?, ?, ?, ?, ?,'2','군휴학')
        update tbl_school_leave set regdate= '2019-08-17'
        
        select schoollvno, startsemester, to_char(regdate, 'yyyy-mm-dd') as regdate, type, comesemester, approve, filename, orgfilename, filesize, noreason
        from tbl_school_leave
        where fk_memberno = '102'
        
        delete from tbl_school_leave
        commit
        rollback
        update tbl_school_leave set armytype = '해군', startsemester = '2021-2' where schoollvno = '13'
        
        select to_char(armyStartDate, 'yyyy-mm-dd') as armyStartDate, to_char(armyEndDate, 'yyyy-mm-dd') as armyEndDate, armyType, schoolLvNo, startSemester, to_char(regdate, 'yyyy-mm-dd') as regdate, type, comeSemester, approve, filename, orgfilename, filesize, noreason
        from tbl_school_leave
        where schoolLvNo = '15'
        
        select *
        from tbl_school_leave
        where startsemester = '2021-1' and fk_memberno = '102'
        
        insert into tbl_school_leave(schoollvno, startsemester, endsemester, approve, reason, fk_memberno, type, comesemester)
        values(tbl_school_leave_seq.nextval, '2020-1', '2020-2', '승인완료', '자기개발을 위해서 하고 싶었습니다.', '102', '일반휴학', '2021-1');
        update tbl_school_leave set comesemester = '2022/2학기' where schoollvno = '17'
        commit
        
        select startsemester, regdate, type, comesemester
        from tbl_school_leave
        where fk_memberno = '102' and comesemester = '2021/1학기'
        
        ---------------------------------------------------------------
        -- 복학 테이블 만들기
        create table tbl_come_school(
            comeseq         number
            ,comesemester   varchar2(30)
            ,regdate        date    default sysdate not null
            ,type           varchar2(30)
            ,approve        varchar2(30) default '승인전'
            ,approvedate    date    
            ,filename       varchar2(255)   
            ,orgfilename    varchar2(255)   
            ,filesize       number
            ,fk_memberno    number not null
            ,constraint PK_tbl_come_school_comeseq  primary key(comeseq)
            ,constraint FK_tbl_come_school_memberno  foreign key(fk_memberno) 
                                   references tbl_member(memberno)
        );
        ALTER TABLE tbl_come_school ADD noreason varchar2(500) 
        create sequence tbl_come_school_seq
        start with 1
        increment by 1
        nomaxvalue
        nominvalue
        nocycle
        nocache;
        commit
        
        select *
        from tbl_member
        delete from tbl_come_school
        select count(*)
        from tbl_come_school
        where comesemester = '' and fk_memberno = ''
         
        select comeseq, comesemester, to_char(regdate, 'yyyy-mm-dd') as regdate, type, approve, approvedate, filename, fk_memberno, noreason
        from tbl_come_school
        where fk_memberno = '102'
        
        select *
        from tbl_member
        
        -- 총학점
        select sum(credits)
        from(
        select fk_subjectno
        from tbl_course
        where fk_memberno = '106' and to_date(courseyear, 'yyyy') < 2020
        )V
        inner join tbl_subject S
        on S.subjectno = V.fk_subjectno
        select *
        from tbl_course
        --전공학점
        select sum(credits)
        from(
        select fk_subjectno
        from tbl_course
        where fk_memberno = '108'
        )V
        inner join tbl_subject S
        on S.subjectno = V.fk_subjectno 
        where fk_deptseq != '23'
    
        -- 교양학점
        select sum(credits)
        from(
        select fk_subjectno
        from tbl_course
        where fk_memberno = '108'
        )V
        inner join tbl_subject S
        on S.subjectno = V.fk_subjectno 
        where fk_deptseq = '23'
        commit
        update tbl_member set graduateok='1' where memberno='108'
        
        select *
        from tbl_subject
        
        
        select deptname, subjectname, subjectno, name, credits, day, period, peoplecnt, grade, curpeoplecnt, subssemester
		from
		(
		select p.name, subjectno, subjectname, credits, day, period, peoplecnt, fk_deptseq, grade, curpeoplecnt, subssemester
		from tbl_subject S
		inner join tbl_professor P
		on S.fk_professorno = p.professorno
        where subjectno = 'NE106'
		) V
		inner join tbl_dept D
		on V.fk_deptseq = D.deptseq


select name, subjectname, credits, subjectno, day, period, peoplecnt, curpeoplecnt, courseno, courseyear, semester
		from
		(
		select name, subjectno, subjectname, credits, day, period, peoplecnt, curpeoplecnt
		from tbl_subject S
		inner join tbl_professor P
		on S.fk_professorno = P.professorno
		) V
		inner join tbl_course C
		on V.subjectno = C.fk_subjectno
		where fk_memberno = '102' and courseyear = '2021' and semester = '1'
        
        update 
        select *
        delete from TBL_CLASS_CHECK
        delete from tbl_course where fk_memberno = '102'
        commit
        select *
        from tbl_course
        
        update tbl_member set currentsemester='1' where memberno = '102'
        select nvl(sum(credits),0)
		from tbl_course C
		inner join tbl_subject S
		on c.fk_subjectno = S.subjectno
		where fk_memberno = '102' and courseyear = '2021' and semester = '1'
        
        select *
        from tbl_course
        where fk_memberno = '102'
        
        select *
		from tbl_course C
		inner join tbl_subject S
		on c.fk_subjectno = S.subjectno
		where fk_memberno = '102'
        
        select count(*)
		from tbl_course C
		inner join tbl_subject S
		on c.fk_subjectno = S.subjectno
		where fk_memberno = '102' and (day LIKE '%화%' or day like '%목%' or day like '%금%') and (period LIKE '%01%' or period like '%02%' or period like '%03%')
        
        select fk_deptseq
        from tbl_subject
        where muststatus = '0' and (fk_deptseq = '2' or fk_deptseq = '23')
        
        select subjectname
        from tbl_subject S
        inner join tbl_course C
        on S.subjectno = C.fk_subjectno
        where C.fk_memberno = '108' and muststatus = '0'
        
        
        select *
        from tbl_member
        commit
        update tbl_member set graduateok = '0' where memberno='108'
        
        -------------- 졸업연기 테이블-----------------
        create table tbl_graduate_delay(
            delayNo      number
            ,regDate     date   default sysdate not null
            ,reason      varchar2(500)  not null
            ,startSem    varchar2(100)  not null
            ,endSem      varchar2(100)  not null
            ,approve     varchar2(20)   default '승인전'
            ,approveDate date
            ,noreason    varchar2(500)
            ,fk_memberno number not null
            ,constraint PK_tbl_graduate_delay_delayNo  primary key(delayNo)
            ,constraint FK_tbl_graduate_delay_memberno  foreign key(fk_memberno) 
                                   references tbl_member(memberno)
        );
        
        create sequence tbl_graduate_delay_seq
        start with 1
        increment by 1
        nomaxvalue
        nominvalue
        nocycle
        nocache;
        commit
       rollback 
       delete
        from tbl_graduate_delay
        
        select count(*)
        from tbl_graduate_delay
        where fk_memberno ='108' and startsem = '2021/1학기'
        
        select *
        from tbl_subject AA102  
        update tbl_member set grade = '4' where memberno='106'
        select * 
        from tbl_course where FK_MEMBERNO = '108' and 
        commit;
        ROLLBACK;
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2018, 'A', '104', 'NE419','1');
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2, 2020, 'A+', '106', 'AD401','1');
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2, 2020, 'A', '106', 'AA103','1');
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2, 2020, 'A', '106', 'AA104','1');
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2, 2020, 'A+', '106', 'NE421','1');
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2, 2019, 'A+', '106', 'AB205','1');
        
        COMMIT
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 1, 2017, 'A+', '106', 'AA101','1')
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno, classchk)
        values(tbl_course_seq.nextval, 2017, 1, 'A+', '106', 'AA101','1')
        
        