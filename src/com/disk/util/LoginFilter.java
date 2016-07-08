package com.disk.util;

import java.io.File;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.disk.entity.User;

public class LoginFilter implements Filter{

	public void destroy() {
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		HttpServletResponse response = (HttpServletResponse)arg1;
		String url = request.getRequestURI();
		response.setContentType("text/xml;charset=UTF-8");
		if( url.contains("login") == false 
			&& url.contains("register.html") == false 
		    && url.contains("register_success.html") == false 
		    && url.contains("login_fail.html") == false 
			&& url.contains("newpasswd.jsp") == false
			&& url.contains(".css") == false
			&& url.contains(".ico") == false
			&& url.contains(".png") == false
			&& url.contains(".jpg") == false){//登录页面，不拦截
			
			User u = (User)request.getSession().getAttribute("loginUser");
			if( u == null ){
				response.sendRedirect("login.html");
			}else{
				chain.doFilter(arg0, arg1);
			}
		}else{
			chain.doFilter(arg0, arg1);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("loginFilter 初始化!");
		
		File file = new File("e://fileupload");
		if( file.exists()){
			System.out.println("文件夹e://fileupload存在");
		}else{
			System.out.println("文件夹e://fileupload不存在，创建");
			if(file.mkdirs()){
				System.out.println("创建成功!");
			}
		}
	}
}