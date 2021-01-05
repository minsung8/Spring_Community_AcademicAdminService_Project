<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath = request.getContextPath();
%>
<style type="text/css">
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 80%;
	/*  border: 1px solid #ddd; */
}

th, td {
	text-align: center;
	padding: 8px;
	border: 1px solid #ddd;
}

thead {
	background-color: #0841ad;
	font-size: 10pt;
	color: white;
}

tbody {
	font-size: 10pt;
}

tbody>tr>td:nth-child(3), td:nth-child(4) {
	text-align: left;
}

tbody>tr>td:nth-child(3) {
	width: 400px;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

li.pageBtn {
	font-size: 15pt;
	display: inline-block;
	width: 32px;
	height: 32px;
	/* border: solid 1px blue; */
}

li.pageBtn:hover {
	background-color: #ebebe0;
	cursor: pointer;
}

ul.nav>li:last-child {
	float: right;
}

button#searchBtn {
	background-color: #ebebe0;
	border: none;
}

ul.pager {
	margin-bottom: 50px;
}

tbody>tr>td:nth-child(1), td:nth-child(2), td:nth-child(6), td:nth-child(7)
	{
	width: 70px;
}

.subjectStyle {
	font-weight: bold;
	color: navy;
	cursor: pointer;
}

tr.notification {
   
   background-color: rgba(8,65,173,0.2);
}

tr.notification td:nth-child(3):hover{
   
   font-weight: normal;
}
tr.notification td {
   font-weight: bold;
}

img.photo {
	width: 18px;
	height: 18px;
}
</style>


<script type="text/javascript">

   $(document).ready(function() {
	   
 	   $("button#register").click(function() {
		   goWrite();
	   });
       
		$("div#tags li").click(function() {
		   $(this).siblings().removeClass("active");
		   $(this).addClass("active");
		});
     
		$("a.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		
		$("a.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13) {
				// 엔터를 했을 경우 
				goSearch();
			}
		});
		

      
   });// end of $(document).ready(function() {});-------------------------------------

	function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%=request.getContextPath()%>/minsungBoardList.sky";
		frm.submit();
	}// end of function goSearch() {}-----------------------
	
	function goView(boardNo) {
		
		var frm = document.goViewFrm;
		frm.boardNo.value = boardNo;
		frm.method = "GET";
		frm.action = "<%=request.getContextPath()%>/minsungBoardView.sky";
		frm.submit();
	}
	
	function goWrite() {
		var frm = document.registerFrm;
		frm.method = "GET";
		frm.action = "<%=request.getContextPath()%>/minsungAdd.sky";
		frm.submit();
	}
	
	function allBoardAdminAdd() {
	      var frm = document.allBoardAdminAddFrm;
	      frm.action="<%=request.getContextPath()%>/allBoardAdminAdd.sky";
	      frm.method="POST";
	      frm.submit();   
	   }
	
	function goNotice(noticeNo) {
	      var frm = document.notificationFrm;
	      frm.noticeNo.value = noticeNo;
	      frm.action = "<%= request.getContextPath()%>/notificationDetail.sky";
	      frm.method="GET";
	      frm.submit();
	      
	   } 
</script>
</head>


