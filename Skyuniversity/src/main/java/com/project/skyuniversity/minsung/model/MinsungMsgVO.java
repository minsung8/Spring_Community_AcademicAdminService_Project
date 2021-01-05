package com.project.skyuniversity.minsung.model;

public class MinsungMsgVO {
	
	private String msgNo;
	private String fromMemberNo;
	private String toMemberNo;
	private String subject;
	private String content;
	private String sendDate;
	
	private String fromNickName;
	private String toNickName;
	
	public MinsungMsgVO() {}

	public MinsungMsgVO(String msgNo, String fromMemberNo, String toMemberNo, String subject, String content,
			String sendDate, String fromNickName, String toNickName) {
		super();
		this.msgNo = msgNo;
		this.fromMemberNo = fromMemberNo;
		this.toMemberNo = toMemberNo;
		this.subject = subject;
		this.content = content;
		this.sendDate = sendDate;
		this.fromNickName = fromNickName;
		this.toNickName = toNickName;
	}

	public String getMsgNo() {
		return msgNo;
	}

	public void setMsgNo(String msgNo) {
		this.msgNo = msgNo;
	}

	public String getFromMemberNo() {
		return fromMemberNo;
	}

	public void setFromMemberNo(String fromMemberNo) {
		this.fromMemberNo = fromMemberNo;
	}

	public String getToMemberNo() {
		return toMemberNo;
	}

	public void setToMemberNo(String toMemberNo) {
		this.toMemberNo = toMemberNo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

	public String getFromNickName() {
		return fromNickName;
	}

	public void setFromNickName(String fromNickName) {
		this.fromNickName = fromNickName;
	}

	public String getToNickName() {
		return toNickName;
	}

	public void setToNickName(String toNickName) {
		this.toNickName = toNickName;
	}
	
}
