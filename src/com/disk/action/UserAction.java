package com.disk.action;

import java.io.IOException;

import org.apache.struts2.ServletActionContext;

import com.disk.dao.UserDAO;
import com.disk.entity.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private String name ;
	private String pwd ;
	private UserDAO userDAO = new UserDAO();
	
	/**
	 * 重新设置密码
	 * @return
	 */
	public String resetpwd(){
		return null ;
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	public String invalidate(){
		ActionContext.getContext().getSession().put("loginUser", null);
		try {
			ServletActionContext.getResponse().sendRedirect("login.html");
		} catch (IOException e) {
		}
		return null ;
	}
	
	/**
	 * 验证用户名是否被注册过
	 */
	public String validateUserName(){
		boolean flag = userDAO.validate(name);
		try {
			ServletActionContext.getResponse().getWriter().print(flag);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	/**
	 * 用户注册
	 * @return
	 */
	public String register(){
		if( userDAO.create(name, pwd)){
			try {
				ServletActionContext.getResponse().sendRedirect("register_success.html");
			} catch (IOException e) {
			}
		}else{
		}
		return null ;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String login(){
		User u = userDAO.login(name, pwd);
		if( u != null ){
			ActionContext.getContext().getSession().put("loginUser", u);
			try {
				ServletActionContext.getResponse().sendRedirect("index.jsp");
			} catch (IOException e) {
			}
		}else{
			try {
				ServletActionContext.getResponse().sendRedirect("login_fail.html");
			} catch (IOException e) {
			}
		}
		return null ;
	}
}