<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String ctxPath = request.getContextPath();
%>

<style>

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




table.board-body {
	/* border: solid 1px black; */
	width: 100%;
	min-height: 30%;
	text-align: center;
	vertical-align: middle;
	
	
}

thead.board-body-header {
	border-bottom: 1px solid #0843ad;
	
	
}

thead.board-body-header th:first-child{
	width: 30%;
	text-align: left;
	padding: 5px;
	padding-left: 10px;
	/* border: 1px red solid; */
}

thead.board-body-header th:last-child{
	width: 69%;
	text-align: left;
	padding: 5px;
	padding-left: 10px;
	/* border: 1px red solid; */
}

.hot thead.board-body-header th:first-child{
	width: 40%;
	text-align: left;
	padding: 5px;
	padding-left: 10px;
	/* border: 1px red solid; */
}

.hot thead.board-body-header th:last-child{
	width: 59%;
	padding: 5px;
	text-align: left;
	/* border: 1px red solid; */
}


.board-body tbody tr>td{
	text-align: left;
	padding: 3px;
	padding-left: 10px;
}

</style>
<script type="text/javascript">
	$(document).ready(function(){
		autoSlide();
		
		$(".board-body tr").click(function(){
			
			
			
			var frm = document.indexViewForm;
			var boardKindNo = Number($(this).find(".boardKindNo").text());
			
			
			if (boardKindNo <= 6 || (18 <= boardKindNo && boardKindNo <= 22)) {
				frm.action = "<%= ctxPath%>/minsungBoardView.sky";
			} else if (23 <= boardKindNo){
				frm.action = "<%= ctxPath%>/marketBoardDetail.sky";
			} else if (boardKindNo != 7){
	          frm.action = "<%=request.getContextPath()%>/boardDetail.sky";
	       } else{
	          frm.action = "<%=request.getContextPath()%>/boardDetail2.sky";
	       }

			
			frm.boardKindNo.value = boardKindNo;
			frm.boardNo.value = $(this).find(".boardNo").text();
			frm.method = "GET";
			frm.submit();
			
			
			
		});
		
		
	});
	
	var index = 0;
	
	function autoSlide() {
		var slides = $(".caro");
		var dots = $(".dot");
		
		
		slides.each(function(index, item) {
			item.style.display = "none";
		});
		
		index++;
		
		if (index > slides.length) {
			index = 1
		}
		
		for (var i = 0; i < dots.length; i++) {
	        dots[i].className = dots[i].className.replace(" sehyeong", "");
	    }
		
		slides[index-1].style.display = "block";
		dots[index-1].className += " sehyeong";
		setTimeout("autoSlide()", 5000); // Change image every 2 seconds
	} 
	
	
	function showSlides(n) {
	    var slides = $(".caro");
	    var dots = $(".dot");
	  
	    index = n;
	    
	    if (n > slides.length) {
			slideIndex = 0;
		}
	    
	    if (n < 1) {
	    	slideIndex = slides.length
	    }
	    
	    slides.each(function(index, item) {
	    	item.style.display = "none";
	    });
	    
	    for (i = 0; i < dots.length; i++) {
	        dots[i].className = dots[i].className.replace(" sehyeong", "");
	    }
	    
	    slides[n].style.display = "block";
	    dots[n].className += " sehyeong";

	}
	
	function openWin(url){  
	    window.open(url, "_blank");  
	}  

	
	
</script>

<div id="index-div">
	<div id="index-div-content">
	
		<div id="index-show-board">
			<div class="row">
  				<div class="column">
    				<div class="index-board hot">
    					<div class="board-header"> 
    						<span style="font-weight: bold; font-size: 15pt;">최근 게시물</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>게시판</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${recentBoardList}" var="recent">
    								<tr>
    									<td>${recent.boardName}</td>
    									<c:choose>
										        <c:when test="${fn:length(recent.subject) > 16}">
								                	<td>${fn:substring(recent.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${recent.subject}</td>
										        </c:otherwise>
											</c:choose>
    									<td style="display: none;" class="boardNo">${recent.boardNo}</td>
    									<td style="display: none;" class="boardKindNo">${recent.fk_boardKindNo}</td>

    								</tr>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board hot">
    					<div class="board-header"> 
    						<span style="font-weight: bold; font-size: 15pt;">주간 베스트 게시물</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>게시판</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${bestBoardList}" var="best">
    								<tr>
    									<td>${best.boardName}</td>
    									<c:choose>
										        <c:when test="${fn:length(best.subject) > 16}">
								                	<td>${fn:substring(best.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${best.subject}</td>
										        </c:otherwise>
											</c:choose>
    									<td style="display: none;" class="boardNo">${best.boardNo}</td>
    									<td style="display: none;" class="boardKindNo">${best.fk_boardKindNo}</td>

    								</tr>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board hot">
    					<div class="board-header"> 
    						<span style="font-weight: bold; font-size: 15pt;">인기 게시물</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>게시판</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${popularBoardList}" var="popular">
    								<tr>
    									<td>${popular.boardName}</td>
    									<c:choose>
										        <c:when test="${fn:length(popular.subject) > 16}">
								                	<td>${fn:substring(popular.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${popular.subject}</td>
										        </c:otherwise>
											</c:choose>
    									<td style="display: none;" class="boardNo">${popular.boardNo}</td>
    									<td style="display: none;" class="boardKindNo">${popular.fk_boardKindNo}</td>
    								</tr>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
			</div>
			
			<c:if test="${not empty bannerList}">
				<div id="index-show-carousel" class="column">
					<a style="cursor: pointer;">
					<c:forEach items="${bannerList}" var="banner">
						<img class="caro" src="/skyuniversity/resources/images/${banner.iname}" onclick="openWin('${banner.ilink}')" />
					</c:forEach>
						
					</a>
					<div style="text-align: center">
						<c:forEach items="${bannerList}" varStatus="status">
							<span class="dot" onclick="showSlides(${status.index})"></span>
						</c:forEach>
					</div>
				</div>
				
			</c:if>
			
			
			<div class="row">
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=8'">자유 게시판(반말)</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>카테고리</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == '8'}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/boardDetail2.sky?boardKindNo=7'">익명게시판</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>카테고리</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == 7}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=10'">유머 게시판</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>게시판</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == 10}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
			</div>
			
			<div class="row">
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=23'">복덕방 게시판</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>카테고리</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == 23}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=24'">중고서적</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>카테고리</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == 24}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
  				<div class="column">
    				<div class="index-board">
    					<div class="board-header"> 
    						<span class="board-title" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=25'">중고 거래</span>
    					</div>
    					<table class="board-body">
    						<thead class="board-body-header">
    							<tr>
    								<th>카테고리</th>
    								<th>글 제목</th>
    							</tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${indexBoardList}" var="index">
    								<c:if test="${index.fk_boardKindNo == 25}">
	    								<tr>
	    									<td>${index.categoryName}</td>
	    									<c:choose>
										        <c:when test="${fn:length(index.subject) > 16}">
								                	<td>${fn:substring(index.subject, 0, 16)}...</td>
										        </c:when>
										        <c:otherwise>
								                	<td>${index.subject}</td>
										        </c:otherwise>
											</c:choose>
	    									
	    									
	    									<td style="display: none;" class="boardNo">${index.boardNo}</td>
    										<td style="display: none;" class="boardKindNo">${index.fk_boardKindNo}</td>
	    								</tr>
    								</c:if>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
  				</div>
			</div>
			
	<form name="indexViewForm">
		<input type="hidden" name="boardKindNo" />
		<input type="hidden" name="boardNo" />
	</form>
		</div>

	</div>

</div>



    				