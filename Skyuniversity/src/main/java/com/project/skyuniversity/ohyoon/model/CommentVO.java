package com.project.skyuniversity.ohyoon.model;

public class CommentVO {

	private String commentNo;		// 댓글 번호
	private String fk_boardNo;  	// 게시글 번호
	private String fk_memberNo;		// 작성회원번호
	private String password;		// 댓글 비밀번호
	private String cmtContent;		// 댓글 내용
	private String regDate;			// 등록일자
	private String status;			// 게시글 상태
	private String writerIp;		// 작성자 ip
	
	
	///////////////////////////////////////////
	private String fk_nickname;		// 작성회원닉네임
	private String fk_boardKindNo;  // 게시판 번호
	private String cmtUpCount;		// 추천수
	private String cmtDownCount;	// 비추천수
	private String reportCount;		// 신고수
	private String levelImg;		// 작성회원 레벨 이미지
	private String totalCount;		// 같은 게시물에 존재하는 댓글의 총개수
	
	
	public CommentVO() {}


	public CommentVO(String commentNo, String fk_boardNo, String fk_memberNo, String cmtContent, String regDate,
			String status, String writerIp) {
		super();
		this.commentNo = commentNo;
		this.fk_boardNo = fk_boardNo;
		this.fk_memberNo = fk_memberNo;
		this.cmtContent = cmtContent;
		this.regDate = regDate;
		this.status = status;
		this.writerIp = writerIp;
	}


	public String getCommentNo() {
		return commentNo;
	}


	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

	
	public String getFk_boardNo() {
		return fk_boardNo;
	}


	public void setFk_boardNo(String fk_boardNo) {
		this.fk_boardNo = fk_boardNo;
	}


	public String getFk_memberNo() {
		return fk_memberNo;
	}


	public void setFk_memberNo(String fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}


	public String getCmtContent() {
		return cmtContent;
	}


	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
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


	public String getFk_nickname() {
		return fk_nickname;
	}


	public void setFk_nickname(String fk_nickname) {
		this.fk_nickname = fk_nickname;
	}


	public String getFk_boardKindNo() {
		return fk_boardKindNo;
	}


	public void setFk_boardKindNo(String fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
	}


	public String getCmtUpCount() {
		return cmtUpCount;
	}


	public void setCmtUpCount(String cmtUpCount) {
		this.cmtUpCount = cmtUpCount;
	}


	public String getCmtDownCount() {
		return cmtDownCount;
	}


	public void setCmtDownCount(String cmtDownCount) {
		this.cmtDownCount = cmtDownCount;
	}


	public String getReportCount() {
		return reportCount;
	}


	public void setReportCount(String reportCount) {
		this.reportCount = reportCount;
	}


	public String getLevelImg() {
		return levelImg;
	}


	public void setLevelImg(String levelImg) {
		this.levelImg = levelImg;
	}


	public String getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
	
	
	
	
	
}
