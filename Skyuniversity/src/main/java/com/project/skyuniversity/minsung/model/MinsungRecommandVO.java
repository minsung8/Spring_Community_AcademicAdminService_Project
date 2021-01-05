package com.project.skyuniversity.minsung.model;

public class MinsungRecommandVO {
	
	private String fk_boardKindNo;
	private String fk_boardNo;
	private String fk_memberNo;
	
	public MinsungRecommandVO(String fk_boardKindNo, String fk_boardNo, String fk_memberNo) {
		super();
		this.fk_boardKindNo = fk_boardKindNo;
		this.fk_boardNo = fk_boardNo;
		this.fk_memberNo = fk_memberNo;
	}

	public String getFk_boardKindNo() {
		return fk_boardKindNo;
	}

	public void setFk_boardKindNo(String fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
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
	
}
