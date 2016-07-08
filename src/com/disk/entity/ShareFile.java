package com.disk.entity;

import java.util.Date;

/**
 * 共享文件
 * @author Administrator
 *
 */
public class ShareFile {
	private String id ;
	private String fromUser ;//分享人
	private String fileId ;//文件id
	private int type ;//分享类型    0:public    1:加密分享
	private int score ;//文件评分
	private String pwd ;//提取密码
	private String shareUrlId ;//共享地址id
	private Date date ;//分享时间
	private int viewcount ;//浏览量
	
	private String shareUserName ;//共享者姓名
	
	private String fileType ;//文件类型
	private String fileName ;//文件名
	private int likes ;//赞
	private int dislikes ;//踩
	
	public int getViewcount() {
		return viewcount;
	}
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getDislikes() {
		return dislikes;
	}
	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
	}
	
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getShareUserName() {
		return shareUserName;
	}
	public void setShareUserName(String shareUserName) {
		this.shareUserName = shareUserName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date shareTime) {
		this.date = shareTime;
	}
	public String getShareUrlId() {
		return shareUrlId;
	}
	public void setShareUrlId(String shareUrlId) {
		this.shareUrlId = shareUrlId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}