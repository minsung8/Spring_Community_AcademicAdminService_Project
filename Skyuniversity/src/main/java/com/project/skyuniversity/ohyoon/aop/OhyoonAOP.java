package com.project.skyuniversity.ohyoon.aop;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.project.skyuniversity.ohyoon.common.MyUtil;
import com.project.skyuniversity.ohyoon.service.InterOhyoonService;

// === #53. 공통관심사 클래스(Aspect 클래스)생성하기 === //
@Aspect     // 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component  // bean 으로 등록된다.
public class OhyoonAOP {

   // ===== Before Advice(보조업무) 만들기 ====== // 
   /*
       주업무(<예: 글쓰기, 글수정, 댓글쓰기 등등>)를 실행하기 앞서서  
       이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
       주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
       관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
       동작하도록 만들겠다.
   */   
   
   // === Pointcut(주업무)을 설정해야 한다. === // 
   //     Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다. 
   @Pointcut("execution(public * com.project..*Controller.requiredLoginOY_*(..))")
   public void requiredLogin() {}
   
   // === Before Advice(공통관심사, 보조업무)를 구현한다. === //
   @Before("requiredLogin()")
   public void loginCheck(JoinPoint joinPoint) { // 로그인 유무 검사를 하는 메소드 작성하기 
      // JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
      
      // 로그인 유무를 확인하기 위해서는 request를 통해 session을 얻어와야 한다.
      HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // getArgs()[0]는 주업무 메소드에 있는 파라미터 중 첫번째 파라미터를 가져오는 것이다. 
      HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // getArgs()[1]는 주업무 메소드에 있는 파라미터 중 두번째 파라미터를 가져오는 것이다.
      
      HttpSession session = request.getSession();
      
      if( session.getAttribute("loginuser") == null ) {
         String message = "로그인이 필요합니다.";
         String loc = request.getContextPath()+"/index.sky";
         
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);
         
         // >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< //
         // === 현재 페이지의 주소(URL) 알아오기 === 
         String url = MyUtil.getCurrentURL(request);
         session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시킨다.
         
         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
         
         try {
            dispatcher.forward(request, response);
         } catch (ServletException | IOException e) {
            e.printStackTrace();
         }
      }
      
   }
   
   
   
   // ===== #97. After Advice(보조업무) 만들기 ====== // 
   /*
	      주업무(<예: 글쓰기, 제품구매 등등>)를 실행하기 앞서서  
	      회원의 포인트를 특정점수(예: 100점, 200점, 300점) 증가해주는 것이 공통의 관심사(보조업무)라고 보자.
	      관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	      동작하도록 만들겠다.
   */
   // === Pointcut(주업무)을 설정해야 한다. === // 
   //     Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다. 
   @Autowired
   InterOhyoonService service;
   
   @Pointcut("execution(public * com.project..*Controller.pointPlusOY_*(..))")
   public void pointPlus() {}
   
   // === After Advice(공통관심사, 보조업무)를 구현한다. === //
   @SuppressWarnings("unchecked") // 앞으로는 노란줄 경고 표시를 하지 말라는 뜻이다.
   @After("pointPlus()")
   public void pointPlus(JoinPoint joinPoint) { // 회원의 포인트를 100점 증가시키는 메소드 작성하기
       // 회원의 포인트를 특정점수(예: 100점, 200점, 300점)만큼 증가시키는 메소드 작성하기
	   // JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
       
	   HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[1];
	   HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[2];
	   
	   Map<String, String> paraMap = (Map<String, String>) joinPoint.getArgs()[0]; 
	   // 주업무 메소드의 첫번쨰 파라미터를 얻어오는 것이다. 
	   
	   String fk_boardKindNo = paraMap.get("fk_boardKindNo");
	   String boardName = paraMap.get("boardName");

	   
	   
	   String message = "";
	   String loc = "";
	   
	   if (paraMap.get("fk_memberNo") != null) { // 글쓰기에 성공해서 회원번호가 넘어오면 
		   service.pointPlus(paraMap);
		   
		   message = "글쓰기가 완료되었습니다.";
		   loc = request.getContextPath()+"/boardList.sky?boardKindNo="+fk_boardKindNo;
		   
		  // return "redirect:/boardList.sky?boardKindNo="+fk_boardKindNo;
	   }else { // 글쓰기에 실패해서 회원번호가 넘어오지 않으면
		   message = "글쓰기에 실패했습니다.";
		   loc = request.getContextPath()+"/boardRegister.sky?boardKindNo="+fk_boardKindNo+"&boardName="+boardName;

		   // return "redirect:/boardRegister.sky?boardKindNo="+fk_boardKindNo+"&boardName="+boardName;
	   }
	   
	   request.setAttribute("message", message);
	   request.setAttribute("loc", loc);
	   
	   RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	   
	   try {
		   dispatcher.forward(request, response);
	   } catch (ServletException | IOException e) {
		   e.printStackTrace();
	   }
	   
   }
   
   
   
}