<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%  String ctxPath = request.getContextPath(); %>
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

td.left {
	text-align: left;
}

th.wide {
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
   margin: 0 5px;
}

li.pageBtn:hover {
   cursor: pointer;
} 

ul.nav > li:last-child {
	float: right;
}

button#searchBtn {
	background-color: #ebebe0;
	border: none;
}

ul.pager {
	margin-bottom: 50px;
}

th.narrow {
	width: 75px;
}

button.btn {
	width: 80px;
	height: 30px;
	border-radius: 5%;
	border: none;
	background-color: #0841ad;
	color: white;
	margin-top: 20px;
} 

button:hover {
	font-weight: bold;
}

tr.board:hover {
	cursor: pointer;
	background-color: #a8d2fe;
	font-weight: bold;
}

tr.notification:hover {
	cursor: pointer;
	background-color: #a8d2fe;
}

img.photo {
	width: 18px;
	height: 18px;
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

</style>


<script type="text/javascript">

   	$(document).ready(function() {
      
   		// 선택한 카테고리(분류)에 active css가 적용되어 있도록 한다.
   		$("div#tags .selectCategory").each(function(index,item) {
			if ($(this).val() == "${paraMap.categoryNo}") {
				$(this).siblings().removeClass("active");
	        	$(this).addClass("active");	
			}
		});

   		// 글쓰기 버튼을 누르면 파라미터 값으로 게시판 번호를 가지고 작성 페이지로 넘어간다.
      	$("button#register").click(function() {
      		if ("${paraMap.boardKindNo}" != "7") {
	      		location.href="<%= request.getContextPath()%>/boardRegister.sky?boardKindNo=${paraMap.boardKindNo}";
			}else{
	      		location.href="<%= request.getContextPath()%>/boardRegister2.sky";
			}
      	});

   		// 각 게시물을 누르면 해당 게시물의 상세 페이지로 넘어간다.
   		$("tr.board").click(function() {
   			var boardNo = $(this).children("td.boardNo").text();
   			$("input[name=boardNo]").val(boardNo);
   			
   			var frm = document.urlFrm;
   			frm.method = "get";
   			if ("${paraMap.boardKindNo}" != "7") {
	   			frm.action = "<%= request.getContextPath()%>/boardDetail.sky"; 
			}else{
	   			frm.action = "<%= request.getContextPath()%>/boardDetail2.sky"; 
			}
   			frm.submit();
		});
       
       
   	});// end of $(document).ready(function() {});-------------------------------------

   	// 검색 버튼을 누르면 list 페이지로 searchType과 searchWord를 보낸다.
	function goSearch() {
		
		var frm = document.searchFrm;
		frm.action = "<%= request.getContextPath()%>/boardList.sky";
		frm.method = "GET";
		frm.submit();
		 
	}// end of function goSearch() {}-------------------------------
	
	// 공지쓰기를 누르면 공지쓰기 요청 들어감.
	function allBoardAdminAdd() {
	      var frm = document.allBoardAdminAddFrm;
	      frm.action="<%= request.getContextPath()%>/allBoardAdminAdd.sky";
	      frm.method="POST";
	      frm.submit();   
	}// end of function allBoardAdminAdd() {}----------------------

	// 공지글 하나를 누르면 해당 글 상세 페이지로 넘어감.
	function goNotice(noticeNo) {
	      var frm = document.notificationFrm;
	      frm.noticeNo.value = noticeNo;
	      frm.action = "<%= request.getContextPath()%>/notificationDetail.sky";
	      frm.method="GET";
	      frm.submit();
	}// end of function goNotice(noticeNo) {}-----------------------
	
</script>
</head>


<div class="container" style="width: 80%;">
	<h1 align="left">${paraMap.boardName}</h1>
	<div id="tags">
		<ul class="nav nav-tabs">
			<c:if test="${not empty cateList}">
            	<li class="selectCategory" value="0"><a href="boardList.sky?boardKindNo=${paraMap.boardKindNo}&categoryNo=0">전체</a></li>
            	<c:forEach var="category" items="${cateList}">
            		<li class="selectCategory" value="${category.categoryNo}"><a href="boardList.sky?boardKindNo=${paraMap.boardKindNo}&categoryNo=${category.categoryNo}">${category.categoryName}</a></li>
            	</c:forEach>
			</c:if>
			<li>
				<form name="searchFrm" style="margin-top: 10px;">
		      		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}"/> 
		      		<input type="hidden" name="categoryNo" value="${paraMap.categoryNo}"/> 
		      		<select name="searchType" id="searchType" style="height: 25px;">
		         		<option value="subject">글제목</option>
		         		<option value="nickname">작성자</option>
		      		</select>
		      		<input type="text" name="searchWord" id="searchWord" size="40" style="width:120px;" autocomplete="off" /> 
	      			<button type="button" onclick="goSearch()">검색</button>
   				</form>
			</li>
		</ul>
	</div>
	<div style="overflow-x: auto; width: 100%;">
		<table style="width: 100%;">
            <thead>
	            <tr>
	                <th class="narrow">글번호</th>
	                <c:if test="${not empty cateList}">
	                	<th class="narrow">분류</th>
	                </c:if>
	                <th class="wide">글제목</th>
	                <th>작성자</th>
	                <th>작성시간</th>
	                <th class="narrow">추천</th>
	                <th class="narrow">조회수</th>
	            </tr>
            </thead>
            <tbody>
            	<c:if test="${not empty noticeList}">
                  <c:forEach items="${noticeList}" var="notice" varStatus="status">
                  
                     <tr class="notification">
                         <td>${notice.noticeNo}</td>
                         <c:if test="${not empty cateList}">
                         	<td>${notice.categoryName}</td>
                  		 </c:if>
                         <c:choose>
                         <c:when test="${fn:length(notice.subject) > 20}">
                               <td class="left" onclick="goNotice('${notice.noticeNo}');">${fn:substring(notice.subject, 0, 20)}...&nbsp;
                               [<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
                               <c:if test="${fn:contains(notice.content, '<img src=')}"><img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" ></c:if>
                               </td>
                          </c:when>
                          <c:otherwise>
                               <td class="left" onclick="goNotice('${notice.noticeNo}');">${notice.subject}&nbsp;
                               [<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
                               <c:if test="${fn:contains(notice.content, '<img src=')}"><img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" ></c:if>
                               </td>
                          </c:otherwise>
                         
                     </c:choose>
                          
                         <td class="left"><img src="<%= ctxPath %>/resources/images/levelimg/${notice.levelImg}" style="width: 15px; height: 15px;" />&nbsp;${notice.nickname}</td>
                         <td>${notice.regDate}</td>
                         <td>/</td>
                         <td>${notice.readCount}</td>
                     </tr>
                  
                  </c:forEach>               
                </c:if>
            	<c:if test="${not empty boardList}">
	            	<c:forEach var="board" items="${boardList}" varStatus="status">
		            	<tr class="board">
		                	<td class="boardNo">${board.boardNo}</td>
		                	<c:if test="${board.fk_categoryName ne null}">
		                		<td>${board.fk_categoryName}</td>
		                	</c:if>
		                	<td class="left"> 
		                		${board.subject}
		                		[<span style="color:#0841ad; font-weight: bold; ">${board.cmtCount}</span>]
		                		<c:if test="${fn:contains(board.content, '<img src=')}"><img src="/skyuniversity/resources/images/picture.png" class="photo"></c:if>
		                	</td>
		                	<td class="left">
		                		<c:if test="${not empty board.levelImg}"><img src="<%= request.getContextPath()%>/resources/images/levelimg/${board.levelImg}" class="photo" /></c:if>
		                		${board.fk_nickname}
		                	</td>
		                	<td>
		                		<c:if test="${fn:contains(board.regDate, '분 전')}"><span style="color:blue;">${board.regDate}</span></c:if>
		                		<c:if test="${not fn:contains(board.regDate, '분 전')}">${board.regDate}</c:if>
		                	</td>
		                	<td>
		                		<c:if test="${empty board.upCount}">
		                			0
		                		</c:if>
		                		<c:if test="${not empty board.upCount}">
			                		${board.upCount}
		                		</c:if>
		                	</td>
		                	<td>${board.readCount}</td>
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

	<form name="allBoardAdminAddFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
    </form>
    <form name="notificationFrm">
        <input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
        <input type="hidden" name="noticeNo" />
        <input type="hidden" name="gobackURL2" value="${gobackURL}" />
    </form>
	<div align="right">
        <c:if test="${sessionScope.loginuser.fk_memberNo == 0}">
            <button class="btn" id="marketBoardWrite" onclick="allBoardAdminAdd();">공지쓰기</button>
		</c:if>
		<button class="btn" id="register">글쓰기</button>
	</div>
	
	${pageBar}

	<form name="urlFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}"/>
		<input type="hidden" name="boardNo" value=""/>
		<input type="hidden" name="gobackURL" value="${gobackURL}"/>
	</form>	
</div>
    