<div class="container" style="width: 80%;">
	<h1 align="left">${kindBoard}</h1>
	<div id="tags">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#">전체</a></li>
			<c:forEach var="categoryvo" items="${categoryList}">

				<li><a href="#">${categoryvo.categoryName}</a></li>

			</c:forEach>
			<li>
				<form name="searchFrm" style="margin-top: 10px;">
					<select name="searchType" id="searchType" style="height: 25px;">
						<option value="subject">글제목</option>
						<option value="nickname">작성자</option>
					</select> 
					<input type="text" name="searchWord" id="searchWord" size="40" style="width: 120px;" autocomplete="off" />
					<button type="button" onclick="goSearch()">검색</button>
				</form>
			</li>
		</ul>
	</div>
	<div style="overflow-x: auto; width: 100%;">
		<table style="width: 100%;">
			<thead>
				<tr>
					<th>글번호</th>
					<th>분류</th>
					<th>글제목</th>
					<th>작성자</th>
					<th>작성시간</th>
					<th>추천</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>

			<c:if test="${not empty noticeList}">
				<c:forEach items="${noticeList}" var="notice" varStatus="status">
                  
                     <tr class="notification">
                         <td>${notice.noticeNo}</td>
                         <td>${notice.categoryName}</td>
                  
                          <c:choose>
                          <c:when test="${fn:length(notice.subject) > 20}">
                               <td onclick="goNotice('${notice.noticeNo}');">${fn:substring(notice.subject, 0, 20)}...&nbsp;
                               [<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
                               <c:if test="${fn:contains(notice.content, '<img src=')}">
                               <img src="<%=request.getContextPath()%>/resources/images/sehyeong/disk.gif" >
                            	</c:if>
                               </td>
                          </c:when>
                          <c:otherwise>
                               <td onclick="goNotice('${notice.noticeNo}');">${notice.subject}&nbsp;
                               <c:if test="${fn:contains(notice.content, '<img src=')}">
                               <img src="<%=request.getContextPath()%>/resources/images/sehyeong/disk.gif" >
                            </c:if>
                               </td>
                          
                          </c:otherwise>
                         
                     </c:choose>
                          
                         <td><img src="<%=request.getContextPath()%>/resources/images/levelimg/${notice.levelImg}" style="width: 15px; height: 15px;" />&nbsp;${notice.nickname}</td>
                         <td>${notice.regDate}</td>
                         <td>/</td>
                         <td>${notice.readCount}</td>
                     </tr>
                  
                  </c:forEach>               
               </c:if>
				
				<c:if test="${not empty boardList}">
				<c:forEach var="boardvo" items="${boardList}">
					<tr class="board">
						<td class="boardNo">${boardvo.boardNo}</td>
						<td>${boardvo.fk_categoryName}</td>
						<td><a class="subject" style="cursor:pointer" onclick="goView('${boardvo.boardNo}')">${boardvo.subject}</a>
						[<span style="color:#0841ad; font-weight: bold; ">${boardvo.cmtCount}</span>]
		                		<c:if test="${fn:contains(boardvo.content, '<img src=')}"><img src="/skyuniversity/resources/images/picture.png" class="photo"></c:if>
						</td>
		                <td class="left"><img src="<%= request.getContextPath()%>/resources/images/levelimg/${boardvo.levelImg}" class="photo" />${boardvo.fk_nickname}</td>
						<td>${boardvo.regDate}</td>
						<td>
	                		<c:if test="${empty boardvo.upCount}">
	                			0
	                		</c:if>
	                		<c:if test="${not empty boardvo.upCount}">
								${boardvo.upCount}
	                		</c:if>
	                	</td>
						<td>${boardvo.readCount}</td>
						
					</tr>
				</c:forEach>
				</c:if>
				
				<c:if test="${empty boardList}">
					<tr>
            			<td colspan="7" style="color: red; font-size: 30pt; font-weight: bold; height: 500px;">게시물이 없습니다.</td>
            		</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	
	<div align="right"><button id="register" onclick="<%=request.getContextPath()%>/minsungAdd.sky">글쓰기</button></div>
	<c:if test="${sessionScope.loginuser.fk_memberNo == 0}">
		<div align="right">
		    <button style="text-align : right;" id="marketBoardWrite" onclick="allBoardAdminAdd();">공지쓰기</button>
		</div>
	</c:if>
	<c:if test="${not empty boardList}">
		<div align="center"
			style="width: 70%; border: solid 0px gray; margin: 20px auto;">
			${pageBar}</div>
	</c:if>

	<form name="goViewFrm">
	    <input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
		<input type="hidden" id="goViewBoardNo" name="boardNo" value="" /> 
		<input type="hidden" name="gobackURL" value="${gobackURL}" />
	</form>
	<form name="registerFrm">
	    <input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
	</form>
	
	<form name="allBoardAdminAddFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
	</form>
	
	<form name="notificationFrm">
      <input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
      <input type="hidden" name="noticeNo" />
      <input type="hidden" name="gobackURL2" value="${gobackURL}" />
   </form>


</div>
