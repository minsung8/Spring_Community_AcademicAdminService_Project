package com.project.skyuniversity.ohyoon.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.ohyoon.common.*;
import com.project.skyuniversity.ohyoon.model.*;

@Service
public class OhyoonService implements InterOhyoonService{
	/*
	 * 주문 ==> 주문테이블 insert (DAO 에 있는 주문테이블에 insert 관련 method 호출) ==> 제품테이블에 주문받은 제품의
	 * 개수는 주문량 만큼 감소해야 한다 (DAO 에 있는 제품테이블에 update 관련 method 호출) ==> 장바구니에서 주문을 한
	 * 경우이라면 장바구니 비우기를 해야 한다 (DAO 에 있는 장바구니테이블에 delete 관련 method 호출) ==> 회원테이블에
	 * 포인트(마일리지)를 증가시켜주어야 한다 (DAO 에 있는 회원테이블에 update 관련 method 호출)
	 * 
	 * 위에서 호출된 4가지의 메소드가 모두 성공되었다면 commit 해주고 1개라도 실패하면 rollback 해준다. 이러한 트랜잭션처리를
	 * 해주는 곳이 Service 단이다.
	 */

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterOhyoonDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.

	@Autowired
	private OhFileManager fileManager;
	
	
	// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 게시판 이름 불러오기
	@Override
	public String getBoardName(int boardKindNo) {
		String boardname = dao.getBoardName(boardKindNo); 
		return boardname;
	}
	
	
	// 게시판 번호를 입력하여 해당 게시판번호에 해당하는 카테고리들을 불러오기
	@Override
	public List<CategoryVO> getCategoryList(int boardKindNo) {
		List<CategoryVO> cateList = dao.getCategoryList(boardKindNo);
		return cateList;
	}
	
	
	// 게시판 번호를 입력하여 해당 게시판 번호에 해당하는 게시물들을 불러오기
	@Override
	public List<BoardVO> getBoardList(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.getBoardList(paraMap); 
		return boardList;
	}

	
	// 총 게시물 건수 알아오기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}
	
	
	// 파일첨부가 없는 글쓰기
	@Override
	public int addBoard(BoardVO boardvo) {
		if (boardvo.getPassword() != null) { // 비밀번호가 null이 아니라면 (익명게시판일 때)
			boardvo.setPassword(Sha256.encrypt(boardvo.getPassword())); // 비밀번호를 암호화 한다.
		}
		return dao.addBoard(boardvo);
	}
	
	
	// 파일첨부가 있는 글쓰기
	@Override
	public int addBoardWithFile(BoardVO boardvo) {
		return dao.addBoardWithFile(boardvo);
	}
	
	
	// 회원 번호와 포인트를 받아와 회원 포인트를 올려주기
	@Override
	public void pointPlus(Map<String, String> paraMap) {
		dao.pointPlus(paraMap);
	}
	
	
	// 게시물 1개를 보여주는 페이지 요청
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap);
		
		// 익명게시판이 아니라면
		if (!paraMap.get("boardKindNo").equals("7")) {
			// 로그인한 유저의 회원번호와 게시물의 작성자 회원번호가 다르다면 
			if ( !boardvo.getFk_memberNo().equals(paraMap.get("loginNo")) ) { 
				// 해당 게시물의 조회수를 1증가시킨다.
				dao.addReadCount(paraMap);
				boardvo = dao.getView(paraMap);
			}
		}else { // 익명 게시판이라면
			/*
			// 현재 조회하는 회원의 ip와 게시물의 작성자 ip가 다르다면 
			if ( !boardvo.getWriterIp().equals(paraMap.get("currentIp")) ) {
				// 해당 게시물의 조회수를 1증가시킨다.
				dao.addReadCount(paraMap);
				boardvo = dao.getView(paraMap);
			}
			*/
			dao.addReadCount(paraMap);      // 조회수를 1증가시키고
			boardvo = dao.getView(paraMap); // 게시물을 다시 불러온다.
		}
		return boardvo;
	}
	

	// 조회수 증가 없이 게시물 1개를 보여주는 페이지 요청
	@Override
	public BoardVO getViewNoAddCount(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap);
		return boardvo;
	}	
	
	
	// 게시글의 추천 수를 가져온다.
	@Override
	public int getBoardGoodCount(Map<String, String> paraMap) {
		int upCount = dao.getBoardGoodCount(paraMap);
		return upCount;
	}
	
	
	// 게시글의 비추천 수를 가져온다.
	@Override
	public int getBoardBadCount(Map<String, String> paraMap) {
		int downCount = dao.getBoardBadCount(paraMap);
		return downCount;
	}
	
	
	// 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addBoardUp(Map<String, String> paraMap) throws Exception{
		int result = dao.addBoardUp(paraMap);
		return result;
	}
	
	
	// 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addBoardDown(Map<String, String> paraMap) throws Exception{
		int result = dao.addBoardDown(paraMap);
		return result;
	}
	

	// 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addBoardReport(Map<String, String> paraMap) throws Exception {
		int result = dao.addBoardReport(paraMap);
		return result;
	}
	

	// 게시물을 삭세해주기
	@Override
	public int deleteBoard(Map<String, String> paraMap) {
		int result = 0;
		if (paraMap.get("boardKindNo").equals("7")) { // 익명게시판 글이라면 
			String password = Sha256.encrypt(paraMap.get("password")); // 비밀번호를 받아 암호화한다.
			BoardVO boardvo = dao.getView(paraMap); // 게시물을 조회해와서 
			String boardPassword = boardvo.getPassword(); // 게시물 비밀번호를 가져온다.
			if (password.equals(boardPassword)) { // 입력한 비밀번호와 게시물 비밀번호가 일치하면
				result = dao.deleteBoard(paraMap); // 게시글을 삭제한다.
			}
		}else { // 익명게시판 글이 아니라면
			// 게시물을 삭제한다.
			result = dao.deleteBoard(paraMap);
			
			// 게시물 삭제가 되었다면 첨부파일을 삭제해준다.
			if (result == 1) {
				String fileName = paraMap.get("fileName");
				String path = paraMap.get("path");
				
				if (fileName != null && !fileName.equals("")) { // fileName이 비어있지 않다면
					try {
						fileManager.doFileDelete(fileName, path);
					} catch (Exception e) {}
				}
			}
		}
		return result;
	}


	// 게시물의 첨부파일 저장명, 원본명, 파일사이즈를 삭제해주기
	@Override
	public int deleteAttach(Map<String, String> paraMap) {
		int result = dao.deleteAttach(paraMap);
		return result;
	}
	
	
	// 파일첨부가 없는 글수정
	@Override
	public int updateBoard(BoardVO boardvo) {
		int result = dao.updateBoard(boardvo);
		return result;
	}
	
	
	// 파일첨부가 있는 글수정
	@Override
	public int updateBoardWithFile(BoardVO boardvo) {
		int result = dao.updateBoardWithFile(boardvo);
		return result;
	}
	
	
	// 공지리스트 불러오기
    @Override
    public List<NoticeVO> getNoticeList(Map<String, String> paraMap) {
       List<NoticeVO> noticeList = dao.getNoticeList(paraMap);
       return noticeList;
    }
	
	
    // 작성한 댓글 저장하기
	@Override
	public int addComment(CommentVO commentvo) {
		if (commentvo.getPassword() != null) { // 만일 비밀번호 값이 있다면(익명 게시판 댓글일 때) 암호화해서 저장한다.
			commentvo.setPassword(Sha256.encrypt(commentvo.getPassword()));
		}
		int result = dao.addComment(commentvo);
		return result;
	}
	
	
	// 요청한 순서의 댓글을 8개씩 가져오기
	@Override
	public List<CommentVO> getCommentList(Map<String, String> paraMap) {
		List<CommentVO> commentList = dao.getCommentList(paraMap);
		return commentList;
	}

	
	// 댓글의 추천 수를 가져온다.
	@Override
	public int getCommentGoodCount(Map<String, String> paraMap) {
		int cmtUpCount = dao.getCommentGoodCount(paraMap);
		return cmtUpCount;
	}
	
	
	// 댓글의 비추천 수를 가져온다.
	@Override
	public int getCommentBadCount(Map<String, String> paraMap) {
		int cmtDownCount = dao.getCommentBadCount(paraMap);
		return cmtDownCount;
	}
	
	
	// 댓글 추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addCommentUp(Map<String, String> paraMap) {
		int result = dao.addCommentUp(paraMap);
		return result;
	}
	
	
	// 댓글 비추천 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addCommentDown(Map<String, String> paraMap) {
		int result = dao.addCommentDown(paraMap);
		return result;
	}
	
	
	// 댓글 신고 테이블에 행을 추가해주는 메서드(ajax로 처리)
	@Override
	public int addCommentReport(Map<String, String> paraMap) {
		int result = dao.addCommentReport(paraMap);
		return result;
	}
	
	
	// 익명 게시판 댓글 비밀번호 검사하기
	@Override
	public int comparePassword(Map<String, String> paraMap) {
		int result = 0;
		String CommentPassword = dao.getCommentOne(paraMap); // 익명 게시판 댓글 가져오기
		String password = Sha256.encrypt(paraMap.get("password"));
		if (password.equals(CommentPassword)) {
			result = 1;
		}
		return result;
	}
	
	
	// 댓글을 삭제해주는 메서드(ajax로 처리)
	@Override
	public int deleteComment(Map<String, String> paraMap) {
		int result = dao.deleteComment(paraMap);
		return result;
	}
	
	
	// 댓글을 수정해주는 메서드 (ajax로 처리)
	@Override
	public int updateComment(Map<String, String> paraMap) {
		int result = dao.updateComment(paraMap);
		return result;
	}
	
	
	// 댓글쓰기 완료 후, 포인트 올려주기 
	@Override
	public int addPoint(Map<String, String> paraMap) {
		return dao.addPoint(paraMap);
	}
	
	
	// 우측 게시판 신규글, 인기글 사이드바
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
	
    
    // 랜덤 닉네임 받아오기
    @Override
    public String getRandomNickname() {
    	// 1~20 까지의 랜덤한 숫자 두개를 뽑아
    	int firstNo = (int)(Math.random() * 20) + 1;
		int secondNo = (int)(Math.random() * 20) + 1;
		
		// paraMap으로 보내어 닉네임을 만든다
		Map<String, Integer> paraMap = new HashMap<>();
		paraMap.put("firstNo", firstNo);
		paraMap.put("secondNo", secondNo);
		String nickname = dao.getRandomNickname(paraMap);
    	return nickname;
    }
    
    
	
	
}
