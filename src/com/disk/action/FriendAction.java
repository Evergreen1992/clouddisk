package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.FriendDAO;
import com.disk.entity.FriendApply;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class FriendAction extends ActionSupport implements ModelDriven<FriendApply>{
	private static final long serialVersionUID = 1L;
	private String uname ;
	private FriendDAO dao = new FriendDAO();
	private FriendApply entity = new FriendApply();
	private String type ;
	
	public String sendapplybyid(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
		if( entity.getId().equals(u.getId())){
			this.getWriter().print("您不能添加自己为好友！");
		}else if(dao.friendApply(IDUtil.generateId(), u.getId(), entity.getId() )){
			this.getWriter().print("发送成功");
		}else{
			this.getWriter().print("发送失败！");
		}
		return null ;
	}
	
	//好友列表加载
	public String listFriend(){
		ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		List<User> list = dao.listFriend(u.getId());
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(User item : list){
			sb.append("{");
			sb.append("id:'" + item.getId() + "',");
			sb.append("name:'" + item.getName() + "'");			
			sb.append("},");
		}
		if(list.size() > 0)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		
		this.getWriter().print(sb.toString());
		return null ;
	}
	
	public String selection(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		if( type.equals("1")){//同意
			dao.deleteApply(entity.getId());
			//查看好友是否已经添加过
			if( dao.checkFriend(entity.getToUid(), u.getId()) == false){
				dao.addFriend(IDUtil.generateId(),  entity.getToUid(), u.getId());
			}
			if( dao.checkFriend(u.getId(), entity.getToUid()) == false){
				dao.addFriend(IDUtil.generateId(),  u.getId(), entity.getToUid());
			}
		}else if(type.equals("2")){//拒绝
			dao.deleteApply(entity.getId());
		}
		return null ;
	}
	
	/**
	 * 好友申请列表
	 * @return
	 */
	public String listapply(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		StringBuffer sb = new StringBuffer();
		List<FriendApply> list = dao.list(u.getId());
		sb.append("[");
		for(FriendApply item : list){
			sb.append("{");
			sb.append("userid:'" + item.getToUid() + "',");
			sb.append("id:'" + item.getId() + "',");
			sb.append("name:'" + item.getName() + "'");			
			sb.append("},");
		}
		if(list.size() > 0)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		
		this.getWriter().print(sb.toString());
		return null ;
	}
	
	public String sendApply(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
		String id = null ;
		if( u.getName().equals(uname)){
			this.getWriter().print("您不能添加自己为好友！");
		}else if( (id = dao.checkIfExists(uname)) == null){
			this.getWriter().print("该好友不存在！");
		}else if(dao.friendApply(IDUtil.generateId(), u.getId(), id )){
			this.getWriter().print("发送成功");
		}else{
			this.getWriter().print("发送失败！");
		}
		return null ;
	}
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	
	public PrintWriter getWriter(){
		try {
			return ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			return null ;
		}
	}

	@Override
	public FriendApply getModel() {
		return entity;
	}
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}