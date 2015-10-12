package com.disk.entity;

import java.util.Date;

/**
 * 文件实体
 * @author xiongxiao
 *
 */
public class File {
	private int id ;
	private int fileName ;//文件名称
	private int type ;//文件类型
	private Date updateTime ;//更新时间
	private int userId ;//所属用户
	
	public int getFileName() {
		return fileName;
	}
	public int getId() {
		return id;
	}
	public int getType() {
		return type;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public int getUserId() {
		return userId;
	}
	public void setFileName(int fileName) {
		this.fileName = fileName;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setType(int type) {
		this.type = type;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
}