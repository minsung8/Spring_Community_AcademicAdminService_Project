package com.project.skyuniversity.minsung.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.project.skyuniversity.minsung.common.FileManager;
import com.project.skyuniversity.minsung.common.MyUtil;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.minsung.model.MinsungCategoryVO;
import com.project.skyuniversity.minsung.model.MinsungMsgVO;
import com.project.skyuniversity.minsung.service.InterMinsungService;

@Component
@Controller
public class MinsungBoardController {

	@Autowired
	private InterMinsungService service;

	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	@RequestMapping(value = "minsungBoardDetail.sky")
	public ModelAndView requiredLoginMS_minsungBoardDetail(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

		mav.setViewName("minsung/minsungBoardDetails.tiles1");

		return mav;
	}

	@RequestMapping(value = "minsungBoardList.sky")
	public ModelAndView NoticeBoardList(HttpServletRequest request, ModelAndView mav) {
				
		HttpSession session = request.getSession();
		
		String boardKindNo = request.getParameter("boardKindNo");
		
		String kindBoard = service.kindBoard(boardKindNo);
		List<MinsungCategoryVO> categoryList = service.categoryList(boardKindNo);

		List<MinsungBoardVO> boardList = null;

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");

		if (searchType == null) {
			searchType = "";
		}

		if (searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("boardKindNo", boardKindNo);

		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)

		int startRno = 0; // 시작 행번호
		int endRno = 0; // 끝 행번호

		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage); // (double)127/10 ==> 12.7 ==> Math.ceil(12.7)
																		// ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12

		if (str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면

			currentShowPageNo = 1;
		} else {
			try {
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

		boardList = service.boardListSearchWithPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)

		if (!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}

		// === #121. 페이지바 만들기 === //
		String pageBar = "<ul style='list-style: none;'>";

		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		 * 1 2 3 4 5 6 7 8 9 10 다음 -- 1개블럭 이전 11 12 13 14 15 16 17 18 19 20 다음 -- 1개블럭
		 * 이전 21 22 23
		 */

		int loop = 1;
		/*
		 * loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */

		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

		String url = "minsungBoardList.sky";

		// === [맨처음][이전] 만들기 ===
		if (pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + (pageNo - 1)
					+ "'>[이전]</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"
						+ pageNo + "</li>";
			} else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url
						+ "?boardKindNo=" + boardKindNo + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo
						+ "'>" + pageNo + "</a></li>";
			}

