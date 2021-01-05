package com.project.skyuniversity.minsung.model;


public class MinsungCommuMemberVO {
	
	private int commuMemberNo;
	private int fk_memberNo;
	private int fk_levelNo;
	private String nickName;
	private int point;
	
	public MinsungCommuMemberVO() {};
	
	public MinsungCommuMemberVO(int commuMemberNo, int fk_memberNo, int fk_levelNo, String nickName, int point) {
		super();
		this.commuMemberNo = commuMemberNo;
		this.fk_memberNo = fk_memberNo;
		this.fk_levelNo = fk_levelNo;
		this.nickName = nickName;
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

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}
	
	

}
