package com.project.skyuniversity.ash.model;

public class NoticeVO {
	private int noticeNo;
	private int fk_boardKindNo;
	private int fk_memberNo;
	private int fk_categoryNo;
	private String subject;
	private String regDate;
	private String content;
	private int readCount;
	private int status;
	private String writerIp;
	//////////////////////////////////////////////////////////////////
	
	
	private String categoryName;
	private String commuMemberNo;
	private String fk_levelNo;
	private String nickname;
	private String point;
	private String levelName;
	private String levelPoint;
	private String levelImg;
	private String boardTypeNo;
	private String boardName;
	private String upCount;
	
	private String cmtCount;      // 댓글수
	
	
	
	
	
	public NoticeVO() {
		// TODO Auto-generated constructor stub
	}


	public NoticeVO(int noticeNo, int fk_boardKindNo, int fk_memberNo, int fk_categoryNo, String subject, String regDate,
			String content, int readCount, int status, String writerIp) {
		super();
		this.noticeNo = noticeNo;
		this.fk_boardKindNo = fk_boardKindNo;
		this.fk_memberNo = fk_memberNo;
		this.fk_categoryNo = fk_categoryNo;
		this.subject = subject;
		this.regDate = regDate;
		this.content = content;
		this.readCount = readCount;
		this.status = status;
		this.writerIp = writerIp;
	}


	public int getNoticeNo() {
		return noticeNo;
	}


	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}


	public int getFk_boardKindNo() {
		return fk_boardKindNo;
	}


	public void setFk_boardKindNo(int fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
	}


	public int getFk_memberNo() {
		return fk_memberNo;
	}


	public void setFk_memberNo(int fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}


	public int getFk_categoryNo() {
		return fk_categoryNo;
	}


	public void setFk_categoryNo(int fk_categoryNo) {
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


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getReadCount() {
		return readCount;
	}


	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public String getWriterIp() {
		return writerIp;
	}


	public void setWriterIp(String writerIp) {
		this.writerIp = writerIp;
	}


	public String getCategoryName() {
		return categoryName;
	}


	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}


	public String getCommuMemberNo() {
		return commuMemberNo;
	}


	public void setCommuMemberNo(String commuMemberNo) {
		this.commuMemberNo = commuMemberNo;
	}


	public String getFk_levelNo() {
		return fk_levelNo;
	}


	public void setFk_levelNo(String fk_levelNo) {
		this.fk_levelNo = fk_levelNo;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public String getPoint() {
		return point;
	}


	public void setPoint(String point) {
		this.point = point;
	}


	public String getLevelName() {
		return levelName;
	}


	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}


	public String getLevelPoint() {
		return levelPoint;
	}


	public void setLevelPoint(String levelPoint) {
		this.levelPoint = levelPoint;
	}


	public String getLevelImg() {
		return levelImg;
	}


	public void setLevelImg(String levelImg) {
		this.levelImg = levelImg;
	}


	public String getBoardTypeNo() {
		return boardTypeNo;
	}


	public void setBoardTypeNo(String boardTypeNo) {
		this.boardTypeNo = boardTypeNo;
	}


	public String getBoardName() {
		return boardName;
	}


	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}


	public String getUpCount() {
		return upCount;
	}


	public void setUpCount(String upCount) {
		this.upCount = upCount;
	}


	public String getCmtCount() {
		return cmtCount;
	}


	public void setCmtCount(String cmtCount) {
		this.cmtCount = cmtCount;
	}
	
	
}
