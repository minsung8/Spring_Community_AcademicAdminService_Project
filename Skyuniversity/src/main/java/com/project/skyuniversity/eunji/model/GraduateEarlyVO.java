package com.project.skyuniversity.eunji.model;

public class GraduateEarlyVO {

	private int earlyNo;    
    private String regDate; 
    private int sumCredit;  
    private int sumSem;     
    private String avgGrade;    
    private String approve;     
    private String approveDate; 
    private String noreason;    
    private int fk_memberno;
	public int getEarlyNo() {
		return earlyNo;
	}
	public void setEarlyNo(int earlyNo) {
		this.earlyNo = earlyNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getSumCredit() {
		return sumCredit;
	}
	public void setSumCredit(int sumCredit) {
		this.sumCredit = sumCredit;
	}
	public int getSumSem() {
		return sumSem;
	}
	public void setSumSem(int sumSem) {
		this.sumSem = sumSem;
	}
	public String getAvgGrade() {
		return avgGrade;
	}
	public void setAvgGrade(String avgGrade) {
		this.avgGrade = avgGrade;
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
