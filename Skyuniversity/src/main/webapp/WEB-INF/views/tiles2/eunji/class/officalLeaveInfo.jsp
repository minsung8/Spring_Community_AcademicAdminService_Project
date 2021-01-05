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

table#scroltbl {
	border-collapse:collapse; width:100%;
}
#scrolth {
	float:left; width:100%;
}
#bodys {
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:350px;
}
#subli {
	display: table; width: 1380px;
}
.sublicl {
	display:table; width:100%;
} 
.sublicl > td {
	font-size: 9pt;
	text-align: center;	
}
#subli > td {
	width:280px;
	font-size: 9pt;
	text-align: center;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		// 현재 년도 구하기
		var date = new Date();
		var year = date.getFullYear();
		
		var html2 = "<option>전체</option>";
		for(var i=parseInt(year);i>=1990; i--){
			html2 += "<option>"+i+"</option>";  
		}
		$("#year").html(html2);
		
		$("#searchbtn2").click(function() {
			
			var year = $("#year option:selected").val();
			var semester = $("#semester option:selected").val();
			
			$.ajax({
				url:"<%= request.getContextPath() %>/officalLeaveInfo_End.sky",
				data:{"year":year,
					   "semester":semester},
				type:"GET",
				dataType:"json",
				success: function(json) {
					var html = "";
					$.each(json, function(index, item){
						html += "<tr class='sublicl'>";
						html += "<td style='width: 200px;'>"+item.deptname+"</td>"+
						        "<td style='width: 100px;'>"+item.grade+"</td>"+
						        "<td style='width: 100px;'>"+item.memberno+"</td>"+
						        "<td style='width: 150px;'>"+item.name+"</td>"+
						        "<td style='width: 200px;'>"+item.startDate+"</td>"+
						        "<td style='width: 200px;'>"+item.endDate+"</td>"+
						        "<td style='width: 230px;'>"+item.reason+"</td>";
						        if(item.filename == null){
						        	html += "<td style='width:100px;'> </td>";
						        }
						        else{
						        	html +="<td style='width:100px;'><a href='<%= request.getContextPath()%>/downloadLeaveInfo.sky?seq="+item.leaveNo+"'><img src='<%= request.getContextPath() %>/resources/images/disk.gif'/></a></td>"
						        }
						        html += "<td>"+item.approve+"</td>";
					    html += "</tr>";
					});
					$("#bodys").html(html);
				},error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			}); 
		});
		
	});
</script>
<div style="padding-left: 10px; padding-right: 10px;">
<div style="background-color: #b3d9ff; padding: 10px; border-radius: 3px;">
	<label style="padding-right:10px;">학년도</label>
	<select name="year" id="year" style="border: solid 1px #cccccc;">	
	</select>
	<label style="padding-right:10px;">학기</label>
	<select name="semester" id="semester" style="border: solid 1px #cccccc;">
		<option>전체</option>
		<option>1</option>
		<option>2</option>
	</select>
	<button id="searchbtn2" style="margin-left: 70px; border:none; color: black; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;">조회</button>
</div>
<br>
<div>
<span style="font-size: 12pt; font-weight: bold;">공결 목록</span>
</div>
<br>
<div style="border: solid 1px #d9d9d9; height: 450px;">
	<table class="table table-striped" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px;">학부(과)</td>
				<td style="width: 100px;">학년</td>
				<td style="width: 100px;">학번</td>
				<td style="width: 150px;">성명</td>
				<td style="width: 200px;">공결시작일자</td>
				<td style="width: 200px;">공결종료일자</td>
				<td style="width: 230px;">공결사유</td>
				<td style="width:100px;">첨부파일</td>
				<td style="width: 100px;">승인여부</td>
			</tr>
		</thead>
		<tbody id="bodys">
		</tbody>
	</table>
</div>
</div>