package com.disk.entity;

import java.util.Date;

/**
 * 说说。动态
 * @author Administrator
 *
 */
public class Shuoshuo {
	private String id ;
	private String userid;
	private String content ;
	private Date date ;
	private int type ;//0:公开    1:私密
	private int likes ;//点赞个数
	
	private String username ;
	private String timestr ;
	
	public String getTimestr() {
		return timestr;
	}
	public void setTimestr(String timestr) {
		this.timestr = timestr;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
}