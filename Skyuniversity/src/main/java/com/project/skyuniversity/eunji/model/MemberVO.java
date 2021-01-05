package com.project.skyuniversity.eunji.model;

public class MemberVO {
	
	private int memberNo;			// 학번
	private String pwd;				// 비밀번호
	private String name;			// 성명
	private String mobile;			// 연락처
	private String email;			// 이메일
	private String birth;			// 생년월일
	private String jubun;			// 주민번호
	private String engName;			// 영문성명
	private String chinaName;		// 한자성명
	private String img;				// 사진
	private int grade;				// 학년
	private int currentSemester;	// 현재이수학기
	private String enterDay;		// 입학날짜
	private String graduateDay; 	// 졸업날짜
	private String postcode;    	// 우편번호
	private String address;			// 주소
	private String detailaddress;	// 상세주소
	private String extraaddress;    // 참고주소
	private int absenceCnt; 		// 휴학횟수
	private int graduateok; 		// 졸업가능여부
	
	private String deptName;
	
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getJubun() {
		return jubun;
	}
	public void setJubun(String jubun) {
		this.jubun = jubun;
	}
	public String getEngName() {
		return engName;
	}
	public void setEngName(String engName) {
		this.engName = engName;
	}
	public String getChinaName() {
		return chinaName;
	}
	public void setChinaName(String chinaName) {
		this.chinaName = chinaName;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getCurrentSemester() {
		return currentSemester;
	}
	public void setCurrentSemester(int currentSemester) {
		this.currentSemester = currentSemester;
	}
	public String getEnterDay() {
		return enterDay;
	}
	public void setEnterDay(String enterDay) {
		this.enterDay = enterDay;
	}
	public String getGraduateDay() {
		return graduateDay;
	}
	public void setGraduateDay(String graduateDay) {
		this.graduateDay = graduateDay;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	public int getAbsenceCnt() {
		return absenceCnt;
	}
	public void setAbsenceCnt(int absenceCnt) {
		this.absenceCnt = absenceCnt;
	}
	public int getGraduateok() {
		return graduateok;
	}
	public void setGraduateok(int graduateok) {
		this.graduateok = graduateok;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


}
