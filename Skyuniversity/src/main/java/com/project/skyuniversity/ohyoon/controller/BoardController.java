package com.project.skyuniversity.ohyoon.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.project.skyuniversity.ash.model.CommuMemberVO;
import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.common.MyUtil;
import com.project.skyuniversity.ohyoon.common.OhFileManager;
import com.project.skyuniversity.ohyoon.common.Sha256;
import com.project.skyuniversity.ohyoon.model.*;
import com.project.skyuniversity.ohyoon.service.InterOhyoonService;

//=== #30. 컨트롤러 선언 === 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은 boardController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class BoardController {

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
		// ※ 의존객체주입(DI : Dependency Injection) 
		//  ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
		//      스프링 컨테이너는 bean으로 등록되어진 BoardController 클래스 객체가 사용되어질때, 
		//      BoardController 클래스의 인스턴스 객체변수(의존객체)인 BoardService service 에 
		//      자동적으로 bean 으로 등록되어 생성되어진 BoardService service 객체를  
		//      BoardController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
		//      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
		//      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
		//      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
		//      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
		//      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
		//      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.
		
		//  IOC(Inversion of Control) 란 ?
		//  ==> 스프링 프레임워크는 사용하고자 하는 객체를 빈형태로 이미 만들어 두고서 컨테이너(Container)에 넣어둔후
		//      필요한 객체사용시 컨테이너(Container)에서 꺼내어 사용하도록 되어있다.
		//      이와 같이 객체 생성 및 소멸에 대한 제어권을 개발자가 하는것이 아니라 스프링 Container 가 하게됨으로써 
		//      객체에 대한 제어역할이 개발자에게서 스프링 Container로 넘어가게 됨을 뜻하는 의미가 제어의 역전 
		//      즉, IOC(Inversion of Control) 이라고 부른다.
		
		
		//  === 느슨한 결합 ===
		//      스프링 컨테이너가 BoardController 클래스 객체에서 BoardService 클래스 객체를 사용할 수 있도록 
		//      만들어주는 것을 "느슨한 결합" 이라고 부른다.
		//      느스한 결합은 BoardController 객체가 메모리에서 삭제되더라도 BoardService service 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.
		
		// ===> 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해서 생성해주던 것)
		// private InterBoardService service = new BoardService(); 
		// ===> BoardController 객체가 메모리에서 삭제 되어지면  BoardService service 객체는 멤버변수(필드)이므로 메모리에서 자동적으로 삭제되어진다.	
		
		@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
		private InterOhyoonService service;

		@Autowired
		private OhFileManager fileManager;
		
