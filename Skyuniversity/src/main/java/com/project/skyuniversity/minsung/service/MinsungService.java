package com.project.skyuniversity.minsung.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.common.AES256;
import com.project.skyuniversity.minsung.model.InterMinsungBoardDAO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.minsung.model.MinsungCategoryVO;
import com.project.skyuniversity.minsung.model.MinsungMsgVO;

@Service
public class MinsungService implements InterMinsungService{
	
	@Autowired
	private InterMinsungBoardDAO dao;
	
	@Autowired
	private AES256 aes;

	@Override
	public List<MinsungBoardVO> boardListSelected() {
		
		List<MinsungBoardVO> boardList = dao.boardListSelected();
		
		return boardList;
	}

	@Override
	public List<MinsungBoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<MinsungBoardVO> boardList = dao.boardListSearchWithPaging(paraMap);
		return boardList;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	@Override
	public List<MinsungCategoryVO> categoryList(String boardKindNo) {
		List<MinsungCategoryVO> categoryList = dao.categoryList(boardKindNo);
		return categoryList;
	}

	@Override
	public String kindBoard(String boardKindNo) {
		String kindBoard = dao.kindBoard(boardKindNo);
		return kindBoard;
	}

	@Override
	public MinsungBoardVO getOneBoard(Map<String, String> paraMap) {
		MinsungBoardVO boardvo = dao.getOneBoard(paraMap);
		return boardvo;
	}

	@Override
	public int edit(MinsungBoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	@Override
	public int del(MinsungBoardVO boardvo) {
		int n = dao.del(boardvo);
		return n;
	}

	@Override
	public int add(MinsungBoardVO boardvo) {
		int n = dao.add(boardvo);
		return n;
	}

	// 공지리스트 컴컴
	   @Override
	   public List<NoticeVO> getNoticeList(Map<String, String> paraMap) {
	      List<NoticeVO> noticeList = dao.getNoticeList(paraMap);
	      return noticeList;
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
	public void pointPlus(Map<String, String> paraMap) {
		dao.pointPlus(paraMap);
	}

	@Override
	public MinsungBoardVO getView(Map<String, String> paraMap) {
		MinsungBoardVO boardvo = dao.getView(paraMap);

		// 로그인한 유저의 회원번호와 게시물의 작성자 회원번호가 다르다면 
		if ( !boardvo.getFk_memberNo().equals(paraMap.get("loginNo")) ) { 
			// 해당 게시물의 조회수를 1증가시킨다.
			dao.addReadCount(paraMap);
			boardvo = dao.getView(paraMap);
		}
		return boardvo;
	}
	
	@Override
	public MinsungBoardVO getViewWithNoAddCount(Map<String, String> paraMap) {
		MinsungBoardVO boardvo = dao.getView(paraMap);
		return boardvo;
	}

	@Override
	public int addBoardUp(Map<String, String> paraMap) {
		int result = dao.addBoardUp(paraMap);
		return result;
	}

	@Override
	public int getBoardGoodCount(Map<String, String> paraMap) {
		int upCount = dao.getBoardGoodCount(paraMap);
		return upCount;
	}

	@Override
	public int addBoardDown(Map<String, String> paraMap) {
		int result = dao.addBoardDown(paraMap);
		return result;
	}

	@Override
	public int getBoardBadCount(Map<String, String> paraMap) {
		int downCount = dao.getBoardBadCount(paraMap);
		return downCount;
	}

	@Override
	public int addCommentReport(Map<String, String> paraMap) {
		int n = dao.addCommentReport(paraMap);
		return n;
	}

	@Override
	public MinsungBoardVO getViewNoAddCount(Map<String, String> paraMap) {
		MinsungBoardVO boardvo = dao.getView(paraMap);
		return boardvo;
	}

	@Override
	public int add_withFile(MinsungBoardVO boardvo) {
		int n = dao.addBoardWithFile(boardvo);
		return n;
	}

	@Override
	public List<MinsungMsgVO> getMsgList(int loginNo) {
		List<MinsungMsgVO> getMsgList = dao.getMsgList(loginNo);
		return getMsgList;
	}

	@Override
	public List<MinsungMsgVO> sendMsgList(int loginNo) {
		List<MinsungMsgVO> sendMsgList = dao.sendMsgList(loginNo);
		return sendMsgList;
	}

	@Override
	public MinsungMsgVO oneMsg(String msgNo) {
		 MinsungMsgVO oneMsg = dao.oneMsg(msgNo);
		 return oneMsg;
	}

	@Override
	public int getToMemberNo(String nickName) {
		int getToMemberNo = dao.getToMemberNo(nickName);
		return getToMemberNo;
	}

	@Override
	public int insertMsg(Map<String, String> paraMap) {
		int n = dao.insertMsg(paraMap);
		return n;
	}
	

	


   
}

