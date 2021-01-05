package com.project.skyuniversity.ohyoon.model;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private String boardNo;			// 게시글 번호
	private String fk_boardKindNo;  // 게시판 번호
	private String fk_memberNo;		// 작성회원번호
	private String fk_nickname;		// 작성자 닉네임
	private String fk_categoryNo;	// 카테고리번호
	private String fk_categoryName;	// 카테고리이름
	private String password;		// 작성글 비밀번호
	private String subject;			// 글 제목
	private String regDate;			// 등록일자
	private String editDate;		// 수정일자
	private String content;			// 글 내용
	private String readCount;		// 조회수
	private String status;			// 게시글 상태
	private String writerIp;		// 작성자 ip
	private String fileName;		// 첨부파일 저장이름
	private String orgFilename;		// 첨부파일 원본이름
	private String fileSize;		// 첨부파일 사이즈
	
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
       !!!!!! MultipartFile attach 는 오라클 데이터베이스 tblBoard 테이블의 컬럼이 아니다.!!!!!!  
       /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
               동일해야만 파일첨부가 가능해진다.!!!!
	*/
	
	///////////////////////////////////////////
	private String upCount;			// 추천수
	private String downCount;		// 비추천수
	private String reportCount;		// 신고수
	private String levelImg;		// 작성회원 레벨 이미지
	private String cmtCount;		// 댓글수
	
	
	public BoardVO() {}

	public BoardVO(String boardNo, String fk_boardKindNo, String fk_memberNo, String fk_nickname, String fk_categoryNo,
			String fk_categoryName, String subject, String regDate, String editDate, String content, String readCount,
			String status, String writerIp, String fileName, String orgFilename, String fileSize) {
		super();
		this.boardNo = boardNo;
		this.fk_boardKindNo = fk_boardKindNo;
		this.fk_memberNo = fk_memberNo;
		this.fk_nickname = fk_nickname;
		this.fk_categoryNo = fk_categoryNo;
		this.fk_categoryName = fk_categoryName;
		this.subject = subject;
		this.regDate = regDate;
		this.editDate = editDate;
		this.content = content;
		this.readCount = readCount;
		this.status = status;
		this.writerIp = writerIp;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}


	public String getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}


	public String getFk_boardKindNo() {
		return fk_boardKindNo;
	}


	public void setFk_boardKindNo(String fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
	}


	public String getFk_memberNo() {
		return fk_memberNo;
	}


	public void setFk_memberNo(String fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}

	
	public String getFk_categoryNo() {
		return fk_categoryNo;
	}

	
	public void setFk_categoryNo(String fk_categoryNo) {
		this.fk_categoryNo = fk_categoryNo;
	}

	
	public String getSubject() {
		return subject;
	}

	
	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getEditDate() {
		return editDate;
	}


	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getReadCount() {
		return readCount;
	}


	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getWriterIp() {
		return writerIp;
	}


	public void setWriterIp(String writerIp) {
		this.writerIp = writerIp;
	}


	public String getUpCount() {
		return upCount;
	}


	public void setUpCount(String upCount) {
		this.upCount = upCount;
	}


	public String getDownCount() {
		return downCount;
	}


	public void setDownCount(String downCount) {
		this.downCount = downCount;
	}


	public String getReportCount() {
		return reportCount;
	}


	public void setReportCount(String reportCount) {
		this.reportCount = reportCount;
	}

	public String getFk_nickname() {
		return fk_nickname;
	}

	public void setFk_nickname(String fk_nickname) {
		this.fk_nickname = fk_nickname;
	}

	public String getFk_categoryName() {
		return fk_categoryName;
	}

	public void setFk_categoryName(String fk_categoryName) {
		this.fk_categoryName = fk_categoryName;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getOrgFilename() {
		return orgFilename;
	}


	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}


	public String getFileSize() {
		return fileSize;
	}


	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getLevelImg() {
		return levelImg;
	}

	public void setLevelImg(String levelImg) {
		this.levelImg = levelImg;
	}

	public String getCmtCount() {
		return cmtCount;
	}

	public void setCmtCount(String cmtCount) {
		this.cmtCount = cmtCount;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
	
}
