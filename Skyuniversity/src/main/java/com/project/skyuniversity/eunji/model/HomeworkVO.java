package com.project.skyuniversity.eunji.model;

public class HomeworkVO {
	
	private int workNo;              
	private String subject;  
	private String subjectName;
	private String contents;         
	private String startDate;        
	private String endDate;          
	private String fk_subjectNo;
	
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public int getWorkNo() {
		return workNo;
	}
	public void setWorkNo(int workNo) {
		this.workNo = workNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
	public String getFk_subjectNo() {
		return fk_subjectNo;
	}
	public void setFk_subjectNo(String fk_subjectNo) {
		this.fk_subjectNo = fk_subjectNo;
	}
}
