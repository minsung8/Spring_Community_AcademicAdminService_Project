package com.project.skyuniversity.jihyun.model;

import java.util.List;
import java.util.Map;

public interface InterJihyunDAO {

	// 로그인하기
	JihyunMemberVO getLoginMember(Map<String, String> paraMap);
	
	// 비밀번호 변경하기
	int updatePwd(Map<String, String> paraMap);
	
	// 현재 비밀번호 일치여부 확인
	boolean checkPwd(Map<String, String> paraMap);
	
	// 증명서 종류 리스트 가져오기
	public List<Map<String, String>> getCertificateKindList();
	
	// 증명서 신청 리스트 가져오기
	public List<Map<String, String>> getApplicationList(String memberNo);
	
	// 공지사항 리스트 가져오기
	public List<Map<String, String>> getNoticeList();	// 전체
	public List<Map<String, String>> getDeptNoticeList();	// 학과별
	public List<Map<String, String>> getSubjectNoticeList();	// 과목별
	
	// 학번으로 유저정보 가져오기
	public JihyunMemberVO getLoginuserFromCommu(String memberNo);
	
	// 증명서 신청 내역 추가
	public int addCertificateApplication(List<Map<String, String>> caList);
	
	// 공지사항 내용 가져오기
	public Map<String, String> getNoticeDetail(Map<String, String> paraMap);
	
	// 현재 수강과목 불러오기
	public List<Map<String, String>> getLectureList(String memberNo);
	
	// 학생 기본정보 업데이트
	public int sInfoUpdate(Map<String, String> paraMap);
	
	// 학생 주소 업데이트
	public int sAddressUpdate(Map<String, String> paraMap);
	
	// 학교 전체 일정 불러오기
	public List<Map<String, String>> getsScheduleList();
	
	// 기이수 성적 가져오기
	public List<Map<String, String>> getTotalGradeList(String memberNo);
}
