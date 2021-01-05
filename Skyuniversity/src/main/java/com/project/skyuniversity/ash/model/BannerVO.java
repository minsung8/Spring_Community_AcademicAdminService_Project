package com.project.skyuniversity.ash.model;

public class BannerVO {
	private String ino;
	private String iname;
	private String ilink;
	private int status;
	
	public BannerVO() {
		// TODO Auto-generated constructor stub
	}
	
	

	public BannerVO(String ino, String iname, String ilink, int status) {
		super();
		this.ino = ino;
		this.iname = iname;
		this.ilink = ilink;
		this.status = status;
	}



	public String getIno() {
		return ino;
	}

	public void setIno(String ino) {
		this.ino = ino;
	}

	public String getIname() {
		return iname;
	}

	public void setIname(String iname) {
		this.iname = iname;
	}

	public String getIlink() {
		return ilink;
	}

	public void setIlink(String ilink) {
		this.ilink = ilink;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
