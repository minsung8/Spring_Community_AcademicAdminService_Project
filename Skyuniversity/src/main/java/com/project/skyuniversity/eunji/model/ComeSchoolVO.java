package com.project.skyuniversity.eunji.model;

import org.springframework.web.multipart.MultipartFile;

public class ComeSchoolVO {
	private int comeSeq;
	private String comeSemester;
	private String regDate;
	private String type;
	private String noReason;
	private String approve;
	private String approveDate;
	private String fileName;
	private String orgFileName;
	private int fileSize;
	private int fk_Memberno;

	private MultipartFile attach;
	
	

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getNoReason() {
		return noReason;
	}

	public void setNoReason(String noReason) {
		this.noReason = noReason;
	}

	public int getComeSeq() {
		return comeSeq;
	}

	public void setComeSeq(int comeSeq) {
		this.comeSeq = comeSeq;
	}

	public String getComeSemester() {
		return comeSemester;
	}

	public void setComeSemester(String comeSemester) {
		this.comeSemester = comeSemester;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public int getFk_Memberno() {
		return fk_Memberno;
	}

	public void setFk_Memberno(int fk_Memberno) {
		this.fk_Memberno = fk_Memberno;
	}

}
