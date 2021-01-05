<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	div.container {
		width: 80%;
		height: 900px;
		border: solid 1px gray;
	}

	select#category {
		width: 30%;
	}

	input#subject {
		width: 85%;
	}


	ul {
		list-style: none;
	}
	
	ul > li:nth-child(4), li:nth-child(5) {
		margin-top: 20px;
	}
	
	button {
		width: 80px;
		height: 30px;
		margin: 0 20px;
		border-radius: 5%;
		border: none;
		background-color: #0841ad;
		color: white;
	}
	
	button:hover {
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		<%-- === 스마트 에디터 구현 시작  === --%>
   		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
	    <%-- === 스마트 에디터 구현 끝  === --%>
      
		// 등록 버튼을 누르면 컨트롤러로 넘어가 내용을 저장한다.
	   	$("button#btnRegister").click(function() {
			
	   		<%-- === 스마트 에디터 구현 시작  === --%>
		  	//id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		    <%-- === 스마트 에디터 구현 끝  === --%>
	   		
	   		// 카테고리를 고르지 않으면 등록되지 않는다.
	   		var category = $("select#category").val();
	   		if (category == 0) {
				alert("분류를 선택해주세요.");
				return false;
			}
	   		
	   		// 제목을 입력하지 않으면 등록되지 않는다.
	   		var subject = $("input#subject").val().trim();
	   		if (subject == "") {
				alert("제목을 입력해주세요.");
				return false;
	   		}
	   		
	   		<%-- === 스마트에디터 구현 시작 === --%>
	        //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("#content").val();
              
           // === 확인용 ===
           // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
           // "<p>&nbsp;</p>" 이라고 나온다.
           
           // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
           // 글내용 유효성 검사 
           if(contentval == "" || contentval == "<p>&nbsp;</p>") {
              alert("글내용을 입력하세요!!");
              return;
           }
           
           // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
           contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	       /*    
	                 대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	           ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                        그리고 뒤의 gi는 다음을 의미합니다.
	
	              g : 전체 모든 문자열을 변경 global
	              i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	       */    
	           contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	           contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	           contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	       
	        $("textarea#content").val(contentval);
	        // alert(contentval);
	       <%-- === 스마트에디터 구현 끝 === --%>
	       var fk_categoryNo = $("#category option:selected").val();
	       $("#fk_categoryNo").val(fk_categoryNo);
	       
	   		var frm = document.registerForm;
			frm.method = "POST";
			frm.action = "<%= request.getContextPath()%>/minsungAddEnd.sky";
			frm.submit();
		});
	   
   	});// end of $(document).ready(function() {});-------------------------------------

   	

</script>
    
<div class="container"  align="left" class="form-group">
	<form class="form-inline" name="registerForm" enctype="multipart/form-data">		
		<input type="hidden" name="fk_boardKindNo" value="${infoMap.boardKindNo}" />
		<input type="hidden" name="fk_memberNo" value="${sessionScope.loginuser.fk_memberNo}" />
		<input type="hidden" name="boardName" value="${infoMap.boardName}" />
		<input type="hidden" id="fk_categoryNo" name="fk_categoryNo" value="" />
		<ul>
			<li><h2>${infoMap.boardName}</h2></li>
			<li><h3>작성자&nbsp;:&nbsp;${sessionScope.loginuser.nickname}</h3></li>
			<li>
				<c:if test="${not empty categoryList}">
					<select class="form-control" id="category" name="category" style="width: 10%;">
						<option value="0" selected>분류</option>
						<c:if test="${sessionScope.loginuser.fk_memberNo eq 3}"><option value="1">공지</option></c:if>
						<c:forEach var="category" items="${categoryList}">
							<option value="${category.categoryNo}">${category.categoryName}</option>
						</c:forEach>
					</select>
				<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" />
				</c:if>
				<c:if test="${empty categoryList}">
					<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" style="width: 95.4%;" />
				</c:if>
			</li>
			<li>
				<textarea class="form-control" id="content" name="content" rows="30" style="width: 95.4%; resize: none;" placeholder="내용을 입력해 주세요"></textarea>
			</li>
			<li>
				<input class="form-control" type="file" name="attach" /><br>
			</li>
		</ul>
		<div align="center">
			<button id="btnRegister">등록</button>
			<button type="reset" onclick="javascript:history.back()">취소</button>
		</div>
	</form>
	
</div>    
