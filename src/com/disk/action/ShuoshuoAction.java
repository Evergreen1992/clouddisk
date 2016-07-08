package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.ShuoshuoDAO;
import com.disk.entity.Shuoshuo;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ShuoshuoAction extends ActionSupport implements ModelDriven<Shuoshuo>{
	private static final long serialVersionUID = 1L;
	private Shuoshuo entity = new Shuoshuo();
	private ShuoshuoDAO dao = new ShuoshuoDAO();
	
	public String zan(){
		if( dao.zan(entity.getId())){
			this.getWriter().print("true");
		}else{
			this.getWriter().print("false");
		}
		return null ;
	}
	
	public String list(){
		List<Shuoshuo> data = new ArrayList<Shuoshuo>();
		StringBuffer sb = new StringBuffer();
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		data = dao.list(loginUser.getId());
		sb.append("[");
		for(Shuoshuo item : data){
			sb.append("{");
			sb.append("id:'" + item.getId() + "',");
			sb.append("username:'" + item.getUsername() + "',");
			sb.append("content:'" + item.getContent() + "',");
			sb.append("date:'" + item.getTimestr() + "',");
			sb.append("type:'" + item.getType() + "',");
			sb.append("likes:'" + item.getLikes() + "' ");
			sb.append("},");
		}
		if(data.size() > 1)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/xml;charset=UTF-8");
		this.getWriter().print(sb.toString());
		return null ;
	}
	
	public String create(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		entity.setId(IDUtil.generateId());
		entity.setUserid(loginUser.getId());
		if( dao.create(entity)){
			this.getWriter().print("true");
		}else{
			this.getWriter().print("false");
		}
		return null ;
	}
	
	@Override
	public Shuoshuo getModel() {
		return entity;
	}
	
	public PrintWriter getWriter(){
		try {
			return ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			return null ;
		}
	}
}