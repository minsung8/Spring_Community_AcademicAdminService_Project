package com.project.skyuniversity.eunji.model;

import org.springframework.web.multipart.MultipartFile;

public class OfficialLeaveVO {
	
	private int leaveNo;
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String reason;
	private String approve;
	private String noReason;
	private String approveDate;
	private String fileName;
	private String orgFileName;
	private String fileSize;
	private String regdate;
	private int fk_memberNo;
	
	private MultipartFile attach;
	
	public int getLeaveNo() {
		return leaveNo;
	}
	public void setLeaveNo(int leaveNo) {
		this.leaveNo = leaveNo;
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
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getApprove() {
		return approve;
	}
	public void setApprove(String approve) {
		this.approve = approve;
	}
	public String getNoReason() {
		return noReason;
	}
	public void setNoReason(String noReason) {
		this.noReason = noReason;
	}
	public String getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public int getFk_memberNo() {
		return fk_memberNo;
	}
	public void setFk_memberNo(int fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
