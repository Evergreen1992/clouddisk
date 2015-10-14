package com.disk.entity;

import java.util.Date;

/**
 * 文件实体
 * @author xiongxiao
 *
 */
public class File {
	private int id ;
	private String fileName ;//文件名称
	private int type ;//文件类型
	private Date updateTime ;//更新时间
	private int uId ;//所属用户
	private int parentId ; //所属文件夹id
	
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getFileName() {
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
	public int getUId() {
		return uId;
	}
	public void setFileName(String fileName) {
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
	public void setUId(int userId) {
		this.uId = userId;
	}
}