
package com.project.skyuniversity.minsung.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.skyuniversity.ash.model.NoticeVO;


@Repository
public class MinsungBoardDAO implements InterMinsungBoardDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<MinsungBoardVO> boardListSelected() {
		
		List<MinsungBoardVO> boardList = sqlsession.selectList("minsung.boardListSelected");
		return boardList;
	}

	@Override
	public List<MinsungBoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<MinsungBoardVO> boardList = null;
		switch (paraMap.get("boardKindNo")) {
		case "1":
			boardList = sqlsession.selectList("minsung.getViewNoticeList", paraMap);
			break;
		case "2":
			boardList = sqlsession.selectList("minsung.getViewCouncilList", paraMap);
			break;
		case "3":
			boardList = sqlsession.selectList("minsung.getViewMajorList", paraMap);
			break;
		case "4":
			boardList = sqlsession.selectList("minsung.getViewClubList", paraMap);
			break;
		case "5":
			boardList = sqlsession.selectList("minsung.getViewGraduateList", paraMap);
			break;
		case "6":
			boardList = sqlsession.selectList("minsung.getViewCriticList", paraMap);
			break;
		case "18":
			boardList = sqlsession.selectList("minsung.getViewStudyList", paraMap);
			break;
		case "19":
			boardList = sqlsession.selectList("minsung.getViewCertList", paraMap);
			break;
		case "20":
			boardList = sqlsession.selectList("minsung.getViewEmpList", paraMap);
			break;
		case "21":
			boardList = sqlsession.selectList("minsung.getViewJobofferList", paraMap);
			break;
		case "22":
			boardList = sqlsession.selectList("minsung.getViewLostList", paraMap);
			break;
		}
		
		return boardList;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		
		int n = sqlsession.selectOne("minsung.getTotalCount", paraMap);
		 	
		return n;
	}

	@Override
	public List<MinsungCategoryVO> categoryList(String boardKindNo) {
		List<MinsungCategoryVO> categoryList = sqlsession.selectList("minsung.categoryList", boardKindNo);
		return categoryList;
	}

	@Override
	public String kindBoard(String boardKindNo) {
		String kindBoard = sqlsession.selectOne("minsung.kindBoard", boardKindNo);
		return kindBoard;
	}

	@Override
	public MinsungBoardVO getOneBoard(Map<String, String> paraMap) {
		
		MinsungBoardVO boardvo = null;
		
		String boardKindNo = paraMap.get("boardKindNo");
		String boardNo = paraMap.get("boardNo");
		
		switch (boardKindNo) {
		case "1":
			boardvo = sqlsession.selectOne("minsung.oneBoardNotice", boardNo);
		break;
		case "2":
			boardvo = sqlsession.selectOne("minsung.oneBoardCouncil", boardNo);
		break;
		case "3":
			boardvo = sqlsession.selectOne("minsung.oneBoardMajor", boardNo);
		break;
		case "4":
			boardvo = sqlsession.selectOne("minsung.oneBoardClub", boardNo);
		break;
		case "5":
			boardvo = sqlsession.selectOne("minsung.oneBoardGraduate", boardNo);
		break;
		case "6":
			boardvo = sqlsession.selectOne("minsung.oneBoardCritic", boardNo);
		break;
		case "18":
			boardvo = sqlsession.selectOne("minsung.oneBoardStudy", boardNo);
		break;
		case "19":
			boardvo = sqlsession.selectOne("minsung.oneBoardCert", boardNo);
		break;
		case "20":
			boardvo = sqlsession.selectOne("minsung.oneBoardEmp", boardNo);
		break;
		case "21":
			boardvo = sqlsession.selectOne("minsung.oneBoardJoboffer", boardNo);
		break;
		case "22":
			boardvo = sqlsession.selectOne("minsung.oneBoardLost", boardNo);
		break;
		}
				
		return boardvo;
	}

	@Override
	public int edit(MinsungBoardVO boardvo) {
		int n = sqlsession.update("minsung.edit", boardvo);
		return n;
	}

	@Override
	public int del(MinsungBoardVO boardvo) {
		int n = sqlsession.delete("minsung.del", boardvo);
		return n;
	}

	@Override
	public int add(MinsungBoardVO boardvo) {
		int result = 0;
						
		switch (boardvo.getFk_boardKindNo()) {
		case "1":
			sqlsession.insert("minsung.addNotice", boardvo);
			break;
		case "2":
			sqlsession.insert("minsung.addCouncil", boardvo);
			break;
		case "3":
			sqlsession.insert("minsung.addMajor", boardvo);
			break;
		case "4":
			sqlsession.insert("minsung.addClub", boardvo);
			break;
		case "5":
			sqlsession.insert("minsung.addGraduate", boardvo);
			break;
		case "6":
			sqlsession.insert("minsung.addCritic", boardvo);
			break;
		case "18":
			sqlsession.insert("minsung.addStudy", boardvo);
			break;
		case "19":
			sqlsession.insert("minsung.addCert", boardvo);
			break;
		case "20":
			sqlsession.insert("minsung.addEmp", boardvo);
			break;
		case "21":
			sqlsession.insert("minsung.addJoboffer", boardvo);
			break;
		case "22":
			sqlsession.insert("minsung.addLost", boardvo);
			break;
		}
		return result;
	}

	// 공지리스트 컴컴
	   @Override
	   public List<NoticeVO> getNoticeList(Map<String, String> paraMap) {
	      List<NoticeVO> noticeList = sqlsession.selectList("ansehyeong.getNoticeList", paraMap);
	      return noticeList;
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
	public void pointPlus(Map<String, String> paraMap) {
		String point = paraMap.get("point"); 
		
		Map<String, Integer> pointMap = sqlsession.selectOne("minsung.pointCheck", paraMap.get("fk_memberNo")); // 회원의 기존 포인트와 다음 레벨의 포인트들을 불러온다.
		
		try {
			int currentPoint = pointMap.get("currentPoint"); 
			int nextLevelPoint = pointMap.get("nextLevelPoint"); 
			
			if ( currentPoint + Integer.parseInt(point) >= nextLevelPoint ) { // 회원의 포인트가 다음 레벨의 포인트 이상이면
				paraMap.put("nextLevelNo", String.valueOf(pointMap.get("nextLevelNo")));
				sqlsession.update("minsung.pointPlusWithLevel", paraMap);
			}else {
				sqlsession.update("minsung.pointPlus", paraMap); // 회원의 포인트가 다음 레벨의 포인트 이하이면
			}
			
		} catch (NullPointerException e) {
			
			sqlsession.update("minsung.pointPlus", paraMap); // 회원의 레벨이 더이상 올라갈 수 없으면
		}
		
	}

	@Override
	public MinsungBoardVO getView(Map<String, String> paraMap) {
		MinsungBoardVO boardvo = null;
		switch (paraMap.get("boardKindNo")) {
		case "1":
			boardvo = sqlsession.selectOne("minsung.getViewNotice", paraMap.get("boardNo"));
			break;
		case "2":
			boardvo = sqlsession.selectOne("minsung.getViewCouncil", paraMap.get("boardNo"));
			break;
		case "3":
			boardvo = sqlsession.selectOne("minsung.getViewMajor", paraMap.get("boardNo"));
			break;
		case "4":
			boardvo = sqlsession.selectOne("minsung.getViewClub", paraMap.get("boardNo"));
			break;
		case "5":
			boardvo = sqlsession.selectOne("minsung.getViewGraduate", paraMap.get("boardNo"));
			break;
		case "6":
			boardvo = sqlsession.selectOne("minsung.getViewCritic", paraMap.get("boardNo"));
			break;
		case "18":
			boardvo = sqlsession.selectOne("minsung.getViewStudy", paraMap.get("boardNo"));
			break;
		case "19":
			boardvo = sqlsession.selectOne("minsung.getViewCert", paraMap.get("boardNo"));
			break;
		case "20":
			boardvo = sqlsession.selectOne("minsung.getViewEmp", paraMap.get("boardNo"));
			break;
		case "21":
			boardvo = sqlsession.selectOne("minsung.getViewJoboffer", paraMap.get("boardNo"));
			break;
		case "22":
			boardvo = sqlsession.selectOne("minsung.getViewLost", paraMap.get("boardNo"));
			break;
		}
		
		return boardvo;
	}
	
	
	@Override
	public void addReadCount(Map<String, String> paraMap) {
		switch (paraMap.get("boardKindNo")) {
		case "1":
			sqlsession.update("minsung.addReadNotice", paraMap.get("boardNo"));
			break;
		case "2":
			sqlsession.update("minsung.addReadCouncil", paraMap.get("boardNo"));
			break;
		case "3":
			sqlsession.update("minsung.addReadMajor", paraMap.get("boardNo"));
			break;
		case "4":
			sqlsession.update("minsung.addReadClub", paraMap.get("boardNo"));
			break;
		case "5":
			sqlsession.update("minsung.addReadGraduate", paraMap.get("boardNo"));
			break;
		case "6":
			sqlsession.update("minsung.addReadCritic", paraMap.get("boardNo"));
			break;
		case "18":
			sqlsession.update("minsung.addReadStudy", paraMap.get("boardNo"));
			break;
		case "19":
			sqlsession.update("minsung.addReadCert", paraMap.get("boardNo"));
			break;
		case "20":
			sqlsession.update("minsung.addReadEmp", paraMap.get("boardNo"));
			break;
		case "21":
			sqlsession.update("minsung.addReadJoboffer", paraMap.get("boardNo"));
			break;
		case "22":
			sqlsession.update("minsung.addReadLost", paraMap.get("boardNo"));
			break;
		}

	}

	@Override
	public int addBoardUp(Map<String, String> paraMap) {
		sqlsession.delete("minsung.deleteBoardBad", paraMap);
		int result = sqlsession.insert("minsung.addBoardUp", paraMap);
		return result;
	}

	@Override
	public int getBoardGoodCount(Map<String, String> paraMap) {
		int upCount = sqlsession.selectOne("minsung.getBoardGoodCount", paraMap);
		return upCount;
	}

	@Override
	public int addBoardDown(Map<String, String> paraMap) {
		// 비추천 테이블에서 paraMap으로 넘어온 값을 가진 행을 삭제한다.
		sqlsession.delete("minsung.deleteBoardGood", paraMap);
		
		// 추천 테이블에 행을 추가한다.
		int result = sqlsession.insert("minsung.addBoardDown", paraMap);
		return result;
	}

	@Override
	public int getBoardBadCount(Map<String, String> paraMap) {
		int downCount = sqlsession.selectOne("minsung.getBoardBadCount", paraMap);
		return downCount;
	}

	@Override
	public int addCommentReport(Map<String, String> paraMap) {
		int n = sqlsession.insert("minsung.addBoardReport",paraMap);
		return n;
	}

	@Override
	public int addBoardWithFile(MinsungBoardVO boardvo) {
		int result = 0;
		switch (boardvo.getFk_boardKindNo()) {
		case "1":
			sqlsession.insert("minsung.addFileReadNotice", boardvo);
			break;
		case "2":
			sqlsession.insert("minsung.addFileReadCouncil", boardvo);
			break;
		case "3":
			sqlsession.insert("minsung.addFileReadMajor", boardvo);
			break;
		case "4":
			sqlsession.insert("minsung.addFileReadClub", boardvo);
			break;
		case "5":
			sqlsession.insert("minsung.addFileReadGraduate", boardvo);
			break;
		case "6":
			sqlsession.insert("minsung.addFileReadCritic", boardvo);
			break;
		case "18":
			sqlsession.insert("minsung.addFileReadStudy", boardvo);
			break;
		case "19":
			sqlsession.insert("minsung.addFileReadCert", boardvo);
			break;
		case "20":
			sqlsession.insert("minsung.addFileReadEmp", boardvo);
			break;
		case "21":
			sqlsession.insert("minsung.addFileReadJoboffer", boardvo);
			break;
		case "22":
			sqlsession.insert("minsung.addFileReadLost", boardvo);
			break;
		}
		return result;
	}

	@Override
	public List<MinsungMsgVO> getMsgList(int loginNo) {
		List<MinsungMsgVO> getMsgList = sqlsession.selectList("minsung.getMsgList", String.valueOf(loginNo));
		return getMsgList;
	}

	@Override
	public List<MinsungMsgVO> sendMsgList(int loginNo) {
		List<MinsungMsgVO> sendMsgList = sqlsession.selectList("minsung.sendMsgList", String.valueOf(loginNo));
		return sendMsgList;
	}

	@Override
	public MinsungMsgVO oneMsg(String msgNo) {
		 MinsungMsgVO oneMsg = sqlsession.selectOne("minsung.oneMsg", msgNo);
		 return oneMsg;
	}

	@Override
	public int getToMemberNo(String nickName) {
		int getToMemberNo = sqlsession.selectOne("minsung.getToMemberNo", nickName);
		return getToMemberNo;
	}

	@Override
	public int insertMsg(Map<String, String> paraMap) {
		int n = sqlsession.insert("minsung.insertMsg", paraMap);
		return n;
	}
	
	

}
