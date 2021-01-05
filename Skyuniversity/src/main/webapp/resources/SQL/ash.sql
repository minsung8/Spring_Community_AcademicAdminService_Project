show user;


update tbl_commu_member set point = 50000
where commuMemberNo = 0;

commit;
create table tbl_an_index_img (
ino      number not null 
, iname     varchar2(500) not null
, ilink      varchar2(500) not null
, status    number(1) default 1 not null
, primary key (ino)
, check (status in (0, 1))
);

create sequence inum
    start with 1         -- 첫번째 출발은 1부터 한다.
    increment by 1        -- 증가치 값
    nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
    nominvalue          -- 최소값이 없다.
    nocycle             -- 반복이 없는 직진
    nocache;
    
    insert into tbl_an_index_img(ino, iname, ilink, status)
    values (inum.nextval, 'banner1.PNG', 'https://www.hyundaicard.com/index.jsp', default);

    insert into tbl_an_index_img(ino, iname, ilink, status)
    values (inum.nextval, 'banner2.PNG', 'https://elyon.game.daum.net/preorder/main', default);

    insert into tbl_an_index_img(ino, iname, ilink, status)
    values (inum.nextval, 'banner3.PNG', 'http://www.webzen.co.kr/', default);

    insert into tbl_an_index_img(ino, iname, ilink, status)
    values (inum.nextval, 'banner4.PNG', 'https://snulife.com/', default);


create table tbl_commu_member (    -- select 할때 필요할 값 비밀번호, 이메일, 커뮤멤버레벨VO
commuMemberNo            number not null
, fk_memberNo           number not null
, fk_levelNo            number default 1 not null
, nickname              varchar2(50) 
, point                 number default 0 not null
, check(point >= 0)
);

create sequence tbl_commu_member_seq
start with 1         -- 첫번째 출발은 1부터 한다.
increment by 1        -- 증가치 값
nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
nominvalue          -- 최소값이 없다.
nocycle             -- 반복이 없는 직진
nocache;

insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (0, 0, 21, 0);

insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 101, 4, 4990);

insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 102, 9, 9990);

insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 104, default, 0);

insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 105, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 106, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 108, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 109, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 110, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 111, default, 0);
insert into tbl_commu_member(commuMemberNo, fk_memberNo, fk_levelNo, point)
values (tbl_commu_member_seq.nextval, 112, default, 0);

commit;

update tbl_commu_member set fk_levelNo = 1
where commuMemberNo = 3;

select * from tbl_member order by 1;

select * from tbl_commu_member;



drop table tbl_commu_member purge;
drop sequence tbl_commu_member_seq;

drop table tbl_commu_member_level purge;
drop sequence tbl_commu_member_level_seq;

create table tbl_commu_member_level (
levelNo             number not null
, levelName         varchar2(50) not null
, levelPoint        number not null
, levelImg          varchar2(200) not null
, check(levelPoint >= 0)
);

create sequence tbl_commu_member_level_seq
start with 1         -- 첫번째 출발은 1부터 한다.
increment by 1        -- 증가치 값
nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
nominvalue          -- 최소값이 없다.
nocycle             -- 반복이 없는 직진
nocache;



desc tbl_member;

begin
    for i in 1..21 loop
        insert into tbl_commu_member_level(levelNo, levelName, levelPoint, levelImg)
        values(tbl_commu_member_level_seq.nextval, 'LEVEL'||i, 1000*i, 'level'||i||'.png');
    end loop;
end;

select *
from tbl_commu_member_level;

select *
from tbl_member;

select * 
from tbl_commu_member;

select *
from tbl_commu_member_level;

select m.memberno, fk_levelNo, nickname, point, m.name, m.email
from tbl_commu_member c
join
(select memberno, name, email
from tbl_member
where memberno = 'asdf' and pwd = 'qwe1234$') m
on c.fk_memberNo = m.memberno;

select levelno, levelName, levelPoint, levelImg
from tbl_commu_member_level
where levelNo = 2;

update tbl_commu_member set nickname = 
where commuMemberNo = ;

update tbl_commu_member_level set levelPoint = levelPoint - 1000;

commit;

select * from tab;
select * from TBL_DEPT;
select * from TBL_MEMBER;
select * from TBL_BOARD_HUMOR;

select * from tbl_commu_member;
select * from TBL_BOARD_INFORMAL;
select * from TBL_BOARD_NOTICE;
select * from TBL_BOARDKIND;
select * from TBL_CATEGORY;

----- 장터 게시판의 boardTypeNo = 5

rollback;

select * from tbl_board_etcmarket order by 1;

drop table tbl_board_etcmarket purge;

