package com.disk.entity;

import java.text.SimpleDateFormat;

/**
 * 文件实体
 * @author xiongxiao
 *
 */
public class File {
	private SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	private String fileName ;//文件名称
	private String id ;
	private String parentId ; //所属文件夹id
	private int type ;//文件类型(1:普通文件　　２:文件夹)
	private String uId ;//所属用户
	private java.util.Date updateTime ;//更新时间
	private String ext ;//文件后缀名(.txt  .pdf   .doc等等)
	private String size ;//文件大小
	
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
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
	public String getUpdateTime() {
		if( this.updateTime == null )
			return "";
		else
			return formater.format(updateTime);
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