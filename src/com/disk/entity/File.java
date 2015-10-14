package com.disk.entity;


/**
 * 文件实体
 * @author xiongxiao
 *
 */
public class File {
	private String fileName ;//文件名称
	private String id ;
	private String parentId ; //所属文件夹id
	private int type ;//文件类型
	private String uId ;//所属用户
	private java.util.Date updateTime ;//更新时间
	
	public String getFileName() {
		return fileName;
	}
	public String getId() {
		return id;
	}
	public String getParentId() {
		return parentId;
	}
	public int getType() {
		return type;
	}
	public String getuId() {
		return uId;
	}
	public java.util.Date getUpdateTime() {
		return updateTime;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public void setType(int type) {
		this.type = type;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}
}