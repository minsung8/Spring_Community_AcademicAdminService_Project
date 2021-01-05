package com.project.skyuniversity.ash.model;

public class CommuMemberVO {
	private int commuMemberNo;
	private int fk_memberNo;
	private int fk_levelNo;
	private String nickname;
	private int point;
	
	//////////////////////////////
	// select 용 field 값 설정 하기 //
	private String name;
	private String email;
	private CommuMemberLevelVO levelvo;
	
	
	////////////////////////////
	public CommuMemberVO() {}

	public CommuMemberVO(int commuMemberNo, int fk_memberNo, int fk_levelNo, String nickname, int point) {
		super();
		this.commuMemberNo = commuMemberNo;
		this.fk_memberNo = fk_memberNo;
		this.fk_levelNo = fk_levelNo;
		this.nickname = nickname;
		this.point = point;
	}

	public int getCommuMemberNo() {
		return commuMemberNo;
	}

	public void setCommuMemberNo(int commuMemberNo) {
		this.commuMemberNo = commuMemberNo;
	}

	public int getFk_memberNo() {
		return fk_memberNo;
	}

	public void setFk_memberNo(int fk_memberNo) {
		this.fk_memberNo = fk_memberNo;
	}

	public int getFk_levelNo() {
		return fk_levelNo;
	}

	public void setFk_levelNo(int fk_levelNo) {
		this.fk_levelNo = fk_levelNo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public CommuMemberLevelVO getLevelvo() {
		return levelvo;
	}

	public void setLevelvo(CommuMemberLevelVO levelvo) {
		this.levelvo = levelvo;
	}

	
	
	
}