create table tbl_board_etcmarket(
boardNo               number                                not null         -- 시퀀스 고유넘버
, fk_boardKindNo      number                                not null         -- tbl_boardkind 참조!
, fk_commuMemberNo    number                                not null         -- 유저넘버 (현재는 101, 102)
, categoryNo          number                                not null         -- 삽니다: 1 , 팝니다: 2,  무료나눔: 3
, subject             varchar2(200)                         not null         -- 글제목
, regDate             date             default sysdate      not null         -- 등록일자
, editDate            date                                                   -- 글 수정 일자
, content             nvarchar2(2000)                                        -- 글 내용(null이 가능한 이유는 사진만 올리는 경우가 있기 때문에!)
, readCount           number           default 0                             -- 조회수 디폴트는 0
, status              number(1)        default 1                             -- 글상태 0 - 비활성화,  1 - 활성화
, writerIp            varchar2(50)                          not null         -- 작성자 아이피주소
, price               number           default 0            not null         -- 다른게시판과 다르게 가격정보 무료나눔이 있으므로 0도 가능
, fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20201208092715353243254235235234.png)                                       
, orgFileName    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
, fileSize       number                           -- 파일크기  
, primary key (boardNo)
, check (status in (0, 1, 2))

);


create sequence tbl_board_etcmarket_seq
start with 1         -- 첫번째 출발은 1부터 한다.
increment by 1        -- 증가치 값
nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
nominvalue          -- 최소값이 없다.
nocycle             -- 반복이 없는 직진
nocache;

create table tbl_board_housemarket(
boardNo               number                                not null         -- 시퀀스 고유넘버
, fk_boardKindNo      number                                not null         -- tbl_boardkind 참조!
, fk_commuMemberNo    number                                not null         -- 유저넘버 (현재는 101, 102)
, categoryNo          number                                not null         -- 삽니다: 1 , 팝니다: 2
, subject             varchar2(200)                         not null         -- 글제목
, regDate             date             default sysdate      not null         -- 등록일자
, editDate            date                                                   -- 글 수정 일자
, content             nvarchar2(2000)                                        -- 글 내용(null이 가능한 이유는 사진만 올리는 경우가 있기 때문에!)
, readCount           number           default 0                             -- 조회수 디폴트는 0
, status              number(1)        default 1                             -- 글상태 0 - 비활성화,  1 - 활성화
, writerIp            varchar2(50)                          not null         -- 작성자 아이피주소
, price               number           default 0            not null         -- 다른게시판과 다르게 가격정보 무료나눔이 있으므로 0도 가능
, fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20201208092715353243254235235234.png)                                       
, orgFileName    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
, fileSize       number                           -- 파일크기  
, primary key (boardNo)
, check (status in (0, 1, 2))

);

create sequence tbl_board_housemarket_seq
start with 1         -- 첫번째 출발은 1부터 한다.
increment by 1        -- 증가치 값
nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
nominvalue          -- 최소값이 없다.
nocycle             -- 반복이 없는 직진
nocache;


create table tbl_board_bookmarket(
boardNo               number                                not null         -- 시퀀스 고유넘버
, fk_boardKindNo      number                                not null         -- tbl_boardkind 참조!
, fk_commuMemberNo    number                                not null         -- 유저넘버 (현재는 101, 102)
, categoryNo          number                                not null         -- 삽니다: 1 , 팝니다: 2,  무료나눔: 3
, subject             varchar2(200)                         not null         -- 글제목
, regDate             date             default sysdate      not null         -- 등록일자
, editDate            date                                                   -- 글 수정 일자
, content             nvarchar2(2000)                                        -- 글 내용(null이 가능한 이유는 사진만 올리는 경우가 있기 때문에!)
, readCount           number           default 0                             -- 조회수 디폴트는 0
, status              number(1)        default 1                             -- 글상태 0 - 비활성화,  1 - 활성화
, writerIp            varchar2(50)                          not null         -- 작성자 아이피주소
, price               number           default 0            not null         -- 다른게시판과 다르게 가격정보 무료나눔이 있으므로 0도 가능
, fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20201208092715353243254235235234.png)                                       
, orgFileName    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
, fileSize       number                           -- 파일크기  
, primary key (boardNo)
, check (status in (0, 1, 2))

);

create sequence tbl_board_bookmarket_seq
start with 1         -- 첫번째 출발은 1부터 한다.
increment by 1        -- 증가치 값
nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
nominvalue          -- 최소값이 없다.
nocycle             -- 반복이 없는 직진
nocache;


select boardKindNo, boardTypeNo, boardName
from tbl_boardkind
where boardKindNo = ;

commit;

drop table tbl_board_bookmarket purge;
drop sequence tbl_board_bookmarket_seq ;


select * from tbl_board_bookmarket order by 1 desc;
select * from tbl_boardkind;
select * from tbl_category;
select * from tbl_commu_member;
select * from tbl_commu_member_level;

