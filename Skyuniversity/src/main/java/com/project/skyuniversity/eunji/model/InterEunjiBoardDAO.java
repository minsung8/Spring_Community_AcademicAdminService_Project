package com.project.skyuniversity.eunji.model;

import java.util.List;
import java.util.Map;

public interface InterEunjiBoardDAO {

	MemberVO selectMemberInfo(Map<String, String> paraMap);// 수강신청시, 해당 학번의 정보를 불러오는 메소드

	List<String> selectAllDept();	// 전체 학과를 불러오는 메소드

	List<String> selectAllSubject(int semester);	// 전체 과목을 불러오는 메소드
	
	List<String> selectDeptClass(Map<String, String> paraMap);	// 학과를 select 했을 때 과목을 불러오는 메소드

	List<Map<String, String>> getSubjectList(Map<String, String> paraMap);

	String selectDeptOneSub(String subjectno);

	int insertCourse(Map<String, String> paraMap);

	int recourseInfo(Map<String, String> paraMap);

	int insertReCourse(Map<String, String> paraMap);

	int recourseInfo2(Map<String, String> paraMap);

	int updatePlusCnt(String string);

	List<Map<String, String>> selectRegList(Map<String, String> paraMap2);

	int deleteCourse(String no);

	int updateDelCnt(String subno);

	int selectSumCredit(Map<String, String> paraMap2);

	List<String> dayInfo(Map<String, String> paraMap);

	int uniqueInfo(Map<String, String> paraMap);

	int add(OfficialLeaveVO ocvo);

	int addNonTime(OfficialLeaveVO ocvo);

	int add_withFile(OfficialLeaveVO ocvo);

	int add_withFileNonTime(OfficialLeaveVO ocvo);

	List<OfficialLeaveVO> selectOfficial(String string);

	int delOfficialLeave(String seq);

	List<Map<String, String>> selectLeaveInfo(Map<String, String> hashmap);

	OfficialLeaveVO getLeaveVO(String seq);

	int checkDate(Map<String, String> timemap);

	int insertGirlLeave(GirlOfficialLeaveVO golvo);

	int insertGirlLeaveTime(GirlOfficialLeaveVO golvo);

	List<GirlOfficialLeaveVO> selectGirlList(int memberNo);

	int checkGirlDate(Map<String, String> checkmap);

	int delGirlOfficialLeave(String seq);

	List<Map<String, String>> selectCheckList(Map<String, String> hashmap);

	int insertClassCheck(ClassCheckVO ccvo);

	int updateCourseCk(int fk_courseno);

	Map<String, String> allMemberInfo(int memberNo);

	int insertArmyLeave(SchoolLeaveVO slvo);

	int insertLeave(Map<String, String> paraMap);

	List<SchoolLeaveVO> selectSchoolLeave(int memberNo);

	SchoolLeaveVO getSchoolLeaveVO(String seq);

	int deleteSchoolInfo(String no);

	int updateArmyType(SchoolLeaveVO slvo);

	int updateLeaveSchool(SchoolLeaveVO slvo);

	int checkLeave(Map<String, String> paraMap);

	List<SchoolLeaveVO> comeSchoolInfo(Map<String, String> commap);

	int insertComeSchool(Map<String, String> paraMap);

	int checkComeSchool(Map<String, String> paraMap);

	List<ComeSchoolVO> selectEndComeSchool(int memberNo);

	int insertComeSchoolArmy(ComeSchoolVO csvo);

	int deleteComeSchool(String seq);

	ComeSchoolVO getComeSchoolVO(String seq);

	int sumSemester(int memberNo);

	int sumMajorCredits(int memberNo);

	int sumCultureCredits(int memberNo);

	List<Map<String, String>> getSubjectListNo(String no);

	List<String> periodInfo(Map<String, String> paraMap);

	List<String> getMustSubject(Map<String, String> paraMap);

	List<String> getMyMustSubejct(Map<String, String> paraMap);

	List<String> getMustSubjectdept(Map<String, String> paraMap);

	int updateGraduateOk(int memberNo);

	int insertGraduateDelay(GraduateDelayVO gdvo);

	List<GraduateDelayVO> selectGraduateList(int memberNo);

	int checkDelay(GraduateDelayVO gdvo);

	int deleteGraduateDelay(String seq);

	int getFGrade(int memberNo);

	List<String> getAllGrade(int memberNo);

	List<String> getAllCredit(int memberNo);

	int insertGraduateEarly(GraduateEarlyVO gevo);

	List<GraduateEarlyVO> selectGraduateEarly(int memberNo);

	int deleteGraduateEarly(String seq);

	List<String> getNowSubject(Map<String, Integer> map);

	List<HomeworkVO> selectHomework(Map<String, Integer> map);


}
