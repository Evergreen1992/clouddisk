package com.disk.entity;

/**
 * 用户
 * @author xiongxiao
 *
 */
public class User {
	private String id ;
	private String name ;
	private String passwd ;
	private String mail ;
	
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
}