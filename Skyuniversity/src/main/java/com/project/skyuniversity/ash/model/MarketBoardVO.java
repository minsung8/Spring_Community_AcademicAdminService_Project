package com.project.skyuniversity.ash.model;

import org.springframework.web.multipart.MultipartFile;

public class MarketBoardVO {
	private int boardNo;         	// 시퀀스 고유넘버
	private int fk_boardKindNo;  	// tbl_boardkind 참조!
	private int fk_commuMemberNo;  	 	// 유저넘버 (현재는 101, 102)
	private int categoryNo;  	 	// 삽니다: 1 , 팝니다: 2,  무료나눔: 3,  거래완료: 4
	private String subject;  	 	// 글제목
	private String regDate;  	 	// 등록일자
	private String editDate;  	 	// 글 수정 일자
	private String content;  	 	// 글 내용(null이 가능한 이유는 사진만 올리는 경우가 있기 때문에!)
	private String readCount;    	// 조회수 디폴트는 0
	private int status;  		 	// 글상태 0 - 비활성화,  1 - 활성화 2 - 
	private String writerIp;  	 	// 작성자 아이피주소
	private String price;  		 	// 다른게시판과 다르게 가격정보 무료나눔이 있으므로 0도 가능
	private String fileName; 		// WAS(톰캣)에 저장될 파일명(20201208092715353243254235235234.png)
	private String orgFileName; 	// 진짜 파일명(강아지.png) 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize; 		// 파일크기
	
	
	///////////////////////////////////////////////////////////////
	private MultipartFile attach; // 첨부파일입니당~
	
	
	private String previousseq;  	// 이전글번호
	private String previoussubject; // 이전글제목
	private String nextseq; 		// 다음글번호
	private String nextsubject; 	// 다음글제목
	
	private String categoryName;
	private String commuMemberNo;
	private String fk_memberNo;
	private String fk_levelNo;
	private String nickname;
	private String point;
	private String levelNo;
	private String levelName;
	private String levelPoint;
	private String levelImg;
	private String boardKindNo;
	private String boardTypeNo;
	private String boardName;
	private String upCount;
	private String fk_categoryNo;
	private String cmtCount;      // 댓글수
	
	
	
	
	public String getCmtCount() {
		return cmtCount;
	}

	public void setCmtCount(String cmtCount) {
		this.cmtCount = cmtCount;
	}

	public MarketBoardVO() {}

	public MarketBoardVO(int boardNo, int fk_boardKindNo, int fk_commuMemberNo, int categoryNo, String subject,
			String regDate, String editDate, String content, String readCount, int status, String writerIp,
			String price, String fileName, String orgFileName, String fileSize) {
		super();
		this.boardNo = boardNo;
		this.fk_boardKindNo = fk_boardKindNo;
		this.fk_commuMemberNo = fk_commuMemberNo;
		this.categoryNo = categoryNo;
		this.subject = subject;
		this.regDate = regDate;
		this.editDate = editDate;
		this.content = content;
		this.readCount = readCount;
		this.status = status;
		this.writerIp = writerIp;
		this.price = price;
		this.fileName = fileName;
		this.orgFileName = orgFileName;
		this.fileSize = fileSize;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getFk_boardKindNo() {
		return fk_boardKindNo;
	}

	public void setFk_boardKindNo(int fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
	}

	public int getFk_commuMemberNo() {
		return fk_commuMemberNo;
	}

	public void setFk_commuMemberNo(int fk_commuMemberNo) {
		this.fk_commuMemberNo = fk_commuMemberNo;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
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

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
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

	public String getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(String levelNo) {
		this.levelNo = levelNo;
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

	public String getBoardKindNo() {
		return boardKindNo;
	}

	public void setBoardKindNo(String boardKindNo) {
		this.boardKindNo = boardKindNo;
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

	public String getFk_memberNo() {
		return fk_memberNo;
	}

	public void setFk_memberNo(String fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}

	public String getUpCount() {
		return upCount;
	}

	public void setUpCount(String upCount) {
		this.upCount = upCount;
	}

	public String getFk_categoryNo() {
		return fk_categoryNo;
	}

	public void setFk_categoryNo(String fk_categoryNo) {
		this.fk_categoryNo = fk_categoryNo;
	}
	
	
	
	
	
	
}
