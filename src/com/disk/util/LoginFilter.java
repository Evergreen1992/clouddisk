package com.disk.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import com.disk.entity.User;

public class LoginFilter implements Filter{

	public void destroy() {
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		
		User u = (User)request.getSession().getAttribute("loginUser");
		if( u == null ){
			//System.out.println("未登录!");
			//request.getRequestDispatcher("login.jsp").forward(arg0, arg1);
			u = new User();
			u.setId("1");
			u.setName("xx");
			request.getSession().setAttribute("loginUser", u);
		}else{
			 
		}
		
		chain.doFilter(arg0, arg1);
	}

	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("loginFilter 初始化!");
	}

}
