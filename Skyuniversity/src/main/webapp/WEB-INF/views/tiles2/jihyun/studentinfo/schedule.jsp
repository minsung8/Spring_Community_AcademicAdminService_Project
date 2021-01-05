<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.common.css" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.light.css" />


<style type="text/css">

#scContainer {
	width: 80%;
}

th, td {
	width: 150px;
	height: 50px;
}

div#scWrapper {
	display: flex;
	flex-direction: column;
	align-items: center;
}

</style>

<script src="https://cdn3.devexpress.com/jslib/20.2.4/js/dx.all.js"></script>
<script type="text/javascript" src="https://unpkg.com/frozor-hybrid@2.0.4/index.js"></script>
<script type="text/javascript">

var data = ${ssList};

var resourcesData = [
    {
        text: "학교일정",
        id: 0,
        color: "#03bb92"
    }, {
        text: "학과일정",
        id: 1,
        color: "#f34c8a"
    }
];

$(function(){
    var scheduler = $("#scheduler").dxScheduler({
        /* timeZone: "America/Los_Angeles", */
        timeZone: "Europe/London",
        dataSource: data,
        views: [{
            type: "month",
            name: "Auto Mode",
            maxAppointmentsPerCell: "auto"
        }, {
            type: "month",
            name: "Unlimited Mode",
            maxAppointmentsPerCell: "unlimited"
        }, {
            type: "month",
            name: "Numeric Mode",
            maxAppointmentsPerCell: 2
        }],
        currentView: "Auto Mode",
        currentDate: new Date(2020, 12, 01),
        resources: [{
            fieldExpr: "sort",
            dataSource: resourcesData,
            label: "일정구분"
        }],
        height: 650
    }).dxScheduler("instance");
});

</script>

<div id="scWrapper">
    <div class="dx-viewport demo-container" id="scContainer">
        <div id="scheduler"></div>
    </div>
	<div style="width: 80%;">
		<h2>일정상세</h2>
		<table class="table">
			<thead>
				<tr>
					<th>No</th>
					<th>일자</th>
					<th>구분</th>
					<th>일정명</th>
					<th>일정내용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="slist" items="${sScheduleList}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>
							<c:set var="startDate" value="${slist.startDate}"/> 
							<c:set var="endDate" value="${slist.endDate}"/> 
							${fn:substring(startDate,0,10)}~${fn:substring(endDate,0,10)}
						</td>
						<c:if test="${slist.status == '0'}">
								<td>전체일정</td>
							</c:if>
							<c:if test="${status == '1'}">
								<td>학과일정</td>
							</c:if>
						<td>${slist.subject}</td>
						<td>${slist.contents}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</html>