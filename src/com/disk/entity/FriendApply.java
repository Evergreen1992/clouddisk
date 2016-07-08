package com.disk.entity;
/**
 * 好友申请
 * @author Administrator
 *
 */
public class FriendApply {
	private String id ;
	private String fromUid ;
	private String toUid ;
	private String name ;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFromUid() {
		return fromUid;
	}
	public void setFromUid(String fromUid) {
		this.fromUid = fromUid;
	}
	public String getToUid() {
		return toUid;
	}
	public void setToUid(String toUid) {
		this.toUid = toUid;
	}
}