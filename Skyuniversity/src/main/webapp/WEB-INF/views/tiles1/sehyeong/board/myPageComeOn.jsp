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
		
		$("span#myPageTotalPage").hide();
		$("span#countMyPage").hide();
		$("button#btnMoreMyPage").hide();
		
		displayMyPage ("1", "fk_boardKindNo");
		
		
		$("button#btnMoreMyPage").click(function(){
			var selectedOption = $("select#orderType").val();
			
			if (selectedOption != "") {  // 선택된 옵션이 있는 경우에 더보기 클릭
				
				if("처음으로...." == $(this).text()) {
					$("tbody#displayMyPage").empty();
					
					displayMyPage ("1", selectedOption);
					$(this).text("더보기..")
				} else {
					displayMyPage($(this).val(), selectedOption);  // displayHIT("9");
					
				}
				
			} else {  // 선택된 옵션이 없는 경우에 더보기 클릭
				
				if("처음으로...." == $(this).text()) {
					$("tbody#displayMyPage").empty();
					
					displayMyPage ("1", "fk_boardKindNo");
					$(this).text("더보기..")
				}
				displayMyPage($(this).val(), "fk_boardKindNo");
			}
			
		});
		
		
		$("select#orderType").change(function(){
			var selectedOption = $(this).val();
			
			
			if (selectedOption != "") {
				
				$("tbody#displayMyPage").empty();
				$("span#countMyPage").text("0");
				displayMyPage ("1", selectedOption);
				
			} else {
				
			}
		});
		
	});
	
	
	function displayMyPage (start, colName) {
		
		$.ajax({
			url:"<%= ctxPath%>/displayMyPageJSON.sky",
			type:"GET",
			data:{"start":start  // "1"
				, "len":lenBoardList
				, "colName": colName},  // 20
			dataType:"JSON",
			success:function(json){
				html = "";
				
				if(start == "1" && json.length == 0) {
        			// 처음부터 데이터가 존재하지 않는 경우
		    		// !!! 주의 !!!
		    		// if(json == null) 이 아님!!!
		    		// if(json.length == 0) 으로 해야함!!
		    		html += "<tr><td colspan='6' style='font-size: 15pt;'>2주내 글을 쓴것이 없구마잉...</td></tr>";
					
		    		// 더보기 버튼 없애버리기
		    		$("button#btnMoreMyPage").hide();
		    		
		    		// HIT 상품 결과를 출력하기
		    		$("tbody#displayMyPage").html(html);
        		}
				else if(json.length > 0) {
					// 데이터가 존재하는 경우
					// !!!!**** 중요 **** !!!! //
					// 더보기 ... 버튼의 value속성의 값을 지정해 주어야 한다.
					// 맨처음 start에 1이 들어오고 lenHIT가 더해져서 버튼의 밸류값은 9가 되어진다.
					// 더보기 버튼의 value값이 9로 변경되어 진다. 
					$("button#btnMoreMyPage").val( Number(start) + lenBoardList );
					
					// 제이쿼리 내의 반복문 $.each(json, function(index, item){});
					$.each(json, function(index, item){
						
						html +=  "<tr>" +
		                	"<td>" + item.boardName + "</td>" + 
		                	"<td>" + item.categoryName + "</td>";
		                	
	                	var subject = item.subject;
	                	if (subject.length > 20) {
	                		subject = subject.substr(0,20);
	                	} 
	                	
	                	html += "<td onclick='showDetailGoGo(" + item.fk_boardKindNo + ", " + item.boardNo + ");'>" + subject + "...&nbsp;" +
	                		"[<span style='color:#0841ad; font-weight: bold;'>" + item.cmtCount + "</span>]";
	                	
	                	
	                	var content = item.content;
		                
	                	if (content.indexOf("<img src=") != -1) {
	                		html += "&nbsp;&nbsp;<img src='/skyuniversity/resources/images/sehyeong/disk.gif'>";
	                	}
		                	
	                	
	                	
		                html += "<td>" + item.regDate + "</td>" + 
		                	"<td>" + item.upCount + "</td>" + 
		                	"<td>" + item.readCount + "</td>" + 
		                	"</tr>";
		                	
					});
					
					
					
					$("tbody#displayMyPage").append(html);
					
					// displayMyPage에 지금까지 출력된 상품의 개수를 누적해서 기록한다!!!
					
					$("span#countMyPage").text((Number)($("span#countMyPage").text())  +  json.length );
					
					
					// 더보기 버튼을 계속 클릭하여 countHIT 값과 totalHITCount값이 일치하는 경우
					if($("span#countMyPage").text() == $("span#myPageTotalPage").text()) {
						$("button#btnMoreMyPage").show();
						
						if (start == "1") {
							$("button#btnMoreMyPage").hide();
						} else {
							
							$("button#btnMoreMyPage").text("처음으로....");
						}
						$("span#countMyPage").text("0");
					} else {
						$("button#btnMoreMyPage").text("더보기...");
						$("button#btnMoreMyPage").show();
						
					}
				
				} 
			},
			error: function(request, status, error){
	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        } 
		});
	}
	
	function showDetailGoGo(boardKindNo, boardNo) {
		
		var frm = document.showDetailGoGoFrm;
		
		if (boardKindNo <= 6 || (18 <= boardKindNo && boardKindNo <= 22)) {
			frm.action = "<%= ctxPath%>/minsungBoardView.sky";
		} else if (23 <= boardKindNo){
			frm.action = "<%= ctxPath%>/marketBoardDetail.sky";
		} else if (boardKindNo != 7){
	          frm.action = "<%=request.getContextPath()%>/boardDetail.sky";
	       } else{
	          frm.action = "<%=request.getContextPath()%>/boardDetail2.sky";
	       }
		
		
		frm.boardKindNo.value= boardKindNo;
		frm.boardNo.value= boardNo;
		
		frm.method = "GET";
		frm.submit();
		
		
		
	}

