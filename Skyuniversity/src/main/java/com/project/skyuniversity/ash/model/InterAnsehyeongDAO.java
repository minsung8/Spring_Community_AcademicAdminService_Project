package com.project.skyuniversity.ash.model;

import java.util.List;
import java.util.Map;

import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.model.CommentVO;

public interface InterAnsehyeongDAO {
	// 메인 화면에 뜨는 배너 광고를 올려준다.
	List<BannerVO> getBannerList();
	
	// 인덱스 화면에 보여질 게시글들의 정보를 가져온다.
	List<MarketBoardVO> getIndexBoardList();

	
	// 로그인 하는 경우 한명의 회원을 불러오기
	CommuMemberVO getLoginUser(Map<String, String> paraMap);

	// 로그인 하는 회원의 등급정보를 알아오기
	CommuMemberLevelVO getLoginUserLevel(CommuMemberVO loginuser);
	
	// 닉넴 업데이트 해주는거쥬~~~
	int updateNicknameEnd(Map<String, String> paraMap);
	
	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
	List<Map<String, String>> getMarketCategoryList(Map<String, String> paraMap);
	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 관리자버전=== //
	List<Map<String, String>> getAdminMarketCategoryList();

	// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
	Map<String, String> getMarketTableInfo(Map<String, String> paraMap);

	// === 총 게시물 건수 알아오기 === //
	int getMarketTotalCount(Map<String, String> paraMap);

	// === 게시판 번호와 시작 게시글 번호, 끝 게시글 번호를 입력하여 해당 게시판번호에 해당하는 게시글들을 불러오기 === //
	List<MarketBoardVO> getMarketBoardList(Map<String, String> paraMap);

	int checkBoardKindNo(String boardKindNo);

	// 장터 게시판 글쓰기 맨~
	int marketAdd(MarketBoardVO boardvo);
	
	// 장터 게시판 글쓰기 맨~ 첨부파일 같이~~~~~~
	int marketAddFile(MarketBoardVO boardvo);

	// 글쓴 사람 포인트 올려보자
	int marketPointPlus(Map<String, String> paraMap);
	
	// 현재 포인트의 레벨 정보가져오기
	String getLevelNo(Map<String, String> paraMap);

	// 레벨확인해서 레벨업 해주기~
	int levelUp(Map<String, String> paraMap);

	// 한개의 글의 디테일을 가지고 오는 것!
	MarketBoardVO getMarketView(Map<String, String> paraMap);

	// 조회수 1개 올려주기
	void setReadCount(Map<String, String> paraMap);

	
	// 글 수정 레스기릿 파일 없다
	int marketEdit(MarketBoardVO boardvo);
	
	// 글 수정 레스기릿 파일 첨부 있다
	int marketEditFile(MarketBoardVO boardvo);
	
	
	// 글 삭제 레스기릿 ~~~~~~~~~~
	int marketBoardDelete(Map<String, String> paraMap);

	// 좋아요 싫어요 숫자 받아오기~~~
	int getMarketBoardGoodCount(Map<String, String> paraMap) throws Exception;
	
	int getMarketBoardBadCount(Map<String, String> paraMap) throws Exception;
	
	
	// 게시글 추천이여~~~~~~
	int addMaketBoardUp(Map<String, String> paraMap) throws Exception;
	
	// 게시글 비추천이여~~
	int addMarketBoardDown(Map<String, String> paraMap) throws Exception;

	// 신고다 신고!
	int addMarketBoardReport(Map<String, String> paraMap) throws Exception;

	// 신고수 알아오기~!!~!~!!!
	int getReportCount(Map<String, String> paraMap);

	
	
	// 관리자 글 쓰기용 게시판 리스트 불러오기
	List<Map<String, String>> getAllBoardList();

	// 관리자 공지쓰기맨~~
	int allBoardAdminAdd(NoticeVO noticevo);
	
	// 공지리스트 컴컴
	List<NoticeVO> getNoticeList(Map<String, String> paraMap);

	
	// 한개의 글의 디테일을 가지고 오는 것!
	NoticeVO getNoticeView(Map<String, String> paraMap);
	
	// 조회수 1개 올려주기
	void setNoticeReadCount(Map<String, String> paraMap);
	
	// 공지글 수정
	int noticeEdit(NoticeVO noticevo);

	// 공지글 삭제
	int noticeDelete(Map<String, String> paraMap);

	
	
	
	
	
	List<MarketBoardVO> recentIndexBoardList();

	List<MarketBoardVO> bestIndexBoardList();

	List<MarketBoardVO> popularIndexBoardList();

	List<MarketBoardVO> getSearchBoardList(Map<String, String> paraMap);

	int getAnTotalHitCount(Map<String, String> paraMap);

	
	   List<MinsungBoardVO> recentBoardList();

	   List<MinsungBoardVO> bestBoardList();

	   List<MinsungBoardVO> popularBoardList();

	List<CommentVO> getNoticeCommentList(Map<String, String> paraMap);

	
	int addNoticeComment(CommentVO commentvo);

	int addNoticePoint(Map<String, String> paraMap);

	
	int deleteNoticeComment(Map<String, String> paraMap);

	int updateNoticeComment(Map<String, String> paraMap);
	
	

	List<MarketBoardVO> getMyBoardList(Map<String, String> paraMap);

	
	// 야 총 페이지구함
	int getTotalCountForMyPage(CommuMemberVO loginuser);

	List<NoticeVO> getAllNoticeList();

	List<NoticeVO> getAllNoticeListWithParam(Map<String, String> paraMap);

	CommuMemberVO getLoginUser(String fk_memberNo);



	
	

	

}
