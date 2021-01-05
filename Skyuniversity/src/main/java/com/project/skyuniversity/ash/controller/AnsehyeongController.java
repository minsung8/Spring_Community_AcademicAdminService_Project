package com.project.skyuniversity.ash.controller;
/*
사용자 웹브라우저 요청(View)  ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
(http://...  *.action)                                  |                                                                                                                              
 ↑                                                View Resolver
 |                                                      ↓
 |                                                View단(.jsp 또는 Bean명)
 -------------------------------------------------------| 

사용자(클라이언트)가 웹브라우저에서 http://localhost:9090/board/test_insert.action 을 실행하면
배치서술자인 web.xml 에 기술된 대로  org.springframework.web.servlet.DispatcherServlet 이 작동된다.
DispatcherServlet 은 bean 으로 등록된 객체중 controller 빈을 찾아서  URL값이 "/test_insert.action" 으로
매핑된 메소드를 실행시키게 된다.                                               
Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
실행되어진 결과값을 @Controller 단으로 넘겨준다.
*/

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.skyuniversity.ash.model.BannerVO;
import com.project.skyuniversity.ash.model.CommuMemberVO;
import com.project.skyuniversity.ash.model.MarketBoardVO;
import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.ash.service.InterAnsehyeongService;
import com.project.skyuniversity.jihyun.model.JihyunMemberVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.minsung.model.MinsungMsgVO;
import com.project.skyuniversity.minsung.service.InterMinsungService;
import com.project.skyuniversity.ohyoon.model.CommentVO;
import com.project.skyuniversity.ash.common.AnFileManager;
import com.project.skyuniversity.ash.common.MyUtil;
import com.project.skyuniversity.ash.common.Sha256;

//=== #30. 컨트롤러 선언 === 
@Component
/*
 * XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 그리고
 * bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 즉, 여기서 bean의 이름은 boardController 이 된다.
 * 여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도
 * BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다.
 */
@Controller
public class AnsehyeongController {

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	// ※ 의존객체주입(DI : Dependency Injection)
	// ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
	// 스프링 컨테이너는 bean으로 등록되어진 BoardController 클래스 객체가 사용되어질때,
	// BoardController 클래스의 인스턴스 객체변수(의존객체)인 BoardService service 에
	// 자동적으로 bean 으로 등록되어 생성되어진 BoardService service 객체를
	// BoardController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency
	// Injection)이라고 부른다.
	// 이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
	// 즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고,
	// 필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다.
	// 스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
	// 객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전
	// 이라고 부른다.
	// 그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.

	// IOC(Inversion of Control) 란 ?
	// ==> 스프링 프레임워크는 사용하고자 하는 객체를 빈형태로 이미 만들어 두고서 컨테이너(Container)에 넣어둔후
	// 필요한 객체사용시 컨테이너(Container)에서 꺼내어 사용하도록 되어있다.
	// 이와 같이 객체 생성 및 소멸에 대한 제어권을 개발자가 하는것이 아니라 스프링 Container 가 하게됨으로써
	// 객체에 대한 제어역할이 개발자에게서 스프링 Container로 넘어가게 됨을 뜻하는 의미가 제어의 역전
	// 즉, IOC(Inversion of Control) 이라고 부른다.

	// === 느슨한 결합 ===
	// 스프링 컨테이너가 BoardController 클래스 객체에서 BoardService 클래스 객체를 사용할 수 있도록
	// 만들어주는 것을 "느슨한 결합" 이라고 부른다.
	// 느스한 결합은 BoardController 객체가 메모리에서 삭제되더라도 BoardService service 객체는 메모리에서 동시에
	// 삭제되는 것이 아니라 남아 있다.

	// ===> 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해서 생성해주던 것)
	// private InterBoardService service = new BoardService();
	// ===> BoardController 객체가 메모리에서 삭제 되어지면 BoardService service 객체는 멤버변수(필드)이므로
	// 메모리에서 자동적으로 삭제되어진다.

	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private InterAnsehyeongService service;
	
	@Autowired
	private InterMinsungService service2;

	@Autowired
	private AnFileManager fileManager;

	// === #36. 메인 페이지 요청 === //
	@RequestMapping(value = "/index.sky")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {

		// 인덱스의 캐러셀에 들어갈 배너 광고를 가져오기
		List<BannerVO> bannerList = service.getBannerList();

		HttpSession session = request.getSession();
		
		
		try {
			if(!"CommuMemberVO".equals(session.getAttribute("loginuser").getClass().getSimpleName())) {
				String fk_memberNo = ((JihyunMemberVO)session.getAttribute("loginuser")).getMemberNo();
				
				CommuMemberVO loginuser = service.getLoginuserFromHs(fk_memberNo);	
				
				session.setAttribute("loginuser", loginuser);
				
			}
		} catch (NullPointerException e) {
			
		}
		
		//  각각의 보드에서 글 리스트를 꺼내온다.
		
		List<MarketBoardVO> indexBoardList = service.getIndexBoardList();
		
		
		List<MarketBoardVO> recentBoardList = service.recentIndexBoardList();
		List<MarketBoardVO> bestBoardList = service.bestIndexBoardList();
		List<MarketBoardVO> popularBoardList = service.popularIndexBoardList();
		
		mav.addObject("indexBoardList", indexBoardList);
		mav.addObject("recentBoardList", recentBoardList);
		mav.addObject("bestBoardList", bestBoardList);
		mav.addObject("popularBoardList", popularBoardList);
		
		
		session.setAttribute("readCountPermission", "yes");
		mav.addObject("bannerList", bannerList);
		mav.setViewName("main/index.tiles1");
		// /WEB-INF/views/tiles1/main/index.jsp 파일을 생성한다.

		return mav;
	}

