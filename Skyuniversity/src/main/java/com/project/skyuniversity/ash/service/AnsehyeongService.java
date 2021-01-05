package com.project.skyuniversity.ash.service;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.skyuniversity.ash.model.BannerVO;
import com.project.skyuniversity.ash.model.CommuMemberLevelVO;
import com.project.skyuniversity.ash.model.CommuMemberVO;
import com.project.skyuniversity.ash.model.InterAnsehyeongDAO;
import com.project.skyuniversity.ash.model.MarketBoardVO;
import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.model.CommentVO;
import com.project.skyuniversity.ash.common.AES256;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class AnsehyeongService implements InterAnsehyeongService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterAnsehyeongDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.

	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	
	 // @Autowired 
	 private AES256 aes;
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 메인 화면에 뜨는 배너 광고를 올려준다.
	@Override
	public List<BannerVO> getBannerList() {
		List<BannerVO> bannerList = dao.getBannerList();
		return bannerList;
	}
	
	
	// 인덱스 화면에 보여질 게시글들의 정보를 가져온다.
	@Override
	public List<MarketBoardVO> getIndexBoardList() {
		List<MarketBoardVO> indexBoardList = dao.getIndexBoardList();
		
		return indexBoardList;
	}
	
	
	// 로그인 요청하기 입니다!!
	@Override
	public CommuMemberVO getLoginUser(Map<String, String> paraMap) {
		
		CommuMemberVO loginuser = dao.getLoginUser(paraMap);
		
		if (loginuser != null) {
			CommuMemberLevelVO levelvo = dao.getLoginUserLevel(loginuser);
			loginuser.setLevelvo(levelvo);
		}
		
		return loginuser;
	}
	
	
	// === 닉네임 업데이트 요청 끝 !=== //
	@Override
	public int updateNicknameEnd(Map<String, String> paraMap) {
		int result = dao.updateNicknameEnd(paraMap);
		return result;
	}
	
	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getMarketCategoryList(Map<String, String> paraMap) {
		
		List<Map<String, String>> categoryList = dao.getMarketCategoryList(paraMap);
		
		return categoryList;
	}
	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 관리자버전=== //
	@Override
	public List<Map<String, String>> getAdminMarketCategoryList() {
		
		List<Map<String, String>> categoryList = dao.getAdminMarketCategoryList();
		
		return categoryList;
	}
	
	// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
	@Override
	public Map<String, String> getMarketTableInfo(Map<String, String> paraMap) {
		 Map<String, String> tableInfo = dao.getMarketTableInfo(paraMap);
		 
		return tableInfo;
	}

	// === 총 게시물 건수 알아오기 === // 
	@Override
	public int getMarketTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getMarketTotalCount(paraMap);
		return totalCount;
	}
	
	// === 게시판 번호와 시작 게시글 번호, 끝 게시글 번호를 입력하여 해당 게시판번호에 해당하는 게시글들을 불러오기 === //
	@Override
	public List<MarketBoardVO> getMarketBoardList(Map<String, String> paraMap) {
		List<MarketBoardVO> boardList = dao.getMarketBoardList(paraMap);
		return boardList;
	}

	@Override
	public int checkBoardKindNo(String boardKindNo) {
		int n = dao.checkBoardKindNo(boardKindNo);
		return n;
	}
	// 장터 게시판 글쓰기 맨~
	@Override
	public int marketAdd(MarketBoardVO boardvo) {
		int n = dao.marketAdd(boardvo);
		
		return n;
	}
	
	// 장터 게시판 글쓰기 맨~ 첨부파일 같이~~~~~~
	@Override
	public int marketAddFile(MarketBoardVO boardvo) {
		int n = dao.marketAddFile(boardvo);
		
		return n;
	}
	
	// 글쓴 사람 포인트 올려보자
	@Override
	public int marketPointPlus(Map<String, String> paraMap) {
		int n = dao.marketPointPlus(paraMap);
		return n;
		
	}
	
	// 레벨확인해서 레벨업 해주기~
	@Override
	public String getLevelNo(Map<String, String> paraMap, CommuMemberVO loginuser) {
		String levelNo = dao.getLevelNo(paraMap);
		
		
		return levelNo;
	}

	@Override
	public int levelUp(Map<String, String> paraMap) {
		
		int n = dao.levelUp(paraMap);
		return n;
	}

	@Override
	public CommuMemberLevelVO getLoginUserLevel(CommuMemberVO loginuser) {
		
		CommuMemberLevelVO levelvo = dao.getLoginUserLevel(loginuser);
		
		return levelvo;
	}

	
	// 조회수를 1 올려주면 한개의 글의 디테일을 가지고 오는 것!
	
	@Override
	public MarketBoardVO getMarketView(Map<String, String> paraMap, CommuMemberVO loginuser) {
		
		MarketBoardVO boardvo = dao.getMarketView(paraMap);
		
		if(loginuser != null && boardvo != null && !(loginuser.getCommuMemberNo() == boardvo.getFk_commuMemberNo()) ) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 해야 한다. 
			
			dao.setReadCount(paraMap);   // 글조회수 1증가 하기 
			
			boardvo = dao.getMarketView(paraMap);
		}
		
		return boardvo;
	}
	
	// 조회수를 올리지 않고! 글의 디테일을 가지고 오는 것!
	@Override
	public MarketBoardVO getMarketViewWithNoAddCount(Map<String, String> paraMap) {
		
		MarketBoardVO boardvo = dao.getMarketView(paraMap);
		
		return boardvo;
	}

	// 글 수정 레스기릿 파일 없다
	@Override
	public int marketEdit(MarketBoardVO boardvo) {
		int n = dao.marketEdit(boardvo);
		return n;
	}
	// 글 수정 레스기릿 파일 첨부 있다
	@Override
	public int marketEditFile(MarketBoardVO boardvo) {
		int n = dao.marketEditFile(boardvo);
		return n;
	}

	// 글 삭제 레스기릿 ~~~~~~~~~~
	@Override
	public int marketBoardDelete(Map<String, String> paraMap) {
		
		int n = dao.marketBoardDelete(paraMap);
		
		return n;
	}
	
	
	// 좋아요 싫어요 숫자 받아오기~~~
	@Override
	public int getMarketBoardGoodCount(Map<String, String> paraMap) throws Exception {
		int upCount = dao.getMarketBoardGoodCount(paraMap);
		return upCount;
	}
	
	@Override
	public int getMarketBoardBadCount(Map<String, String> paraMap) throws Exception {
		int downCount = dao.getMarketBoardBadCount(paraMap);
		return downCount;
	}
	
	
	// 게시글 추천이염~~~~
	@Override
	public int addMaketBoardUp(Map<String, String> paraMap) throws Exception {
		int result = dao.addMaketBoardUp(paraMap);
		return result;

	}

	// 게시글 비추천이여~~
	@Override
	public int addMarketBoardDown(Map<String, String> paraMap) throws Exception {
		int result = dao.addMarketBoardDown(paraMap);
		return result;
	}

	// 신고다 신고!
	@Override
	public int addMarketBoardReport(Map<String, String> paraMap) throws Exception {
		int result = dao.addMarketBoardReport(paraMap);
		
		
		result *= dao.getReportCount(paraMap);
		return result;

	}

	
	// 관리자 글 쓰기용 게시판 리스트 불러오기
	@Override
	public List<Map<String, String>> getAllBoardList() {
		List<Map<String, String>> boardList = dao.getAllBoardList();
		
		return boardList;
	}

	// 관리자 공지쓰기맨~~
	@Override
	public int allBoardAdminAdd(NoticeVO noticevo) {
		int n = dao.allBoardAdminAdd(noticevo);
		
		return n;
	}

	// 공지리스트 컴컴
	@Override
	public List<NoticeVO> getNoticeList(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.getNoticeList(paraMap);
		return noticeList;
	}
	
	// 조회수를 1 올려주면 한개의 공지글의 디테일을 가지고 오는 것!
	@Override
	public NoticeVO getNoticeView(Map<String, String> paraMap, CommuMemberVO loginuser) {
		NoticeVO noticevo = dao.getNoticeView(paraMap);
		
		if(loginuser != null && noticevo != null && !(loginuser.getCommuMemberNo() == noticevo.getFk_memberNo()) ) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 해야 한다. 
			
			dao.setNoticeReadCount(paraMap);   // 글조회수 1증가 하기 
			
			noticevo = dao.getNoticeView(paraMap);
		}
		return noticevo;
	}
	
	// 조회수 증가 없이 한개의 공지글의 디테일을 가지고 오는 것!
	@Override
	public NoticeVO getNoticeViewWithNoAddCount(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getNoticeView(paraMap);
		return noticevo;
	}

	
	// 공지글 수정
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = dao.noticeEdit(noticevo);
		return n;
	}
	// 공지글 삭제
	@Override
	public int noticeDelete(Map<String, String> paraMap) {
		int n = dao.noticeDelete(paraMap);
		return n;
	}

	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 @Override
	   public List<MarketBoardVO> recentIndexBoardList() {
	      
	      List<MarketBoardVO> recentBoardList = dao.recentIndexBoardList();
	      return recentBoardList;
	      
	   }

	   @Override
	   public List<MarketBoardVO> bestIndexBoardList() {
	      List<MarketBoardVO> bestBoardList = dao.bestIndexBoardList();
	      return bestBoardList;
	   }

	   @Override
	   public List<MarketBoardVO> popularIndexBoardList() {
	      List<MarketBoardVO> popularBoardList = dao.popularIndexBoardList();
	      return popularBoardList;
	   }


	@Override
	public List<MarketBoardVO> getSearchBoardList(Map<String, String> paraMap) {
		List<MarketBoardVO> searchBoardList = dao.getSearchBoardList(paraMap);
		return searchBoardList;
	}


	@Override
	public int getAnTotalHitCount(Map<String, String> paraMap) {
		
		int totalHitCount = dao.getAnTotalHitCount(paraMap);
		return totalHitCount;
	}


	   @Override
	   public List<MinsungBoardVO> recentBoardList() {
	      
	      List<MinsungBoardVO> recentBoardList = dao.recentBoardList();
	      return recentBoardList;
	      
	   }

	   @Override
	   public List<MinsungBoardVO> bestBoardList() {
	      List<MinsungBoardVO> bestBoardList = dao.bestBoardList();
	      return bestBoardList;
	   }

	   @Override
	   public List<MinsungBoardVO> popularBoardList() {
	      List<MinsungBoardVO> popularBoardList = dao.popularBoardList();
	      return popularBoardList;
	   }


	@Override
	public List<CommentVO> getNoticeCommentList(Map<String, String> paraMap) {
		// 요청한 순서의 댓글을 8개씩 가져오기
	
		List<CommentVO> commentList = dao.getNoticeCommentList(paraMap);
		return commentList;
		
	}


	@Override
	public int addNoticeComment(CommentVO commentvo) {
		int result = dao.addNoticeComment(commentvo);
		return result;
	}


	@Override
	public int addNoticePoint(Map<String, String> paraMap) {
		return dao.addNoticePoint(paraMap);
	}


	@Override
	public int deleteNoticeComment(Map<String, String> paraMap) {
		int result = dao.deleteNoticeComment(paraMap);
		return result;
	}


	@Override
	public int updateNoticeComment(Map<String, String> paraMap) {
		int result = dao.updateNoticeComment(paraMap);
		return result;
	}


	@Override
	public List<MarketBoardVO> getMyBoardList(Map<String, String> paraMap) {
		List<MarketBoardVO> myBoardList = dao.getMyBoardList(paraMap);
		return myBoardList;
	}

	// 야 총 페이지구함
	@Override
	public int getTotalCountForMyPage(CommuMemberVO loginuser) {
		int myPageTotalPage = dao.getTotalCountForMyPage(loginuser);
		return myPageTotalPage;
	}


	@Override
	public List<NoticeVO> getAllNoticeList() {
		List<NoticeVO> allNoticeList = dao.getAllNoticeList();
		return allNoticeList;
	}


	@Override
	public List<NoticeVO> getAllNoticeListWithParam(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.getAllNoticeListWithParam(paraMap);
		return noticeList;
	}

	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public NoticeVO getNoticeView(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getNoticeView(paraMap);	
		dao.setNoticeReadCount(paraMap);   // 글조회수 1증가 하기 
			
		noticevo = dao.getNoticeView(paraMap);
		
		return noticevo;
	}


	@Override
	public CommuMemberVO getLoginuserFromHs(String fk_memberNo) {
		CommuMemberVO loginuser = dao.getLoginUser(fk_memberNo);
		
		if (loginuser != null) {
			CommuMemberLevelVO levelvo = dao.getLoginUserLevel(loginuser);
			loginuser.setLevelvo(levelvo);
		}
		
		return loginuser;
	}
	


	

}
