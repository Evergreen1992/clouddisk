package com.disk.action;

import com.disk.entity.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport{
	private static final long serialVersionUID = 1L;

	public String login(){
		User u = new User();
		u.setId("1");
		u.setName("xx");
		
		ActionContext.getContext().getSession().put("loginUser", u);
		
		return null ;
	}
}