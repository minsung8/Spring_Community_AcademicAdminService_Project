package com.project.skyuniversity.ohyoon.service;

import java.util.List;
import java.util.Map;

import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.model.BoardVO;
import com.project.skyuniversity.ohyoon.model.CategoryVO;
import com.project.skyuniversity.ohyoon.model.CommentVO;

public interface InterOhyoonService {

	// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 게시판 이름 불러오기
	String getBoardName(int boardKindNo);
	
	// 게시판 번호를 입력하여 해당 게시판 번호에 해당하는 게시물들을 불러오는 메소드
	List<BoardVO> getBoardList(Map<String, String> paraMap);

	// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 카테고리들을 불러오기
	List<CategoryVO> getCategoryList(int boardKindNo);

	// 총 게시물 건수 알아오기
	int getTotalCount(Map<String, String> paraMap);

	// 파일첨부가 없는 글쓰기
	int addBoard(BoardVO boardvo);

	// 파일첨부가 있는 글쓰기
	int addBoardWithFile(BoardVO boardvo);

	// 회원 번호와 포인트를 받아와 회원 포인트를 올려주기
	void pointPlus(Map<String, String> paraMap);

	// 게시물 1개를 보여주는 페이지 요청
	BoardVO getView(Map<String, String> paraMap);

	// 게시글의 추천, 비추천 수를 가져온다.
	int getBoardGoodCount(Map<String, String> paraMap);
	int getBoardBadCount(Map<String, String> paraMap);

	// 게시물 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addBoardUp(Map<String, String> paraMap) throws Exception;

	// 게시물 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addBoardDown(Map<String, String> paraMap) throws Exception;

	// 게시물 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addBoardReport(Map<String, String> paraMap) throws Exception;

	// 조회수 증가 없이 게시물 1개를 보여주는 페이지 요청
	BoardVO getViewNoAddCount(Map<String, String> paraMap);

	// 게시물을 삭세해주기
	int deleteBoard(Map<String, String> paraMap);

	// 게시물의 첨부파일 저장명, 원본명, 파일사이즈를 삭제해주기
	int deleteAttach(Map<String, String> paraMap);

	// 파일첨부가 없는 글수정
	int updateBoard(BoardVO boardvo);

	// 파일첨부가 있는 글수정
	int updateBoardWithFile(BoardVO boardvo);

	// 공지리스트 불러오기
	List<NoticeVO> getNoticeList(Map<String, String> paraMap);

	// 작성한 댓글 저장하기
	int addComment(CommentVO commentvo);

	// 요청한 순서의 댓글을 8개씩 가져오기
	List<CommentVO> getCommentList(Map<String, String> paraMap);

	// 댓글의 추천, 비추천 수를 가져온다.
	int getCommentGoodCount(Map<String, String> paraMap);
	int getCommentBadCount(Map<String, String> paraMap);
	
	// 댓글 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addCommentUp(Map<String, String> paraMap);
	
	// 댓글 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addCommentDown(Map<String, String> paraMap);
	
	// 댓글 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	int addCommentReport(Map<String, String> paraMap);

	// 댓글을 삭제해주는 메서드(ajax로 처리)
	int deleteComment(Map<String, String> paraMap);

	// 댓글을 수정해주기 (ajax로 처리)
	int updateComment(Map<String, String> paraMap);

	// 댓글쓰기 완료 후, 포인트 올려주기 
	int addPoint(Map<String, String> paraMap);

	// 우측 게시판 신규글, 인기글 사이드바
    List<MinsungBoardVO> recentBoardList();
    List<MinsungBoardVO> bestBoardList();
    List<MinsungBoardVO> popularBoardList();

    // 랜덤 닉네임 받아오기
	String getRandomNickname();

	// 익명 게시판 댓글 비밀번호 검사하기
	int comparePassword(Map<String, String> paraMap);

    
    
}
