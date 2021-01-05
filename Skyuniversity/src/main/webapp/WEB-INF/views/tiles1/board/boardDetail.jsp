<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	 tbody > tr > td {
	 	text-align : left;
	 }

	table
	 {border: solid gray 1px;
	 margin-bottom : 5%;}
	 
	 div.form-group{
	 border: solid gray 1px;
	 }
	 
	 form#form-group {
	 	width : 100%;
	 }
	
	textarea#main {
		width : 100%;
		height : 250px;
	}
	
	textarea#reply {
		width : 30%;
		height : 25px;
	}
	
	div.content1{
		float : left;
		width: 60%;
		height: 600px;
		border: solid gray 1px;
	 	margin-bottom : 5%;
	 	margin-left : 15%;
	}
	
	div.content2 {
		float : left;
		width: 60%;
		height: 700px;
		border: solid gray 1px;
	 	margin-bottom : 5%;
	 	margin-left : 15%;
	}
	
	
	
	table#contentTable {
		margin-top : 5%;
		margin-bottom : 1%;
		width: 100%;
	}
	
	#contentTable2 {
		margin-top : 5%;
		margin-bottom : 1%;
		width: 80%;
	}
	
	div#sideBar {
		float : right;
		width: 15%;
		border: solid gray 1px;
		margin-right : 7%;
		margin-bottom : 1%;
		
	}
	
	div#include {
		border: solid gray 1px;
		display: inline-block;
		width: 80%;
	}
	
	p3 {
		width : 100%;
	}
	
	div#buttons1 {
		width : 30%;
	}
	
	div#buttons2 {
		float : right;
	}
	
	input#commentContent {
		width : 30%;
	}

	div#replyButtons {
		float : right;
	}
	
	button {
      width: 60px;
      height: 30px;
      margin: 0 5px;
      border-radius: 5%;
      border: none;
      background-color: #0841ad;
      color: white;
   }
   
   button:hover {
      font-weight: bold;
   }
   
   	button#goback {
		float : right;
		width: 80px;
	}
	
	table.form-group {
		width : 100%;
	}
	
	#fileAttach {
		float : left;
	}	
			
</style>

<script type="text/javascript"></script>

<body>
	<div class="content1">
		<div class="contents" class="form-group">
			<h1>글제목 <span>[카테고리]</span></h1>
			<h4><span>유저 : 유저 1</span>ㅣ<span>조회수 : 230</span>ㅣ<span>작성시간 : 2020-12-24 12:23:10</span>ㅣ<span>수정시간 : 2020-12-24 12:23:10 </span></h4>
			<form action="" id="replycontent" >
				<textarea id="main">글 내용을 입력하세요~ </textarea>
			</form>
		</div>
		
		<div id="buttons1">
			<button>추천</button>
			<button>반대</button>
			<button>신고</button>
		</div>
		
		<div id="buttons2">
			<button>수정</button>
			<button>삭제</button>
		</div>
	</div>
	
	<div id="sideBar">
	
		게시판 1
		<table>
			<tr>
				<td>신규글</td>
				<td>인기글</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
		</table>
	</div>
<div id="sideBar">
		게시판 1
		<table>
			<tr>
				<td>신규글</td>
				<td>인기글</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
		</table>
	</div>
<div id="sideBar">
		게시판 1
		<table>
			<tr>
				<td>신규글</td>
				<td>인기글</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
			<tr>
				<td colspan="2">제목1</td>
			</tr>
		</table>
	</div>
	
	<div class="content2">
		
		<div id="reply">
			<h3 style="margin-top: 50px;">댓글쓰기 &nbsp;&nbsp; <span>로그인유저 ID</span></h3>
			<form name="add	WriteFrm" style="margin-top: 20px;" class="form-group">
				 
				댓글내용 : <textarea id="reply">글 내용을 입력하세요~   </textarea>
				
				<button id="btnComment" type="button" onclick="goAddWrite()">확인</button> 
			</form>
		</div>
	
		<table id="contentTable2">
				<tr>
					<td>유저2&nbsp;&nbsp;2020-12-11 08:00:20(댓글 작성 시간)&nbsp;&nbsp;&nbsp;&nbsp; <div id="replyButtons"></a><button>추천</button>&nbsp;&nbsp;<button>반대</button>&nbsp;&nbsp;<button>신고</button></div></td>
				</tr>
				<tr>
					<td>~~~~~~ 댓글내용 ~~~~~</td>
				</tr>
				<tr>
					<td>유저2&nbsp;&nbsp;2020-12-11 08:00:20(댓글 작성 시간)&nbsp;&nbsp;&nbsp;&nbsp; <div id="replyButtons"></a><button>추천</button>&nbsp;&nbsp;<button>반대</button>&nbsp;&nbsp;<button>신고</button></div></td>
				</tr>
				<tr>
					<td>~~~~~~ 댓글내용 ~~~~~</td>
				</tr>
				<tr>
					<td>유저2&nbsp;&nbsp;2020-12-11 08:00:20(댓글 작성 시간)&nbsp;&nbsp;&nbsp;&nbsp; <div id="replyButtons"></a><button>추천</button>&nbsp;&nbsp;<button>반대</button>&nbsp;&nbsp;<button>신고</button></div></td>
				</tr>
				<tr>
					<td>~~~~~~ 댓글내용 ~~~~~</td>
				</tr>
				<tr>
					<td>유저2&nbsp;&nbsp;2020-12-11 08:00:20(댓글 작성 시간)&nbsp;&nbsp;&nbsp;&nbsp; <div id="replyButtons"></a><button>추천</button>&nbsp;&nbsp;<button>반대</button>&nbsp;&nbsp;<button>신고</button></div></td>
				</tr>
				<tr>
					<td>~~~~~~ 댓글내용 ~~~~~</td>
				</tr>			
		</table>
		<h4>더보기...</h4>
		<button id="goback">목록으로</button>
		
	</div>
	
	
	
	<div id="include">
		<jsp:include page="boardList.jsp" />
	</div>


</body>
</html>