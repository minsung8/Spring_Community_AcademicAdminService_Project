package com.project.skyuniversity.eunji.model;

public class GirlOfficialLeaveVO {
	private int girlLeaveNo;
	private String startTime;
	private String endTime;
	private String startDate;
	private String endDate;
	private String approveDate;
	private String approve;
	private String noreason;
	private String regDate;
	private int fk_memberno;

	public int getGirlLeaveNo() {
		return girlLeaveNo;
	}

	public void setGirlLeaveNo(int girlLeaveNo) {
		this.girlLeaveNo = girlLeaveNo;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getFk_memberno() {
		return fk_memberno;
	}

	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}

}