			loop++;
			pageNo++;

		} // end of while------------------------------

		// === [다음][마지막] 만들기 ===
		if (!(pageNo > totalPage)) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo + "'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + totalPage + "'>[마지막]</a></li>";
		}

		pageBar += "</ul>";
		
		List<NoticeVO> noticeList = service.getNoticeList(paraMap);
		String gobackURL = MyUtil.getCurrentURL(request);
	
		
		mav.addObject("gobackURL", gobackURL);
		mav.addObject("boardList", boardList);
		mav.addObject("pageBar", pageBar);
		mav.addObject("categoryList", categoryList);
		mav.addObject("kindBoard", kindBoard);
		mav.addObject("paraMap", paraMap);
		mav.addObject("noticeList", noticeList);

		mav.setViewName("minsung/minsungBoardList.tiles1");

		return mav;
	}

	@RequestMapping(value = "/minsungBoardView.sky")
	public ModelAndView requiredLoginMS_view(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");
		Map<String, String> paraMap2 = new HashMap<>();
		paraMap2.put("boardNo", boardNo);
		paraMap2.put("boardKindNo", boardKindNo);
		MinsungBoardVO boardvo = service.getOneBoard(paraMap2);
				
		boardvo.setFk_boardKindNo(boardKindNo);
		boardvo.setBoardNo(boardNo);
		
    	try {
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
    		loginNo = ( (CommuMemberVO)session.getAttribute("loginuser") ).getFk_memberNo();
    	}

		String gobackURL = request.getParameter("gobackURL");

		if (gobackURL != null) {
			gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것임.
			// System.out.println("###### 확인용 gobackURL : " + gobackURL);
			// ###### 확인용 gobackURL :
			// list.action?searchType=&searchWord=&currentShowPageNo=2
			mav.addObject("gobackURL", gobackURL);
		}

    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("boardKindNo", boardKindNo);
    	paraMap.put("boardNo", boardNo);
    	paraMap.put("loginNo", String.valueOf(loginNo) );

		CommuMemberVO loginuser = (CommuMemberVO) session.getAttribute("loginuser");

		// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
		if ("yes".equals(session.getAttribute("readCountPermission"))) {
			// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.

			boardvo = service.getView(paraMap);
			session.removeAttribute("readCountPermission");
			// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		} else {

			boardvo = service.getViewWithNoAddCount(paraMap);

		}

		mav.addObject("boardvo", boardvo);

		List<MinsungBoardVO> recentBoardList = service.recentBoardList();
		List<MinsungBoardVO> bestBoardList = service.bestBoardList();
		List<MinsungBoardVO> popularBoardList = service.popularBoardList();
		
		mav.addObject("recentBoardList", recentBoardList);
		mav.addObject("bestBoardList", bestBoardList);
		mav.addObject("popularBoardList", popularBoardList);

		mav.addObject("boardvo", boardvo);
		mav.setViewName("minsung/minsungBoardDetails.tiles1");

		return mav;
	}

	@RequestMapping(value = "/minsungEdit.sky")
	public ModelAndView requiredLoginMS_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		// 글 수정해야 할 글번호 가져오기
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");
		
		Map<String, String> paraMap2 = new HashMap<>();
		paraMap2.put("boardNo", boardNo);
		paraMap2.put("boardKindNo", boardKindNo);

		// 글 수정해야할 글1개 내용 가져오기
		MinsungBoardVO boardvo = service.getOneBoard(paraMap2);
		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.

		mav.addObject("boardvo", boardvo);
		mav.setViewName("minsung/MinsungEdit.tiles1");

		return mav;
	}

	@RequestMapping(value = "/minsungEditEnd.sky", method = { RequestMethod.POST })
	public ModelAndView editEnd(MinsungBoardVO boardvo, HttpServletRequest request, ModelAndView mav) {

		int n = service.edit(boardvo);
		// n 이 1 이라면 정상적으로 변경됨.
		// n 이 0 이라면 글수정에 필요한 글암호가 틀린경우

		if (n == 0) {
			mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
		} else {
			mav.addObject("message", "글수정 성공!!");
		}

		mav.addObject("loc", request.getContextPath() + "/minsungBoardView.sky?boardNo=" + boardvo.getBoardNo());
		mav.setViewName("msg");

		return mav;
	}

	// === #77. 글삭제 페이지 완료하기 === //
	@RequestMapping(value = "/minsungDel.sky")
	public ModelAndView del(HttpServletRequest request, ModelAndView mav) {

		/*
		 * 글 삭제를 하려면 원본글의 글암호와 삭제시 입력해준 암호가 일치할때만 글 삭제가 가능하도록 해야한다.
		 */
		String boardNo = request.getParameter("boardNo");
		String boardKindNo = request.getParameter("boardKindNo");

		Map<String, String> paraMap2 = new HashMap<>();
		paraMap2.put("boardNo", boardNo);
		paraMap2.put("boardKindNo", boardKindNo);
		MinsungBoardVO boardvo = service.getOneBoard(paraMap2);

		/*
		 * if (boardvo.getFileName() != null) { FileManager filemanager = new
		 * FileManager();
		 * 
		 * HttpSession session = request.getSession(); String root =
		 * session.getServletContext().getRealPath("/");
		 * 
		 * System.out.println("~~~~ webapp 의 절대경로 => " + root); // ~~~~ webapp 의 절대경로 =>
		 * //
		 * C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\
		 * wtpwebapps\Board\
		 * 
		 * String path = root + "resources" + File.separator + "files"; try {
		 * filemanager.doFileDelete(boardvo.getFileName(), path); } catch (Exception e)
		 * { e.printStackTrace(); } }
		 */

		int n = service.del(boardvo);
		// n 이 1 이라면 정상적으로 삭제됨.
		// n 이 0 이라면 글삭제에 필요한 글암호가 틀린경우

		mav.addObject("message", "글삭제 성공!!");
		mav.addObject("loc", request.getContextPath() + "/minsungBoardList.sky");

		mav.setViewName("msg");

		return mav;
	}

	@RequestMapping(value = "/minsungAdd.sky")
	public ModelAndView requiredLoginMS_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav,  String boardKindNo) {
				
		List<MinsungCategoryVO> categoryList = service.categoryList(String.valueOf(boardKindNo));
		String boardName = service.kindBoard( boardKindNo );
		
		Map<String, String> infoMap = new HashMap<>();
		infoMap.put("boardKindNo", boardKindNo);
		infoMap.put("boardName", boardName);
		
		HttpSession session = request.getSession();
		CommuMemberVO loginuser = (CommuMemberVO)session.getAttribute("loginuser");
		if (loginuser.getNickname() == null) {
			mav.addObject("message", "닉네임을 먼저 설정해야합니다.");
			mav.addObject("loc", "javascript:history.back();");
			
			mav.setViewName("msg");
			return mav;
		}
		
		
		mav.addObject("infoMap", infoMap);
		mav.addObject("categoryList", categoryList);
		mav.setViewName("minsung/minsungBoardRegister.tiles1");
		// /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.

		return mav;
	}
	
	@RequestMapping(value = "/minsungAddEnd.sky", method = { RequestMethod.POST })
	public void pointPlusMS_addEnd(Map<String, String> paraMap, MinsungBoardVO boardvo,
			MultipartHttpServletRequest mrequest, HttpServletRequest request, HttpServletResponse response) {
		
		
		try {
			boardvo.setWriterIp(getUserIp()); // 작성자 ip를 받아 boardvo에 저장.
		} catch (Exception e1) {
			boardvo.setWriterIp(""); // 만일 getUserIp()도중 예외가 발생하면 ""으로 저장.
		}
		
		MultipartFile attach = boardvo.getAttach();
		if (!attach.isEmpty()) {

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
		paraMap.put("fk_boardKindNo", mrequest.getParameter("fk_boardKindNo"));
		paraMap.put("boardName", mrequest.getParameter("boardName"));
		paraMap.put("fk_memberNo", boardvo.getFk_memberNo());
		paraMap.put("point", "3");
		
		// 작성한 글을 db에 저장.
		int n = 0;
		if (attach.isEmpty()) {
			n = service.add(boardvo);
		}else {
			n = service.add_withFile(boardvo);
		}



		
	}
	
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
	
    @ResponseBody
    @RequestMapping(value="/minsungAddBoardUp.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
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
    	int downCount = service.getBoardGoodCount(paraMap);
		
		JSONObject jsonObj = new JSONObject();
    	jsonObj.put("n", n);
    	jsonObj.put("upCount", upCount);
    	jsonObj.put("downCount", downCount);

    	
    	return jsonObj.toString();
    
    	}
    
    @ResponseBody
    @RequestMapping(value="/minsungAddBoardDown.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
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
    @ResponseBody
    @RequestMapping(value="/minsungAddCommentReport.sky", method = {RequestMethod.POST}, produces = "text/plain; charset=UTF-8")
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
    
    @RequestMapping(value = "/minsungDownload.sky")
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
    		MinsungBoardVO boardvo = service.getViewNoAddCount(paraMap);
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
    
    @RequestMapping(value = "/messageLetsGetIt.sky")
	public ModelAndView message(HttpServletRequest request, HttpServletResponse response, ModelAndView mav,  String boardKindNo) {
    	
    	int loginNo = 0;
    	HttpSession session = request.getSession();
    	List<MinsungMsgVO> getMsgList = null;
		List<MinsungMsgVO> sendMsgList = null; 
		
		String value = request.getParameter("value");
    	
    	if (session.getAttribute("loginuser") != null) {
    		loginNo = ( (CommuMemberVO)session.getAttribute("loginuser") ).getFk_memberNo();
    		
    		getMsgList = service.getMsgList(loginNo);
    		sendMsgList = service.sendMsgList(loginNo);    		
    	}
    	
		mav.addObject("getMsgList", getMsgList);
		mav.addObject("sendMsgList", sendMsgList);
		mav.addObject("value", value);
    	
		mav.setViewName("minsung/message.tiles1");
    	
    	return mav;
    }
    
    @ResponseBody
    @RequestMapping(value = "/getOneMsg.sky",  produces="text/plain;charset=UTF-8")
	public String getOneMsg(HttpServletRequest request, HttpServletResponse response, ModelAndView mav,  String boardKindNo) {
    	
    	String msgNo = request.getParameter("msgNo");
    	
    	MinsungMsgVO msg = service.oneMsg(msgNo);
    	
    	JSONObject jsonObj = new JSONObject();
    	String subject = msg.getSubject();
    	String fromNickName = msg.getFromNickName();
    	String content = msg.getContent();

    	jsonObj.put("subject", subject);
    	jsonObj.put("fromNickName", fromNickName);
    	jsonObj.put("content", content);
    	
    	return jsonObj.toString();
    }
    
    @ResponseBody
    @RequestMapping(value = "/writeMsg.sky",  produces="text/plain;charset=UTF-8")
	public String writeMsg(HttpServletRequest request, HttpServletResponse response, ModelAndView mav,  String boardKindNo) {
    	
    	String subject = request.getParameter("subject");
    	String nickName = request.getParameter("nickName");
    	String content = request.getParameter("content");
    	
    	HttpSession session = request.getSession();
    	int loginNo = ( (CommuMemberVO)session.getAttribute("loginuser") ).getFk_memberNo();
    	int toMemberNo = service.getToMemberNo(nickName);
    	
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("loginNo", String.valueOf(loginNo) );
		paraMap.put("toMemberNo", String.valueOf(toMemberNo) );
		paraMap.put("subject", subject);
		paraMap.put("content", content );
    	int n = service.insertMsg(paraMap);
    	    	
    	JSONObject jsonObj = new JSONObject();

    	jsonObj.put("n", n);
    	
    	return jsonObj.toString();
    }
    
    
    
}
	