//////////////////////////////////////////////////////////////////////////////////////
		
		// === 게시판 리스트 페이지 요청 === // 
		@RequestMapping(value="/boardList.sky")
		public ModelAndView boardList(ModelAndView mav, String boardKindNo, HttpServletRequest request) {
			
			// 익명게시판으로 들어오면 세션에 랜덤 닉네임이 들어가 있는지 확인 후 들어있지 않으면 닉네임을 넣어준다.
			if (boardKindNo.equals("7")) {
				HttpSession session = request.getSession();
				if (session.getAttribute("nickname") == null) {
					// 익명게시판이므로 랜덤한 숫자 2개를 받아 닉네임을 만든다.
					String nickname = service.getRandomNickname();
					session.setAttribute("nickname", nickname);
				}
			}
			
			// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 게시판 이름 불러오기
			String boardName = service.getBoardName(Integer.parseInt(boardKindNo));
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("boardKindNo", boardKindNo);
			paraMap.put("boardName", boardName);
			
			String categoryNo = request.getParameter("categoryNo");
			if (categoryNo == null) { // 카테고리가 null이라면 "0"으로 설정.
				categoryNo = "0";
			}
			
			try { // 숫자로 입력된 것이 아니라면 url상으로 문자가 들어왔다면
				Integer.parseInt(categoryNo);
			} catch (Exception e) {
				categoryNo = "0";
			}
			
			paraMap.put("categoryNo", categoryNo);
			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			// searchWord 가 공백만 있거나 null이라면 ""로 저장해준다.
			if (searchWord == null || searchWord.trim().isEmpty()) {
				searchWord = "";
			}
			
		   	paraMap.put("searchType", searchType);
		   	paraMap.put("searchWord", searchWord);
			
			int totalCount = 0; 		// 총 게시물 건수 - 검색조건이 있을 때와 없을 때로 나뉨.
			int sizePerPage = 15;		// 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호 - 처음에는 1페이지로 나와야 함.
			int totalPage = 0;			// 총 페이지 수
			
			int startRno = 0;			// 시작 행번호
			int endRno = 0;				// 끝 행번호
			
			// 총 게시물 건수 알아오기
			totalCount = service.getTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount / sizePerPage); 
			
			if (str_currentShowPageNo == null) {
				// 요청한 페이지가 없다면
				currentShowPageNo = 1;
			}else {
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
			List<BoardVO> boardList = service.getBoardList(paraMap); 
			
			// ======== 페이지바 만들기 ======== // 
			String pageBar = "<ul class='pager'>";
			
			// 블럭당 보여지는 페이지 번호 개수
			int blockSize = 10;
			
			int loop = 1;
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; // 페이지번호 시작값
			
			String url = "boardList.sky?boardKindNo="+boardKindNo+"&categoryNo="+categoryNo;
			
			// [맨처음][이전] 만들기 
			if (pageNo != 1) {
				pageBar += "<li><a href='"+url+"&searchType="+searchType+"&searchWord'"+searchWord+"&currentShowPageNo=1>맨처음</a></li>";
				pageBar += "<li><a href='"+url+"&searchType="+searchType+"&searchWord'"+searchWord+"&currentShowPageNo="+(pageNo-1)+">Previous</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				if (pageNo == currentShowPageNo) {
					pageBar += "<li class='pageBtn'><a style='color: #0841ad; font-weight: bold;'>"+pageNo+"</a></li>";
				}else {
					pageBar += "<li class='pageBtn'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}
			
			// [다음][마지막] 만들기
			if ( !(pageNo > totalPage) ) {
				pageBar += "<li><a href='"+url+"&searchType="+searchType+"&searchWord'"+searchWord+"&currentShowPageNo="+pageNo+">Next</a></li>";
				pageBar += "<li><a href='"+url+"&searchType="+searchType+"&searchWord'"+searchWord+"&currentShowPageNo="+totalPage+">마지막</a></li>";
			}
			
			pageBar += "</ul>";
			
			// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 카테고리들을 불러오기
			List<CategoryVO> cateList = service.getCategoryList(Integer.parseInt(boardKindNo));
			
			// 리스트 페이지에서 상세페이지로 넘어간 경우만 해당 글의 조회수를 1 증가시켜야 하므로 session에 readCountPermission라는 key로 값을 넣어둔다.
			HttpSession session = request.getSession();
			session.setAttribute("readCountPermission", "yes");
			
			// 특정 게시물의 상세 페이지로 갔다가 목록으로 버튼을 누르면 다시 돌아오기 위한 url 
			String gobackURL = MyUtil.getCurrentURL(request);
			
			// 공지리스트 불러오기
			List<NoticeVO> noticeList = service.getNoticeList(paraMap);
			mav.addObject("noticeList", noticeList);
			
			mav.addObject("gobackURL", gobackURL);
			mav.addObject("pageBar", pageBar);
			mav.addObject("paraMap", paraMap);
			mav.addObject("cateList", cateList);
			mav.addObject("boardList", boardList);
			mav.setViewName("/ohyoon/boardList.tiles1");
			return mav;
		}

		
		// 글 작성 페이지 요청
		@RequestMapping(value="/boardRegister.sky", method = {RequestMethod.GET})
		public ModelAndView requiredLoginOY_boardRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, String boardKindNo) {
			
			int iBoardKindNo = 0;

			// url상으로 숫자가 아닌 문자로 장난으로 들어온 거라면
			try {
				iBoardKindNo = Integer.parseInt(boardKindNo);
			} catch (NumberFormatException e) {
				mav.addObject("message", "잘못된 형식입니다.");
				mav.addObject("loc", "javascript:history.back();");
				mav.setViewName("msg");
				return mav;
			}

			// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 게시판 이름 불러오기
			String boardName = service.getBoardName(iBoardKindNo);
			
			if (boardName == null) { // 등록되어있지 않는 게시판 번호를 입력하고 들어온거라면
				mav.addObject("message", "잘못된 형식입니다.");
				mav.addObject("loc", "javascript:history.back();");
				mav.setViewName("msg");
				return mav;
			}
			
			Map<String, String> infoMap = new HashMap<>();
			infoMap.put("boardKindNo", boardKindNo);
			infoMap.put("boardName", boardName);
			
			// 닉네임 설정을 안했으면 작성 못하도록 하기	
			HttpSession session = request.getSession();
			CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
			if (loginuser.getNickname() == null) {
				mav.addObject("message", "닉네임을 먼저 설정해야합니다.");
				mav.addObject("loc", "javascript:history.back();");
				
				mav.setViewName("msg");
				return mav;
			}

			mav.addObject("infoMap", infoMap);
			
			// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 카테고리들을 불러오기
			List<CategoryVO> cateList = service.getCategoryList(iBoardKindNo);
			mav.addObject("cateList", cateList);
			mav.setViewName("/ohyoon/boardRegister.tiles1");
			
			return mav;
		}
		
		
		// 글 작성 페이지 완료
		@RequestMapping(value="/boardRegister.sky", method = {RequestMethod.POST})
		public void pointPlusOY_boardRegister(Map<String, String> paraMap, MultipartHttpServletRequest mrequest, HttpServletResponse response, BoardVO boardvo) {

			try {
				boardvo.setWriterIp(getUserIp()); // 작성자 ip를 받아 boardvo에 저장.
			} catch (Exception e1) {
				boardvo.setWriterIp(""); // 만일 getUserIp()도중 예외가 발생하면 ""으로 저장.
			}
			
			MultipartFile attach = boardvo.getAttach();
			if (!attach.isEmpty()) {
				// 첨부파일이 비어있지 않다면
				
				// 1. 올리는 파일을 WAS(톰캣) 폴더에 저장해야 한다.
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "files";
				
				// 2. 파일 첨부를 위해서 변수를 설정하고 파일을 올려야 한다.
				String newFilename = ""; // 저장될 파일명
				
				byte[] bytes = null; // 첨부파일의 내용물
				
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // // 첨부파일의 내용물을 읽어옴. 첨부파일을 bytes에 넣는다.
					
					newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); // getOriginalFilename()은 첨부파일의 원본 이름을 리턴한다.
					
					// 3. boardvo에 fileName 값과 orgFilename 값, fileSize 값을 넣어준다.
					boardvo.setFileName(newFilename); // 저장할 파일명 boardvo에 저장.
					boardvo.setOrgFilename(attach.getOriginalFilename()); // 원본 파일명을 boardvo에 저장.
					
					fileSize = attach.getSize(); // getSize()은 첨부파일의 크기를 리턴한다.
					boardvo.setFileSize(String.valueOf(fileSize)); // 첨부파일의 크기를 boardvo에 저장한다.
					
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
			
			// 작성한 글을 db에 저장.
			int n = 0;
			if (attach.isEmpty()) {
				// 파일첨부가 없는 글쓰기
				n = service.addBoard(boardvo);
			}else {
				// 파일첨부가 있는 글쓰기
				n = service.addBoardWithFile(boardvo);
			}

			paraMap.put("fk_boardKindNo", mrequest.getParameter("fk_boardKindNo"));
			paraMap.put("boardName", mrequest.getParameter("boardName"));

			if (n == 1) {
				// 글쓰기 완료 후, 포인트 올려주기 - 글작성 메서드의 첫번째 파라미터로 있는 Map<String,String> paraMap은 값이 비어있지만 AfterAdvice에서 사용하기 위해 넣어놓음. 이제 값을 넣어준다.
				paraMap.put("fk_memberNo", boardvo.getFk_memberNo());
				paraMap.put("point", "3");
			}
		}
		
		
		// 익명게시판 글 작성 페이지 요청
		@RequestMapping(value="/boardRegister2.sky", method = {RequestMethod.GET})
		public ModelAndView boardRegister2(HttpServletRequest request, ModelAndView mav) {
			
			// 익명게시판은 게시판번호가 7. url상으로 boardKindNo를 입혀서 들어오지 않기 때문에 게시판 번호를 설정해준다.
			String boardKindNo = "7";
			
			// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 게시판 이름 불러오기
			String boardName = service.getBoardName(Integer.parseInt(boardKindNo));
			
			if (boardName == null) { // 등록되어있지 않는 게시판 번호를 입력하고 들어온거라면
				mav.addObject("message", "잘못된 형식입니다.");
				mav.addObject("loc", "javascript:history.back();");
				mav.setViewName("msg");
				return mav;
			}
			
			Map<String, String> infoMap = new HashMap<>();
			infoMap.put("boardKindNo", boardKindNo);
			infoMap.put("boardName", boardName);
			
			mav.addObject("infoMap", infoMap);
			
			mav.setViewName("/ohyoon/boardRegister2.tiles1");
			return mav;
		}
		
		
		// 익명 게시판 글 작성 페이지 완료
		@RequestMapping(value="/boardRegister2.sky", method = {RequestMethod.POST})
		public ModelAndView boardRegister2(ModelAndView mav, HttpServletRequest request, BoardVO boardvo) {

			try {
				boardvo.setWriterIp(getUserIp()); // 작성자 ip를 받아 boardvo에 저장.
			} catch (Exception e1) {
				boardvo.setWriterIp(""); // 만일 getUserIp()도중 예외가 발생하면 ""으로 저장.
			}
			
			// 작성한 글을 db에 저장.
			int n = service.addBoard(boardvo);
			
			String message = "";
			if (n == 1) message = "글쓰기가 완료되었습니다.";
			else message = "글쓰기에 실패했습니다.";
			
			String loc = request.getContextPath()+"/boardList.sky?boardKindNo=7";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			
			return mav;
		}
		
	    
	    // 게시물 1개를 보여주는 페이지 요청
	    @RequestMapping(value="/boardDetail.sky", method = {RequestMethod.GET})
	    public ModelAndView requiredLoginOY_boardDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	try {
	    		// url로 장난을 치고 들어오면
				Integer.parseInt(boardKindNo);
				Integer.parseInt(boardNo);
			} catch (Exception e) {
				mav.addObject("message", "잘못된 형식입니다.");
	    		mav.addObject("loc", "javascript:history.back();");

				mav.setViewName("msg");
				return mav;
			}
	    	
	    	int loginNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		loginNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	// 게시물 1개를 가져오며 로그인 회원번호와 작성자 회원번호가 일치하지 않으면 해당 게시물의 조회수를 1 올린다.
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	
	    	String readCountPermission = (String)session.getAttribute("readCountPermission"); // 세션으로부터 readCountPermission에 대한 데이터가 있는지 가져온다.
	    	
	    	BoardVO boardvo = null;
	    	if (readCountPermission != null) { // 리스트 페이지를 통해 들어왔다면
	    		// 게시물의 조회수를 올리고 게시물을 가져온다.
	    		paraMap.put("loginNo", String.valueOf(loginNo));
	    		boardvo = service.getView(paraMap);
	    		
	    		session.removeAttribute("readCountPermission"); // 세션은 비워준다.
			}else { // 리스트 페이지를 통해 들어온 것이 아니라면
				// 게시물 1개를 가져만 오고 조회수는 올리지 않는다. 
				boardvo = service.getViewNoAddCount(paraMap);
			}
	    	
	    	String gobackURL = request.getParameter("gobackURL");
	    	System.out.println("상세페이지 요청:gobackURL ->" + gobackURL);
	    	
	    	if (boardvo == null) {
	    		mav.addObject("message", "해당 게시글은 존재하지 않습니다.");
	    		mav.addObject("loc", request.getContextPath()+"/"+gobackURL);

				mav.setViewName("msg");
				return mav;
			}
	    	
	    	// 우측 게시판 신규글, 인기글 사이드바
	    	List<MinsungBoardVO> recentBoardList = service.recentBoardList();
	        List<MinsungBoardVO> bestBoardList = service.bestBoardList();
	        List<MinsungBoardVO> popularBoardList = service.popularBoardList();
	        
	        mav.addObject("recentBoardList", recentBoardList);
	        mav.addObject("bestBoardList", bestBoardList);
	        mav.addObject("popularBoardList", popularBoardList);
	    	
	    	mav.addObject("gobackURL", gobackURL);
	    	mav.addObject("boardvo", boardvo);
	    	mav.setViewName("/ohyoon/boardDetail.tiles1");
	    	return mav;
	    }
	    
	    // 게시판 상세페이지에서 우측 사이드바를 타고 들어오면 조회수를 1올려준 후 다시 get방식으로 보낸다.
	    @RequestMapping(value="/boardDetail.sky", method = {RequestMethod.POST})
	    public String boardDetailPost(HttpServletRequest request) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int loginNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		loginNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	// 게시물 1개를 가져오며 로그인 회원번호와 작성자 회원번호가 일치하지 않으면 해당 게시물의 조회수를 1 올린다.
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	
	    	// 게시물의 조회수를 올린다.
    		paraMap.put("loginNo", String.valueOf(loginNo));
    		service.getView(paraMap);
	    	
	    	return "redirect:/boardDetail.sky?boardKindNo="+boardKindNo+"&boardNo="+boardNo;
	    }
	    
	    
	    // 익명게시판 게시물 1개를 보여주는 페이지 요청
	    @RequestMapping(value="/boardDetail2.sky", method = {RequestMethod.GET})
	    public ModelAndView boardDetail2(HttpServletRequest request, ModelAndView mav) {
	    	
	    	// 세션에 랜덤 닉네임이 들어가 있는지 확인 후 들어있지 않으면 닉네임을 넣어준다.(다른 게시글 사이드바로 들어온 경우)
			HttpSession session = request.getSession();
			if (session.getAttribute("nickname") == null) {
				// 익명게시판이므로 랜덤한 숫자 2개를 받아 닉네임을 만든다.
				String nickname = service.getRandomNickname();
				session.setAttribute("nickname", nickname);
			}
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	try {
	    		// url로 장난을 치고 들어오면
				Integer.parseInt(boardKindNo);
				Integer.parseInt(boardNo);
			} catch (Exception e) {
				mav.addObject("message", "잘못된 형식입니다.");
	    		mav.addObject("loc", "javascript:history.back();");

				mav.setViewName("msg");
				return mav;
			}
	    	
	    	// 게시물 1개를 가져오며 로그인 회원번호와 작성자 회원번호가 일치하면 해당 게시물의 조회수를 1 올린다.
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	
	    	String readCountPermission = (String)session.getAttribute("readCountPermission"); // 세션으로부터 readCountPermission에 대한 데이터가 있는지 가져온다.

	    	BoardVO boardvo = null;
	    	if (readCountPermission != null) { // 리스트 페이지를 통해 들어왔다면
	    		// 게시물의 조회수를 올리고 게시물을 가져온다.
	    	//	paraMap.put("currentIp", currentIp); // 현재 접속자 ip와 글 작성자 ip가 같으면 조회수를 올리지 않음.
	    		boardvo = service.getView(paraMap);
	    		
	    		session.removeAttribute("readCountPermission"); // 세션은 비워준다.
			}else { // 리스트 페이지를 통해 들어온 것이 아니라면
				// 게시물 1개를 가져만 오고 조회수는 올리지 않는다. 
				boardvo = service.getViewNoAddCount(paraMap);
			}
	    	
	    	String gobackURL = request.getParameter("gobackURL");
	    	if (boardvo == null) {
	    		mav.addObject("message", "해당 게시글은 존재하지 않습니다.");
	    		mav.addObject("loc", request.getContextPath()+"/"+gobackURL);

				mav.setViewName("msg");
				return mav;
			}
	    	
	    	// 우측 게시판 신규글, 인기글 사이드바
	    	List<MinsungBoardVO> recentBoardList = service.recentBoardList();
	        List<MinsungBoardVO> bestBoardList = service.bestBoardList();
	        List<MinsungBoardVO> popularBoardList = service.popularBoardList();
	        
	        mav.addObject("recentBoardList", recentBoardList);
	        mav.addObject("bestBoardList", bestBoardList);
	        mav.addObject("popularBoardList", popularBoardList);
	    	
	    	mav.addObject("gobackURL", gobackURL);
	    	mav.addObject("boardvo", boardvo);
	    	mav.setViewName("/ohyoon/boardDetail2.tiles1");
	    	return mav;
	    }
	    
	    
	 // 게시판 상세페이지에서 우측 사이드바를 타고 들어오면 조회수를 1올려준 후 다시 get방식으로 보낸다.
	    @RequestMapping(value="/boardDetail2.sky", method = {RequestMethod.POST})
	    public String boardDetai2lPost(HttpServletRequest request) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int loginNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		loginNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	// 게시물 1개를 가져오며 로그인 회원번호와 작성자 회원번호가 일치하지 않으면 해당 게시물의 조회수를 1 올린다.
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	
	    	// 게시물의 조회수를 올린다.
    		paraMap.put("loginNo", String.valueOf(loginNo));
    		service.getView(paraMap);
	    	
	    	return "redirect:/boardDetail2.sky?boardKindNo="+boardKindNo+"&boardNo="+boardNo;
	    }
	    
	    
	    
	    // 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addBoardUp.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addBoardUp(HttpServletRequest request) {
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	paraMap.put("memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
			try {
				n = service.addBoardUp(paraMap);
			} catch (Exception e) {
				n = 0;
			}

			// 게시글의 추천, 비추천 수를 가져온다.
	    	int upCount = service.getBoardGoodCount(paraMap);
	    	int downCount = service.getBoardBadCount(paraMap);
			
			JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	jsonObj.put("upCount", upCount);
	    	jsonObj.put("downCount", downCount);
	    	return jsonObj.toString();
	    }
	    
	    
	    // 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addBoardDown.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addBoardDown(HttpServletRequest request) {
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	paraMap.put("memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
			try {
				n = service.addBoardDown(paraMap);
			} catch (Exception e) {
				n = 0;
			}

			// 게시글의 추천, 비추천 수를 가져온다.
	    	int upCount = service.getBoardGoodCount(paraMap);
	    	int downCount = service.getBoardBadCount(paraMap);
			
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	jsonObj.put("upCount", upCount);
	    	jsonObj.put("downCount", downCount);
	    	
	    	return jsonObj.toString();
	    }
	    
	    
	    // 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addBoardReport.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addBoardReport(HttpServletRequest request) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	paraMap.put("memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
	    	try {
	    		n = service.addBoardReport(paraMap);
	    	} catch (Exception e) {
	    		n = 0;
	    	}
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	
	    	return jsonObj.toString();
	    }
	    
	    
	    // 게시글 삭제 메서드
	    @RequestMapping(value="/deleteBoard.sky")
	    public ModelAndView requiredLoginOY_deleteBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	
	    	// 조회수를 올리지 않고 게시물을 가져온 후, 삭제 요청 회원이 글작성자인지 비교한다.
	    	BoardVO boardvo = service.getViewNoAddCount(paraMap);

	    	HttpSession session = request.getSession();
	    	CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");

	    	String message = "";
	    	String loc = "";
	    	
	    	if (loginuser == null || Integer.parseInt(boardvo.getFk_memberNo()) != loginuser.getFk_memberNo()) { 
	    		// 로그인하지 않은 상태거나 로그인한 회원이 글작성자가 아니라면
	    		message = "타인의 글은 삭제할 수 없습니다.";
	    		loc = "javascript:history.back();";
			}else { 
				// 로그인한 상태이며 글작성자라면
				
				// 해당 글의 첨부파일을 삭제하기 위해 첨부파일의 파일명과 경로를 service로 보내준다.
				String fileName = boardvo.getFileName();
				if ( fileName != null && !fileName.equals("") ) { // 첨부파일이 있는 게시물이라면
					paraMap.put("fileName", fileName); // 삭제해야할 파일명
					String root = session.getServletContext().getRealPath("/");
					String path = root+"resources"+ File.separator +"files";
					paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
				}
				
				// 해당 글을 삭제한다.
				int result = service.deleteBoard(paraMap);
				if (result == 1) {
					message = "삭제되었습니다.";
					loc = request.getContextPath()+"/boardList.sky?boardKindNo="+boardKindNo;
				}
				
			}
	    	
	    	mav.addObject("message", message);
	    	mav.addObject("loc", loc);
	    	mav.setViewName("msg");
	    	return mav;
	    }
	    
	    
	    // 익명게시판 게시글 삭제 메서드
	    @RequestMapping(value="/deleteBoard2.sky")
	    public ModelAndView deleteBoard2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	String password = request.getParameter("boardPassword");
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("boardKindNo", boardKindNo);
	    	paraMap.put("boardNo", boardNo);
	    	paraMap.put("password", password);
	    	
	    	String message = "";
	    	String loc = "";
	    	
    		// 해당 글을 삭제한다.
    		int result = service.deleteBoard(paraMap);
    		if (result == 1) {
    			message = "삭제되었습니다.";
    			loc = request.getContextPath()+"/boardList.sky?boardKindNo="+boardKindNo;
    		}else {
    			message = "삭제에 실패했습니다.";
    			loc = request.getContextPath()+"/boardDetail2.sky?boardKindNo="+boardKindNo+"&boardNo="+boardNo;
    		}
    		
	    	mav.addObject("message", message);
	    	mav.addObject("loc", loc);
	    	mav.setViewName("msg");
	    	return mav;
	    }
	    
	    
	    // 첨부파일 다운로드 받기
	    @RequestMapping(value = "/download.sky")
	    public void download(HttpServletRequest request, HttpServletResponse response) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	response.setContentType("text/html; charset=UTF-8");
	    	PrintWriter writer = null;
	    	
	    	try {
	    		Integer.parseInt(boardKindNo);
	    		Integer.parseInt(boardNo);
	    		
	    		Map<String, String> paraMap = new HashMap<>();
	    		paraMap.put("boardKindNo", boardKindNo);
	    		paraMap.put("boardNo", boardNo);
	    		
	    		// 게시글을 조회해온다
	    		BoardVO boardvo = service.getViewNoAddCount(paraMap);
	    		String fileName = boardvo.getFileName();
	    		String orgFilename = boardvo.getOrgFilename();
	    		
	    		// 첨부파일이 저장되어있는 톰캣의 경로명을 알아온다.
	    		HttpSession session = request.getSession();
	    		String root = session.getServletContext().getRealPath("/");
	    		String path = root + "resources" + File.separator + "files";

	    		// file 다운로드
	    		boolean flag = false; // file 다운로드의 성공 여부 확인용
	    		flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
	    		
	    		if (!flag) {
	    			try {
						// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
						writer = response.getWriter();
						writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>");
					} catch (IOException e) {}
	    		}
	    		
	    		
			} catch (NumberFormatException e) {
				try {
					// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
					writer = response.getWriter();
					writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>");
				} catch (IOException e1) {}
			}
	    }
	    
	    
	    // 게시물 수정하기
	    @RequestMapping(value = "/updateBoard.sky")
	    public ModelAndView requiredLoginOY_updateBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	String gobackURL = request.getParameter("gobackURL");
	    	
	    	String message = "";
	    	String loc = "";
	    	try {
	    		
	    		Integer.parseInt(boardNo);
	    		String boardKindName = service.getBoardName(Integer.parseInt(boardKindNo)); // 게시판 이름을 알아온다.
	    		
	    		Map<String, String> paraMap = new HashMap<>();
	    		paraMap.put("boardKindNo", boardKindNo);
	    		paraMap.put("boardNo", boardNo);
	    		BoardVO boardvo = service.getViewNoAddCount(paraMap); // 게시글 내용을 받아온다.
	    		
	    		HttpSession session = request.getSession();
	    		CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
	    		
	    		if (loginuser == null || loginuser.getFk_memberNo() != Integer.parseInt(boardvo.getFk_memberNo())) { // 로그인을 하지 않았거나 타인의 글 수정을 눌렀다면
	    			message = "타인의 글은 수정할 수 없습니다.";
	    			loc = "javascript:history.back();";
	    			mav.addObject("message", message);
					mav.addObject("loc", loc);
					mav.setViewName("msg");
				}else {
					// 자기글을 수정하려 들어왔다면 수정페이지를 보여준다.
					mav.addObject("boardKindName", boardKindName);
					mav.addObject("boardvo", boardvo);
					mav.addObject("gobackURL", gobackURL);
					mav.setViewName("ohyoon/boardUpdate.tiles1");
				}
	    		
	    		
			} catch (NumberFormatException e) {
				// url상으로 잘못 들어왔다면
				message = "잘못된 형식입니다.";
				loc = "javascript:history.back();";
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
	    	return mav;
	    }

	    
	    // 게시글 수정중 첨부파일 삭제하기(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value = "/deleteAttach.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String deleteAttach(HttpServletRequest request) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	
	    	int n = 0;
	    	// 해당 글의 첨부파일을 삭제하기 위해 첨부파일의 파일명과 경로를 받아온다.
	    	String fileName = request.getParameter("fileName");
			if ( fileName != null && !fileName.equals("") ) { // 첨부파일이 있는 게시물이라면
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+ File.separator +"files";
				
				try {
					fileManager.doFileDelete(fileName, path); // 해당 파일을 삭제한다.
					
					// 삭제 성공시 해당 글의 첨부파일 저장명, 원본명, 파일 사이즈를 null로 update 해준다.
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("boardKindNo", boardKindNo);
					paraMap.put("boardNo", boardNo);
					n = service.deleteAttach(paraMap);
					
				} catch (Exception e) {}
			}
			
			// 파일이 삭제되고 db에도 반영됐다면 n = 1, 아니라면 n = 0
			JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	return jsonObj.toString();
	    }
	    
	    
	    // 게시글 수정 완료하기
	    @RequestMapping(value = "/boardUpdateEnd.sky", method = {RequestMethod.POST})
	    public ModelAndView boardUpdateEnd(BoardVO boardvo, MultipartHttpServletRequest mrequest, ModelAndView mav) {
	    	
	    	String gobackURL = mrequest.getParameter("gobackURL");

	    	MultipartFile attach = boardvo.getAttach();
			
	    	if (!attach.isEmpty()) {
				// 첨부파일이 비어있지 않다면
				
				// 1. 올리는 파일을 WAS(톰캣) 폴더에 저장해야 한다.
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "files";
				
				// 2. 파일 첨부를 위해서 변수를 설정하고 파일을 올려야 한다.
				String newFilename = ""; // 저장될 파일명
				
				byte[] bytes = null; // 첨부파일의 내용물
				
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // // 첨부파일의 내용물을 읽어옴. 첨부파일을 bytes에 넣는다.
					
					newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); // getOriginalFilename()은 첨부파일의 원본 이름을 리턴한다.
					
					// 3. boardvo에 fileName 값과 orgFilename 값, fileSize 값을 넣어준다.
					boardvo.setFileName(newFilename); // 저장할 파일명 boardvo에 저장.
					boardvo.setOrgFilename(attach.getOriginalFilename()); // 원본 파일명을 boardvo에 저장.
					
					fileSize = attach.getSize(); // getSize()은 첨부파일의 크기를 리턴한다.
					boardvo.setFileSize(String.valueOf(fileSize)); // 첨부파일의 크기를 boardvo에 저장한다.
					
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
	    	
	    	// 작성한 글을 db에 저장.
			int n = 0;
			if (attach.isEmpty()) {
				// 파일첨부가 없는 글수정
				n = service.updateBoard(boardvo);
			}else {
				// 파일첨부가 있는 글수정
				n = service.updateBoardWithFile(boardvo);
			}
	    	
			String message = "";
			if (n == 1) {
				message = "수정이 완료되었습니다.";
			}else {
				message = "수정에 실패했습니다.";
			}
			String loc = mrequest.getContextPath()+"/boardDetail.sky?boardKindNo="+boardvo.getFk_boardKindNo()+"&boardNo="+boardvo.getBoardNo()+"&gobackURL="+gobackURL;
	    	
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
	    	return mav;
	    } 

	    
	    // 익명게시판 게시물 수정하기
	    @RequestMapping(value = "/updateBoard2.sky", method = {RequestMethod.POST})
	    public ModelAndView updateBoard2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	    	
	    	String boardKindNo = request.getParameter("boardKindNo");
	    	String boardNo = request.getParameter("boardNo");
	    	String password = request.getParameter("boardPassword");
	    	String gobackURL = request.getParameter("gobackURL");
	    	System.out.println("게시물 수정요청 : " + gobackURL);
	    	
	    	String message = "";
	    	String loc = "";
	    	try {
	    		
	    		Integer.parseInt(boardNo);
	    		String boardKindName = service.getBoardName(Integer.parseInt(boardKindNo)); // 게시판 이름을 알아온다.
	    		
	    		Map<String, String> paraMap = new HashMap<>();
	    		paraMap.put("boardKindNo", boardKindNo);
	    		paraMap.put("boardNo", boardNo);

	    		BoardVO boardvo = service.getViewNoAddCount(paraMap); // 게시글 내용을 받아온다.
	    		
	    		password = Sha256.encrypt(password); // 입력한 글 비밀번호를 암호화한다.
	    		
	    		if ( !password.equals(boardvo.getPassword()) ) { // 글 비밀번호를 틀렸다면
	    			message = "비밀번호가 틀렸으므로 수정할 수 없습니다.";
	    			loc = "javascript:history.back();";
	    			mav.addObject("message", message);
	    			mav.addObject("loc", loc);
	    			mav.setViewName("msg");
	    		}else {
	    			// 자기글을 수정하려 들어왔다면 수정페이지를 보여준다.
	    			mav.addObject("boardKindName", boardKindName);
	    			mav.addObject("boardvo", boardvo);
	    			mav.addObject("gobackURL", gobackURL);
	    			mav.setViewName("ohyoon/boardUpdate2.tiles1");
	    		}
	    		
	    		
	    	} catch (NumberFormatException e) {
	    		// url상으로 잘못 들어왔다면
	    		message = "잘못된 형식입니다.";
	    		loc = "javascript:history.back();";
	    		mav.addObject("message", message);
	    		mav.addObject("loc", loc);
	    		mav.setViewName("msg");
	    	}
	    	return mav;
	    }
	    
	    
	    // 익명 게시판 게시글 수정 완료하기
	    @RequestMapping(value = "/boardUpdateEnd2.sky", method = {RequestMethod.POST})
	    public ModelAndView boardUpdateEnd2(BoardVO boardvo, HttpServletRequest request, ModelAndView mav) {
	    	
	    	String gobackURL = request.getParameter("gobackURL");
	    	System.out.println("게시물 수정완료 : " + gobackURL);
	    	
	    	// 작성한 글을 db에 저장.
	    	int n = service.updateBoard(boardvo);
	    	
	    	String message = "";
	    	if (n == 1) {
	    		message = "수정이 완료되었습니다.";
	    	}else {
	    		message = "수정에 실패했습니다.";
	    	}
	    	String loc = request.getContextPath()+"/boardDetail2.sky?boardKindNo="+boardvo.getFk_boardKindNo()+"&boardNo="+boardvo.getBoardNo()+"&gobackURL="+gobackURL;
	    	
	    	mav.addObject("message", message);
	    	mav.addObject("loc", loc);
	    	mav.setViewName("msg");
	    	return mav;
	    } 
	    
	    
	    // 댓글 작성하기(ajax 사용)
	    @ResponseBody
	    @RequestMapping(value = "/commentRegister.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String commentRegister(Map<String, String> paraMap, HttpServletRequest request, HttpServletResponse response){
	    	
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
	    	
	    	// 게시판 번호, 게시글 번호, 댓글 내용, 작성자 회원번호, 작성자 닉네임, 작성자 ip, 댓글 비밀번호를 commentvo에 저장한다.
	    	CommentVO commentvo = new CommentVO();
	    	commentvo.setFk_boardKindNo(fk_boardKindNo);
	    	commentvo.setFk_boardNo(fk_boardNo);
	    	commentvo.setCmtContent(cmtContent);
	    	
	    	if (fk_boardKindNo.equals("7")) { // 익명게시판 댓글이라면 작성자 닉네임과 댓글 비밀번호를 받아와서 commentvo에 저장한다.
	    		commentvo.setPassword(request.getParameter("password"));
		    	commentvo.setFk_nickname(request.getParameter("fk_nickname"));
			}
	    	
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
	    		n = service.addComment(commentvo);

	    		if (!fk_boardKindNo.equals("7")) { // 익명 게시판 댓글이 아니라면
	    			// 댓글쓰기 완료 후, 포인트 올려주기 
	    			paraMap.put("fk_memberNo", commentvo.getFk_memberNo());
	    			paraMap.put("point", "1");	   
	    			n = service.addPoint(paraMap);
				}
	    		
			} catch (Exception e) {
				n = 0;
			}

	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	
	    	return jsonObj.toString();
	    }
	    
	    
	    // 댓글 리스트 가져오기(ajax 사용)
	    @ResponseBody
	    @RequestMapping(value = "/commentList.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String commentList(HttpServletRequest request) {
	    	
	    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
	    	String fk_boardNo = request.getParameter("fk_boardNo");
	    	String startNo = request.getParameter("startNo");
	    	String cmtLength = request.getParameter("cmtLength");
	    	
	    	Map<String, String> paraMap = new HashMap<String, String>();
	    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
	    	paraMap.put("fk_boardNo", fk_boardNo);
	    	paraMap.put("startNo", startNo);
	    	
	    	String endNo = String.valueOf(Integer.parseInt(startNo) + Integer.parseInt(cmtLength) - 1);
	    	paraMap.put("endNo", endNo);
	    	
	    	// 요청한 순서의 댓글을 8개씩 가져오기
	    	List<CommentVO> commentList = service.getCommentList(paraMap);
	    	
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
				jsonObj.put("cmtUpCount", commentvo.getCmtUpCount());
				jsonObj.put("cmtDownCount", commentvo.getCmtDownCount());
				
				jsonArr.put(jsonObj);
			}
	    	return jsonArr.toString();
	    }
	    
	    
	    // 댓글 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addCommentUp.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addCommentUp(HttpServletRequest request) {
	    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
	    	String fk_boardNo = request.getParameter("fk_boardNo");
	    	String fk_commentNo = request.getParameter("commentNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
	    	paraMap.put("fk_boardNo", fk_boardNo);
	    	paraMap.put("fk_commentNo", fk_commentNo);
	    	paraMap.put("fk_memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
	    	try {
	    		n = service.addCommentUp(paraMap);
	    	} catch (Exception e) {
	    		n = 0;
	    	}
	    	
	    	// 댓글의 추천, 비추천 수를 가져온다.
	    	int cmtUpCount = service.getCommentGoodCount(paraMap);
	    	int cmtDownCount = service.getCommentBadCount(paraMap);
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	jsonObj.put("cmtUpCount", cmtUpCount);
	    	jsonObj.put("cmtDownCount", cmtDownCount);
	    	
	    	return jsonObj.toString();
	    }
 
	    
	    // 댓글 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addCommentDown.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addCommentDown(HttpServletRequest request) {
	    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
	    	String fk_boardNo = request.getParameter("fk_boardNo");
	    	String fk_commentNo = request.getParameter("commentNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
	    	paraMap.put("fk_boardNo", fk_boardNo);
	    	paraMap.put("fk_commentNo", fk_commentNo);
	    	paraMap.put("fk_memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
	    	try {
	    		n = service.addCommentDown(paraMap);
	    	} catch (Exception e) {
	    		n = 0;
	    	}
	    	
	    	// 댓글의 추천, 비추천 수를 가져온다.
	    	int cmtUpCount = service.getCommentGoodCount(paraMap);
	    	int cmtDownCount = service.getCommentBadCount(paraMap);
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	jsonObj.put("cmtUpCount", cmtUpCount);
	    	jsonObj.put("cmtDownCount", cmtDownCount);
	    	
	    	return jsonObj.toString();
	    }
	    
	    
	    // 댓글 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/addCommentReport.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String addCommentReport(HttpServletRequest request) {
	    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
	    	String fk_boardNo = request.getParameter("fk_boardNo");
	    	String fk_commentNo = request.getParameter("commentNo");
	    	
	    	int fk_memberNo = 0;
	    	HttpSession session = request.getSession();
	    	if (session.getAttribute("loginuser") != null) {
	    		fk_memberNo = ((CommuMemberVO)session.getAttribute("loginuser")).getFk_memberNo();
	    	}
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
	    	paraMap.put("fk_boardNo", fk_boardNo);
	    	paraMap.put("fk_commentNo", fk_commentNo);
	    	paraMap.put("fk_memberNo", String.valueOf(fk_memberNo));
	    	
	    	int n;
	    	try {
	    		n = service.addCommentReport(paraMap);
	    	} catch (Exception e) {
	    		n = 0;
	    	}
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	return jsonObj.toString();
	    }

	    
	    // 댓글을 삭제해주기(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/deleteComment.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String deleteComment(HttpServletRequest request) {
	    	String fk_boardKindNo = request.getParameter("fk_boardKindNo");
	    	String fk_boardNo = request.getParameter("fk_boardNo");
	    	String fk_commentNo = request.getParameter("commentNo");
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("fk_boardKindNo", fk_boardKindNo);
	    	paraMap.put("fk_boardNo", fk_boardNo);
	    	paraMap.put("fk_commentNo", fk_commentNo);

	    	int n;
	    	try {
	    		n = service.deleteComment(paraMap);
	    	} catch (Exception e) {
	    		n = 0;
	    	}
	    	
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("n", n);
	    	return jsonObj.toString();
	    }
	    
	    
	    // 댓글을 수정해주기 (ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/updateComment.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String updateComment(HttpServletRequest request, CommentVO commentvo) {
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
				n = service.updateComment(paraMap); 
			} catch (Exception e) { 
				n = 0; 
			}
			
			JSONObject jsonObj = new JSONObject(); 
			jsonObj.put("n", n); 
			return jsonObj.toString();
	    }
	    
	    
	    // 익명게시판 댓글 비밀번호 검사하기(ajax로 처리)
	    @ResponseBody
	    @RequestMapping(value="/comparePassword.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
	    public String comparePassword(HttpServletRequest request, CommentVO commentvo) {
	    	
	    	Map<String, String> paraMap = new HashMap<>();
	    	paraMap.put("fk_boardNo", commentvo.getFk_boardNo());
	    	paraMap.put("commentNo", commentvo.getCommentNo());
	    	paraMap.put("password", commentvo.getPassword());
	    	
	    	int n; 
	    	try { 
	    		n = service.comparePassword(paraMap); 
	    	} catch (Exception e) { 
	    		n = 0; 
	    	}
	    	
	    	JSONObject jsonObj = new JSONObject(); 
	    	jsonObj.put("n", n); 
	    	return jsonObj.toString();
	    }
	    
	    
	    //=== 채팅창으로 페이지로 넘어가기 ===
	    @RequestMapping(value="/chatting.sky", method= {RequestMethod.GET}) 
	    public String requiredLoginOY_chatting(HttpServletRequest request, HttpServletResponse response) { 
	    	
	    	return "ohyoon/chatting.tiles1";
	    } 
	    
	    
	    
	    
	    
	/////////////////////////////////////////////////////////////////////////////////////////////////////    
	    // ==== #스마트에디터. 드래그앤드롭을 사용한 다중사진 파일업로드 ====
	    @RequestMapping(value="/image/multiplePhotoUpload.sky", method={RequestMethod.POST})
	    public void multiplePhotoUpload(HttpServletRequest req, HttpServletResponse res) {
		    
		 /*
		    1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		    >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		         우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
		  */
			
		 // WAS 의 webapp 의 절대경로를 알아와야 한다. 
		 HttpSession session = req.getSession();
		 String root = session.getServletContext().getRealPath("/"); 
		 String path = root + "resources"+File.separator+"photo_upload";
		 // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
		 System.out.println(">>>> 확인용 path ==> " + path); 
		 // >>>> 확인용 path ==> C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload  
			
		 File dir = new File(path);
		 if(!dir.exists())
		     dir.mkdirs();
			
		 String strURL = "";
			
		  try {
			if(!"OPTIONS".equals(req.getMethod().toUpperCase())) {
			    String filename = req.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명
		    		
		        // System.out.println(">>>> 확인용 filename ==> " + filename); 
		        // >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg
		    		
		    	   InputStream is = req.getInputStream();
		    	/*
		          요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
		          혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
		          이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.

	               	  서블릿에서 payload body는 Request.getParameter()가 아니라 
	            	  Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
		    	*/
		    	   String newFilename = fileManager.doFileUpload(is, filename, path);
		    	
			   int width = fileManager.getImageWidth(path+File.separator+newFilename);
				
			   if(width > 600)
			      width = 600;
					
			// System.out.println(">>>> 확인용 width ==> " + width);
			// >>>> 확인용 width ==> 600
			// >>>> 확인용 width ==> 121
		    	
			   String CP = req.getContextPath(); // board
				
			   strURL += "&bNewLine=true&sFileName="; 
	            	   strURL += newFilename;
	            	   strURL += "&sWidth="+width;
	            	   strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
		    	}
			
		    	/// 웹브라우저상에 사진 이미지를 쓰기 ///
			   PrintWriter out = res.getWriter();
			   out.print(strURL);
		 } catch(Exception e){
				e.printStackTrace();
		 } 
	   
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


		
		
	
}
