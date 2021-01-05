package com.project.skyuniversity.ash.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.model.CommentVO;

//=== #32. DAO 선언 ===
@Repository
public class AnsehyeongDAO implements InterAnsehyeongDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 로컬DB에 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된
	// org.mybatis.spring.SqlSessionTemplate 의 bean 을 sqlsession 에 주입시켜준다.
	// 그러므로 sqlsession 는 null 이 아니다.

	// 메인페이지 배너 광고 띄워주기
	@Override
	public List<BannerVO> getBannerList() {
		List<BannerVO> bannerList = sqlsession.selectList("ansehyeong.getBannerList");
		return bannerList;
	}

	// 인덱스 화면에 보여질 게시글들의 정보를 가져온다.
	@Override
	public List<MarketBoardVO> getIndexBoardList() {
		List<MarketBoardVO> indexBoardList = sqlsession.selectList("ansehyeong.getIndexBoardList");
		return indexBoardList;
	}

	// 로그인 하는 유저 한명 알아오기
	@Override
	public CommuMemberVO getLoginUser(Map<String, String> paraMap) {
		CommuMemberVO loginuser = sqlsession.selectOne("ansehyeong.getLoginUser", paraMap);
		return loginuser;
	}

	// 로그인 하는 회원의 등급정보를 알아오기
	@Override
	public CommuMemberLevelVO getLoginUserLevel(CommuMemberVO loginuser) {
		CommuMemberLevelVO levelvo = sqlsession.selectOne("ansehyeong.getLoginUserLevel", loginuser);
		return levelvo;
	}

	// === 닉네임 업데이트 요청 끝 !=== //
	@Override
	public int updateNicknameEnd(Map<String, String> paraMap) {
		int result = sqlsession.update("ansehyeong.updateNicknameEnd", paraMap);
		return result;
	}

	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getMarketCategoryList(Map<String, String> paraMap) {

		List<Map<String, String>> categoryList = sqlsession.selectList("ansehyeong.getMarketCategoryList", paraMap);

		return categoryList;
	}

	// === 장터 게시판 리스트 페이지 요청시 카테고리 목록 가져오기 관리자버전=== //
	@Override
	public List<Map<String, String>> getAdminMarketCategoryList() {

		List<Map<String, String>> categoryList = sqlsession.selectList("ansehyeong.getAdminMarketCategoryList");

		return categoryList;
	}

	// === 장터 게시판 리스트 페이지 요청시 테이블 정보 가져오기 === //
	@Override
	public Map<String, String> getMarketTableInfo(Map<String, String> paraMap) {

		Map<String, String> tableInfo = sqlsession.selectOne("ansehyeong.getMarketTableInfo", paraMap);
		return tableInfo;
	}

	// === 총 게시물 건수 알아오기 === //
	@Override
	public int getMarketTotalCount(Map<String, String> paraMap) {

		int totalCount = 0;

		switch (paraMap.get("boardKindNo")) {

		case "23":
			totalCount = sqlsession.selectOne("ansehyeong.getHouseTotalCount", paraMap);
			break;
		case "24":
			totalCount = sqlsession.selectOne("ansehyeong.getBookTotalCount", paraMap);
			break;
		case "25":
			totalCount = sqlsession.selectOne("ansehyeong.getEtcTotalCount", paraMap);
			break;
		}

		return totalCount;
	}

	// === 게시판 번호와 시작 게시글 번호, 끝 게시글 번호를 입력하여 해당 게시판번호에 해당하는 게시글들을 불러오기 === //
	@Override
	public List<MarketBoardVO> getMarketBoardList(Map<String, String> paraMap) {

		List<MarketBoardVO> boardList = null;

		switch (paraMap.get("boardKindNo")) {
		case "23":
			boardList = sqlsession.selectList("ansehyeong.getHouseBoardList", paraMap);
			break;
		case "24":
			boardList = sqlsession.selectList("ansehyeong.getBookBoardList", paraMap);
			break;
		case "25":
			boardList = sqlsession.selectList("ansehyeong.getEtcBoardList", paraMap);
			break;
		}

		return boardList;
	}

	@Override
	public int checkBoardKindNo(String boardKindNo) {

		int n = sqlsession.selectOne("ansehyeong.checkBoardKindNo", boardKindNo);
		return n;
	}

	// 장터 게시판 글쓰기 맨~
	@Override
	public int marketAdd(MarketBoardVO boardvo) {
		int n = 0;
		switch (boardvo.getFk_boardKindNo()) {
		case 23:
			n = sqlsession.insert("ansehyeong.marketHouseAdd", boardvo);
			break;
		case 24:
			n = sqlsession.insert("ansehyeong.marketBookAdd", boardvo);
			break;
		case 25:
			n = sqlsession.insert("ansehyeong.markeEtcAdd", boardvo);
			break;
		}
		return n;
	}

	// 장터 게시판 글쓰기 맨~ 첨부파일 같이~~~~~~
	@Override
	public int marketAddFile(MarketBoardVO boardvo) {
		int n = 0;
		switch (boardvo.getFk_boardKindNo()) {
		case 23:
			n = sqlsession.insert("ansehyeong.marketHouseaAddFile", boardvo);
			break;
		case 24:
			n = sqlsession.insert("ansehyeong.marketBookAddFile", boardvo);
			break;
		case 25:
			n = sqlsession.insert("ansehyeong.markeEtcAddFile", boardvo);
			break;
		}
		return n;
	}

	// 글쓴 사람 포인트 올려보자
	@Override
	public int marketPointPlus(Map<String, String> paraMap) {
		int n = sqlsession.update("ansehyeong.marketPointPlus", paraMap);
		return n;
	}

	// 레벨확인해서 레벨업 해주기~
	@Override
	public String getLevelNo(Map<String, String> paraMap) {
		String levelNo = sqlsession.selectOne("ansehyeong.getLevelNo", paraMap);
		return levelNo;
	}

	// 레벨확인해서 레벨업 해주기~
	@Override
	public int levelUp(Map<String, String> paraMap) {
		int n = sqlsession.update("ansehyeong.levelUp", paraMap);
		return n;
	}

	// 조회수를 1 올려주면 한개의 글의 디테일을 가지고 오는 것!
	@Override
	public MarketBoardVO getMarketView(Map<String, String> paraMap) {

		MarketBoardVO boardvo = null;

		switch (paraMap.get("boardKindNo")) {
		case "23":
			boardvo = sqlsession.selectOne("ansehyeong.getHouseMarketView", paraMap);
			break;
		case "24":
			boardvo = sqlsession.selectOne("ansehyeong.getBookMarketView", paraMap);
			break;
		case "25":
			boardvo = sqlsession.selectOne("ansehyeong.getEtcMarketView", paraMap);
			break;
		}

		return boardvo;
	}

	// 조회수 1개 올려주기
	@Override
	public void setReadCount(Map<String, String> paraMap) {

		switch (paraMap.get("boardKindNo")) {
		case "23":
			sqlsession.update("ansehyeong.setHouseReadCount", paraMap);
			break;
		case "24":
			sqlsession.update("ansehyeong.setBookReadCount", paraMap);
			break;
		case "25":
			sqlsession.update("ansehyeong.setEtcReadCount", paraMap);
			break;
		}
	}

	// 글 수정 레스기릿 파일 없다
	@Override
	public int marketEdit(MarketBoardVO boardvo) {
		int n = 0;
		switch (boardvo.getFk_boardKindNo()) {
		case 23:
			n = sqlsession.update("ansehyeong.marketHouseaEdit", boardvo);
			break;
		case 24:
			n = sqlsession.update("ansehyeong.marketBookEdit", boardvo);
			break;
		case 25:
			n = sqlsession.update("ansehyeong.markeEtcEdit", boardvo);
			break;
		}
		return n;
	}

	// 글 수정 레스기릿 파일 첨부 있다
	@Override
	public int marketEditFile(MarketBoardVO boardvo) {
		int n = 0;
		switch (boardvo.getFk_boardKindNo()) {
		case 23:
			n = sqlsession.update("ansehyeong.marketHouseaEditFile", boardvo);
			break;
		case 24:
			n = sqlsession.update("ansehyeong.marketBookEditFile", boardvo);
			break;
		case 25:
			n = sqlsession.update("ansehyeong.markeEtcEditFile", boardvo);
			break;
		}
		return n;
	}

	// 글 삭제 레스기릿 ~~~~~~~~~~
	@Override
	public int marketBoardDelete(Map<String, String> paraMap) {
		int n = 0;

		switch (paraMap.get("boardKindNo")) {
		case "23":
			n = sqlsession.update("ansehyeong.marketHouseBoardDelete", paraMap);
			break;
		case "24":
			n = sqlsession.update("ansehyeong.marketBookBoardDelete", paraMap);
			break;
		case "25":
			n = sqlsession.update("ansehyeong.marketEtcBoardDelete", paraMap);
			break;
		}

		return n;
	}

	// 좋아요 싫어요 숫자 받아오기~~~
	@Override
	public int getMarketBoardGoodCount(Map<String, String> paraMap) {
		int upCount = sqlsession.selectOne("ansehyeong.getMarketBoardGoodCount", paraMap);
		return upCount;
	}

	@Override
	public int getMarketBoardBadCount(Map<String, String> paraMap) {
		int downCount = sqlsession.selectOne("ansehyeong.getMarketBoardBadCount", paraMap);
		return downCount;
	}

	// 게시글 추천이여~~~~~~
	@Override
	public int addMaketBoardUp(Map<String, String> paraMap) throws Exception {

		// 비추천 테이블에서 paraMap으로 넘어온 값을 가진 행을 삭제한다.
		sqlsession.delete("ansehyeong.getMaketBoardBad", paraMap);

		// 추천 테이블에 행을 추가한다.
		int result = sqlsession.insert("ansehyeong.addMaketBoardUp", paraMap);
		return result;

	}

	// 게시글 비추천이여~~
	@Override
	public int addMarketBoardDown(Map<String, String> paraMap) throws Exception {
		// 비추천 테이블에서 paraMap으로 넘어온 값을 가진 행을 삭제한다.
		sqlsession.delete("ansehyeong.getMaketBoardGood", paraMap);

		// 추천 테이블에 행을 추가한다.
		int result = sqlsession.insert("ansehyeong.addMaketBoardDown", paraMap);
		return result;

	}

	// 신고다 신고!!
	@Override
	public int addMarketBoardReport(Map<String, String> paraMap) throws Exception {
		int result = sqlsession.insert("ansehyeong.addMarketBoardReport", paraMap);
		return result;

	}

	// 신고수 알아오기~!!~!~!!!
	@Override
	public int getReportCount(Map<String, String> paraMap) {

		int result = sqlsession.selectOne("ansehyeong.getMarketReportCount", paraMap);
		return result;
	}

	// 관리자 글 쓰기용 게시판 리스트 불러오기
	@Override
	public List<Map<String, String>> getAllBoardList() {
		List<Map<String, String>> boardList = sqlsession.selectList("ansehyeong.getAllBoardList");

		return boardList;
	}

	@Override
	public int allBoardAdminAdd(NoticeVO noticevo) {
		int n = sqlsession.insert("ansehyeong.allBoardAdminAdd", noticevo);

		return n;
	}

	// 공지리스트 컴컴
	@Override
	public List<NoticeVO> getNoticeList(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = sqlsession.selectList("ansehyeong.getNoticeList", paraMap);
		return noticeList;
	}

	// 한개의 글의 디테일을 가지고 오는 것!
	@Override
	public NoticeVO getNoticeView(Map<String, String> paraMap) {
		NoticeVO noticevo = sqlsession.selectOne("ansehyeong.getNoticeList", paraMap);

		return noticevo;
	}

	// 조회수 1개 올려주기
	@Override
	public void setNoticeReadCount(Map<String, String> paraMap) {
		sqlsession.update("ansehyeong.setNoticeReadCount", paraMap);
	}

	// 공지글 수정
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = sqlsession.update("ansehyeong.noticeEdit", noticevo);
		return n;
	}

	// 공지글 삭제
	@Override
	public int noticeDelete(Map<String, String> paraMap) {
		int n = sqlsession.update("ansehyeong.noticeDelete", paraMap);
		return n;
	}

	@Override
	public List<MarketBoardVO> recentIndexBoardList() {
		List<MarketBoardVO> recentBoardList = sqlsession.selectList("ansehyeong.indexRecentBoardList");
		return recentBoardList;
	}

	@Override
	public List<MarketBoardVO> bestIndexBoardList() {

		List<MarketBoardVO> bestBoardList = sqlsession.selectList("ansehyeong.indexBestBoardList");
		return bestBoardList;
	}

	@Override
	public List<MarketBoardVO> popularIndexBoardList() {
		List<MarketBoardVO> popularBoardList = sqlsession.selectList("ansehyeong.indexPopularBoardList");
		return popularBoardList;
	}

	@Override
	public List<MarketBoardVO> getSearchBoardList(Map<String, String> paraMap) {
		List<MarketBoardVO> searchBoardList = sqlsession.selectList("ansehyeong.getSearchBoardList", paraMap);
		return searchBoardList;
	}

	@Override
	public int getAnTotalHitCount(Map<String, String> paraMap) {
		int totalHitCount = sqlsession.selectOne("ansehyeong.getAnTotalHitCount", paraMap);
		return totalHitCount;
	}

	@Override
	public List<MinsungBoardVO> recentBoardList() {
		List<MinsungBoardVO> recentBoardList = sqlsession.selectList("minsung.recentBoardList");
		return recentBoardList;
	}

	@Override
	public List<MinsungBoardVO> bestBoardList() {

		List<MinsungBoardVO> bestBoardList = sqlsession.selectList("minsung.bestBoardList");
		return bestBoardList;
	}

	@Override
	public List<MinsungBoardVO> popularBoardList() {
		List<MinsungBoardVO> popularBoardList = sqlsession.selectList("minsung.popularBoardList");
		return popularBoardList;
	}

	@Override
	public List<CommentVO> getNoticeCommentList(Map<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("ansehyeong.getNoticeCommentList", paraMap);
		return commentList;
	}

	
	
	@Override
	public int addNoticeComment(CommentVO commentvo) {
		int result = sqlsession.insert("ansehyeong.addNoticeComment", commentvo);
		return result;
	}

	@Override
	public int addNoticePoint(Map<String, String> paraMap) {
		return sqlsession.update("ohyoon.pointPlus", paraMap);
	}

	@Override
	public int deleteNoticeComment(Map<String, String> paraMap) {
		int result = sqlsession.update("ansehyeong.deleteNoticeComment", paraMap);
		
		return result;
	}

	@Override
	public int updateNoticeComment(Map<String, String> paraMap) {
		int result = sqlsession.update("ansehyeong.updateNoticeComment", paraMap);
		return result;
	}

	@Override
	public List<MarketBoardVO> getMyBoardList(Map<String, String> paraMap) {
		List<MarketBoardVO> myBoardList = sqlsession.selectList("ansehyeong.getMyBoardList", paraMap);
		return myBoardList;
	}

	@Override
	public int getTotalCountForMyPage(CommuMemberVO loginuser) {
		int myPageTotalPage = sqlsession.selectOne("ansehyeong.getTotalCountForMyPage", loginuser);
		return myPageTotalPage;
	}

	@Override
	public List<NoticeVO> getAllNoticeList() {
		List<NoticeVO> allNoticeList = sqlsession.selectList("ansehyeong.getAllNoticeList");
		return allNoticeList;
	}

	@Override
	public List<NoticeVO> getAllNoticeListWithParam(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = sqlsession.selectList("ansehyeong.getAllNoticeListWithParam", paraMap);
		return noticeList;
	}

	@Override
	public CommuMemberVO getLoginUser(String fk_memberNo) {
		CommuMemberVO loginuser	= sqlsession.selectOne("ansehyeong.getLoginuserFromHs", fk_memberNo);
		return loginuser;
	}

}
