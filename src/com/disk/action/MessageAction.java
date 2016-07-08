package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.MessageDAO;
import com.disk.entity.Message;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class MessageAction extends ActionSupport implements ModelDriven<Message>{
	private static final long serialVersionUID = 1L;
	private Message entity = new Message();
	private MessageDAO dao = new MessageDAO();
	
	public String create(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		entity.setuId(loginUser.getId());
		entity.setId(IDUtil.generateId());
		this.getWriter().print(dao.create(entity));
		return null ;
	}
	
	public String list(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		List<Message> data = dao.list(entity.getToUid() , loginUser.getId()) ;
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(Message item : data){
			sb.append("{");
			sb.append("id:'" + item.getId() + "',");
			sb.append("date:'" + item.getTimeStr() + "',");
			sb.append("content:'" + item.getContent() + "'");
			sb.append("},");
		}
		if( data.size() > 0)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		try {
			ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
			ServletActionContext.getResponse().getWriter().print(sb.toString());
		} catch (IOException e) {
			
		}
		return null ;
	}
	
	public Message getEntity() {
		return entity;
	}
	public void setEntity(Message entity) {
		this.entity = entity;
	}
	@Override
	public Message getModel() {
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