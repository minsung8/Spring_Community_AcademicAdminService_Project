<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	div#thisGradeContainer {
	 	font-size: 11pt;
	 	margin: 30px 50px;
	 }
	
	 input.defaultInput {
	 	width: 85px;
	 	margin-right: 30px;
	 	outline: none;
	 }
	 
	 div.defaultInfo {
	 	margin-bottom: 50px;
	 }
	 
	 div.totalGradeInfo {
		border: solid 1px lightgray;
	 	border-radius: 10px;
		padding: 20px;
		width: 100%; 
		margin-bottom: 30px;
	 }
	 
	  
	 div#sumBlock {
	 	border: solid 1px lightgray;
	 	border-radius: 10px;
	 	padding: 20px;
	 	width: 100%;
	 }
	 
	 div#detailBlock {
	 	border: solid 1px lightgray;
	 	border-radius: 10px;
	 	padding: 20px;
	 	width: 100%;
	 	margin-top: 30px;
	 }
	 
	 .bordered {
	    *border-collapse: collapse; /* IE7 and lower */
	    border-spacing: 0;
	    width: 100%;
	    border: solid #ccc 1px;
	    -moz-border-radius: 6px;
	    -webkit-border-radius: 6px;
	    border-radius: 6px;
	    -webkit-box-shadow: 0 1px 1px #ccc;
	    -moz-box-shadow: 0 1px 1px #ccc;
	    box-shadow: 0 1px 1px #ccc;
	}
	 
	.bordered tr:hover {
	    background: #fbf8e9;
	    -o-transition: all 0.1s ease-in-out;
	    -webkit-transition: all 0.1s ease-in-out;
	    -moz-transition: all 0.1s ease-in-out;
	    -ms-transition: all 0.1s ease-in-out;
	    transition: all 0.1s ease-in-out;
	}
	 
	.bordered td, .bordered th {
	    border-left: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    padding: 10px;
	    text-align: center;
	}
	 
	.bordered th {
	    background-color: #dce9f9;
	    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
	    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
	    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
	    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
	    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
	    border-top: none;
	    text-shadow: 0 1px 0 rgba(255,255,255,.5);
	}
	 
	.bordered td:first-child, .bordered th:first-child {
	    border-left: none;
	}
	 
	.bordered th:first-child {
	    -moz-border-radius: 6px 0 0 0;
	    -webkit-border-radius: 6px 0 0 0;
	    border-radius: 6px 0 0 0;
	}
	 
	.bordered th:last-child {
	    -moz-border-radius: 0 6px 0 0;
	    -webkit-border-radius: 0 6px 0 0;
	    border-radius: 0 6px 0 0;
	}
	 
	.bordered th:only-child{
	    -moz-border-radius: 6px 6px 0 0;
	    -webkit-border-radius: 6px 6px 0 0;
	    border-radius: 6px 6px 0 0;
	}
	 
	.bordered tr:last-child td:first-child {
	    -moz-border-radius: 0 0 0 6px;
	    -webkit-border-radius: 0 0 0 6px;
	    border-radius: 0 0 0 6px;
	}
	 
	.bordered tr:last-child td:last-child {
	    -moz-border-radius: 0 0 6px 0;
	    -webkit-border-radius: 0 0 6px 0;
	    border-radius: 0 0 6px 0;
	}
	 
</style>

<script type="text/javascript">

</script>

<div id="thisGradeContainer">
	<div class="defaultInfo">
		<label style="width: 30px;">학번</label><input type="text" class="defaultInput"  value="${loginuser.memberNo}" readonly />
		<label style="width: 30px;">성명</label><input type="text" class="defaultInput" value="${loginuser.name}" readonly />
	</div>
	<div class="totalGradeInfo" >
		<h4 style="font-weight: bold;">총성적</h4>
		<table class="bordered">
			<thead>
				<tr>
					<th>신청학점</th>
					<th>취득학점</th>
					<th>총점수</th>
					<th>평균학점</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="sumBlock">
		<h4 style="font-weight: bold;">당학기 평점 내역</h4>
		<table class="bordered">
			<thead>
				<tr>
					<th>No</th>
					<th>학기</th>
					<th>이수학점</th>
					<th>평점평균</th>
					<th>최초평점평균</th>
					<th>학사경고</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="detailBlock">
		<h4 style="font-weight: bold;">과목별 성적 내역</h4>
		<table class="bordered">
			<thead>
				<tr>
					<th>No</th>
					<th>학기</th>
					<th>이수구분</th>
					<th>교과목코드</th>
					<th>교과목명</th>
					<th>학점</th>
					<th>평점</th>
					<th>성적</th>
					<th>이수여부</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
					<td>n</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>