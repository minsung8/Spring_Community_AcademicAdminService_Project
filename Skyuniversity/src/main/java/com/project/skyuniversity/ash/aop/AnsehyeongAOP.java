package com.project.skyuniversity.ash.aop;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.project.skyuniversity.ash.model.CommuMemberLevelVO;
import com.project.skyuniversity.ash.model.CommuMemberVO;
import com.project.skyuniversity.ash.service.InterAnsehyeongService;
import com.project.skyuniversity.ash.common.MyUtil;

@Aspect     // 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component
public class AnsehyeongAOP {
	
	
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
	@Pointcut("execution(public * com.project.skyuniversity..*Controller.anRequiredLogin_*(..))")
	public void anRequiredLogin() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("anRequiredLogin()")
	public String anRequiredLogin(JoinPoint joinPoint) { // 로그인 유무 검사를 하는 메소드 작성하기 
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		// 로그인 유무를 확인하기 위해서는 request를 통해 session을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		
		if( session.getAttribute("loginuser") == null ) {
			String message = "먼저 로그인 하세요~~~111111";
			String loc = request.getContextPath()+"/index.sky";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< // 
			// === 현재 페이지의 주소(URL) 알아오기 === //
			
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다. 
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
				return null;
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				
			}
		}
		return null;
		
	}
	
	
	
	
	
	//  비정상적인 경로로 접근하는 경우를 막자!
	@Pointcut("execution(public * com.project.skyuniversity..*Controller.*anGetCheck_*(..))")
	public void anGetCheck() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("anGetCheck()")
	public void anGetCheck(JoinPoint joinPoint) { 
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.
				
		String method = request.getMethod();
		HttpSession session = request.getSession();
		
		if( "GET".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로입니다~~111111";
			String loc = "javascript:history.back()";
			
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
	
	//  닉네임이 없이 글을 쓰는 녀석들을 막아보자
	@Pointcut("execution(public * com.project.skyuniversity..*Controller.anNicknameCheck_*(..))")
	public void anNicknameCheck() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("anNicknameCheck()")
	public void anNicknameCheck(JoinPoint joinPoint) { // 닉네임 체크를 한다.
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		// 로그인 유무를 확인하기 위해서는 request를 통해 session을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		
		if( session.getAttribute("loginuser") == null ) {
			String message = "먼저 로그인 하세요~~~222222";
			String loc = request.getContextPath()+"/index.sky";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< // 
			// === 현재 페이지의 주소(URL) 알아오기 === 
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다. 
			
			System.out.println(url);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
			
			if( loginuser.getNickname() == null || loginuser.getNickname().isEmpty()) {
				String message = "닉네임 설정을 먼저 해주세요~~111111111";
				String loc = request.getContextPath()+"/updateNicknameStart.sky";
				
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
		
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	// =====#97. After Advice(보조업무) 만들기 ====== // 
	/*
	    주업무(<예: 글쓰기, 제품구매 등등>)를 실행한 다음에  
	    회원의 포인트를 특정점수(예: 100점, 200점, 300점) 증가해 주는 것이 공통의 관심사(보조업무)라고 보자.
	    관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	    동작하도록 만들겠다.
	*/	
	
	// === Pointcut(주업무)을 설정해야 한다. === // 
	//     Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다. 
	@Autowired
	InterAnsehyeongService service;
	
	@Pointcut("execution(public * com.project..*Controller.*marketPointPlus_*(..))")
	public void marketPointPlus() {}
	
	// === After Advice(공통관심사, 보조업무)를 구현한다. === //
	@SuppressWarnings("unchecked") // 앞으로는 노란줄 경고 표시를 하지 말라는 뜻이다.  
	@After("marketPointPlus()")
	public void marketPointPlus(JoinPoint joinPoint) { 
		// 회원의 포인트를 특정점수(예 100점,200점,300점) 만큼 증가시키는 메소드 작성하기 
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];  // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.
		HttpSession session = request.getSession();
		
		CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
		
		
		Map<String,String> paraMap = (Map<String,String>) joinPoint.getArgs()[2];  
		// 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다. 
		int n1 = 0;
		
		if (paraMap.get("addPoint") != null || !"".equals(paraMap.get("addPoint"))) {
			n1 = service.marketPointPlus(paraMap);			
		}
		
		if (n1 == 1) {
			int point = Integer.parseInt(paraMap.get("point")) + Integer.parseInt(paraMap.get("addPoint"));
			paraMap.put("point", String.valueOf(point));
		}
		
		if (paraMap.get("point") != null || !"".equals(paraMap.get("point"))) {
			String levelNo = service.getLevelNo(paraMap, loginuser);
			
			if ( levelNo != null  && !"".equals(levelNo)) {
				if (!String.valueOf(loginuser.getLevelvo().getLevelNo()).equals(levelNo)) {
					
					
					paraMap.put("levelNo", levelNo);
					
					int n = service.levelUp(paraMap);
					
					if ( n == 1 ) {
						
						loginuser.setFk_levelNo(Integer.parseInt(levelNo));
						CommuMemberLevelVO levelvo = service.getLoginUserLevel(loginuser);
						loginuser.setLevelvo(levelvo);
					}
				}
			}
			
			session.setAttribute("loginuser", loginuser);
			
			String message = "글등록 성공했어요~";
			String loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + paraMap.get("boardKindNo");
			
			if (paraMap.get("categoryNo") != null && !"".equals(paraMap.get("categoryNo"))) {
				loc += "&categoryNo=" + paraMap.get("categoryNo");
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
}
