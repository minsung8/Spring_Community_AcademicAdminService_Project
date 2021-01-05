<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

tbody > tr > td:nth-child(3), td:nth-child(4) {
	text-align: left;
}

tbody > tr > td:nth-child(3) {
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

tbody > tr > td:nth-child(1), td:nth-child(2), td:nth-child(6), td:nth-child(7) {
	width: 70px;
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

</style>


<script type="text/javascript">

   $(document).ready(function() {
      
      $("div#tags li").click(function() {
         $(this).siblings().removeClass("active");
         $(this).addClass("active");
      });
      
   });// end of $(document).ready(function() {});-------------------------------------


</script>
</head>


<div class="container" style="width: 80%;">
	<h1 align="left">oo게시판</h1>
	<div id="tags">
		<ul class="nav nav-tabs">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Menu 1</a></li>
            <li><a href="#">Menu 2</a></li>
			<li><a href="#">Menu 3</a></li>
			<li>
				<form name="searchFrm" style="margin-top: 10px;">
		      		<select name="searchType" id="searchType" style="height: 25px;">
		         		<option value="subject">글제목</option>
		         		<option value="name">작성자</option>
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
            	<c:forEach var="i" begin="1" end="30" varStatus="status">
	            	<tr>
	                	<td>1029</td>
	                	<td>운동</td>
	                	<td>${i}번째 제목입니다아아아아라</td>
	                	<td>가나다</td>
	                	<td>2020-12-08</td>
	                	<td>203</td>
	                	<td>10292</td>
	            	</tr>
            	</c:forEach>
            </tbody>
		</table>
	</div>

	<div align="right"><button id="register">글쓰기</button></div>

	<ul class="pager">
		<li class=""><a href="#">맨처음</a></li>
        <li class=""><a href="#">Previous</a></li>
        <li class="pageBtn">1</li>
        <li class="pageBtn">2</li>
        <li class="pageBtn">3</li>
        <li class="pageBtn">4</li>
        <li class="pageBtn">5</li>
        <li class="pageBtn">6</li>
        <li class="pageBtn">7</li>
        <li class="pageBtn">8</li>
        <li class="pageBtn">9</li>
        <li class="pageBtn">10</li>
        <li class=""><a href="#">Next</a></li>
        <li class=""><a href="#">마지막</a></li>
	</ul>
</div>
    