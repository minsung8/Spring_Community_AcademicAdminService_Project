<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

tbody > tr > td:nth-child(3), td:nth-child(5) {
	text-align: left;
}

tbody > tr > td:nth-child(3) {
	width: 360px;
}

tbody > tr > td:nth-child(3):hover {
	cursor: pointer;
	font-weight: bold;
}

/* tr:nth-child(even) {
   background-color: #f2f2f2;
} */

li.pageBtn {
   font-size: 15pt;
   display: inline-block;
   width: 32px;
   height: 32px;
   /* border: solid 1px blue; */
}

li.hi:hover {
   background-color: #ebebe0;
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

tbody > tr > td:nth-child(1), td:nth-child(7), td:nth-child(8) {
	width: 70px;
}

tbody > tr > td:nth-child(2){
	width: 90px;
}

tbody > tr > td:nth-child(4){
	text-align: right;
}

button#register {
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

div#tags li.cate:hover {
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


</style>


<script type="text/javascript">

	$(document).ready(function() {
		
		
		if( '${paraMap.searchType}' != '' && '${paraMap.searchWord}' != '') {
			$("select#searchType").val("${paraMap.searchType}");
			$("input#searchWord").val("${paraMap.searchWord}");
		}
		
		
		
		$("div#tags li.cate").click(function() {
        	$(this).siblings().removeClass("active");
        	$(this).addClass("active");
        });
        
		var categoryCheck = "${paraMap.categoryNo}";
		
		
        if (categoryCheck == "" || categoryCheck == null) {
        	
        	$("div#tags li.cate").removeClass("active");
        	$("div#tags li.cate").eq(0).addClass("active");
		} else {
			$("div#tags li.cate").removeClass("active");
        	$("div#tags li.cate[value=${paraMap.categoryNo}]").addClass("active");
		}
        
        
        
        $("#searchWord").keydown(function(event){
        	if (event.keyCode == 13) {
        		goSearch();
        	}
        });
        
        
        $("#superSearch").click(function() {
        	goSearch();
        });
        
        
     
        
        
      
	});// end of $(document).ready(function() {});-------------------------------------

    function marketBoardWrite () {
		
		var frm = document.marketBoardFrm;
		
		frm.action="<%= ctxPath%>/marketAdd.sky";
		frm.method="GET";
		frm.submit();		
    }
	
   
    function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/marketboardList.sky";
		
		frm.submit();
	}// end of function goSearch() {}-----------------------
	
	
	function goview(boardNo) {
		
		var frm = document.marketViewFrm;
		frm.boardNo.value = boardNo;
		frm.action = "<%= request.getContextPath()%>/marketBoardDetail.sky";
		frm.method="GET";
		frm.submit();
		
	}
	
	function allBoardAdminAdd() {
		var frm = document.allBoardAdminAddFrm;
		frm.action="<%= ctxPath%>/allBoardAdminAdd.sky";
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


<div class="container" style="width: 80%;" >
	<h1 align="left">${tableInfo.boardName}</h1>
	<div id="tags">
		<ul class="nav nav-tabs">
		
			<li class="cate" value="0"><a href="<%= ctxPath%>/marketboardList.sky?boardKindNo=${paraMap.boardKindNo}">전체</a></li>
			<c:forEach items="${categoryList}" var="category" varStatus="status">
				
				<li class="cate" value="${category.categoryNo}"><a href="<%= ctxPath%>/marketboardList.sky?boardKindNo=${paraMap.boardKindNo}&categoryNo=${category.categoryNo}">${category.categoryName}</a></li>
				
			</c:forEach>
            
			<li>
				<form name="searchFrm" style="margin-top: 10px;">
		      		<select name="searchType" id="searchType" style="height: 25px;">
		         		<option value="subject">글제목</option>
		         		<option value="nickname">작성자</option>
		      		</select>
		      		<input type="text" name="searchWord" id="searchWord" size="40" style="width:120px;" autocomplete="off" /> 
		      		<input type="text"style="display: none;" />
		      		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
		      		<input type="hidden" name="categoryNo" value="${paraMap.categoryNo}"/>
	      			<button type="button" id="superSearch">검색</button>
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
	                <th>가격</th>
	                <th>작성자</th>
	                <th>작성시간</th>
	                <th>추천</th>
	                <th>조회수</th>
	            </tr>
            </thead>
            <tbody >
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
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                	</c:if>
				                	</td>
						        </c:when>
						        <c:otherwise>
				                	<td onclick="goNotice('${notice.noticeNo}');">${notice.subject}&nbsp;
				                	[<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
				                	<c:if test="${fn:contains(notice.content, '<img src=')}">
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                	</c:if>
				                	</td>
						        
						        </c:otherwise>
						       
							</c:choose>
			           		
		                	<td>0원</td>
		                	<td><img src="<%= ctxPath %>/resources/images/levelimg/${notice.levelImg}" style="width: 15px; height: 15px;" />&nbsp;${notice.nickname}</td>
		                	<td>
                            <c:if test="${fn:contains(notice.regDate, '분 전')}"><span style="color:blue;">${notice.regDate}</span></c:if>
                            <c:if test="${not fn:contains(notice.regDate, '분 전')}">${notice.regDate}</c:if>
                         </td>
		                	<td>/</td>
		                	<td>${notice.readCount}</td>
		            	</tr>
	            	
	            	</c:forEach>	            
	            </c:if>
            
            
            	
	            <c:if test="${empty boardList}">
            		<tr>
	                	<td colspan="8"><span>작성된 글이 없습니다!</span></td>
	            	</tr>
	            </c:if>
	            <c:if test="${not empty boardList}">
	            	<c:forEach items="${boardList}" var="marketBoard" varStatus="status">
	            	
		            	<tr>
		                	<td>${marketBoard.boardNo}</td>
		                	<td>${marketBoard.categoryName}</td>
			         
		           			<c:choose>
						        <c:when test="${fn:length(marketBoard.subject) > 20}">
				                	<td onclick="goview('${marketBoard.boardNo}')">${fn:substring(marketBoard.subject, 0, 20)}...&nbsp;
				                	 [<span style="color:#0841ad; font-weight: bold; ">${marketBoard.cmtCount}</span>]
				                	<c:if test="${fn:contains(marketBoard.content, '<img src=')}">
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                		</c:if>
				                	</td>
						        </c:when>
						        <c:otherwise>
				                	<td onclick="goview('${marketBoard.boardNo}')">${marketBoard.subject}&nbsp;
				                	 [<span style="color:#0841ad; font-weight: bold; ">${marketBoard.cmtCount}</span>]
				                	<c:if test="${fn:contains(marketBoard.content, '<img src=')}">
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                	</c:if>
				                	</td>
						        
						        </c:otherwise>
						       
							</c:choose>
			           		
			           		
			           		
		                	<td><fmt:formatNumber value="${marketBoard.price}" pattern="#,###" />원</td>
		                	<td><img src="<%= ctxPath %>/resources/images/levelimg/${marketBoard.levelImg}" style="width: 15px; height: 15px;" />&nbsp;${marketBoard.nickname}</td>
		                	<td>
                            <c:if test="${fn:contains(marketBoard.regDate, '분 전')}"><span style="color:blue;">${marketBoard.regDate}</span></c:if>
                            <c:if test="${not fn:contains(marketBoard.regDate, '분 전')}">${marketBoard.regDate}</c:if>
                         	</td>
		                	<td>${marketBoard.upCount}</td>
		                	<td>${marketBoard.readCount}</td>
		            	</tr>
	            	
	            	
		      
	            	</c:forEach>	            
	            </c:if>
            
            </tbody>
		</table>
	</div>
	<br>
	<div id="pager-div">
		${pageBar}
	</div>
	<div align="right">
		<c:choose>
			<c:when test="${sessionScope.loginuser.fk_memberNo == 0}">
				<button id="marketBoardWrite" onclick="allBoardAdminAdd();">공지쓰기</button>
			</c:when>
			<c:otherwise>
				<button id="marketBoardWrite" onclick="marketBoardWrite();">글쓰기</button>			
			</c:otherwise>
		</c:choose>
		
		
	</div>
	<form name="marketBoardFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
		<input type="hidden" name="categoryNo" value="${paraMap.categoryNo}"/>
	</form>
	
	
	<form name="marketViewFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
		<input type="hidden" name="boardNo" />
		<input type="hidden" name="gobackURL2" value="${gobackURL2}" />
	</form>
	
	<form name="allBoardAdminAddFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
	</form>
	
	<form name="notificationFrm">
		<input type="hidden" name="boardKindNo" value="${paraMap.boardKindNo}" />
		<input type="hidden" name="noticeNo" />
		<input type="hidden" name="gobackURL2" value="${gobackURL2}" />
	</form>
	
	
	<br>
</div>
    