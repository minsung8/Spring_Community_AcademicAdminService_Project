<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<style>
div#logincontainer {
	font-family: "Open Sans", sans-serif, 돋움;
}

div#loginheader {
	height: 150px;
	display: flex;
	justify-content: space-between;
	border-bottom: solid 2px #0843ad;
}

ul {
	list-style-type: none;
}

span.sname {
	font-size: 30pt;
	font-weight: 600;
}

span.sinfo {
	font-family: "Open Sans", sans-serif;
	font-size: 18pt;
	font-weight: 500;
}

div#logo {
	padding-left: 30px;
}

span.btn {
	cursor: pointer;
	margin: 3px;
	background-color: #0843ad;
	color: white;
	border-radius: 20px;
	font-weight: bold;
	font-size: 12pt;
}

div#loginWrapper {
	
	border: solid 2px #0843ad;
	border-radius: 20px;
	margin: 60px auto;
	padding: 30px;
	width: 60%;
	
}

form#loginform {
	display: flex;
	flex-direction: column;
	align-items: center;
}


</style>

<script type="text/javascript">
$(document).ready(function(){
    
    $("button#btnLOGIN").click(function() {
       func_Login();
    }); // end of $("#btnLOGIN").click();-----------------------
    
    $("input#pwd").keydown(function(event){
       
       if(event.keyCode == 13) { // 엔터를 했을 경우
          func_Login();
       }
    }); // end of $("#pwd").keydown();-----------------------   
    
}); // end of $(document).ready()---------------------------    

function func_Login() {
    
    var userid = $("#userid").val(); 
    var pwd = $("#pwd").val(); 
   
    if(userid.trim()=="") {
        alert("아이디를 입력하세요!!");
       $("#userid").val(""); 
       $("#userid").focus();
       return;
    }
   
    if(pwd.trim()=="") {
       alert("비밀번호를 입력하세요!!");
       $("#pwd").val(""); 
       $("#pwd").focus();
       return;
    }

    var frm = document.loginFrm;
    
    frm.action = "<%=ctxPath%>/loginhsEnd.sky";
	frm.method = "POST";
	frm.submit();

	} // end of function func_Login(event)-----------------------------
</script>

<body>
	<div id="logincontainer">
		<div id="loginheader">

			<div id="logo">
				<img src="<%=ctxPath%>/resources/images/logo_size.jpg"
					style="width: 250px; height: 100px;">
			</div>
			<div id="loginStudent">
				<span class="sname">통합로그인</span>
			</div>
			<div id="btn" style="margin-right: 30px; margin-top: 20px;">
				<span class="btn" onclick="location.href='<%=ctxPath%>/index.sky';">커뮤니티</span>
			</div>

		</div>

		<div id="mycontent">

			<div id="loginWrapper">
				<h2 class="text-primary" style="text-align: center;">로그인</h2>

				<form id="loginform" name="loginFrm">
					<div style="width: 60%;">
						<label for="userid">학번</label>
						<input type="text" class="form-control loginInput" name="userid" id="userid" value="" />
					</div>
					<div style="width: 60%;">
						<label for="pwd">비밀번호</label>
						<input type="password" class="form-control loginInput" name="pwd" id="pwd" value=""/>
					</div>
					<br/>
					<button class="btn btn-primary" type="button" id="btnLOGIN"  style="width: 60%;">로그인</button>
				</form>
				
			</div>

		</div>
	</div>
</body>
</html>