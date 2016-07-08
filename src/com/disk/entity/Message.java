package com.disk.entity;

import java.util.Date;

/**
 * 站内信信息
 * @author Administrator
 *
 */
public class Message {
	private String id ;
	private String uId ;
	private String toUid;
	private Date time ;
	private String content ;
	
	private String timeStr ;
	
	public String getTimeStr() {
		return timeStr;
	}
	public void setTimeStr(String timeStr) {
		this.timeStr = timeStr;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getToUid() {
		return toUid;
	}
	public void setToUid(String toUid) {
		this.toUid = toUid;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}