</script>


<div class="container" style="width: 80%;">
	<h1 align="left">최근 2주내 게시글</h1>
	<div id="tags">
		<ul class="nav nav-tabs" style="border-bottom: none;">
			<li>
	      		<select name="orderType" id="orderType" style="height: 25px;">
	         		<option value="">==정렬선택==</option>
	         		<option value="fk_boardKindNo">게시판</option>
	         		<option value="regDate">작성시간</option>
	         		<option value="upCount">추천수</option>
	         		<option value="readCount">조회수</option>
	      		</select>
			</li>
			<!-- <li>
				<form name="searchFrm" style="margin-top: 10px;">
		      		<select name="searchType" id="searchType" style="height: 25px;">
		         		<option value="subject">글제목</option>
		      		</select>
		      		<input type="text" name="searchWord" id="searchWord" size="40" style="width:120px;" autocomplete="off" /> 
	      			<button type="button" onclick="goSearch()">검색</button>
   				</form>
			</li> -->
		</ul>
	</div>
	<br>
	<div style="overflow-x: auto; width: 100%;">
		<table style="width: 100%;">
            <thead>
	            <tr>
	                <th>게시판</th>
	                <th>분류</th>
	                <th>글제목</th>
	                <th>작성시간</th>
	                <th>추천</th>
	                <th>조회수</th>
	            </tr>
            </thead>
            <tbody id="displayMyPage">
	            	
            </tbody>
		</table>
		
		<div style="margin: 20px 0;">
			<br />
			<button type="button" id="btnMoreMyPage" value="">더보기....</button>
			<span id="myPageTotalPage">${myPageTotalPage}</span>
			<span id="countMyPage">0</span>
		</div>
	</div>


</div>


<form name="showDetailGoGoFrm">
	<input type="hidden" name="boardKindNo"  />
	<input type="hidden" name="boardNo" />
</form>


