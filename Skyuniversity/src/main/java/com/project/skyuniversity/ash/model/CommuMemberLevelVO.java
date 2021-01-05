package com.project.skyuniversity.ash.model;

public class CommuMemberLevelVO {
	private int levelNo;
	private String levelName;
	private int levelPoint;
	private String levelImg;
	
	public CommuMemberLevelVO() {}

	public CommuMemberLevelVO(int levelNo, String levelName, int levelPoint, String levelImg) {
		super();
		this.levelNo = levelNo;
		this.levelName = levelName;
		this.levelPoint = levelPoint;
		this.levelImg = levelImg;
	}

	public int getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(int levelNo) {
		this.levelNo = levelNo;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public int getLevelPoint() {
		return levelPoint;
	}

	public void setLevelPoint(int levelPoint) {
		this.levelPoint = levelPoint;
	}

	public String getLevelImg() {
		return levelImg;
	}

	public void setLevelImg(String levelImg) {
		this.levelImg = levelImg;
	}
	
	
	
}
