package com.project.skyuniversity.jihyun.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.skyuniversity.jihyun.model.JihyunDAO;
import com.project.skyuniversity.jihyun.model.JihyunMemberVO;

@Service
public class JihyunService implements InterJihyunService {

	@Autowired
	private JihyunDAO dao;
	
	@Override
	public JihyunMemberVO getLoginMember(Map<String, String> paraMap) {
		JihyunMemberVO getLoginMember = dao.getLoginMember(paraMap);
		return getLoginMember;
	}

	// 비밀번호 업데이트
	@Override
	public int updatePwd(Map<String, String> paraMap) {
		int n = dao.updatePwd(paraMap);
		return n;
	}

	// 비밀번호확인
	@Override
	public boolean checkPwd(Map<String, String> paraMap) {
		boolean isEqualPwd = dao.checkPwd(paraMap);
		return isEqualPwd;
	}

	// 증명서 종류 리스트 가져오기
	@Override
	public List<Map<String, String>> getCertificatekindList() {
		List<Map<String, String>> certificatekindList = dao.getCertificateKindList();
		return certificatekindList;
	}

	// 증명서 신청 리스트 가져오기
	@Override
	public List<Map<String, String>> getApplicationList(String memberNo) {
		List<Map<String, String>> ApplicationList = dao.getApplicationList(memberNo);
		return ApplicationList;
	}

	// 공지사항 리스트 가져오기
	@Override
	public List<Map<String, String>> getNoticeList() {
		List<Map<String, String>> noticeList = dao.getNoticeList();
		return noticeList;
	}
	// 학과별
	@Override
	public List<Map<String, String>> getDeptNoticeList() {
		List<Map<String, String>> detpNoticeList = dao.getDeptNoticeList();
		return detpNoticeList;
	}
	// 과목별
	@Override
	public List<Map<String, String>> getSubjectNoticeList() {
		List<Map<String, String>> subjectnoticeList = dao.getSubjectNoticeList();
		return subjectnoticeList;
	}

	// 학번으로 학생정보가져오기
	@Override
	public JihyunMemberVO getLoginuserFromCommu(String memberNo) {
		JihyunMemberVO loginuser = dao.getLoginuserFromCommu(memberNo);
		return loginuser;
	}

	// 증명서 신청 내역 추가
	@Override
	public int addCertificateApplication(List<Map<String, String>> caList) {
		int n = dao.addCertificateApplication(caList);
		return n;
	}

	// 공지사항 내용 가져오기
	@Override
	public Map<String, String> getNoticeDetail(Map<String, String> paraMap) {
		Map<String, String> noticeDetail = dao.getNoticeDetail(paraMap);
		return noticeDetail;
	}

	// 현재 수강과목 불러오기
	@Override
	public List<Map<String, String>> getLectureList(String memberNo) {
		List<Map<String, String>> lectureList = dao.getLectureList(memberNo);
		return lectureList;
	}

	// 학생 기본정보 업데이트
	@Override
	public int sInfoUpdate(Map<String, String> paraMap) {
		int n = dao.sInfoUpdate(paraMap);
		return n;
	}

	// 학생 주소 업데이트
	@Override
	public int sAddressUpdate(Map<String, String> paraMap) {
		int n = dao.sAddressUpdate(paraMap);
		return n;
	}

	// 학교 전체 일정 불러오기
	@Override
	public List<Map<String, String>> getsScheduleList() {
		List<Map<String, String>> sScheduleList = dao.getsScheduleList();
		return sScheduleList;
	}

	// 기이수 성적 가져오기
	@Override
	public List<Map<String, String>> getTotalGradeList(String memberNo) {
		List<Map<String, String>> totalGradeList = dao.getLectureList(memberNo);
		return totalGradeList;
	}

}
