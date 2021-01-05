package com.project.skyuniversity.ohyoon.model;

public class CategoryVO {

	private String categoryNo;		// 카테고리 번호
	private String fk_boardKindNo;  // 게시판 번호
	private String categoryName;	// 카테고리 이름
	
	public CategoryVO() {}

	public CategoryVO(String categoryNo, String fk_boardKindNo, String categoryName) {
		super();
		this.categoryNo = categoryNo;
		this.fk_boardKindNo = fk_boardKindNo;
		this.categoryName = categoryName;
	}

	public String getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getFk_boardKindNo() {
		return fk_boardKindNo;
	}

	public void setFk_boardKindNo(String fk_boardKindNo) {
		this.fk_boardKindNo = fk_boardKindNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
	
	
}
