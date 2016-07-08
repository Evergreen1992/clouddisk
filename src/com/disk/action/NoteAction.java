package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.disk.dao.NoteDAO;
import com.disk.entity.Note;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Results({@Result(name = "list", location = "notebook.jsp")})
public class NoteAction extends ActionSupport implements ModelDriven<Note>{
	private static final long serialVersionUID = 1L;
	private Note entity = new Note();
	private NoteDAO dao = new NoteDAO();
	private List<Note> data = new ArrayList<Note>();
	
	public String get(){
		this.entity = this.dao.getNote(entity.getId());
		ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
		String s = "";
		s += "{";
		s += "title:'" + entity.getTitle() + "',";
		s += "content:'" + entity.getContent() + "'";
		s += "}";
		this.getWriter().print(s);
		return null ;
	}
	
	public List<Note> getData() {
		return data;
	}

	public void setData(List<Note> data) {
		this.data = data;
	}

	public String create(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
		entity.setUid(u.getId());
		entity.setId(IDUtil.generateId());
		if( dao.create(entity)){
			this.getWriter().print("true");
		}else{
			this.getWriter().print("false");
		}
		return null ;
	}
	
	public String list(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		StringBuffer sb = new StringBuffer();
		data = this.dao.list(u.getId());
		for(Note item : data){
			if( item.getTitle().length() > 10){
				item.setTitle(item.getTitle().substring(0, 9) + "...");
			}
		}
		try {
			ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
			ServletActionContext.getResponse().getWriter().print(sb.toString());
		} catch (IOException e) {
			
		}
		return "list" ;
	}
	
	public Note getEntity() {
		return entity;
	}

	public void setEntity(Note entity) {
		this.entity = entity;
	}

	@Override
	public Note getModel() {
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