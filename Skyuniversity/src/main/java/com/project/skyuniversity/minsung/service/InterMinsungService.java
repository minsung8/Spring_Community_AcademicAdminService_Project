package com.project.skyuniversity.minsung.service;

import java.util.List;
import java.util.Map;

import com.project.skyuniversity.ash.model.NoticeVO;
import com.project.skyuniversity.minsung.model.MinsungBoardVO;
import com.project.skyuniversity.minsung.model.MinsungCategoryVO;
import com.project.skyuniversity.minsung.model.MinsungMsgVO;
import com.project.skyuniversity.ohyoon.model.CommentVO;

public interface InterMinsungService {

	List<MinsungBoardVO> boardListSelected(); // 선택된 게시물 리스트

	List<MinsungBoardVO> boardListSearchWithPaging(Map<String, String> paraMap); // 검색 + 페이지 처리 리스트

	int getTotalCount(Map<String, String> paraMap); // 총 게시물 개수

	List<MinsungCategoryVO> categoryList(String boardKindNo); // 게시판 리스트의 카테고리 가져오긱

	String kindBoard(String boardKindNo); // 해당 게시판 리스트 종류

	MinsungBoardVO getOneBoard(Map<String, String> paraMap); // detail board 가져오기

	int edit(MinsungBoardVO boardvo); // 글 수정

	int del(MinsungBoardVO boardvo); // 글 삭제

	int add(MinsungBoardVO boardvo); // 글 쓰기

	List<NoticeVO> getNoticeList(Map<String, String> paraMap);

	List<MinsungBoardVO> recentBoardList();

	List<MinsungBoardVO> bestBoardList();

	List<MinsungBoardVO> popularBoardList();

	void pointPlus(Map<String, String> paraMap);

	MinsungBoardVO getView(Map<String, String> paraMap);

	MinsungBoardVO getViewWithNoAddCount(Map<String, String> paraMap);

	int addBoardUp(Map<String, String> paraMap);

	int getBoardGoodCount(Map<String, String> paraMap);

	int addBoardDown(Map<String, String> paraMap);

	int getBoardBadCount(Map<String, String> paraMap);

	int addCommentReport(Map<String, String> paraMap);

	MinsungBoardVO getViewNoAddCount(Map<String, String> paraMap);

	int add_withFile(MinsungBoardVO boardvo);

	List<MinsungMsgVO> getMsgList(int loginNo);

	List<MinsungMsgVO> sendMsgList(int loginNo);

	MinsungMsgVO oneMsg(String msgNo);

	int getToMemberNo(String nickName);

	int insertMsg(Map<String, String> paraMap);




}
