package com.project.skyuniversity.eunji.model;

public class GraduateDelayVO {

	 private int delayNo;      
     private String regDate;     
     private String reason;      
     private String startSem;   
     private String endSem;      
     private String approve;    
     private String approveDate; 
     private String noreason;    
     private int fk_memberno;
     
	public int getDelayNo() {
		return delayNo;
	}
	public void setDelayNo(int delayNo) {
		this.delayNo = delayNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getStartSem() {
		return startSem;
	}
	public void setStartSem(String startSem) {
		this.startSem = startSem;
	}
	public String getEndSem() {
		return endSem;
	}
	public void setEndSem(String endSem) {
		this.endSem = endSem;
	}
	public String getApprove() {
		return approve;
	}
	public void setApprove(String approve) {
		this.approve = approve;
	}
	public String getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}
	public String getNoreason() {
		return noreason;
	}
	public void setNoreason(String noreason) {
		this.noreason = noreason;
	}
	public int getFk_memberno() {
		return fk_memberno;
	}
	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}
     
     
}
