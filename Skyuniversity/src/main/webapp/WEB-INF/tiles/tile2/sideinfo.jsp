<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style>
/*   .sidenav {
  height: 100%;
  width: 250px;
  position: fixed;
  top: 100px;
  left: 0;
  background-color: #ffff;
  padding-top: 60px;
} */

 li.menu1 {
    border: 2px solid #0843ad;
    height: 30px;
    margin: 2px;
    border-radius: 20px;
    font-weight: bold;
    width: 100%;
 }   
 
 li.menu2 {
     height: 30px;
    margin: 2px;
    /* cursor: pointer; */
    /* background-color: rgb(43,121,194, 0.5); */
    margin:0;
 }
 
 ul#myMenu {
    list-style-type: none;
    width: 225px;
    margin: 0;
    padding: 0;
   line-height: 27px;    
 }
 
 div#search {
    margin: 50px auto;
    width: 100%;
 }
 
 input#searchInput {
    border: 0px;
    border-bottom: solid 2px #0843ad;
    outline: none;
    max-width : 100%;
 }
 
 span#searchbtn {
   cursor: pointer;
 }
 
 .choice {
    font-weight: bold;
    background-color: #0843ad;
    color: white;
    cursor: pointer;
 }

</style>

<script type="text/javascript">

   $(document).ready(function(){
      
      $("li.menu2").hide();
      
      $("li.menu1").hover(function(){
         $(this).addClass("choice");
      }, function(){
         $(this).removeClass("choice");
      });
      $("li.menu2").hover(function(){
         $(this).addClass("choice"); 
      }, function(){
         $(this).removeClass("choice");
      });
      
      $("li#stuentInfo").click(function(){
         $("li.stuentInfo").toggle();
      });
      
      
      $("li#clases").click(function(){
         $("li.clases").toggle();
      });
      
      
      $("li#resister").click(function(){
         $("li.resister").toggle();
      });
      
      
      $("li#grade").click(function(){
         $("li.grade").toggle();
      });
      
      
      $("li#graduate").click(function(){
         $("li.graduate").toggle();
      });
      
      // 검색기능
      $("input#searchInput").keyup(function(){
         if(event.keyCode == 13){
            goSearchMenu();
         }
      });
      
   }); // end of $(document).ready(function(){})-------------------------

    function goSearchMenu() {
       
       var input = $("input#searchInput").val();
        
        if(input != ""){
           
         var arrMenuList = [];
           
         // arrMenuList => menu2 텍스트값의 배열 
         $("li.menu2").each(function(){
           arrMenuList.push($(this).text());
         });
         
         $("li.menu2").hide();
         // arrMenuList 반복문 돌리기
         $.each(arrMenuList, function(index, item){
           // 해당요소에 input 텍스트 값이 있다면
           if(item.indexOf(input) > -1) {
            $("li.menu2").each(function(){ // li.menu2 반복문
               if($(this).text() == item){ // li.menu2의 텍스트 값이 item과 일치할경우
                   $(this).show(); //해당 li태그를 보여줌
               }
            });
          }
             
          });
        }
        else {
           $("li.menu2").each(function(){ // li.menu2 반복문
               $(this).hide();
           });
        }// end of if()  
   }// end of goSearchMenu() ------------------------
</script>
 

<div align="center">

   <div id="search">
      <input id="searchInput"/>
      <span id="searchbtn" onclick="goSearchMenu();"><img src="<%= ctxPath %>/resources/images/searchicon_jh.png" style="width: 20px; height: 20px;"/></span>
   </div>
   
   <div id="menu" style="width: 100%;">
      <ul id="myMenu" style="width: 100%;">
         <li id="stuentInfo" class="menu1">학생정보</li>
            <li class="stuentInfo menu2" onclick="javascript:location.href='<%=ctxPath%>/lookupStudentInfo.sky'">학생정보조회</li>
               <li class="stuentInfo menu2" onclick="javascript:location.href='<%=ctxPath%>/changepwd.sky'">비밀번호변경</li>
               <li class="stuentInfo menu2" onclick="javascript:location.href='<%=ctxPath%>/schedule.sky'">학사일정</li>
               <li class="stuentInfo menu2" onclick="javascript:location.href='<%=ctxPath%>/certificate.sky'">증명서발급</li>
         <li id="clases" class="menu1">수업</li>
             <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/registerClassInfoSubs.sky'">수강신청 과목조회</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/registerClass.sky'">수강신청</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/registerSubjects.sky'">수강과목</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/classCheck.sky'">강의평가</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/girlOfficalLeave.sky'">여학생공결신청</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/officalLeave.sky'">공결신청</li>
               <li class="clases menu2" onclick="javascript:location.href='<%=ctxPath%>/officalLeaveInfo.sky'">공결신청조회</li>
         <li id="resister" class="menu1">학적관리</li>
               <li class="resister menu2" onclick="javascript:location.href='<%=ctxPath%>/armyLeaveSchool.sky'">군휴학</li>
               <li class="resister menu2" onclick="javascript:location.href='<%=ctxPath%>/leaveSchool.sky'">일반휴학</li>
               <li class="resister menu2" onclick="javascript:location.href='<%=ctxPath%>/leaveSchoolInfo.sky'">휴학결과조회</li>
               <li class="resister menu2" onclick="javascript:location.href='<%=ctxPath%>/comeSchool.sky'">복학신청 및 결과조회</li>
         <li id="grade" class="menu1">성적</li>
               <li class="grade menu2" onclick="javascript:location.href='<%=ctxPath%>/totalGrade.sky'">기이수성적조회</li>
               <li class="grade menu2" onclick="javascript:location.href='<%=ctxPath%>/thisSemesterGrade.sky'">당학기성적조회</li>
               <%-- <li class="grade menu2" onclick="javascript:location.href='<%=ctxPath%>/printReportCard.sky'">성적표출력</li> --%>
               <li class="grade menu2" onclick="javascript:location.href='<%=ctxPath%>/statusOfComplete.sky'">교양 및 전공필수 이수현황</li>
         <li id="graduate" class="menu1">졸업</li>
               <li class="graduate menu2" onclick="javascript:location.href='<%=ctxPath%>/graduateDelay.sky'">졸업연기</li>
               <li class="graduate menu2" onclick="javascript:location.href='<%=ctxPath%>/graduateTest.sky'">졸업적부심사</li>
               <li class="graduate menu2" onclick="javascript:location.href='<%=ctxPath%>/earlyGraduate.sky'">조기졸업신청 및 결과조회</li>
      </ul>
   </div> 
</div>
