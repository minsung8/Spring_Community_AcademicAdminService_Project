<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
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


tbody > tr > td:nth-child(3) {
	padding-left: 20px;
	width: 470px;
	text-align: left;
	cursor: pointer;
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

tbody > tr > td:nth-child(1), td:nth-child(2), td:nth-child(5), td:nth-child(6) {
	width: 80px;
}
tbody > tr > td:nth-child(1) {
	width: 150px;
}



button:hover {
	font-weight: bold;
}

</style>

<script type="text/javascript">
	var lenBoardList = 20;
	
	
	$(document).ready(function(){
		
		
		$("select#orderType").change(function(){
			var selectedOption = $(this).val();
			
			
			if (selectedOption != "") {
				
				$("tbody#displayAllNotice").empty();
				displayNoticeList (selectedOption);
				
			} else {
				
			}
		});
		
	});
	
	
	function displayNoticeList (colName) {
		
		$.ajax({
			url:"<%= ctxPath%>/displayNoticeListJSON.sky",
			type:"GET",
			data:{"colName": colName},  // 20
			dataType:"JSON",
			success:function(json){
				html = "";
				
				if(json.length == 0) {
        			// 처음부터 데이터가 존재하지 않는 경우
		    		// !!! 주의 !!!
		    		// if(json == null) 이 아님!!!
		    		// if(json.length == 0) 으로 해야함!!
		    		html += "<tr><td colspan='6' style='font-size: 15pt;'>글을 쓴것이 없구마잉...</td></tr>";
			
		    		// HIT 상품 결과를 출력하기
		    		$("tbody#displayAllNotice").html(html);
        		}
				else if(json.length > 0) {
					
					// 제이쿼리 내의 반복문 $.each(json, function(index, item){});
					$.each(json, function(index, item){
						
						html +=  "<tr>" +
		                	"<td>" + item.boardName + "</td>" + 
		                	"<td>" + item.categoryName + "</td>";
		                	
	                	var subject = item.subject;
	                	if (subject.length > 20) {
	                		subject = subject.substr(0,20);
	                	} 
	                	
	                	html += "<td onclick='goNotice(" + item.fk_boardKindNo + ", " + item.noticeNo + ");'>" + subject + "...&nbsp;" +
	                		"[<span style='color:#0841ad; font-weight: bold;'>" + item.cmtCount + "</span>]";
	                	
	                	
	                	var content = item.content;
		                
	                	if (content.indexOf("<img src=") != -1) {
	                		html += "&nbsp;&nbsp;<img src='/skyuniversity/resources/images/sehyeong/disk.gif'>";
	                	}
		                	
	                	
	                	
		                html += "<td>" + item.regDate + "</td>" + 
		                	"<td>" + item.readCount + "</td>" + 
		                	"<td><button onclick='deleteNoticeGoGo(" + item.fk_boardKindNo + ", " + item.noticeNo + ");''>삭제</button></td>" + 
		                	"</tr>";
		                	
					});
					
					$("tbody#displayAllNotice").append(html);
					
				} 
			},
			error: function(request, status, error){
	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        } 
		});
	}
	
	function goNotice(fk_boardKindNo, noticeNo) {
		var frm = document.notificationFrm;
		frm.noticeNo.value = noticeNo;
		frm.boardKindNo.value = fk_boardKindNo;
		
		frm.action = "<%= request.getContextPath()%>/notificationDetail.sky";
		
		frm.method="GET";
		frm.submit();
		
	}
	function deleteNoticeGoGo(fk_boardKindNo, noticeNo) {
		
		$.ajax({
			url:"<%= ctxPath%>/deleteNoticeJSON.sky",
			type:"GET",
			data:{"noticeNo": noticeNo,
				"boardKindNo":fk_boardKindNo},  // 20
			dataType:"JSON",
			success:function(json){
				html = "";
				
				if(json.n == 0) {
        			alert("공지 삭제 실패");
        		}
				else if(json.n == 1) {
					
					alert("공지 삭제 성공@$#@#")
					
					var selectedOption = $("select#orderType").val();
			
			
					if (selectedOption != "") {
						
						$("tbody#displayAllNotice").empty();
						displayNoticeList (selectedOption);
						
					} else {
						$("tbody#displayAllNotice").empty();
						displayNoticeList ("fk_boardKindNo");
					}
					
				} 
			},
			error: function(request, status, error){
	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        } 
		});
		
	}

</script>


<div class="container" style="width: 80%;">
	<h1 align="left">작성한 모든 공지글</h1>
	<div id="tags">
		<ul class="nav nav-tabs" style="border-bottom: none;">
			<li>
	      		<select name="orderType" id="orderType" style="height: 25px;">
	         		<option value="">==정렬선택==</option>
	         		<option value="fk_boardKindNo">게시판</option>
	         		<option value="regDate">작성시간</option>
	         		<option value="readCount">조회수</option>
	      		</select>
			</li>
		</ul>
	</div>
	<br>
	<div style="overflow-x: auto; width: 100%;">
		<table style="width: 100%;">
            <thead>
	            <tr>
	                <th>게시판</th>
	                <th>분류</th>
	                <th>공지제목</th>
	                <th>작성시간</th>
	                <th>조회수</th>
	                <th>삭제</th>
	            </tr>
            </thead>
            <tbody id="displayAllNotice">
				<c:forEach items="${allNoticeList}" var="notice">
					<tr>
						<td>${notice.boardName}</td>
		                <td>${notice.categoryName}</td>
						<c:choose>
						        <c:when test="${fn:length(notice.subject) > 20}">
				                	<td onclick="goNotice('${notice.fk_boardKindNo}', '${notice.noticeNo}');">${fn:substring(notice.subject, 0, 20)}...&nbsp;
				                	[<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
				                	<c:if test="${fn:contains(notice.content, '<img src=')}">
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                	</c:if>
				                	</td>
						        </c:when>
						        <c:otherwise>
				                	<td onclick="goNotice('${notice.fk_boardKindNo}', '${notice.noticeNo}');">${notice.subject}&nbsp;
				                	[<span style="color:#0841ad; font-weight: bold; ">${notice.cmtCount}</span>]
				                	<c:if test="${fn:contains(notice.content, '<img src=')}">
			                		<img src="<%=ctxPath%>/resources/images/sehyeong/disk.gif" >
			                	</c:if>
				                	</td>
						        
						        </c:otherwise>
						       
							</c:choose>
						<td>${notice.regDate}</td>
	                	<td>${notice.readCount}</td>
	                	<td><button onclick="deleteNoticeGoGo('${notice.fk_boardKindNo}', '${notice.noticeNo}');">삭제</button></td>
					</tr>
				
				</c:forEach>
            </tbody>
		</table>
		
		
	</div>


</div>

<form name="notificationFrm">
		<input type="hidden" name="boardKindNo" />
		<input type="hidden" name="noticeNo" />
</form>

