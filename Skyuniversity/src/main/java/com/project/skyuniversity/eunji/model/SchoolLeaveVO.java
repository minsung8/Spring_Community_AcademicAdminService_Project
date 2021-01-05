package com.project.skyuniversity.eunji.model;

import org.springframework.web.multipart.MultipartFile;

public class SchoolLeaveVO {
	private int schoolLvNo;
	private int armyNo;
	private String armyType;
	private String armyStartDate;
	private String armyEndDate;
	private String startSemester;
	private String endSemester;
	private String filename;
	private String orgfilename;
	private int filesize;
	private String regdate;
	private String approve;
	private String noreason;
	private String reason;
	private String type;
	private String comeSemester;
	
	private int fk_memberNo;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getComeSemester() {
		return comeSemester;
	}

	public void setComeSemester(String comeSemester) {
		this.comeSemester = comeSemester;
	}

	private MultipartFile attach;

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public int getSchoolLvNo() {
		return schoolLvNo;
	}

	public void setSchoolLvNo(int schoolLvNo) {
		this.schoolLvNo = schoolLvNo;
	}

	public int getArmyNo() {
		return armyNo;
	}

	public void setArmyNo(int armyNo) {
		this.armyNo = armyNo;
	}

	public String getArmyType() {
		return armyType;
	}

	public void setArmyType(String armyType) {
		this.armyType = armyType;
	}

	public String getArmyStartDate() {
		return armyStartDate;
	}

	public void setArmyStartDate(String armyStartDate) {
		this.armyStartDate = armyStartDate;
	}

	public String getArmyEndDate() {
		return armyEndDate;
	}

	public void setArmyEndDate(String armyEndDate) {
		this.armyEndDate = armyEndDate;
	}

	public String getStartSemester() {
		return startSemester;
	}

	public void setStartSemester(String startSemester) {
		this.startSemester = startSemester;
	}

	public String getEndSemester() {
		return endSemester;
	}

	public void setEndSemester(String endSemester) {
		this.endSemester = endSemester;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getApprove() {
		return approve;
	}

	public void setApprove(String approve) {
		this.approve = approve;
	}

	public String getNoreason() {
		return noreason;
	}

	public void setNoreason(String noreason) {
		this.noreason = noreason;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getFk_memberNo() {
		return fk_memberNo;
	}

	public void setFk_memberNo(int fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}

}
