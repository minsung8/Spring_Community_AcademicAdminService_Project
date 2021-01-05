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
	border-collapse:collapse; width:100%;
}
#scrolth {
	float:left; width:100%;
}
#tb {
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:190px;
}
.sublicl {
	display:table; width: 1400px;
} 
.sublicl > td {
	text-align: center;
}
#subli {
	display: table; width: 1400px;
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
		
		$("#subsearchbtn").click(function() {
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
							   +"<td style='width:300px;'> <span id='dayspan"+index+"'>"+item.day+"</span>" 
							   + " /  <span id='span2"+index+"'>" + item.period+"</span></td>"
							   +"<td style='width:150px; id='td6"+index+"'>"+item.curpeoplecnt + " / " + item.peoplecnt+"</td>"
							   +"<td style='width:100px;'><button onclick='funcClassReg("+index+");' style='border:none; color: black; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>신청</button></td>";
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
	
	function funcClassReg(index){
		var addcredit = $("#td3"+index).text();
		var sumcredits = ${sumcredits};
		var $target = $(event.target);
		
		var days = $("#dayspan"+index).text();
		var period = $("#span2"+index).text();
		var total = "19";
		if(parseInt(sumcredits)+parseInt(addcredit) > parseInt(total)){
			alert("신청가능한 학점이 초과되어 신청이 불가합니다.");
			return;
		}
		var subjectno = $("#td1"+index).text();
		var year = ${year};
		var cursemester = ${mvo.currentSemester};
		var memberno = ${mvo.memberNo};
		
		$.ajax({
			url: "<%= request.getContextPath() %>/insertSub.sky",
			data: {"subjectno":subjectno,
				   "year":year,
				   "cursemester":cursemester,
				   "memberno":memberno,
				   "day":days,
				   "period":period},
			type: "GET",
			dataType: "json",
			success: function(json) {
				if(!json.dayre && json.unique && json.bool){
					alert("해당 요일,교시에 해당하는 과목이 존재합니다");
					return;
				}
				if(!json.bool){
					alert("자신의 학과의 과목을 수강신청해주세요.");
					return;
				}
				if(!json.unique){
					alert("이미 수강신청한 과목입니다.");
					return;
				}
				if(json.recourse){
					var result = confirm("재수강 하시겠습니까?");
					if(result){
						$.ajax({
							url: "<%= request.getContextPath() %>/insertReSub.sky",
							data: {"bool":result,
								   "subjectno":subjectno,
								   "cursemester":cursemester,
								   "year":year,
								   "memberno":memberno},
							type: "GET",
							dataType: "json",
							success: function(json) {
								if(json.boolre){
									alert("재수강 신청이 되었습니다.");
									location.reload();
								}
							},error: function(request, status, error){
					               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					        }
						}); 
					}
				} 
				if(json.end){
					alert("수강신청 되었습니다.");
					location.reload();
				}
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});	//------------------end of ajax
		
		
	}
	
	function funcdelbtn(index) {
		var no = $("#no"+index).val();
		var subno = $("#subno"+index).text();
		$.ajax({
			url: "<%= request.getContextPath() %>/delCourse.sky",
			data: {"no":no,
				   "subno":subno},
			type: "POST",
			dataType: "json",
			success: function(json) {
				if(json.result){
					alert("해당 과목이 삭제되었습니다.");
					location.reload();
				}
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});	//------------------end of ajax
	}
	
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
						   +"<td style='width:100px;'><button onclick='funcClassReg("+index+");' style='border:none; color: black; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>신청</button></td>";
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
	<div>
		<table class="table table-striped">
			<tr id="credittbl">
				<td style="width:120px; font-weight: bold;">수강가능학점:</td>
				<td style="width:120px; color: #0066cc; font-weight: bold;">19학점</td>
				<td style="width:160px; font-weight: bold;">총 수강신청 학점:</td>
				<td style="color: #0066cc; font-weight: bold;">${sumcredits}학점</td>
			</tr>
		</table>
		<div style="margin-left: 10px;">
			<label style="display: inline-block;">과목코드 검색:</label>
			<input type="text" style="display: inline-block; width: 120px; border: solid 1px #cccccc;" id="subnos"/>
			<button onclick="nosearch();" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;">검색</button>
		</div>
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
						<button id="subsearchbtn" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;">검색</button>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table id="scroltbl" class="table">
			<thead id="scrolth">
				<tr id="subli">
					<td style="width:150px;">과목코드</td>
					<td style="width:200px;">과목명</td>
					<td style="width:100px;">학점</td>
					<td style="width:100px;">교수님</td>
					<td style="width:300px;">요일 / 교시</td>
					<td style="width:150px;">수강가능인원</td>
					<td style="width:100px;">수강신청</td>
				</tr>
			</thead>
			<tbody id="tb">
				
			</tbody>
			</table>
		</div>
	</div>
	<br><br>
	<br>
	<div><span style="font-size: 12pt; font-weight: bold; padding: 10px; color:red;">[수강신청 내역]</span></div>
	<br>
	<div>
		<table class="table table-bordered">
			<thead>
				<tr id="boottr">
					<td>과목코드</td>
					<td>과목명</td>
					<td>학점</td>
					<td>교수님</td>
					<td>요일 / 교시</td>
					<td>수강가능인원</td>
					<td>취소</td>
				</tr>
			</thead>
			<tbody>
				<form name="regform">
				<c:forEach items="${reglist}" var ="reg" varStatus="status">
					<tr class="forboottr">
						<td id="subno${status.index}">${reg.subjectno}</td>
						<td>${reg.subjectname}</td>
						<td>${reg.credits}</td>
						<td>${reg.name}</td>
						<td>${reg.day}/${reg.period}</td>
						<td>${reg.curpeoplecnt}/${reg.peoplecnt}</td>
						<td><button onclick="funcdelbtn(${status.index});" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button></td>
					</tr>
					<input id="no${status.index}" value="${reg.courseno}" hidden="true"/>
				</c:forEach>
				</form>
			</tbody>
		</table>
	</div>
</div>