select boardNo, fk_boardKindNo, fk_commuMemberNo, categoryNo, subject
                 , content, readCount, status, writerIp, price, fileName, orgFileName, fileSize
                 , regDate, editDate
                 
                 , categoryName
                 
                 , commuMemberNo, fk_memberNo, fk_levelNo, nickname, point
                 
                 , levelNo, levelName, levelPoint, levelImg
                 
                 , boardKindNo, boardTypeNo, boardName
                 , upCount
                 
		from 
		(
		    select row_number() over(order by e.status desc, boardNo desc)  as rno, e.boardNo, e.fk_boardKindNo, e.fk_commuMemberNo
                 , e.categoryNo, e.subject
                 , e.content, e.readCount, e.status, e.writerIp, e.price, e.fileName, e.orgFileName, e.fileSize
                 , to_char(e.regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(e.editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
                 
                 , c.categoryName
                 
                 , m.commuMemberNo, m.fk_memberNo,  m.fk_levelNo, m.nickname, m.point
                 
                 , l.levelNo, l.levelName, l.levelPoint, l.levelImg
                 
                 , k.boardKindNo, k.boardTypeNo, k.boardName
                 
                 , nvl(g.upCount, 0) as upCount
                 
		    from tbl_board_etcmarket e join tbl_category c  
		    on e.categoryNo =  c.categoryNo
		    join tbl_commu_member m 
		    on e.fk_commuMemberNo = m.commuMemberNo
            join tbl_commu_member_level l
            on m.fk_levelNo = l.levelNo
            join tbl_boardkind k
            on e.fk_boardKindNo = k.boardKindNo 
            join tbl_board_good g
            on m.fk_memberNo = g.fk_memberNo
            left join (select fk_boardNo, count(*) as upCount
                    from tbl_board_bad
                    where fk_boardKindNo = 25
                    group by fk_boardNo
                ) g
            on  e.boardNo = g.fk_boardNo
		    where e.status >= 1
            
--            <if test='categoryNo != "" '>
--            and e.categoryNo = #{categoryNo}
--	        </if>
--		    <if test='searchWord != "" '>
--            and lower(${searchType}) like '%' || lower(#{searchWord}) || '%'
--	        </if>
		)T
where rno between 1 and 15
order by rno asc;

select * from tbl_board_etcmarket;


select fk_boardNo, count(*) as upCount
from tbl_board_good
where fk_boardKindNo = e.fk_boardKindNo and fk_boardNo = e.boardNo
group by fk_boardNo;

select * from tbl_board_etcmarket;

select e.boardNo, e.fk_boardKindNo, e.fk_commuMemberNo
	                 , e.categoryNo, e.subject, e.price
	                 , e.content, e.readCount, e.status, e.writerIp, e.fileName, e.orgFileName, e.fileSize
	                 , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
	                 
	                 , c.categoryName
	                 
	                 , m.commuMemberNo, m.fk_levelNo, m.nickname, m.point
	                 
	                 , l.levelNo, l.levelName, l.levelPoint, l.levelImg
	                 
	                 , k.boardKindNo, k.boardTypeNo, k.boardName
	                 
			    from tbl_board_etcmarket e join tbl_category c  
			    on e.categoryNo =  c.categoryNo
			    join tbl_commu_member m 
			    on e.fk_commuMemberNo = m.commuMemberNo
	            join tbl_commu_member_level l
	            on m.fk_levelNo = l.levelNo
	            join tbl_boardkind k
	            on e.fk_boardKindNo = k.boardKindNo
			    where e.status = 1 and boardNo = 5





select boardKindNo, boardTypeNo, boardName
		from tbl_boardkind
		where boardKindNo = 25;
        
        select categoryNo, fk_boardKindNo, categoryName
		from tbl_category
		where fk_boardKindNo = to_number('25');
        
        select count(*)
        from tbl_boardkind
        where boardKindNo = 2525;
        
        
        select * from tbl_commu_member;
        select * from tbl_commu_member_level;
        
insert into tbl_board_etcmarket(boardNo, fk_boardKindNo, fk_commuMemberNo, categoryNo, subject, regDate, content, readCount, status, writerIp, price, fileName, orgFileName, fileSize)
values(tbl_board_etcmarket_seq.nextval, ?, ?, ?, ?, default, ?, default, default, ?, ?, ?, ?, ?);

insert into tbl_board_etcmarket(boardNo, fk_boardKindNo, fk_commuMemberNo, categoryNo, subject, regDate, content, readCount, status, writerIp, price)
values(tbl_board_etcmarket_seq.nextval, ?, ?, ?, ?, default, ?, default, default, ?, ?);


update tbl_commu_member set point = point + to_number(#{point})
where commuMemberNo = #{fk_commuMemberNo}

select levelNo
from tbl_commu_member_level
where trunc(4000,-3)<= levelPoint and levelPoint <= 4000

update tbl_commu_member set fk_levelNo = #{levelNo}
where commuMemberNo = #{fk_commuMemberNo}

update tbl_commu_member set point = 3999
where commuMemberNo = 1;

update tbl_commu_member set fk_levelNo = 4
where commuMemberNo = 1;

commit;

select * from tbl_board_etcmarket order by 1 desc;
select * from tbl_commu_member;


update tbl_commu_member set point = 123121234
where commuMemberNo = 1;

update tbl_commu_member set fk_levelNo = 4
where commuMemberNo = 1;

commit;

select levelNo
from tbl_commu_member_level
where levelPoint <= #{point} and trunc( #{point} , -3) <= levelPoint


select rno, boardNo, fk_boardKindNo, fk_commuMemberNo, categoryNo, subject 
                 , content, readCount, status, writerIp, fileName, orgFileName, fileSize
                 , regDate, editDate, price
                 
                 , categoryName
                 
                 , commuMemberNo, fk_levelNo, nickname, point
                 
                 , levelNo, levelName, levelPoint, levelImg
                 
                 , boardKindNo, boardTypeNo, boardName
                 
		from 
			(
			    select row_number() over(order by e.status desc, boardNo desc)  as rno, e.boardNo, e.fk_boardKindNo, e.fk_commuMemberNo
	                 , e.categoryNo, e.subject, e.price
	                 , e.content, e.readCount, e.status, e.writerIp, e.fileName, e.orgFileName, e.fileSize
	                 , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
	                 
	                 , c.categoryName
	                 
	                 , m.commuMemberNo, m.fk_levelNo, m.nickname, m.point
	                 
	                 , l.levelNo, l.levelName, l.levelPoint, l.levelImg
	                 
	                 , k.boardKindNo, k.boardTypeNo, k.boardName
	                 
			    from tbl_board_etcmarket e join tbl_category c  
			    on e.categoryNo =  c.categoryNo
			    join tbl_commu_member m 
			    on e.fk_commuMemberNo = m.commuMemberNo
	            join tbl_commu_member_level l
	            on m.fk_levelNo = l.levelNo
	            join tbl_boardkind k
	            on e.fk_boardKindNo = k.boardKindNo
			    where e.status >= 1
--	            <if test='categoryNo != "" '>
--	            and e.categoryNo = #{categoryNo}
--		        </if>
--			    <if test='searchWord != "" '>
--	            and lower(${searchType}) like '%' || lower(#{searchWord}) || '%'
--		        </if>
			)T
		where rno between 16 and 30
		order by rno asc
        
        
        
        
        
        select e.boardNo, e.fk_boardKindNo, e.fk_commuMemberNo
	                 , e.categoryNo, e.subject, e.price
	                 , e.content, e.readCount, e.status, e.writerIp, e.fileName, e.orgFileName, e.fileSize
	                 , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, to_char(editDate, 'yyyy-mm-dd hh24:mi:ss') as editDate
	                 
	                 , c.categoryName
	                 
	                 , m.commuMemberNo, m.fk_levelNo, m.nickname, m.point
	                 
	                 , l.levelNo, l.levelName, l.levelPoint, l.levelImg
	                 
	                 , k.boardKindNo, k.boardTypeNo, k.boardName
	                 
			    from tbl_board_etcmarket e join tbl_category c  
			    on e.categoryNo =  c.categoryNo
			    join tbl_commu_member m 
			    on e.fk_commuMemberNo = m.commuMemberNo
	            join tbl_commu_member_level l
	            on m.fk_levelNo = l.levelNo
	            join tbl_boardkind k
	            on e.fk_boardKindNo = k.boardKindNo
			    where e.status >= 1 and boardNo = 5;


select * from tbl_category;









-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select *
from tbl_board_etcmarket;

update tbl_board_etcmarket set categoryNo = #{categoryNo}, subject = #{subject}, editDate = syadate, content = #{content}, price = #{price}, fileName = #{fileName}, orgFileName = #{orgFileName}, fileSize = #{fileSize}
where boardNo = #{boardNo}

select * from tab;

commit;
select * from tbl_commu_member;
select * from tbl_board_good;
select * from tbl_board_bad;
select * from tbl_board_report
where fk_boardKindNo = 25 and fk_boardNo = 53;

delete from tbl_board_report
where fk_boardKindNo = 23;

delete from tbl_board_report
where fk_boardKindNo = 24;
delete from tbl_board_report
where fk_boardKindNo = 25;

commit;
select count(*)
from tbl_board_good
where fk_boardKindNo = #{boardKindNo} and fk_boardNo = #{boardNo};

select count(*)
		from tbl_board_report
		where fk_boardKindNo = 25 and fk_boardNo = 53;
        
        select * from tbl_member;
        
        update tbl_commu_member set nickname = '관리자(찐)'
        where commuMemberNo = 0;
        
        commit;
        
        select * from tbl_category;
        
        
        
        select boardKindNo, boardTypeNo, boardName
        from tbl_boardkind;
        
        select commuMemberNo, fk_memberNo, fk_levelNo, nickname, point, m.name, m.email
		from tbl_commu_member c
		join
			(select memberno, name, email
			from tbl_member
			where memberno = 0 and pwd = 'qwer1234$'
		) m
		on c.fk_memberNo = m.memberno
        
        delete from tbl_commu_member
        where fk_levelNo = 21 and commuMemberNo = 0;
        
        commit;
        
        select * from tbl_board_etcmarket
        
        create table tbl_notice (
            noticeNo             number                  not null
            , fk_boardKindNo    number                  not null
            , fk_memberNo       number default 0        not null
            , fk_categoryNo     number default 1        not null
            , subject           varchar2(200)           not null
            , regDate           date default sysdate    not null
            , content           nvarchar2(2000)         not null
            , readCount         number default 0                 not null
            , status            number(1) default 1     not null  -- 0 : 못쓸글 , 1: 활성화글
            , writerIp          varchar2(50)            not null
        );
        
        create sequence tbl_notice_seq
        start with 1         -- 첫번째 출발은 1부터 한다.
        increment by 1        -- 증가치 값
        nomaxvalue          -- 최대값이 없이 무제한으로 증가시키겠다는 뜻. 최대값을 주고 싶다면 maxvalue 100이런 식으로 주면 된다.
        nominvalue          -- 최소값이 없다.
        nocycle             -- 반복이 없는 직진
        nocache;

insert into tbl_notice(boardNo, fk_boardKindNo, subject, content, writerIp)
values(tbl_notice_seq.nextval, #{fk_boardKindNo}, #{subject}, #{content}, #{writerIp})

drop table tbl_notice purge;
drop sequence tbl_notice_seq;


select * from tbl_commu_member;
select * from tbl_category;
select * from tbl_commu_member;
select * from tbl_commu_member_level;
select * from tbl_boardKind;

select n.noticeNo, n.fk_boardKindNo, n.fk_memberNo, n.fk_categoryNo
, n.subject, n.regDate, n.content, n.readCount, n.status, n.writerIp

, c.categoryName

, m.commuMemberNo, m.fk_levelNo, m.nickname, m.point

, l.levelName, l.levelPoint, l.levelImg

, k.boardKindNo, k.boardTypeNo, k.boardName

, nvl(g.upCount, 0) as upCount

from tbl_notice n join tbl_category c
on n.fk_categoryNo = c.categoryNo
join tbl_commu_member m 
on n.fk_memberNo = m.fk_memberNo
join tbl_commu_member_level l
on m.fk_levelNo = l.levelNo
join tbl_boardkind k
on n.fk_boardKindNo = k.boardKindNo
left join (select fk_boardNo, count(*) as upCount
                    from tbl_board_good
                    where fk_boardKindNo = 25
                    group by fk_boardNo
                ) g
on  n.noticeNo = g.fk_boardNo
where n.fk_boardKindNo = 25 and noticeNo = 1;

select * from tbl_member;
select * from tbl_notice;

update from tbl_notice set fk_boardKindNo = 3, subject = '[공지] 업뎃 -  중고거래 게시판 이용수칙', content = ' 업뎃 이용수칙1.ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ<br>이용수칙1.ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ&nbsp;<br>이용수칙1.ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ&nbsp;<br>이용수칙1.ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ&nbsp;', writerIp = '0:0:0:0:0:0:0:1'
where noticeNo = 1

update tbl_notice set fk_boardKindNo = 24
where noticeNo = 2

commit;



select * from tbl_boardkind;


select fk_boardKindNo, subject, readCount, boardName, boardNo
      from
      (
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno )
      ) V
      
    
      
      
      select * from tbl_category;
      select b.boardNo, b.fk_boardkindno, b.subject, c.categoryName from tbl_board_notice b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo;
      
      
      
      selectboardNo, fk_boardKindNo, subject, categoryName
      from 
      (
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_notice b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
      union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_council b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_major b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_club b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_graduate b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_critic b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_study b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_cert b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_emp b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_joboffer b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from TBL_BOARD_lost b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_informal b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_polite b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from  tbl_board_humor b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_issue b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from  tbl_board_mbti b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_food b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_love b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from  tbl_board_hobby b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_health b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_diet b left join tbl_category c
      on b.fk_categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
       union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_housemarket b left join tbl_category c
      on b.categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
      union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_bookmarket b left join tbl_category c
      on b.categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5
      
      union all 
      
      select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, b.boardNo, b.fk_boardKindNo, b.subject, nvl(c.categoryName, '일반') as categoryName from tbl_board_etcmarket b left join tbl_category c
      on b.categoryNo = c.categoryNo
      where status = 1) aa
      where rno between 1 and 5)
      order by fk_boardKindNo
      ;
      
      select * from tbl_boardKind;
      select * from tbl_board_notice;
      select * from tbl_board_council;
      select * from TBL_BOARD_major;
      select * from TBL_BOARD_club;
      select * from TBL_BOARD_graduate;
      select * from tbl_board_critic;
      select * from TBL_BOARD_study;
      select * from TBL_BOARD_cert;
      select * from TBL_BOARD_emp;
      select * from tbl_board_joboffer;
      select * from TBL_BOARD_lost;
      select * from tbl_board_informal;
      select * from tbl_board_polite;
      select * from tbl_board_humor;
      select * from tbl_board_issue;
      select * from tbl_board_mbti;
      select * from tbl_board_food;
      select * from tbl_board_love;
      select * from tbl_board_hobby;
      select * from tbl_board_health;
      select * from tbl_board_diet;
      select * from tbl_board_housemarket;
      select * from tbl_board_bookmarket;
      select * from tbl_board_etcmarket;
      
      
      select * from tbl_boardKind;
      
      
      
      select boardName, fk_boardNo as boardNo, fk_boardKindNo, subject
      from
      (
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_notice where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_council where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_major where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_club where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_graduate where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_critic where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_study where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_cert where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_emp where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_joboffer where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_lost where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_informal where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_polite where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_humor where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_issue where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_mbti where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_food where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_love where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_hobby where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname,subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_health where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      union all
      (select boardname, subject, fk_boardKindNo, fk_boardno, count(*) as goodCount
      from
      (select k.boardname, b.fk_boardkindno, g.fk_boardno, subject from tbl_board_good g
      inner join (select * from tbl_board_diet where status = 1 and regDate >= sysdate - 7) b 
      on g.fk_boardno = b.boardno
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno)
      V group by fk_boardno, fk_boardkindno, boardname, subject)
      order by goodCount desc)
      V2 
     where rownum <= 11
     
     
     
     select fk_boardKindNo, fk_boardNo, count(*)
     from tbl_board_good
     group by fk_boardKindNo, fk_boardNo
     
     
     
     select boardNo, fk_boardKindNo, subject, boardName
     from
     ( 
     select row_number() over(order by upCount desc, readCount desc) as rno, boardNo, fk_boardKindNo, subject, readCount, upCount, boardName
     from 
     (
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_NOTICE b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
      
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_COUNCIL b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_MAJOR b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_CLUB b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_GRADUATE b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_CRITIC b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_INFORMAL b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from tbl_board_polite b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_HUMOR b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_ISSUE b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_MBTI b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_FOOD b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_LOVE b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_HOBBY b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_HEALTH b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_DIET b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_STUDY b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_CERT b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_EMP b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     
     union all
     
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_JOBOFFER b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     union all
     select b.boardNo, b.fk_boardKindNo, b.subject, b.readCount, nvl(v.upCount, 0) as upCount, b.status, k.boardName
     from TBL_BOARD_LOST b
     left join 
     (
         select fk_boardKindNo, fk_boardNo, count(*) as upCount
         from tbl_board_good
         group by fk_boardKindNo, fk_boardNo
     ) v 
     on b.fk_boardKindNo = v.fk_boardKindNo and b.boardNo = v.fk_boardNo
     join tbl_boardkind k
     on b.fk_boardkindno = k.boardkindno
     ) ee
     where status = 1
     ) 
     where rno <= 11;
     
     
     select * from tab;
     
     
     
     select fk_boardKindNo, subject, boardName, boardNo
     from
     (
     select row_number() over (order by fk_boardKindNo) as rno, fk_boardKindNo, subject, boardName, boardNo
      from
      (
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      ) V
    where lower(subject) like '%' || lower('하') || '%'
    ) tt
    where rno between 1 and 3;
    
    
    
    
    
    
    
    
    
    
    select count(*) as count
      from
      (
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, readCount, k.boardname, boardNo from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      ) V
    where lower(subject) like '%' || lower('테') || '%';
    
    
    
    
-------------------------- 다이어트 댓글 테이블 생성 ------------------------------
create table tbl_comment_housemarket(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_housemarket PRIMARY KEY(commentNo)
);

create sequence tbl_comment_housemarket_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 다이어트 댓글 테이블 생성 ------------------------------
create table tbl_comment_bookmarket(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_bookmarket PRIMARY KEY(commentNo)
);

create sequence tbl_comment_bookmarket_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-------------------------- 다이어트 댓글 테이블 생성 ------------------------------
create table tbl_comment_etcmarket(
    commentNo      NUMBER         NOT NULL,         -- 댓글번호
    fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
    fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호  
    cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
    regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
    status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
    writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
    CONSTRAINT PK_tbl_comment_etcmarket PRIMARY KEY(commentNo)
);

create sequence tbl_comment_etcmarket_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    select fk_boardKindNo, subject, regDate, boardName, boardNo
      from
      (
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      union all
      (select fk_boardkindno, subject, regDate, k.boardname, boardNo from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno where status = 1)
      order by regDate desc
      ) V
      where rownum <= 11
     
    select * from tbl_notice
    select * from tbl_comment_etcmarket;
    
    select * from tab;
    
    select * from tbl_comment_good;
    
    select * from tbl_notice;
    
    select * from tbl_comment_board_notice;
    
    create table tbl_comment_board_notice (
        commentNo      NUMBER         NOT NULL,         -- 댓글번호
        fk_boardNo     NUMBER         NOT NULL,         -- 게시글 번호
        fk_memberNo    NUMBER         NOT NULL,         -- 작성회원번호
        cmtContent        VARCHAR2(200)  NOT NULL,      -- 댓글 내용
        regDate        DATE           DEFAULT SYSDATE,  -- 등록일자
        status         NUMBER(1)      DEFAULT 1,        -- 댓글 상태
        writerIp       VARCHAR2(50)   NOT NULL,         -- 작성자IP
        CONSTRAINT PK_tbl_comment_board_notice PRIMARY KEY(commentNo)
    );
    
    create sequence tbl_comment_board_notice_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    select * from tbl_commu_member;
    select * from tbl_member;
    
    select * from tbl_board_notice;
    select * from tbl_boardKind
    
    select fk_boardkindno, subject, readCount, boardname, boardNo, fk_memberNo, categoryName
    from
    (
    (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName from tbl_board_housemarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.categoryNo where status = 1 and fk_commuMemberNo = 1)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName from tbl_board_bookmarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.categoryNo where status = 1 and fk_commuMemberNo = 1)
      union all
      (select b.fk_boardkindno, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName from tbl_board_etcmarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno 
      left join tbl_category c on c.categoryNo = b.categoryNo
      where status = 1 and fk_commuMemberNo = 1)
      )
      order by 1;
      
      select * from tbl_category;
      select * from tbl_board_etcmarket;
      
      select * from tbl_board_humor;


select fk_boardKindNo, subject, readCount, boardName, boardNo, fk_memberNo, categoryName, cmtCount, regDate, upCount, content
from
(
select row_number () over (order by fk_boardKindNo, regDate) as rno, fk_boardKindNo, subject, readCount, boardName, boardNo, fk_memberNo, categoryName, cmtCount, regDate, upCount, content
    from
    (
    (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
    	, (select count(*) from tbl_comment_notice where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
    	, (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
    	from tbl_board_notice b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_council where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_council b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_major where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_major b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_club where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_club b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all 
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_graduate where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_graduate b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo =101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_critic where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_critic b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_study where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_study b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_cert where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_cert b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_emp where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_emp b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_joboffer where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_joboffer b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_lost where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from TBL_BOARD_lost b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_informal where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_informal b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_polite where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_polite b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_humor where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_humor b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_issue where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_issue b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_mbti where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_mbti b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_food where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_food b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_love where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_love b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_hobby where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_hobby b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_health where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_health b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_memberNo, nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_diet where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_diet b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.fk_categoryNo where status = 1 and fk_memberNo = 101 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName , to_char(b.content) as content
      , (select count(*) from tbl_comment_housemarket where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_housemarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.categoryNo where status = 1 and fk_commuMemberNo = 1 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_bookmarket where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_bookmarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno left join tbl_category c on c.categoryNo = b.categoryNo where status = 1 and fk_commuMemberNo = 1 and regDate >= sysdate - 13)
      union all
      
      (select b.fk_boardKindNo, b.subject, b.readCount, k.boardname, b.boardNo, b.fk_commuMemberNo,  nvl(categoryName, '일반') as categoryName, to_char(b.content) as content
      , (select count(*) from tbl_comment_etcmarket where status = 1 and fk_boardNo = b.boardNo) as cmtCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
      , (select count(*) from tbl_board_good where fk_boardKindNo = b.fk_boardKindNo and fk_boardNo = boardNo) as upCount
      from tbl_board_etcmarket b
      join tbl_boardkind k on b.fk_boardkindno = k.boardkindno 
      left join tbl_category c on c.categoryNo = b.categoryNo
      where status = 1 and fk_commuMemberNo = 1 and regDate >= sysdate - 13)
      ) 
      ) w
      where rno between 1 and 10;
      
      desc tbl_notice;
      
      select n.noticeNo, n.fk_boardKindNo, n.fk_memberNo, n.fk_categoryNo
		, n.subject, to_char(n.regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate, n.content, n.readCount, n.status, n.writerIp
		
		, c.categoryName
		
		, m.commuMemberNo, m.fk_levelNo, m.nickname, m.point
		
		, l.levelName, l.levelPoint, l.levelImg
		
		, k.boardTypeNo, k.boardName
		
		, (select count(*) from tbl_comment_board_notice where status = 1 and fk_boardNo = n.noticeNo) as cmtCount
		
		from tbl_notice n join tbl_category c
		on n.fk_categoryNo = c.categoryNo
		join tbl_commu_member m 
		on n.fk_memberNo = m.fk_memberNo
		join tbl_commu_member_level l
		on m.fk_levelNo = l.levelNo
		join tbl_boardkind k
		on n.fk_boardKindNo = k.boardKindNo
		where n.status = 1
		order by fk_boardKindNo;
      
      select *
      from tbl_comment_board_notice;
      
      select * from tab;
      
       desc tbl_member;
       desc TBL_COMMU_MEMBER_LEVEL;
       select *
       from TBL_COMMU_MEMBER;
       
       select *
       from tbl_subject
       order by grade, subssemester;
       
       select *
       from tbl_member;
       
       select *
       from tbl_dept;
       
       select * from tbl_course;
       
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'A', '108', 'NE113');

        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'B', '108', 'NE106');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'B', '108', 'EB103');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'C+', '108', 'AA101');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'B+', '108', 'AA102');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2017', 'B', '108', 'AA105');
       
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'A', '108', 'NE101');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'B+', '108', 'NE119');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'D+', '108', 'NE103');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'A', '108', 'NE116');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'B', '108', 'AC305');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2017', 'B+', '108', 'AB203');
        
        commit;
        -----------------------------------------------------------------------------
        
        delete from tbl_course
        where fk_memberNo = 108
        
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'A', '108', 'NE220');

        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'B', '108', 'NE203');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'B+', '108', 'NE201');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'C+', '108', 'NE202');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'C', '108', 'AC304');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2018', 'A', '108', 'AB201');
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'C+', '108', 'NE255');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'D+', '108', 'NE309');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'A+', '108', 'NE314');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'F', '108', 'NE210');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'A+', '108', 'NE221');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2018', 'B+', '108', 'AB202');
        
        commit;
        ----------------------------------
        
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'B+', '108', 'NE302');

        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'B+', '108', 'NE329');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'B', '108', 'NE334');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'B', '108', 'NE308');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'C+', '108', 'NE335');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2019', 'A', '108', 'AC303');
        
        
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'A', '108', 'NE331');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'A+', '108', 'NE332');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'C+', '108', 'NE333');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'F', '108', 'NE336');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'B', '108', 'NE324');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2019', 'B+', '108', 'AB205');
        
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2020', 'B+', '108', 'NE447');

        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2020', 'B+', '108', 'NE448');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2020', 'B+', '108', 'NE410');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2020', 'A', '108', 'AC302');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '1', '2020', 'C', '108', 'AC301');
       
        
        
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2020', 'A', '108', 'NE419');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2020', 'A+', '108', 'AD401');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2020', 'A', '108', 'AA103');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2020', 'B', '108', 'AA104');
        
        insert into tbl_course(courseno, semester, courseyear, score, fk_memberno, fk_subjectno)
        values(tbl_course_seq.nextval, '2', '2020', 'B+', '108', 'NE421');
        
        commit;
        
        select * from tbl_course;
        
       select * from tab;
       
       select * from TBL_BOARD_ANONYMOUS;
        
        
    select boardNo, fk_boardKindNo, subject, categoryName
      from (
      select row_number() over (order by regDate desc) as rno, boardNo, fk_boardKindNo, subject, '일반' as categoryName from TBL_BOARD_ANONYMOUS
      where status = 1) aa
      where rno between 1 and 6;
      
      
      
      
      
      
      select commuMemberNo, fk_memberNo, fk_levelNo, nickname, point, m.name, m.email
		from tbl_commu_member c
		join
			(select memberno, name, email
			from tbl_member
		) m
		on c.fk_memberNo = m.memberno
        where fk_memberNo = 102
        
        select * from tbl_member;
        select * from tbl_commu_member;
        commit;
        update tbl_commu_member set nickname = null
        where commuMemberNo = 10;
        
        select * from tab;
        
        select * from tbl_message;
        
        select * from tbl_commu_member;
        
        update tbl_commu_member set fk_levelNo = 4 , point = 3999
        where commuMemberNo = 10;
        commit;