package com.project.skyuniversity.minsung.aop;

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

import com.project.skyuniversity.minsung.common.MyUtil;
import com.project.skyuniversity.minsung.service.InterMinsungService;

@Aspect
@Component
public class MinsungAOP {	

	@Pointcut("execution(public * com.project.skyuniversity..*Controller.requiredLoginMS_*(..))")
	public void requiredLoginMS() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("requiredLoginMS()")
	public void loginCheck(JoinPoint joinPoint) { // 로그인 유무 검사를 하는 메소드 작성하기 
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		// 로그인 유무를 확인하기 위해서는 request를 통해 session을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		
		if( session.getAttribute("loginuser") == null ) {
			String message = "먼저 로그인 하세요~~~";
			String loc = request.getContextPath()+"/";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< // 
			// === 현재 페이지의 주소(URL) 알아오기 === 
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다. 
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		
	}
   
   
   // === Pointcut(주업무)을 설정해야 한다. === // 
   //     Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다. 
	
	  @Autowired
	  InterMinsungService service;
	  @Pointcut("execution(public * com.project.skyuniversity..*Controller.*pointPlusMS_*(..))")
	  public void pointPlusMS() {}
	   
	   // === After Advice(공통관심사, 보조업무)를 구현한다. === //
	  @SuppressWarnings("unchecked") // 앞으로는 노란줄 경고 표시를 하지 말라는 뜻이다.
	  @After("pointPlusMS()")
	  public void pointPlusMS(JoinPoint joinPoint) { 
		  
	       		   
		   HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[3];
		   HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[4];
		   
		   Map<String, String> paraMap = (Map<String, String>) joinPoint.getArgs()[0]; 
		   // 주업무 메소드의 첫번쨰 파라미터를 얻어오는 것이다. 
		   
		   String fk_boardKindNo = paraMap.get("fk_boardKindNo");
		   String boardName = paraMap.get("boardName");
		   String fk_memberNo = request.getParameter("fk_memberNo");
		   
		   paraMap.put("fk_memberNo", fk_memberNo);
		   
		   String message = "";
		   String loc = "";
		   		   
		   if (paraMap.get("fk_memberNo") != null) { // 글쓰기에 성공해서 회원번호가 넘어오면 
			   service.pointPlus(paraMap);
			   
			   message = "글쓰기가 완료되었습니다.";
			   loc = request.getContextPath()+"/minsungBoardList.sky?boardKindNo="+fk_boardKindNo;
			   
			  // return "redirect:/boardList.sky?boardKindNo="+fk_boardKindNo;
		   }else { // 글쓰기에 실패해서 회원번호가 넘어오지 않으면
			   message = "글쓰기에 실패했습니다.";
			   loc = request.getContextPath()+"/minsungAdd.sky?boardKindNo="+fk_boardKindNo+"&boardName="+boardName;

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