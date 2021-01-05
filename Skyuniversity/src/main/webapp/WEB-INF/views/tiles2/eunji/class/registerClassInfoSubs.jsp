<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style type="text/css">
#infodiv {
	font-size: 12pt;
	background-color: #e6eeff;
	height: 70px;
	text-align: center;	
}
#tbldiv {
	margin: 0 auto;
}
#infotr > td {
	padding-left: 40px;
	padding-right: 40px;
	height: 70px;
	font-weight: bold;
}
#classtr > td {
	padding-left: 40px;
	padding-right: 40px;
	height: 70px;
	
}
#regdiv {
	height: 300px;
}

table#scroltbl {
	border-collapse:collapse; width:1000px;
}
#scrolth {
	float:left; width:100px;
}
#tb {
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:250px;
}
.sublicl {
	display:table; width: 1375px;
} 
.sublicl > td {
	text-align: center;
}
#subli {
	display: table; width: 1375px;
}
#subli > td {
	text-align: center;
}
#boottr > td {
	text-align: center;
}
.forboottr > td {
	text-align: center;
}

#info {
	color: #737373;
}

</style>
<script type="text/javascript">

	$(document).ready(function() {
	
		$("#subjects").hide();
		
		$("#depts").change(function() {
			var dept = "";
			$("#depts option:selected").each(function() {
				dept = $(this).val();
			});
			var grades = $("#grades option:selected").val();
			$.ajax({
				url: "<%= request.getContextPath() %>/deptSelect.sky",
				data: {"dept":dept,
					   "grade":grades},
				type: "GET",
				dataType: "json",
				success: function(json) {
					$("#firstsub").hide();
					$("#subjects").show();
					var html = "<option>전체</option>";
					$.each(json, function(index, item){
						
						html += "<option>"+item.subject+"</option>";
					});
	
					$("#subjects").html(html);
				},
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});	//------------------end of ajax
			
		});
		
		$("#grades").change(function() {
			var grades = "";
			$("#grades option:selected").each(function() {
				 grades = $(this).val();	
			});
			
			var dept = $("#depts option:selected").val();
			$.ajax({
				url: "<%= request.getContextPath() %>/deptSelect.sky",
				data: {"dept":dept,
					   "grade":grades},
				type: "GET",
				dataType: "json",
				success: function(json) {
					$("#firstsub").hide();
					$("#subjects").show();
					var html = "<option>전체</option>";
					$.each(json, function(index, item){
						
						html += "<option>"+item.subject+"</option>";
					});
	
					$("#subjects").html(html);
				},
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});	//------------------end of ajax
		});
		
		$("#subssearchbtn").click(function() {
			var dept = $("#depts option:selected").val();
			var grades = $("#grades option:selected").val();
			var subjects = $("#subjects option:selected").val();
			var firstsub = $("#firstsub option:selected").val();
			
			$.ajax({
				url: "<%= request.getContextPath() %>/subSelect.sky",
				data: {"dept":dept,
					   "grade":grades,
					   "subject":subjects,
					   "firstsub":firstsub},
				type: "GET",
				dataType: "json",
				success: function(json) {
					var html="";
					$.each(json, function(index, item){						
						html += "<tr class='sublicl'>";
						html += "<td style='width:150px;' id='td1"+index+"'>"+item.subjectno+"</td>"
							   +"<td style='width:200px;' id='td2"+index+"'>"+item.subjectname+"</td>"
							   +"<td style='width:100px;' id='td3"+index+"'>"+item.credits+"</td>"
							   +"<td style='width:100px;' id='td4"+index+"'>"+item.name+"</td>"
							   +"<td style='width:300px;> <span id='span1"+index+"'>"+item.day+"</span> /  <span id='span2"+index+"'>" + item.period+"</span></td>"
							   +"<td style='width:150px; id='td6"+index+"'>"+item.curpeoplecnt + " / " + item.peoplecnt+"</td>"
						html += "</tr>";
					});
					$("#tb").html(html);
				},
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});	//------------------end of ajax
			
		
		});	// ---------------- end of button click func
		
	});	//-------------------------------- end of document.ready()
	function nosearch() {
		var no = $("#subnos").val();
		
		$.ajax({
			url: "<%= request.getContextPath() %>/subSelectNo.sky",
			data: {"no":no},
			type: "GET",
			dataType: "json",
			success: function(json) {
				var html="";
				$.each(json, function(index, item){						
					html += "<tr class='sublicl'>";
					html += "<td style='width:150px;' id='td1"+index+"'>"+item.subjectno+"</td>"
						   +"<td style='width:200px;' id='td2"+index+"'>"+item.subjectname+"</td>"
						   +"<td style='width:100px;' id='td3"+index+"'>"+item.credits+"</td>"
						   +"<td style='width:100px;' id='td4"+index+"'>"+item.name+"</td>"
						   +"<td style='width:300px;> <span id='span1"+index+"'>"+item.day+"</span> /  <span id='span2"+index+"'>" + item.period+"</span></td>"
						   +"<td style='width:150px; id='td6"+index+"'>"+item.curpeoplecnt + " / " + item.peoplecnt+"</td>"
					html += "</tr>";
				});
				$("#tb").html(html);
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});	//------------------end of ajax
	}
	

</script>

<div id="container">
	<div id="infodiv">
		<table>
			<tr id="infotr">
				<td style="padding-left: 400px;">${year}년 / ${mvo.currentSemester}학기</td>
				<td>이름: ${mvo.name}</td>
				<td>학번: ${mvo.memberNo}</td>
				<td>학과: ${mvo.deptName}</td>
			</tr>
		</table>
	</div>
	<br>
	<div>
				<ul id="credittbl" style="list-style: none; width: 600px;">
					<li>
						<label>수강가능학점: </label>
						<span style="color: #0066cc;font-weight: bold;">19학점</span>
					</li>
					<li>
						<label style="display: inline-block;">과목코드 검색:</label>
						<input type="text" style="display: inline-block; width: 120px; border: solid 1px #cccccc;" id="subnos"/>
						<button onclick="nosearch();" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px;  border-radius: 3px;">검색</button>
					</li>
				</ul>
	</div>
	
	<div id="regdiv">
		<div id="classlist">
			<table>
				<tr id="classtr">
					<td style="padding-left: 400px;">
						<label>학과: </label>
						<select name="depts" id="depts" style="border: solid 1px #cccccc;">
						  <option>전체</option>
						  <c:forEach items="${deptlist}" var="dept">
						  	<option>${dept}</option>
						 </c:forEach>
						</select>
					</td>
					<td>
						<label>학년: </label>
						<select name="grades" id="grades" style="border: solid 1px #cccccc;">
							<option>전체</option>
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
						</select>
					</td>
					<td>
						<label>과목명: </label>
						<select name="subjects" id="subjects" style="border: solid 1px #cccccc;">
						</select>
						<select name="firstsub" id="firstsub" style="border: solid 1px #cccccc;">
						  <option>전체</option>
						  <c:forEach items="${subjectlist}" var ="sub" >
						  	<option>${sub}</option>
						  </c:forEach> 
						</select>
					</td>
					<td>
						<button id="subssearchbtn" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px;  border-radius: 3px;">검색</button>
					</td>
				</tr>
			</table>
		</div>
		<div style="border: solid 2px #cccccc;border-radius: 6px; margin-left: 10px; margin-right: 10px;">
			<table id="scroltbl" class="table">
			<thead id="scrolth">
				<tr id="subli">
					<td style="width:150px;">과목코드</td>
					<td style="width:200px;">과목명</td>
					<td style="width:100px;">학점</td>
					<td style="width:100px;">교수님</td>
					<td style="width:300px;">요일 / 교시</td>
					<td style="width:150px;">수강가능인원</td>
				</tr>
			</thead>
			<tbody id="tb">
				
			</tbody>
			</table>
		</div>
	</div>
	<br><br> <br><br><br>
	<div id="divbtn" style="margin-left: 10px;">
	<span style="font-size: 12pt; font-weight: bold; color: #ff4000">수강신청 안내</span>
	</div>
	<br/>
	<div style="padding-top: 20px; border: solid 2px #cccccc;border-radius: 6px; margin-left: 10px; margin-right: 10px;">
	<ul id="info" >
	    <li>시간표가 학부(과) 사정으로 부득이하게 변경될 경우 전산상에 실시간으로 변경사항이 입력되므로 수강신청 시 담당교수, 강의요일 및 시간, 강의실 등내용을 반드시 확인한다.</li>
		<li>상급학년의 과목은 신청할 수 없다.</li>
		<li>4학년은 전체성적을 확인하고 졸업이 가능하도록 수강신청 한다. (특히 필수과목 이수여부, 중복수강, 교양, 전공, 졸업학점 취득여부를 확인한다.)</li>
		<li>강의시간이 1시간이라도 중복되는 과목은 신청할 수 없다. </li>
		<li>수강신청을 하지 않은 교과목의 성적은 인정하지 않는다.</li>
		<li>본인의 과실로 수강신청 오류가 생길 경우 책임은 본인에게 있다.</li>
	</ul>
	</div>
</div>