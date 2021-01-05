<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>
    
<style type="text/css">
	div#nickname-container {
		height: 300px;
		margin-top: 40px;
		/* border: solid 1px red; */
		width: 30%;
	}
	
	div#nickname-minicontainer {
		margin: 20px;
	}
	
	div#nickname-minicontainer label{
		display: inline-block;
		width: 80px;
		/* border: solid 1px red; */
	}
	
	div#buttons {
		margin: 30px;
	}
	
	button.nickname-button {
		margin: 0 20px;
	}
	
	


</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("span.nickname-error").hide();
		
		
		$("input#nickname").blur(function() {
			if ($(this).val().trim() == "") {
				$("span#nickname-error").html("빈칸 입력점ㅎ").css({'color':'red', 'font-size':'15pt'});
				$("input#nickname").focus();
			} else {
				checkReg();				
			}
			
		});
		
		$("input#nickname").keydown(function(event){
			
			if (event.keyCode == 13) {
				if ($(this).val().trim() == "") {
					$("span#nickname-error").html("빈칸 입력점ㅎ").css({'color':'red', 'font-size':'15pt'});
					$("input#nickname").focus();
					return;
				} else {
					checkReg();
					goRegNickname();
				}
			}
			
		});
		
	
		
	});
	
	function checkReg() {  // 정규표현식 확인하는 메서드
		var nickname = $("input#nickname").val().trim();
		
		var regExp = /^[가-힣a-zA-Z0-9]{4,8}$/g;
		
		var bool = regExp.test(nickname);	
		
		if (!bool) {
			$("span#nickname-error").html("형식에 안맞아용").css({'color':'red', 'font-size':'15pt'});
			$("span#nickname-error").focus();
		} else {
			$("span#nickname-error").text("");
		}
		
		
	}
	function goRegNickname() {
		var error = $("span#nickname-error").text();
		
		
		if (error != "" ) { // 비어있지 않으면 다시입력해야되고
			$("span#nickname-error").focus();
			return;
		} else {
			var frm = document.updateNicknameFrm
			frm.action = "<%= ctxPath%>/updateNicknameEnd.sky";
			frm.method = "POST";
			frm.submit();
		}
		
	}
</script>


<div id="nickname-container" class="hanna">
	<h2>닉네임 설정</h2>
    <div id="nickname-minicontainer">
	    <form name="updateNicknameFrm" id="updateNicknameFrm" method="POST">
	        
			<label for="nickname"  >&nbsp;닉네임&nbsp;:&nbsp;</label>
			<input type="text" name="nickname" id="nickname" autocomplete="off" maxlength="30pt" placeholder="한글/영어/숫자조합/ 4-8자리" />
			<input type="hidden" name="commuMemberNo" value="${sessionScope.loginuser.commuMemberNo}">
			<input type="text" style="display: none;" />
			<br>
			<span id="nickname-error"></span>
            <div id="buttons" style="text-align: center;">
                <button type="button" class="nickname-button" onclick="goRegNickname()">등록</button>
                
            </div>	        
	    </form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/tiles1/main/index.jsp" />