	// === 로그인 요청 하기 입니다! === //
	@RequestMapping(value = "/login.sky") // , method = { RequestMethod.POST }
	public ModelAndView anGetCheck_login(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		try {
			Integer.parseInt(id);

		} catch (Exception e) {
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			// /WEB-INF/views/msg.jsp 파일을 생성한다.

			return mav;

		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("id", id);
		paraMap.put("pwd", Sha256.encrypt(pwd)); // <<<<<<<< 암호는 나중에 암호화 해서 맵에 넣어주야 함!

		CommuMemberVO loginuser = service.getLoginUser(paraMap);

		if (loginuser == null) { // 로그인 실패시
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			// /WEB-INF/views/msg.jsp 파일을 생성한다.
		}

		else { // 아이디와 암호가 존재하는 경우

			HttpSession session = request.getSession();
			// 메모리에 생성되어져 있는 session을 불러오는 것이다.
			
			session.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
			
	    	int loginNo = 0;
	    	List<MinsungMsgVO> getMsgList = null;
	    	String getMsgListSize = "0";
	    	
	    	loginNo = ( (CommuMemberVO)session.getAttribute("loginuser") ).getFk_memberNo();
	    	getMsgList = service2.getMsgList(loginNo);
	    	getMsgListSize = String.valueOf(getMsgList.size());
	    	
	    	session.setAttribute("getMsgListSize", getMsgListSize);
			
			
			if ("".equals(loginuser.getNickname()) || loginuser.getNickname() == null) {
				String message = "닉네임을 설정해주세요 🌽🌽🌽🌽";
				String loc = request.getContextPath() + "/updateNicknameStart.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				// /WEB-INF/views/msg.jsp 파일을 생성한다.

				return mav;
			} else {
				// 특정 제품상세 페이지를 보았을 경우 로그인을 하면 시작페이지로 가는 것이 아니라
				// 방금 보았던 특정 제품상세 페이지로 가기 위한 것이다.
				String goBackURL = (String) session.getAttribute("goBackURL");

				if (goBackURL != null) {
					mav.setViewName("redirect:/" + goBackURL);
					session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
				} else {
					mav.setViewName("redirect:/index.sky");
				}
			}

		}
		return mav;
	}

	// === 로그아웃 처리하기 === //
	@RequestMapping(value = "/logout.sky")
	public ModelAndView anRequiredLogin_logout(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		HttpSession session = request.getSession();

		String loc = request.getContextPath() + "/index.sky";

		mav.addObject("loc", loc);
		mav.setViewName("msg");

		session.invalidate();
		return mav;
	}

	// === 닉네임 업데이트 요청 시작 !=== //
	@RequestMapping(value = "/updateNicknameStart.sky")
	public ModelAndView anRequiredLogin_updateNicknameStart(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 인덱스의 캐러셀에 들어갈 배너 광고를 가져오기
		List<BannerVO> bannerList = service.getBannerList();
		//  각각의 보드에서 글 리스트를 꺼내온다.
		
		List<MarketBoardVO> indexBoardList = service.getIndexBoardList();
		
		
		List<MarketBoardVO> recentBoardList = service.recentIndexBoardList();
		List<MarketBoardVO> bestBoardList = service.bestIndexBoardList();
		List<MarketBoardVO> popularBoardList = service.popularIndexBoardList();
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		mav.addObject("indexBoardList", indexBoardList);
		mav.addObject("recentBoardList", recentBoardList);
		mav.addObject("bestBoardList", bestBoardList);
		mav.addObject("popularBoardList", popularBoardList);

		mav.addObject("bannerList", bannerList);
		mav.setViewName("sehyeong/member/updateNickname.tiles1");

		return mav;
	}

	// === 닉네임 업데이트 요청 끝 !=== //
	@RequestMapping(value = "/updateNicknameEnd.sky")
	public ModelAndView anGetCheck_updateNicknameEnd(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		String nickname = request.getParameter("nickname");
		String commuMemberNo = request.getParameter("commuMemberNo");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("nickname", nickname);
		paraMap.put("commuMemberNo", commuMemberNo);

		int result = service.updateNicknameEnd(paraMap);

		if (result == 1) { // 닉네임 업데이트에 성공했을 경우 메인화면으로 돌아가주고

			HttpSession session = request.getSession();

			CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");
			loginuser.setNickname(nickname);

			session.setAttribute("loginuser", loginuser);

			String message = "닉네임 바뀜!";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		} else { // 닉네임 업데이트에 실패했을 경우 다시닉네임 업데이트 화면으로 돌아가주자
			String message = "아...실퍀ㅋㅋㅋ";
			String loc = request.getContextPath() + "/updateNicknameStart.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}

	// === 장터 게시판 리스트 페이지 요청 === //
	@RequestMapping(value = "/marketboardList.sky")
	public ModelAndView boardList(HttpServletRequest request, ModelAndView mav) {

		String boardKindNo = request.getParameter("boardKindNo");

		Map<String, String> paraMap = new HashMap<>();

		paraMap.put("boardKindNo", boardKindNo);

		// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
		List<Map<String, String>> categoryList = service.getMarketCategoryList(paraMap);

		//////////////////////////////////////////////////////////////////////

		// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
		Map<String, String> tableInfo = service.getMarketTableInfo(paraMap);

		//////////////////////////////////////////////////////////////////////

		String categoryNo = request.getParameter("categoryNo");

		if (categoryNo == null || categoryNo.trim().isEmpty()) {
			categoryNo = "";
		}

		paraMap.put("categoryNo", categoryNo);

		////////////////////////////////////////////////////////////////////
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");

		if (searchType == null || searchType.trim().isEmpty()) {
			searchType = "";
		}

		if (searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}

		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		int totalCount = 0; // 총 게시물 건수 - 검색조건이 있을 때와 없을 때로 나뉨.
		int sizePerPage = 15; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호 - 처음에는 1페이지로 나와야 함.
		int totalPage = 0; // 총 페이지 수

		int startRno = 0; // 시작 행번호
		int endRno = 0; // 끝 행번호

		// 총 게시물 건수 알아오기
		totalCount = service.getMarketTotalCount(paraMap);

		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		if (str_currentShowPageNo == null) {
			// 요청한 페이지가 없다면
			currentShowPageNo = 1;
		} else {
			try {
				// 요청한 페이지가 숫자가 아니라면
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		// 게시판 번호와 시작 게시글 번호, 끝 게시글 번호를 입력하여 해당 게시판번호에 해당하는 게시글들을 불러오기
		List<MarketBoardVO> boardList = service.getMarketBoardList(paraMap);

		// ======== 페이지바 만들기 ======== //
		String pageBar = "<ul class='pager'>";

		// 블럭당 보여지는 페이지 번호 개수
		int blockSize = 10;

		int loop = 1;
		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1; // 페이지번호 시작값

		String url = "marketboardList.sky?boardKindNo=" + boardKindNo;

		// [맨처음][이전] 만들기
		if (pageNo != 1) {
			pageBar += "<li class='pageBtn hi'><a href='" + url + "&searchType=" + searchType + "&searchWord="
					+ searchWord + "&currentShowPageNo=1" + "&categoryNo=" + categoryNo + "'>맨처음</a></li>";
			pageBar += "<li class='pageBtn hi'><a href='" + url + "&searchType=" + searchType + "&searchWord"
					+ searchWord + "&currentShowPageNo=" + (pageNo - 1) + "&categoryNo=" + categoryNo
					+ "'>Previous</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {
			if (pageNo == currentShowPageNo) {
				pageBar += "<li class='pageBtn'><a style='color: #0843ad; font-weight: bold;'>" + pageNo + "</a></li>";
			} else {
				pageBar += "<li class='pageBtn hi'><a href='" + url + "&searchType=" + searchType + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + pageNo + "&categoryNo=" + categoryNo + "'>" + pageNo
						+ "</a></li>";
			}

			loop++;
			pageNo++;
		}

		// [다음][마지막] 만들기
		if (!(pageNo > totalPage)) {
			pageBar += "<li class='pageBtn hi'><a href='" + url + "&searchType=" + searchType + "&searchWord"
					+ searchWord + "&currentShowPageNo=" + pageNo + "&categoryNo=" + categoryNo + "'>Next</a></li>";
			pageBar += "<li class='pageBtn hi'><a href='" + url + "&searchType=" + searchType + "&searchWord"
					+ searchWord + "&currentShowPageNo=" + totalPage + "&categoryNo=" + categoryNo + "'>마지막</a></li>";
		}

		pageBar += "</ul>";

		// === #123. 페이징 처리 되어진 후 특정 글제목을 클릭하여 상세 내용을 본 이후 사용자가 목록보기 버튼을 클릭 했을때 돌아갈 페이지를
		// 알려주기 위해
		// 현재 페이지 주소를 뷰딴으로 넘겨준다.

		String gobackURL2 = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL2", gobackURL2);

		//////////////////////////////////////////////////////
		// === #69. 글조회수(readCount)증가 (DML문 update)는
		// 반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		// 웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		// 이것을 하기 위해서는 session 을 사용하여 처리하면 된다.

		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		/*
		 * session 에 "readCountPermission" 키값으로 저장된 value값은 "yes" 이다. session 에
		 * "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 반드시 웹브라우저에서 주소창에
		 * "/list.action" 이라고 입력해야만 얻어올 수 있다.
		 */
		///////////////////////////////////////////////////////////////

		List<NoticeVO> noticeList = service.getNoticeList(paraMap);
		
		mav.addObject("noticeList", noticeList);
		
		mav.addObject("paraMap", paraMap);
		mav.addObject("tableInfo", tableInfo);
		mav.addObject("categoryList", categoryList);
		mav.addObject("boardList", boardList);
		mav.addObject("pageBar", pageBar);
		mav.setViewName("sehyeong/board/marketBoardList.tiles1");
		return mav;
	}

	// === 게시판 글쓰기 폼페이지 요청 === //
	@RequestMapping(value = "/marketAdd.sky")
	public ModelAndView anNicknameCheck_marketAdd(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		String boardKindNo = request.getParameter("boardKindNo");

		if (boardKindNo == null || "".equals(boardKindNo)) {
			String message = "정상적인 경로좀 ㅎㅎ";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(boardKindNo);
				int n = service.checkBoardKindNo(boardKindNo);

				if (n == 0) {
					String message = "정상적인 경로좀 ㅎㅎ";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		Map<String, String> paraMap = new HashMap<>();

		paraMap.put("boardKindNo", boardKindNo);

		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");
		List<Map<String, String>> categoryList = null;

		// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
		categoryList = service.getMarketCategoryList(paraMap);

		//////////////////////////////////////////////////////////////////////

		// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
		Map<String, String> tableInfo = service.getMarketTableInfo(paraMap);

		String writerIp = request.getRemoteAddr();
		paraMap.put("writerIp", writerIp);
		String categoryNo = request.getParameter("categoryNo");

		if (categoryNo != null && !"".equals(categoryNo)) {
			paraMap.put("categoryNo", categoryNo);
		}

		mav.addObject("paraMap", paraMap);
		mav.addObject("tableInfo", tableInfo);
		mav.addObject("categoryList", categoryList);

		mav.setViewName("sehyeong/board/marketBoardRegister.tiles1");
		// /WEB-INF/views/tiles1/sehyeong/board/marketBoardRegister.jsp 파일을 불러온다.

		return mav;
	}

	// === 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value = "/marketAddEnd.sky")
	public String anGetCheck_marketPointPlus_marketAddEnd(HttpServletRequest request, HttpServletResponse response,
			Map<String, String> paraMap, MarketBoardVO boardvo, MultipartHttpServletRequest mrequest) {

		String categoryNo = request.getParameter("hi");

		MultipartFile attach = boardvo.getAttach();

		if (!attach.isEmpty()) {
			// attach가 비어있지 않으면! (즉, 첨부 파일이 있는 경우라면~)

			/*
			 * 1. 사용자가 보낸 첨부파일을 WAS의 특정 폴더에 저장해주어야 한다. >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 우리는
			 * WAS의 webapp/resources/files라는 폴더로 지정해 준다. 조심할 것은 Package Explorer에서 files라는
			 * 폴더를 직접 만드는 것이 아니다.
			 */

			// WAS의 webapp의 절대 경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			System.out.println("this is root : " + root);

			String path = root + "resources" + File.separator + "files";

			// path 가 첨부파일이 저장될 WAS의 폴더가 된다.
			System.out.println("this is path : " + path);

			/*
			 * 2. 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */

			String newFileName = "";
			// WAS의 디스크에 저장될 파일명입니다.

			byte[] bytes = null;
			// 첨부 파일의 내용물

			long fileSize = 0;
			// 첨부파일의 크기
			try {
				bytes = attach.getBytes();
				// 첨부 파일의 내용물을 읽어 오는것

				// 첨부 되어진 파일을 업로드 되도록 하는 것이다!
				// attach.getOriginalFilename()은 첨부 파일의 파일명 (예: 강아지.png)을 얻어 오는 것 입니다!
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);

				System.out.println("확인용인디! ===>>>>>> " + newFileName);
				// 확인용인디! ===>>>>>> 202012091037071013008888107800.png

				/*
				 * 3. BoardVO boardvo에 fileName 값과 orgFilename값과 fileSize 값을 넣어주기
				 * 
				 */

				boardvo.setFileName(newFileName);
				// WAS에 저장될 파일명 => 202012091037071013008888107800.png

				boardvo.setOrgFileName(attach.getOriginalFilename());
				// 게시판 페이지에 청부된 파일을 보여줄때 사용
				// 또한 사용자가 파일을 다운로드 할때 사용!

				fileSize = attach.getSize(); // 첨부 파일의 크기 (단뒤는 byte임)

				boardvo.setFileSize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		HttpSession session = request.getSession();

		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");
		// == After Advice 를 사용하기 위해 파라미터를 생성하는 것임 ==
		// (글쓰기를 한 이후에 회원의 포인트를 3점 증가)
		// 증가하고 나서 바로 유저 포인트도 확인해서 레벨업하는지 아닌지 확인하기
		paraMap.put("fk_commuMemberNo", String.valueOf(boardvo.getFk_commuMemberNo()));
		paraMap.put("addPoint", "3");
		paraMap.put("point", String.valueOf(loginuser.getPoint()));
		///////////////////////////////////////////////////

		int n = 0;

		// 첨부 파일이 없는 경우라면~
		if (attach.isEmpty()) {
			n = service.marketAdd(boardvo);
		}

		// 첨부 파일이 있는 경우라면 ~
		if (!attach.isEmpty()) {

			n = service.marketAddFile(boardvo);
		}

		if (n == 1) {
			if (categoryNo != null && !"".equals(categoryNo)) {
				paraMap.put("boardKindNo", String.valueOf(boardvo.getFk_boardKindNo()));
				paraMap.put("categoryNo", categoryNo);

			} else {
				paraMap.put("boardKindNo", String.valueOf(boardvo.getFk_boardKindNo()));

			}
		} else {

			String message = "글 입력에 실패했삼~~";
			String loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardvo.getFk_boardKindNo();

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			return "msg";
		}
		return null;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// === 글1개를 보여주는 페이지 요청 === //
	@RequestMapping(value = "/marketBoardDetail.sky", method = {RequestMethod.GET})
	public ModelAndView anRequiredLogin_marketBoardDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 조회하고자 하는 글번호 받아오기
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");
		String gobackURL2 = request.getParameter("gobackURL2");

		
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		if (boardKindNo == null || "".equals(boardKindNo)) {
			String message = "정상적인 경로좀 ㅎㅎ";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(boardKindNo);
				paraMap.put("boardKindNo", boardKindNo);

				int n = service.checkBoardKindNo(boardKindNo);

				if (n == 0) {
					String message = "정상적인 경로좀 ㅎㅎ";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		
		
		if (boardNo == null || "".equals(boardNo)) {
			String message = "정상적인 경로좀 ㅎㅎ11";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(boardNo);
				paraMap.put("boardNo", boardNo);

				MarketBoardVO n = service.getMarketViewWithNoAddCount(paraMap);

				if (n == null) {
					String message = "정상적인 경로좀 ㅎㅎ22";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ33";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		paraMap.put("gobackURL2", gobackURL2);

		// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
		Map<String, String> tableInfo = service.getMarketTableInfo(paraMap);

		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");

		// 글1개를 보여주는 페이지 요청은 select 와 함께
		// DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
		// 이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
		// 매번 글조회수 증가가 발생한다.
		// 그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
		// 단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은
		// 실행하지 않도록 해주어야 한다. !!! === //

		
		
		MarketBoardVO boardvo = null;

		if (loginuser != null) {
			// 위의 글목록보기 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
			if ("yes".equals(session.getAttribute("readCountPermission"))) {
				// 게시글 리스트/메인페이지/검색리스트 를 클릭한 다음에 특정글을 조회해온 경우이다.

				boardvo = service.getMarketView(paraMap, loginuser);
				// 글조회수 증가와 함께 글1개를 조회를 해주는 것

				session.removeAttribute("readCountPermission");
				// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.

			} else {
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
				boardvo = service.getMarketViewWithNoAddCount(paraMap);
				// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.
			}

			List<MinsungBoardVO> recentBoardList = service.recentBoardList();
			List<MinsungBoardVO> bestBoardList = service.bestBoardList();
			List<MinsungBoardVO> popularBoardList = service.popularBoardList();

			
			mav.addObject("recentBoardList", recentBoardList);
			mav.addObject("bestBoardList", bestBoardList);
			mav.addObject("popularBoardList", popularBoardList);

			mav.addObject("boardvo", boardvo);
			mav.addObject("paraMap", paraMap);
			mav.addObject("tableInfo", tableInfo);

			mav.setViewName("sehyeong/board/marketBoardDetail.tiles1");

		}
		
		
		return mav;
	}

	@RequestMapping(value = "/fileDownloadGoGo.sky")
	public void anRequiredLogin_anGetCheck_fileDownloadGoGo(HttpServletRequest request, HttpServletResponse response) {
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");

		/*
		 * 첨부 파일이 있는 글 번호에서 fileName의 값을 가져와야 한다. 또한 orgFilename의 값도 가져와야 한다.(다운받을때 보여줄
		 * 용도)
		 */

		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = null;

		try {
			Integer.parseInt(boardNo);

			Map<String, String> paraMap = new HashMap<String, String>();

			paraMap.put("boardNo", boardNo);
			paraMap.put("boardKindNo", boardKindNo);

			MarketBoardVO boardvo = service.getMarketViewWithNoAddCount(paraMap);

			String fileName = boardvo.getFileName();

			String orgFilename = boardvo.getOrgFileName();

			// **** file 다운로드한 메서드를 불러오기 - 파일 다운로드 **** //
			boolean flag = false; // 파일 다운로드 성공 / 실패 유무

			// 첨부파일이 저장되어 있는
			// WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다.
			// 이 경로는 우리가 파일첨부를 위해서
			// /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
			// WAS 의 webapp 의 절대경로를 알아와야 한다.

			// WAS의 webapp의 절대 경로를 알아와야 한다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");

			// this is root :
			// C:\eclipse\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\

			/*
			 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
			 * 는 "\" 이고, 운영체제가 UNIX, Linux 이라면 File.separator 는 "/" 이다.
			 */
			String path = root + "resources" + File.separator + "files";
			// path 가 첨부파일이 저장될 WAS의 폴더가 된다.

			flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
			// 파일 다운로드 tjdrhd시 flag = true;
			// 파일 다운로드 실패시 flag = false;

			if (!flag) {
				try {
					writer = response.getWriter();
					writer.println(
							"<script type='text/javascript'>alert('파일 다운로드 불가맨~'); " + " history.back();</script>");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch (NumberFormatException e) {
			try {
				writer = response.getWriter();
				writer.println("<script type='text/javascript'>alert('파일 다운로드 불가맨~'); " + " history.back();</script>");
			} catch (IOException e1) {
			}
		}
	}

	// === #71. 글수정 페이지 요청 === //
	@RequestMapping(value = "/marketBoardEdit.sky")
	public ModelAndView anRequiredLogin_anGetCheck_marketBoardEdit(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {

		// 글 수정해야 할 글번호 가져오기
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");
		String gobackURL2 = request.getParameter("gobackURL2");

		System.out.println("이것은 gobackURL2 입니다 => " + gobackURL2);
		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("boardNo", boardNo);
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("gobackURL2", gobackURL2);
		
		
		
		// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
		Map<String, String> tableInfo = service.getMarketTableInfo(paraMap);
		List<Map<String, String>> categoryList;

		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");

		// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
		categoryList = service.getMarketCategoryList(paraMap);

		// 글 수정해야할 글1개 내용 가져오기
		MarketBoardVO boardvo = service.getMarketViewWithNoAddCount(paraMap);

		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.

		if (loginuser.getCommuMemberNo() != boardvo.getFk_commuMemberNo()) {
			String message = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		} else {
			// 자신의 글을 수정할 경우
			// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
			mav.addObject("boardvo", boardvo);
			mav.addObject("tableInfo", tableInfo);
			mav.addObject("categoryList", categoryList);
			mav.addObject("paraMap", paraMap);
			mav.setViewName("sehyeong/board/marketBoardUpdate.tiles1");
		}

		return mav;
	}

	// === 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value = "/marketBoardEditEnd.sky")
	public ModelAndView anGetCheck_marketBoardEditEnd(HttpServletRequest request, HttpServletResponse response,
			Map<String, String> paraMap, MarketBoardVO boardvo, MultipartHttpServletRequest mrequest, ModelAndView mav) {

		String gobackURL2 = request.getParameter("gobackURL2");
		
		gobackURL2 = gobackURL2.replaceAll("&", "%26");
		
		HttpSession session = request.getSession();

		System.out.println("마켓보드에딧엔드 gobackURL2 입니다 => " + gobackURL2);
		
		MultipartFile attach = boardvo.getAttach();

		if (!attach.isEmpty()) {
			// attach가 비어있지 않으면! (즉, 첨부 파일이 있는 경우라면~)

			/*
			 * 1. 사용자가 보낸 첨부파일을 WAS의 특정 폴더에 저장해주어야 한다. >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 우리는
			 * WAS의 webapp/resources/files라는 폴더로 지정해 준다. 조심할 것은 Package Explorer에서 files라는
			 * 폴더를 직접 만드는 것이 아니다.
			 */

			// WAS의 webapp의 절대 경로를 알아와야 한다.
			session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			System.out.println("this is root : " + root);

			String path = root + "resources" + File.separator + "files";

			// path 가 첨부파일이 저장될 WAS의 폴더가 된다.
			System.out.println("this is path : " + path);

			/*
			 * 2. 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */

			String newFileName = "";
			// WAS의 디스크에 저장될 파일명입니다.

			byte[] bytes = null;
			// 첨부 파일의 내용물

			long fileSize = 0;
			// 첨부파일의 크기
			try {
				bytes = attach.getBytes();
				// 첨부 파일의 내용물을 읽어 오는것

				// 첨부 되어진 파일을 업로드 되도록 하는 것이다!
				// attach.getOriginalFilename()은 첨부 파일의 파일명 (예: 강아지.png)을 얻어 오는 것 입니다!
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);

				System.out.println("확인용인디! ===>>>>>> " + newFileName);
				// 확인용인디! ===>>>>>> 202012091037071013008888107800.png

				/*
				 * 3. BoardVO boardvo에 fileName 값과 orgFilename값과 fileSize 값을 넣어주기
				 * 
				 */

				boardvo.setFileName(newFileName);
				// WAS에 저장될 파일명 => 202012091037071013008888107800.png

				boardvo.setOrgFileName(attach.getOriginalFilename());
				// 게시판 페이지에 청부된 파일을 보여줄때 사용
				// 또한 사용자가 파일을 다운로드 할때 사용!

				fileSize = attach.getSize(); // 첨부 파일의 크기 (단뒤는 byte임)

				boardvo.setFileSize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		int n = 0;

		// 첨부 파일이 없는 경우라면~
		if (attach.isEmpty()) {
			n = service.marketEdit(boardvo);
		}

		// 첨부 파일이 있는 경우라면 ~
		if (!attach.isEmpty()) {

			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "files";
			Map<String, String> paraMap1 = new HashMap<>();
			paraMap1.put("boardKindNo", String.valueOf(boardvo.getFk_boardKindNo()));
			paraMap1.put("boardNo", String.valueOf(boardvo.getBoardNo()));

			MarketBoardVO oldboardvo = service.getMarketViewWithNoAddCount(paraMap1);

			try {
				fileManager.doFileDelete(oldboardvo.getFileName(), path);
				n = 1;
			} catch (Exception e) {
				n = 0;
			}

			n *= service.marketEditFile(boardvo);
		}

		if (n == 1) {
			String message = "글 수정에 성공했삼~~";
			String loc = request.getContextPath() + "/marketBoardDetail.sky?boardKindNo=" + boardvo.getFk_boardKindNo()
					+ "&boardNo=" + boardvo.getBoardNo() + "&gobackURL2=" + gobackURL2;

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		} else {

			String message = "글 수정에 실패했삼~~";
			String loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardvo.getFk_boardKindNo();

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");

		}
		return mav;
	}

	// === #76. 글삭제 페이지 요청 === //
	@RequestMapping(value = "/marketBoardDelete.sky")
	public ModelAndView anGetCheck_marketBoardDelete(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 글 삭제해야 할 글번호 가져오기
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");

		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("boardNo", boardNo);
		paraMap.put("boardKindNo", boardKindNo);

		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.
		MarketBoardVO boardvo = service.getMarketViewWithNoAddCount(paraMap);

		// 삭제해야할 글1개 내용 가져와서 로그인한 사람이 쓴 글이라면 글삭제가 가능하지만
		// 다른 사람이 쓴 글은 삭제가 불가하도록 해야 한다.
		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");

		String fileName = boardvo.getFileName();
		String root = session.getServletContext().getRealPath("/");

		// this is root :
		// C:\eclipse\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\

		/*
		 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
		 * 는 "\" 이고, 운영체제가 UNIX, Linux 이라면 File.separator 는 "/" 이다.
		 */
		String path = root + "resources" + File.separator + "files";

		int n = 0;

		if (loginuser.getCommuMemberNo() != boardvo.getFk_commuMemberNo()) {
			String message = "다른 사용자의 글은 삭제가 불가합니다.";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		} else {

			if (boardvo.getFileName() == null) {
				n = service.marketBoardDelete(paraMap);

			} else {
				n = service.marketBoardDelete(paraMap);

				if (n == 1) {
					try {
						fileManager.doFileDelete(fileName, path);
					} catch (Exception e) {
						n = 0;
					}

				}
			}

		}

		if (n == 0) {
			mav.addObject("message", "글 삭제 쌉 실패ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ");
			mav.addObject("loc", request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardKindNo);

		} else {
			mav.addObject("message", "글삭제 쌉 성공~!~!!~!!!~!!~!!~!~!");
			mav.addObject("loc", request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardKindNo);

		}

		mav.setViewName("msg");

		return mav;
	}

	// 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@ResponseBody
	@RequestMapping(value = "/addMaketBoardUp.sky", method = {
			RequestMethod.POST }, produces = "text/plain; charset=UTF-8")
	public String addMaketBoardUp(HttpServletRequest request) {
		String boardKindNo = request.getParameter("boardKindNo");
		String boardNo = request.getParameter("boardNo");

		int fk_memberNo = 0;
		HttpSession session = request.getSession();

		if (session.getAttribute("loginuser") != null) {
			fk_memberNo = ((CommuMemberVO) session.getAttribute("loginuser")).getFk_memberNo();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("boardNo", boardNo);
		paraMap.put("memberNo", String.valueOf(fk_memberNo));

		int n;
		try {
			n = service.addMaketBoardUp(paraMap);
		} catch (Exception e) {
			n = 0;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString();
	}

	// 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@ResponseBody
	@RequestMapping(value = "/addMaketBoardDown.sky", method = {
			RequestMethod.POST }, produces = "text/plain; charset=UTF-8")
	public String addMaketBoardDown(HttpServletRequest request) {
		String boardKindNo = request.getParameter("boardKindNo");
		String boardNo = request.getParameter("boardNo");

		int fk_memberNo = 0;
		HttpSession session = request.getSession();
		if (session.getAttribute("loginuser") != null) {
			fk_memberNo = ((CommuMemberVO) session.getAttribute("loginuser")).getFk_memberNo();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("boardNo", boardNo);
		paraMap.put("memberNo", String.valueOf(fk_memberNo));

		int n;
		try {
			n = service.addMarketBoardDown(paraMap);
		} catch (Exception e) {
			n = 0;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString();
	}

	// 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@ResponseBody
	@RequestMapping(value = "/addMarketBoardReport.sky", method = {
			RequestMethod.POST }, produces = "text/plain; charset=UTF-8")
	public String addMarketBoardReport(HttpServletRequest request) {
		String boardKindNo = request.getParameter("boardKindNo");
		String boardNo = request.getParameter("boardNo");

		int fk_memberNo = 0;
		HttpSession session = request.getSession();

		if (session.getAttribute("loginuser") != null) {
			fk_memberNo = ((CommuMemberVO) session.getAttribute("loginuser")).getFk_memberNo();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("boardNo", boardNo);
		paraMap.put("memberNo", String.valueOf(fk_memberNo));

		int n = 0;

		try {
			n = service.addMarketBoardReport(paraMap);
		} catch (Exception e) {
			n = 0;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString();
	}

	// 보드 카운트 가져오기 기릿
	@ResponseBody
	@RequestMapping(value = "/getMarketBoardCount.sky", method = {
			RequestMethod.POST }, produces = "text/plain; charset=UTF-8")
	public String getMarketBoardCount(HttpServletRequest request) {
		String boardKindNo = request.getParameter("boardKindNo");
		String boardNo = request.getParameter("boardNo");

		int fk_memberNo = 0;
		HttpSession session = request.getSession();
		if (session.getAttribute("loginuser") != null) {
			fk_memberNo = ((CommuMemberVO) session.getAttribute("loginuser")).getFk_memberNo();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("boardNo", boardNo);
		paraMap.put("memberNo", String.valueOf(fk_memberNo));

		// 게시글의 추천, 비추천 수를 가져온다.
		int upCount = 0;
		int downCount = 0;

		try {
			upCount = service.getMarketBoardGoodCount(paraMap);
			downCount = service.getMarketBoardBadCount(paraMap);
		} catch (Exception e) {
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("upCount", upCount);
		jsonObj.put("downCount", downCount);

		return jsonObj.toString();
	}

	// === #76. 글삭제 페이지 요청 === //
	@RequestMapping(value = "/marketTooMuchReport.sky")
	public ModelAndView anGetCheck_marketTooMuchReport(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 글 삭제해야 할 글번호 가져오기
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");
		String policeCount = request.getParameter("policeCount");

		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("boardNo", boardNo);
		paraMap.put("boardKindNo", boardKindNo);

		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.
		MarketBoardVO boardvo = service.getMarketViewWithNoAddCount(paraMap);

		// 삭제해야할 글1개 내용 가져와서 로그인한 사람이 쓴 글이라면 글삭제가 가능하지만
		// 다른 사람이 쓴 글은 삭제가 불가하도록 해야 한다.
		HttpSession session = request.getSession();

		String fileName = boardvo.getFileName();
		String root = session.getServletContext().getRealPath("/");

		// this is root :
		// C:\eclipse\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\

		/*
		 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
		 * 는 "\" 이고, 운영체제가 UNIX, Linux 이라면 File.separator 는 "/" 이다.
		 */
		String path = root + "resources" + File.separator + "files";

		int n = 0;

		if (boardvo.getFileName() == null) {
			n = service.marketBoardDelete(paraMap);

		} else {
			n = service.marketBoardDelete(paraMap);

			if (n == 1) {
				try {
					fileManager.doFileDelete(fileName, path);
				} catch (Exception e) {
					n = 0;
				}

			}
		}

		if (n == 0) {
			mav.addObject("message", "신고가 너무많아서 글을 블락처리 하려 했지만 실패했닼ㅋㅋㅋㅋ미안ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ");
			mav.addObject("loc", request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardKindNo);

		} else {
			mav.addObject("message", "신고가 많이 쌓인 아주 xxx같은 글이라 블락처리함! 당신이 마지막 신고자! 빵야!");
			mav.addObject("loc", request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardKindNo);

		}

		mav.setViewName("msg");

		return mav;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// === 게시판 글쓰기 폼페이지 요청 === //
	@RequestMapping(value = "/allBoardAdminAdd.sky")
	public ModelAndView anGetCheck_allBoardAdminAdd(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		String boardKindNo = request.getParameter("boardKindNo");

		if (boardKindNo == null || "".equals(boardKindNo)) {
			String message = "정상적인 경로좀 ㅎㅎ";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(boardKindNo);
				int n = service.checkBoardKindNo(boardKindNo);

				if (n == 0) {
					String message = "정상적인 경로좀 ㅎㅎ";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		Map<String, String> paraMap = new HashMap<>();

		paraMap.put("boardKindNo", boardKindNo);

		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");
		List<Map<String, String>> boardList = null;

		String writerIp = request.getRemoteAddr();
		paraMap.put("writerIp", writerIp);
		
		
		if (loginuser.getFk_memberNo() == 0) {
			// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
			boardList = service.getAllBoardList();
			
			mav.addObject("paraMap", paraMap);
			mav.addObject("boardList", boardList);
			
			mav.setViewName("sehyeong/board/allBoardAdminAdd.tiles1");
			// /WEB-INF/views/tiles1/sehyeong/board/marketBoardRegister.jsp 파일을 불러온다.
			
			return mav;

		} else {
			String message = "정상적인 경로좀 ㅎㅎ";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		}

	}

	// === 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value = "/allBoardAdminAddEnd.sky")
	public String anGetCheck_allBoardAdminAddEnd(HttpServletRequest request, HttpServletResponse response,
			NoticeVO noticevo) {


		int n = service.allBoardAdminAdd(noticevo);

		int boardKindNo = noticevo.getFk_boardKindNo();
		String loc = "";
		switch (boardKindNo) {
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
			loc = request.getContextPath() + "/minsungBoardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
			
			break;
		case 7:
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
			loc = request.getContextPath() + "/boardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
			break;
		case 23:
		case 24:
		case 25:
			loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
			break;

		}
		
		if (n == 1) {
			String message = "⭕⭕⭕⭕⭕⭕쌉대성공⭕⭕⭕⭕⭕";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

		} else {

			String message = "글 입력에 실패했삼~~";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

		}
		return "msg";
	}
	
	// === rhdwltkgkd 글1개를 보여주는 페이지 요청 === //
	@RequestMapping(value = "/notificationDetail.sky")
	public ModelAndView notificationDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 조회하고자 하는 글번호 받아오기
		String noticeNo = request.getParameter("noticeNo");
		String boardKindNo = request.getParameter("boardKindNo");
		String gobackURL2 = request.getParameter("gobackURL2");

		
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		
		if (boardKindNo == null || "".equals(boardKindNo)) {
			String message = "정상적인 경로좀 ㅎㅎ";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(boardKindNo);
				paraMap.put("boardKindNo", boardKindNo);

				int n = service.checkBoardKindNo(boardKindNo);

				if (n == 0) {
					String message = "정상적인 경로좀 ㅎㅎ";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		if (noticeNo == null || "".equals(noticeNo)) {
			String message = "정상적인 경로좀 ㅎㅎ11";
			String loc = request.getContextPath() + "/index.sky";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			return mav;
		} else {
			try {
				Integer.parseInt(noticeNo);
				
				paraMap.put("noticeNo", noticeNo);

				NoticeVO notice = service.getNoticeViewWithNoAddCount(paraMap);

				if (notice == null) {
					String message = "정상적인 경로좀 ㅎㅎ22";
					String loc = request.getContextPath() + "/index.sky";

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
					return mav;
				}
			} catch (Exception e) {
				String message = "정상적인 경로좀 ㅎㅎ33";
				String loc = request.getContextPath() + "/index.sky";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				return mav;
			}

		}

		paraMap.put("gobackURL2", gobackURL2);

		// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
		Map<String, String> tableInfo = service.getMarketTableInfo(paraMap);
		
		NoticeVO noticevo = null;
		
		HttpSession session = request.getSession();
		
		// 익명 게시판인지 아닌지 확인해야함		
		if(!"7".equals(boardKindNo)) {  // 익명게시판이 아닐경우 그냥 원래대로
			CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");
			
			
			// 글1개를 보여주는 페이지 요청은 select 와 함께
			// DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
			// 이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
			// 매번 글조회수 증가가 발생한다.
			// 그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
			// 단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은
			// 실행하지 않도록 해주어야 한다. !!! === //
			
			
			if (loginuser != null) {
				// 위의 글목록보기 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
				if ("yes".equals(session.getAttribute("readCountPermission"))) {
					// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
					
					noticevo = service.getNoticeView(paraMap, loginuser);
					// 글조회수 증가와 함께 글1개를 조회를 해주는 것
					
					session.removeAttribute("readCountPermission");
					// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
					
				} else {
					// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
					
					noticevo = service.getNoticeViewWithNoAddCount(paraMap);
					// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.
				}
				
				
				
			} else {
				String message = "로그인하고 엄마 모시고 와~~~~";
				String loc = "javascript:history.back()";

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				
				return mav;
			}
			
		} else {  // 익명게시판일 경우 로그인 여부에 상관없이 조회수를 증가시켜 줘야함
			
			if ("yes".equals(session.getAttribute("readCountPermission"))) {  // 리스트 통해 접근할 경우
				
				noticevo = service.getNoticeView(paraMap);
				session.removeAttribute("readCountPermission");
				// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
			} else {  // 그냥 접근할 경우
				noticevo = service.getNoticeViewWithNoAddCount(paraMap);
			}
		}

		List<MinsungBoardVO> recentBoardList = service.recentBoardList();
		List<MinsungBoardVO> bestBoardList = service.bestBoardList();
		List<MinsungBoardVO> popularBoardList = service.popularBoardList();
		mav.addObject("recentBoardList", recentBoardList);
		mav.addObject("bestBoardList", bestBoardList);
		mav.addObject("popularBoardList", popularBoardList);
		
		mav.addObject("noticevo", noticevo);
		mav.addObject("paraMap", paraMap);
		mav.addObject("tableInfo", tableInfo);
		
		mav.setViewName("sehyeong/board/noticeDetail.tiles1");

		return mav;
	}


	
	
	// === #71. 글수정 페이지 요청 === //
	@RequestMapping(value = "/noticeEdit.sky")
	public ModelAndView anRequiredLogin_anGetCheck_noticeEdit(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {

		// 글 수정해야 할 글번호 가져오기
		String noticeNo = request.getParameter("noticeNo");
		String boardKindNo = request.getParameter("boardKindNo");
		String gobackURL2 = request.getParameter("gobackURL2");

		System.out.println("이것은 gobackURL2 입니다 => " + gobackURL2);
		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("noticeNo", noticeNo);
		paraMap.put("boardKindNo", boardKindNo);
		paraMap.put("gobackURL2", gobackURL2);

		String writerIp = request.getRemoteAddr();
		paraMap.put("writerIp", writerIp);
		
		// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
		List<Map<String, String>> boardList = service.getAllBoardList();
			
		mav.addObject("paraMap", paraMap);
		mav.addObject("boardList", boardList);
		
		
		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");


		// 글 수정해야할 글1개 내용 가져오기
		NoticeVO noticevo = service.getNoticeViewWithNoAddCount(paraMap);

		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.

		if (loginuser.getFk_memberNo() != noticevo.getFk_memberNo()) {
			String message = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		} else {
			// 자신의 글을 수정할 경우
			// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
			mav.addObject("noticevo", noticevo);
			mav.addObject("boardList", boardList);
			mav.addObject("paraMap", paraMap);
			mav.setViewName("sehyeong/board/allBoardAdminAdd.tiles1");
		}

		return mav;
	}

	// === 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value = "/noticeEditEnd.sky")
	public ModelAndView anGetCheck_noticeEditEnd(HttpServletRequest request, HttpServletResponse response,
			NoticeVO noticevo, ModelAndView mav) {

		String gobackURL2 = request.getParameter("gobackURL2");

		int n = service.noticeEdit(noticevo);
		
		if (n == 1) {
			String message = "글 수정에 성공했삼~~";
			String loc = request.getContextPath() + "/notificationDetail.sky?boardKindNo=" + noticevo.getFk_boardKindNo()
					+ "&noticeNo=" + noticevo.getNoticeNo() + "&gobackURL2=" + gobackURL2;

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		} else {

			String message = "글 수정에 실패했삼~~";
			int boardKindNo = noticevo.getFk_boardKindNo();
			String loc = "";
			switch (boardKindNo) {
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 18:
			case 19:
			case 20:
			case 21:
			case 22:
				loc = request.getContextPath() + "/minsungBoardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
				
				break;
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
			case 12:
			case 13:
			case 14:
			case 15:
			case 16:
			case 17:
				loc = request.getContextPath() + "/boardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
				break;
			case 23:
			case 24:
			case 25:
				loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + noticevo.getFk_boardKindNo();
				break;

			}
			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");

		}
		return mav;
	}

	// === #76. 글삭제 페이지 요청 === //
	@RequestMapping(value = "/noticeDelete.sky")
	public ModelAndView anGetCheck_noticeDelete(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 글 삭제해야 할 글번호 가져오기
		String noticeNo = request.getParameter("noticeNo");
		String boardKindNo = request.getParameter("boardKindNo");

		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("noticeNo", noticeNo);
		paraMap.put("boardKindNo", boardKindNo);



		int n = service.noticeDelete(paraMap);
		
		String loc = "";
		switch (boardKindNo) {
		case "1":
		case "2":
		case "3":
		case "4":
		case "5":
		case "6":
		case "18":
		case "19":
		case "20":
		case "21":
		case "22":
			loc = request.getContextPath() + "/minsungBoardList.sky?boardKindNo=" + boardKindNo;
			
			break;
		case "7":
		case "8":
		case "9":
		case "10":
		case "11":
		case "12":
		case "13":
		case "14":
		case "15":
		case "16":
		case "17":
			loc = request.getContextPath() + "/boardList.sky?boardKindNo=" + boardKindNo;
			break;
		case "23":
		case "24":
		case "25":
			loc = request.getContextPath() + "/marketboardList.sky?boardKindNo=" + boardKindNo;
			break;

		}
		
		if (n == 0) {
			mav.addObject("message", "글 삭제 쌉 실패ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ");
			mav.addObject("loc", loc);

		} else {
			mav.addObject("message", "글삭제 쌉 성공~!~!!~!!!~!!~!!~!~!");
			mav.addObject("loc", loc);

		}

		mav.setViewName("msg");

		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@ResponseBody
	@RequestMapping(value = "/getAnSearchList.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	public String getSearchList(HttpServletRequest request) {
		
		
		String searchWord = request.getParameter("searchWord");
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("start", start);
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);
		
		List<MarketBoardVO> searchBoardList = service.getSearchBoardList(paraMap);
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		JSONArray jsonArr = new JSONArray();  // []
		
		if (searchBoardList.size() > 0) {
			for (MarketBoardVO board : searchBoardList) {
				JSONObject jsonObj = new JSONObject();  // {}
				
				jsonObj.put("fk_boardKindNo", board.getFk_boardKindNo());
				jsonObj.put("subject", board.getSubject());
				jsonObj.put("boardName", board.getBoardName());
				jsonObj.put("boardNo", board.getBoardNo());
				
				jsonArr.put(jsonObj);
			}
		}
		return jsonArr.toString();
	}
	@ResponseBody
	@RequestMapping(value = "/getAnTotalHitCount.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	public String getAnTotalHitCount(HttpServletRequest request) {
		
		
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		
		int totalHitCount = service.getAnTotalHitCount(paraMap);
		
		
		JSONObject jsonObj = new JSONObject(); // {}

		jsonObj.put("totalHitCount", totalHitCount);
				
		
		return jsonObj.toString();
	}
	
	
	
	// 댓글 리스트 가져오기(ajax 사용)
    @ResponseBody
    @RequestMapping(value = "/noticeCommentList.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
    public String noticeCommentList(HttpServletRequest request) {
    	
    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
    	String noticeNo = request.getParameter("noticeNo");
    	String startNo = request.getParameter("startNo");
    	String cmtLength = request.getParameter("cmtLength");
    	
    	Map<String, String> paraMap = new HashMap<String, String>();
    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
    	paraMap.put("noticeNo", noticeNo);
    	paraMap.put("startNo", startNo);
    	
    	String endNo = String.valueOf(Integer.parseInt(startNo) + Integer.parseInt(cmtLength) - 1);
    	paraMap.put("endNo", endNo);
    	
    	// 요청한 순서의 댓글을 8개씩 가져오기
    	List<CommentVO> commentList = service.getNoticeCommentList(paraMap);
    	
    	JSONArray jsonArr = new JSONArray();

    	for (CommentVO commentvo : commentList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentNo", commentvo.getCommentNo());
			jsonObj.put("fk_boardNo", commentvo.getFk_boardNo());
			jsonObj.put("fk_memberNo", commentvo.getFk_memberNo());
			jsonObj.put("cmtContent", commentvo.getCmtContent());
			jsonObj.put("regDate", commentvo.getRegDate());
			jsonObj.put("fk_nickname", commentvo.getFk_nickname());
			jsonObj.put("levelImg", commentvo.getLevelImg());
			jsonObj.put("totalCount", commentvo.getTotalCount());
			
			
			jsonArr.put(jsonObj);
		}
    	return jsonArr.toString();
    }
	
    // 댓글 작성하기(ajax 사용)
    @ResponseBody
    @RequestMapping(value = "/noticeCommentRegister.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
    public String noticeCommentRegister(Map<String, String> paraMap, HttpServletRequest request, HttpServletResponse response){
    	
    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
    	String fk_boardNo = request.getParameter("fk_boardNo");
    	String cmtContent = request.getParameter("cmtContent");
    	
    	cmtContent = cmtContent.replaceAll("<", "&lt;");
    	cmtContent = cmtContent.replaceAll(">", "&gt;");
    	cmtContent = cmtContent.replaceAll("\r\n", "<br>");
    	cmtContent = cmtContent.replaceAll("&nbsp;", " ");
    	cmtContent = cmtContent.replaceAll("&ensp;", "");
    	cmtContent = cmtContent.replaceAll("&emsp;", "");
    	cmtContent = cmtContent.replaceAll("null", " ");
    	
    	// 게시판 번호, 게시글 번호, 댓글 내용, 작성자 회원번호, 작성자 ip를 commentvo에 저장한다.
    	CommentVO commentvo = new CommentVO();
    	commentvo.setFk_boardKindNo(fk_boardKindNo);
    	commentvo.setFk_boardNo(fk_boardNo);
    	commentvo.setCmtContent(cmtContent);
    	
    	HttpSession session = request.getSession();
    	CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
    	
    	if (loginuser != null) {
			commentvo.setFk_memberNo(String.valueOf(loginuser.getFk_memberNo()));
		}
    	
    	try {
			commentvo.setWriterIp(getUserIp());
		} catch (Exception e) {
			commentvo.setWriterIp("");
		}
    	
		
    	// 작성한 댓글 저장하기
		int n = 0;
		
    	try {
    		n = service.addNoticeComment(commentvo);

    		// 댓글쓰기 완료 후, 포인트 올려주기 
    		paraMap.put("fk_memberNo", commentvo.getFk_memberNo());
    		paraMap.put("point", "1");	   
    		
    		n = service.addNoticePoint(paraMap);
    		
		} catch (Exception e) {
			n = 0;
		}

    	
    	JSONObject jsonObj = new JSONObject();
    	
    	jsonObj.put("n", n);
    	
    	return jsonObj.toString();
    }
    
    // 댓글을 삭제해주기(ajax로 처리)
    @ResponseBody
    @RequestMapping(value="/deleteNoticeComment.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
    public String deleteNoticeComment(HttpServletRequest request) {
    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
    	String fk_boardNo = request.getParameter("fk_boardNo");
    	String commentNo = request.getParameter("commentNo");
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
    	paraMap.put("fk_boardNo", fk_boardNo);
    	paraMap.put("commentNo", commentNo);

    	int n;
    	try {
    		n = service.deleteNoticeComment(paraMap);
    	} catch (Exception e) {
    		n = 0;
    	}
    	
    	JSONObject jsonObj = new JSONObject();
    	jsonObj.put("n", n);
    	return jsonObj.toString();
    }
    
    // 댓글을 수정해주기 (ajax로 처리)
    @ResponseBody
    @RequestMapping(value="/updateNoticeComment.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
    public String updateNoticeComment(HttpServletRequest request, CommentVO commentvo) {
    	String fk_boardKindNo = commentvo.getFk_boardKindNo();
    	String fk_boardNo = commentvo.getFk_boardNo();
    	String commentNo = commentvo.getCommentNo();
    	String cmtContent = commentvo.getCmtContent();
    	
    	cmtContent = cmtContent.replaceAll("<", "&lt;");
    	cmtContent = cmtContent.replaceAll(">", "&gt;");
    	cmtContent = cmtContent.replaceAll("\r\n", "<br>");
    	cmtContent = cmtContent.replaceAll("&nbsp;", " ");
    	cmtContent = cmtContent.replaceAll("&ensp;", "");
    	cmtContent = cmtContent.replaceAll("&emsp;", "");
    	cmtContent = cmtContent.replaceAll("null", "");
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
    	paraMap.put("fk_boardNo", fk_boardNo);
    	paraMap.put("commentNo", commentNo);
    	paraMap.put("cmtContent", cmtContent);

		int n; 
		try { 
			n = service.updateNoticeComment(paraMap); 
		} catch (Exception e) { 
			n = 0; 
		}
		
		JSONObject jsonObj = new JSONObject(); 
		jsonObj.put("n", n); 
		return jsonObj.toString();
    }
    
	
    // 클라이언트 ip주소를 가져오는 메소드
	public String getUserIp() throws Exception {
		
        String ip = null;
        
        HttpServletRequest request = 
        ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

        ip = request.getHeader("X-Forwarded-For");
        
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
		
		return ip;
	}
	
	
	
	
	@RequestMapping(value = "/checkMyList.sky")
	public ModelAndView anRequiredLogin_checkMyList(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {

		HttpSession session = request.getSession();
		
		CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
		
	
		int myPageTotalPage = service.getTotalCountForMyPage(loginuser);
	
		
		mav.addObject("myPageTotalPage", myPageTotalPage);
		mav.setViewName("sehyeong/board/myPageComeOn.tiles1");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/displayMyPageJSON.sky", produces = "text/plain; charset=UTF-8")
	public String anRequiredLogin_displayMyPageJSON(HttpServletRequest request,HttpServletResponse response) {
		
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		
		String colName = request.getParameter("colName");
		
		
		HttpSession session = request.getSession();
		
		CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_memberNo", String.valueOf(loginuser.getFk_memberNo()));
		paraMap.put("commuMemberNo", String.valueOf(loginuser.getCommuMemberNo()));
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("colName", colName);
		
		List<MarketBoardVO> myBoardList = service.getMyBoardList(paraMap);
		
		
		JSONArray jsonArr = new JSONArray();

    	for (MarketBoardVO myBoard : myBoardList) {
    		
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fk_boardKindNo", myBoard.getFk_boardKindNo());
			jsonObj.put("subject", myBoard.getSubject());
			jsonObj.put("readCount", myBoard.getReadCount());
			jsonObj.put("boardName", myBoard.getBoardName());
			jsonObj.put("boardNo", myBoard.getBoardNo());
			jsonObj.put("fk_memberNo", myBoard.getFk_memberNo());
			jsonObj.put("categoryName", myBoard.getCategoryName());
			jsonObj.put("cmtCount", myBoard.getCmtCount());
			jsonObj.put("regDate", myBoard.getRegDate());
			jsonObj.put("upCount", myBoard.getUpCount());
			jsonObj.put("content", myBoard.getContent());
			
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString();

	}
	
	@RequestMapping(value = "/checkALlNotice.sky")
	public ModelAndView anRequiredLogin_checkALlNotice(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		
		List<NoticeVO> allNoticeList = service.getAllNoticeList();
		
		
		mav.addObject("allNoticeList", allNoticeList);
		mav.setViewName("sehyeong/board/allNoticeListComeOn.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/displayNoticeListJSON.sky", produces = "text/plain; charset=UTF-8")
	public String anRequiredLogin_displayNoticeListJSON(HttpServletRequest request,HttpServletResponse response) {
		
		
		String colName = request.getParameter("colName");
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("colName", colName);
		
		List<NoticeVO> noticeList = service.getAllNoticeListWithParam(paraMap);
		
		
		JSONArray jsonArr = new JSONArray();

    	for (NoticeVO notice : noticeList) {
    		
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("noticeNo", notice.getNoticeNo());
			jsonObj.put("fk_boardKindNo", notice.getFk_boardKindNo());
			jsonObj.put("fk_memberNo", notice.getFk_memberNo());
			jsonObj.put("fk_categoryNo", notice.getFk_categoryNo());
			
			jsonObj.put("subject", notice.getSubject());
			jsonObj.put("regDate", notice.getRegDate());
			jsonObj.put("content", notice.getContent());
			jsonObj.put("readCount", notice.getReadCount());
			jsonObj.put("boardName", notice.getBoardName());
			jsonObj.put("categoryName", notice.getCategoryName());
			jsonObj.put("cmtCount", notice.getCmtCount());
			jsonObj.put("boardName", notice.getBoardName());
			
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString();

	}
	@ResponseBody
	@RequestMapping(value = "/deleteNoticeJSON.sky", produces = "text/plain; charset=UTF-8")
	public String anRequiredLogin_deleteNoticeJSON(HttpServletRequest request,HttpServletResponse response) {
		
		// 글 삭제해야 할 글번호 가져오기
		String noticeNo = request.getParameter("noticeNo");
		String boardKindNo = request.getParameter("boardKindNo");

		Map<String, String> paraMap = new HashMap<String, String>();

		paraMap.put("noticeNo", noticeNo);
		paraMap.put("boardKindNo", boardKindNo);

		int n = service.noticeDelete(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	}
	
	  
    // 게시판 상세페이지에서 우측 사이드바를 차고 들어오면 조회수를 1올려준 후 다시 get방식으로 보낸다.
    @RequestMapping(value="/marketBoardDetail.sky", method = {RequestMethod.POST})
    public String boardDetailPost(HttpServletRequest request) {
       
       String boardKindNo = request.getParameter("boardKindNo");
       String boardNo = request.getParameter("boardNo");
       
       CommuMemberVO loginuser = null;
       HttpSession session = request.getSession();
       if (session.getAttribute("loginuser") != null) {
    	   loginuser = (CommuMemberVO) session.getAttribute("loginuser");
       }
       
       // 게시물 1개를 가져오며 로그인 회원번호와 작성자 회원번호가 일치하지 않으면 해당 게시물의 조회수를 1 올린다.
       Map<String, String> paraMap = new HashMap<>();
       paraMap.put("boardKindNo", boardKindNo);
       paraMap.put("boardNo", boardNo);
       
       // 게시물의 조회수를 올린다.
       service.getMarketView(paraMap, loginuser);
       
       return "redirect:/marketBoardDetail.sky?boardKindNo="+boardKindNo+"&boardNo="+boardNo;
    }
}