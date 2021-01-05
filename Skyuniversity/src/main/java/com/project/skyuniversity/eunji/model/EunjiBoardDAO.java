package com.project.skyuniversity.eunji.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EunjiBoardDAO implements InterEunjiBoardDAO {

	@Resource
	private SqlSessionTemplate sqlSession;
	
	@Override
	public MemberVO selectMemberInfo(Map<String, String> paraMap) {
		MemberVO mvo = sqlSession.selectOne("eunji.selectMemberInfo",paraMap );
		return mvo;
	}

	@Override
	public List<String> selectAllDept() {
		List<String> arraylist = sqlSession.selectList("eunji.selectAllDept");
		return arraylist;
	}
	
  
	@Override
	public List<String> selectAllSubject(int semester) {
		List<String> arraylist = sqlSession.selectList("eunji.selectAllSubject", semester);
		return arraylist;
	}

	@Override
	public List<String> selectDeptClass(Map<String, String> paraMap) {
		List<String> arraylist = sqlSession.selectList("eunji.selectDeptClass", paraMap);
		return arraylist;
	}

	@Override
	public List<Map<String, String>> getSubjectList(Map<String, String> paraMap) {
		List<Map<String, String>> subjectlist = sqlSession.selectList("eunji.getSubjectList", paraMap);
		return subjectlist;
	}

	@Override
	public String selectDeptOneSub(String subjectno) {
		String dept = sqlSession.selectOne("eunji.selectDeptOneSub",subjectno);
		return dept;
	}

	@Override
	public int insertCourse(Map<String, String> paraMap) {
		int n = sqlSession.insert("eunji.insertCourse", paraMap);
		return n;
	}

	@Override
	public int recourseInfo(Map<String, String> paraMap) {
		int info = sqlSession.selectOne("eunji.recourseInfo", paraMap);
		return info;
	}

	@Override
	public int insertReCourse(Map<String, String> paraMap) {
		int n = sqlSession.insert("eunji.insertReCourse",paraMap);
		return n;
	}

	@Override
	public int recourseInfo2(Map<String, String> paraMap) {
		int info = sqlSession.selectOne("eunji.recourseInfo2", paraMap);
		return info;
	}

	@Override
	public int updatePlusCnt(String string) {
		int n = sqlSession.update("eunji.updatePlusCnt", string);
		return n;
	}

	@Override
	public List<Map<String, String>> selectRegList(Map<String, String> paraMap2) {
		List<Map<String, String>> reglist = sqlSession.selectList("eunji.selectRegList", paraMap2);
		return reglist;
	}

	@Override
	public int deleteCourse(String no) {
		int n = sqlSession.delete("eunji.deleteCourse", no);
		return n;
	}

	@Override
	public int updateDelCnt(String subno) {
		int n = sqlSession.update("eunji.updateDelCnt", subno);
		return n;
	}

	@Override
	public int selectSumCredit(Map<String, String> paraMap2) {
		int sumcredit = sqlSession.selectOne("eunji.selectSumCredit", paraMap2);
		return sumcredit;
	}

	@Override
	public List<String> dayInfo(Map<String, String> paraMap) {
		List<String> daylist = sqlSession.selectList("eunji.dayInfo",paraMap);
		return daylist;
	}

	@Override
	public int uniqueInfo(Map<String, String> paraMap) {
		int uniqueinfo = sqlSession.selectOne("eunji.uniqueInfo", paraMap);
		return uniqueinfo;
	}

	@Override
	public int add(OfficialLeaveVO ocvo) {
		int n = sqlSession.insert("eunji.add", ocvo);
		return n;
	}

	@Override
	public int addNonTime(OfficialLeaveVO ocvo) {
		int n = sqlSession.insert("eunji.addNonTime", ocvo);
		return n;
	}

	@Override
	public int add_withFile(OfficialLeaveVO ocvo) {
		int n = sqlSession.insert("eunji.add_withFile", ocvo);
		return n;
	}

	@Override
	public int add_withFileNonTime(OfficialLeaveVO ocvo) {
		int n = sqlSession.insert("eunji.add_withFileNonTime", ocvo);
		return n;
	}

	@Override
	public List<OfficialLeaveVO> selectOfficial(String string) {
		List<OfficialLeaveVO> leavelist = sqlSession.selectList("eunji.selectOfficial", string);
		return leavelist;
	}

	@Override
	public int delOfficialLeave(String seq) {
		int n = sqlSession.delete("eunji.delOfficialLeave", seq);
		return n;
	}

	@Override
	public List<Map<String, String>> selectLeaveInfo(Map<String, String> hashmap) {
		List<Map<String, String>> leavelist = sqlSession.selectList("eunji.selectLeaveInfo", hashmap);
		return leavelist;
	}

	@Override
	public OfficialLeaveVO getLeaveVO(String seq) {
		OfficialLeaveVO olvo = sqlSession.selectOne("eunji.getLeaveVO", seq);
		return olvo;
	}

	@Override
	public int checkDate(Map<String, String> timemap) {
		int n = sqlSession.selectOne("eunji.checkDate", timemap);
		return n;
	}

	@Override
	public int insertGirlLeave(GirlOfficialLeaveVO golvo) {
		int n = sqlSession.insert("eunji.insertGirlLeave", golvo);
		return n;
	}

	@Override
	public int insertGirlLeaveTime(GirlOfficialLeaveVO golvo) {
		int n = sqlSession.insert("eunji.insertGirlLeaveTime", golvo);
		return n;
	}

	@Override
	public List<GirlOfficialLeaveVO> selectGirlList(int memberNo) {
		List<GirlOfficialLeaveVO> girllist = sqlSession.selectList("eunji.selectGirlList", memberNo);
		return girllist;
	}

	@Override
	public int checkGirlDate(Map<String, String> checkmap) {
		int cnt = sqlSession.selectOne("eunji.checkGirlDate", checkmap);
		return cnt;
	}

	@Override
	public int delGirlOfficialLeave(String seq) {
		int n = sqlSession.delete("eunji.delGirlOfficialLeave", seq);
		return n;
	}

	@Override
	public List<Map<String, String>> selectCheckList(Map<String, String> hashmap) {
		List<Map<String, String>> checklist = sqlSession.selectList("eunji.selectCheckList", hashmap);
		return checklist;
	}

	@Override
	public int insertClassCheck(ClassCheckVO ccvo) {
		int n = sqlSession.insert("eunji.insertClassCheck", ccvo);
		return n;
	}

	@Override
	public int updateCourseCk(int fk_courseno) {
		int n = sqlSession.update("eunji.updateCourseCk",fk_courseno);
		return n;
	}

	@Override
	public Map<String, String> allMemberInfo(int memberNo) {
		Map<String, String> paraMap = sqlSession.selectOne("eunji.allMemberInfo", memberNo);
		return paraMap;
	}

	@Override
	public int insertArmyLeave(SchoolLeaveVO slvo) {
		int n = sqlSession.insert("eunji.insertArmyLeave",slvo);
		return n;
	}

	@Override
	public int insertLeave(Map<String, String> paraMap) {
		int n = sqlSession.insert("eunji.insertLeave", paraMap);
		return n;
	}

	@Override
	public List<SchoolLeaveVO> selectSchoolLeave(int memberNo) {
		List<SchoolLeaveVO> list = sqlSession.selectList("eunji.selectSchoolLeave", memberNo);
		return list;
	}

	@Override
	public SchoolLeaveVO getSchoolLeaveVO(String seq) {
		SchoolLeaveVO slvo = sqlSession.selectOne("eunji.getSchoolLeaveVO", seq);
		return slvo;
	}

	@Override
	public int deleteSchoolInfo(String no) {
		int n = sqlSession.delete("eunji.deleteSchoolInfo", no);
		return n;
	}

	@Override
	public int updateArmyType(SchoolLeaveVO slvo) {
		int n = sqlSession.update("eunji.updateArmyType", slvo);
		return n;
	}

	@Override
	public int updateLeaveSchool(SchoolLeaveVO slvo) {
		int n = sqlSession.update("eunji.updateLeaveSchool", slvo);
		return n;
	}

	@Override
	public int checkLeave(Map<String, String> paraMap) {
		int n = sqlSession.selectOne("eunji.checkLeave", paraMap);
		return n;
	}

	@Override
	public List<SchoolLeaveVO> comeSchoolInfo(Map<String, String> commap) {
		List<SchoolLeaveVO> comeList = sqlSession.selectList("eunji.comeSchoolInfo", commap);
		return comeList;
	}

	@Override
	public int insertComeSchool(Map<String, String> paraMap) {
		int n = sqlSession.insert("eunji.insertComeSchool", paraMap);
		return n;
	}

	@Override
	public int checkComeSchool(Map<String, String> paraMap) {
		int n = sqlSession.selectOne("eunji.checkComeSchool", paraMap);
		return n;
	}

	@Override
	public List<ComeSchoolVO> selectEndComeSchool(int memberNo) {
		List<ComeSchoolVO> list = sqlSession.selectList("eunji.selectEndComeSchool", memberNo);
		return list;
	}

	@Override
	public int insertComeSchoolArmy(ComeSchoolVO csvo) {
		int n = sqlSession.insert("eunji.insertComeSchoolArmy", csvo);
		return n;
	}

	@Override
	public int deleteComeSchool(String seq) {
		int n = sqlSession.delete("eunji.deleteComeSchool",seq);
		return n;
	}

	@Override
	public ComeSchoolVO getComeSchoolVO(String seq) {
		ComeSchoolVO csvo = sqlSession.selectOne("eunji.getComeSchoolVO",seq);
		return csvo;
	}

	@Override
	public int sumSemester(int memberNo) {
		int n = sqlSession.selectOne("eunji.sumSemester", memberNo);
		return n;
	}

	@Override
	public int sumMajorCredits(int memberNo) {
		int n = sqlSession.selectOne("eunji.sumMajorCredits", memberNo);
		return n;
	}

	@Override
	public int sumCultureCredits(int memberNo) {
		int n = sqlSession.selectOne("eunji.sumCultureCredits", memberNo);
		return n;
	}

	@Override
	public List<Map<String, String>> getSubjectListNo(String no) {
		List<Map<String, String>> mapList = sqlSession.selectList("eunji.getSubjectListNo", no);
		return mapList;
	}

	@Override
	public List<String> periodInfo(Map<String, String> paraMap) {
		List<String> periodlist = sqlSession.selectList("eunji.periodInfo",paraMap);
		return periodlist;
	}

	@Override
	public List<String> getMustSubject(Map<String, String> paraMap) {
		List<String> sublist = sqlSession.selectList("eunji.getMustSubject", paraMap);
		return sublist;
	}

	@Override
	public List<String> getMyMustSubejct(Map<String, String> paraMap) {
		List<String> sublist = sqlSession.selectList("eunji.getMyMustSubejct", paraMap);
		return sublist;
	}

	@Override
	public List<String> getMustSubjectdept(Map<String, String> paraMap) {
		List<String> list = sqlSession.selectList("eunji.getMustSubjectdept", paraMap);
		return list;
	}

	@Override
	public int updateGraduateOk(int memberNo) {
		int n = sqlSession.update("eunji.updateGraduateOk", memberNo);
		return n;
	}

	@Override
	public int insertGraduateDelay(GraduateDelayVO gdvo) {
		int n = sqlSession.insert("eunji.insertGraduateDelay", gdvo);
		return n;
	}

	@Override
	public List<GraduateDelayVO> selectGraduateList(int memberNo) {
		List<GraduateDelayVO> list = sqlSession.selectList("eunji.selectGraduateList", memberNo);
		return list;
	}

	@Override
	public int checkDelay(GraduateDelayVO gdvo) {
		int check = sqlSession.selectOne("eunji.checkDelay", gdvo);
		return check;
	}

	@Override
	public int deleteGraduateDelay(String seq) {
		int n = sqlSession.delete("eunji.deleteGraduateDelay", seq);
		return n;
	}

	@Override
	public int getFGrade(int memberNo) {
		int n = sqlSession.selectOne("eunji.getFGrade", memberNo);
		return n;
	}

	@Override
	public List<String> getAllGrade(int memberNo) {
		List<String> list = sqlSession.selectList("eunji.getAllGrade", memberNo);
		return list;
	}

	@Override
	public List<String> getAllCredit(int memberNo) {
		List<String> list = sqlSession.selectList("eunji.getAllCredit", memberNo);
		return list;
	}

	@Override
	public int insertGraduateEarly(GraduateEarlyVO gevo) {
		int n = sqlSession.insert("eunji.insertGraduateEarly", gevo);
		return n;
	}

	@Override
	public List<GraduateEarlyVO> selectGraduateEarly(int memberNo) {
		List<GraduateEarlyVO> list = sqlSession.selectList("eunji.selectGraduateEarly", memberNo);
		return list;
	}

	@Override
	public int deleteGraduateEarly(String seq) {
		int n = sqlSession.delete("eunji.deleteGraduateEarly",seq);
		return n;
	}

	@Override
	public List<String> getNowSubject(Map<String, Integer> map) {
		List<String> list = sqlSession.selectList("eunji.getNowSubject", map);
		return list;
	}

	@Override
	public List<HomeworkVO> selectHomework(Map<String, Integer> map) {
		List<HomeworkVO> worklist = sqlSession.selectList("eunji.selectHomework", map);
		return worklist;
	}

}
