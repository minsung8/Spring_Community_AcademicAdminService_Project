<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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

tbody>tr>td:nth-child(3), td:nth-child(4) {
	text-align: left;
}

tbody>tr>td:nth-child(3) {
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
	background-color: white;
	/* border: solid 1px blue; */
}



ul.pager {
	margin-bottom: 50px;
}

tbody>tr>td:nth-child(1), td:nth-child(2), td:nth-child(6), td:nth-child(7)
	{
	width: 70px;
}

div.modal-content {
	width: 400px;
}


</style>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
	      $(".modal-dialog").css({
	          "display": "none"
	      });
	      
	      $("#writeMsg").css({
	          "display": "none"
	      });
   	
	});
	
	function showModal(msgNo) {
		
		var msgNo = msgNo;
		
		$.ajax({
			url: "<%= ctxPath%>/getOneMsg.sky",
			type: "POST",
			data: {"msgNo": msgNo},
			dataType:"JSON",
			success: function(json){
								
				$("span#msgSubject").text(json.subject);
				$("span#msgFromNickName").text(json.fromNickName);
				$("span#msgContent").text(json.content);
				
			      $(".modal-dialog").css({
			          "display": "block"
			      });
			      
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
		
		

	}
	
	function closeModal() {
		
		
	      $(".modal-dialog").css({
	          "display": "none"
	      });
	}
	
	function closeModal2() {
		
		
	      $("#writeMsg").css({
	          "display": "none"
	      });
	}
	

	
	function writeMsg() {

	      $("#writeMsg").css({
	          "display": "block"
	      });
		
	}
	
	function writeMsg2() {
		var frm = $("form[name=sendMsg]").serialize();
		
		$.ajax({
			url: "<%= request.getContextPath()%>/writeMsg.sky",
			data: frm,
			type: "POST",
			dataType:"JSON",
			success: function(json){
					
				if (json.n == 1) {
					alert("쪽지 보내기 성공!");
					location.reload();
				} else {
					alert("해당 사용자가 없습니다!");
				}
				
			},
			error: function(request, status, error){
				alert("해당 사용자가 없습니다!");
	        }
			
		});
	}

</script>
<div class="container" style="width: 80%; position: relative; z-index: 1;">

	<h1 align="left">쪽지함</h1>
	<div id="tags">
		<ul class="nav nav-tabs">

           	<li class="getMsg" value="0"><a href="messageLetsGetIt.sky">받은쪽지</a></li>
           	<li class="sendMsg" value="${category.categoryNo}"><a href="messageLetsGetIt.sky?value=1">보낸쪽지</a></li>

		</ul>
	</div>

	<div>
		<table style="width: 100%;">
			<c:if test="${value == null }">
				<thead>
					<tr>
						<th style="width: 100px;" >보낸사람</th>
						<th style="width: 100px;">보낸시간</th>
						<th>제목</th>
						<th>내용</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="getMsg" items="${getMsgList}">
						<tr class="">
							<td>${getMsg.fromNickName}</td>
							<td>${getMsg.sendDate}</td>
							<td onclick="showModal(${getMsg.msgNo})">${getMsg.subject}</td>
							<td>${getMsg.content}</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
			
			<c:if test="${value != null }">
				<thead>
					<tr>
						<th style="width: 100px;">받은사람</th>
						<th style="width: 100px;">보낸시간</th>
						<th>제목</th>
						<th>내용</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="sendMsg" items="${sendMsgList}">
						<tr class="">
							<td>${sendMsg.toNickName}</td>
							<td>${sendMsg.sendDate}</td>
							<td onclick="showModal(${sendMsg.msgNo})">${sendMsg.subject}</td>
							<td>${sendMsg.content}</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
		</table>
	</div>
	<div align="right"><a class="btn btn-primary" id="register" onclick="writeMsg()">쪽지 쓰기</a></div>
</div>
 
 <div id="ex7" class="modal-dialog modal-dialog-scrollable" style="position: absolute; top:50%; left:30%; z-index: 2;">	
  <div class="modal-dialog" >
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel" style="text-align:left;"><B>제목 :</B> <span id="msgSubject"></span> <br><B>보낸사람 : </B><span id="msgFromNickName"></span></h5>
      </div>

      <div class="modal-body" style="text-align:left;">
        	<B>내용 : </B><span id="msgContent"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="closeModal()">Close</button>
      </div>
    </div>
  </div>
</div>

 
  <div id="writeMsg" class="writeMsg modal-dialog-scrollable" style="position: absolute; top:50%; left:45%; z-index: 2;">	
  <div class="writeMsg" id="writeMsg">
    <div class="modal-content">
    <form name="sendMsg">
    	
    	<h3 style="text-align:center;"><B>쪽지 보내기</B></h3>
    	
	    <div class="input-group flex-nowrap">
		  <span class="input-group-text"><B>제목</B></span><br>
		  <input class="form-control" type="text" style = "text-align:left; width:290px;" id="subject" name="subject"/>
		</div>
		
		<div class="input-group flex-nowrap">
		  <span class="input-group-text"><B>받는사람</B></span><br>
		  <input class="form-control" type="text" style = "text-align:left; width:290px;" id="nickName" name="nickName"/>
		</div>
		
		<div class="input-group flex-nowrap">
		  <span class="input-group-text"><B>내용</B></span><br>
		  <input class="form-control" type="text" style = "text-align:left; width:290px; height:100px;" id="content" name="content" maxlength="400"/>
		</div>

      </form>
      <div class="modal-footer">
       	<a class="btn btn-primary" onclick="writeMsg2()">보내기</a>
		<a class="btn btn-primary" onclick="closeModal2()">취소</a>
      </div>
    </div>
  </div>
</div>


