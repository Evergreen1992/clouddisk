package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.disk.dao.FileDAO;
import com.disk.dao.ShareFileDAO;
import com.disk.dao.ShuoshuoDAO;
import com.disk.entity.File;
import com.disk.entity.ShareFile;
import com.disk.entity.Shuoshuo;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Results({@Result(name = "share", location = "share.jsp")})
public class ShareAction extends ActionSupport implements ModelDriven<ShareFile>{
	private static final long serialVersionUID = 1L;
	private ShareFile entity = new ShareFile();
	private ShareFileDAO shareFileDAO = new ShareFileDAO();
	private String shareId ;//分享id
	private String filesJson ;
	private ShuoshuoDAO shuoshuoDAO = new ShuoshuoDAO();
	private FileDAO fileDAO = new FileDAO();
	//保存到我的网盘
	public String savesharefiletomine(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/xml;charset=UTF-8");
		if( u.getId().equals(entity.getFromUser())){
			this.getWriter().print("false");
		}else{
			//保存该文件
			File file = this.shareFileDAO.getFile(entity.getId());
			String originalId = file.getId();
			file.setId(IDUtil.generateId());
			file.setuId(u.getId());
			file.setUpdateTime(new Date());
			this.fileDAO.create(file);
			//保存该文件的子文件
			if( file.getType() == 2){
				List<File> files = this.shareFileDAO.getFileByParentId(originalId, entity.getFromUser());
				for(File item : files){
					item.setId(IDUtil.generateId());
					item.setUpdateTime(new Date());
					item.setuId(u.getId());
					item.setParentId(file.getId());
					this.fileDAO.create(item);
				}
			}
			
			this.getWriter().print("true");
			
		}
		return null ;
	}
	//点赞和踩
	public String zancai(){
		if( this.shareFileDAO.zanorcai(entity.getId(), entity.getType())){
			this.getWriter().print("true");
		}else{
			this.getWriter().print("false");
		}
		return null ;
	}
	
	public String delete(){
		if( shareFileDAO.delete(entity.getId())){
			this.getWriter().print("true");
		}else{
			this.getWriter().print("false");
		}
		return null ;
	}
	
	/**
	 * 显示访问文件列表
	 * @return
	 */
	public String listShareFiles(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		List<ShareFile> sf = shareFileDAO.getAllShareFile(u.getId());
		
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(ShareFile item : sf){
			sb.append("{");
			sb.append("id:'" + item.getId() + "',");
			sb.append("name:'" + item.getFileName() + "',");
			sb.append("type:'" + item.getType() + "',");
			sb.append("pwd:'" + item.getPwd() + "',");
			sb.append("cai:'" + item.getDislikes() + "',");
			sb.append("viewcount:'" + item.getViewcount() + "',");
			sb.append("date:'" + item.getDate() + "',");
			sb.append("zan:'" + item.getLikes() + "'");
			sb.append("},");
		}
		if( sf.size() > 0)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		try {
			ServletActionContext.getResponse().setContentType("text/xml;charset=UTF-8");
			ServletActionContext.getResponse().getWriter().print(sb.toString());
		} catch (IOException e) {
			
		}
		return null ;
	}
	
	/**
	 * 获取共享文件
	 * @return
	 */
	public String getShareFiles(){
		this.entity = shareFileDAO.getShareFile(shareId);
		StringBuffer sb = new StringBuffer();
		List<File> files = shareFileDAO.getShareFileById(shareId);
		
		sb.append("[");
		for(File item : files){
			sb.append("{");
			sb.append("id:'" + item.getId() + "',");
			sb.append("filename:'" + item.getFileName() + "',");
			sb.append("uid:'" + item.getuId() + "',");
			sb.append("size:'" + item.getSize() + "',");
			sb.append("ext:'" + item.getExt() + "',");
			sb.append("type:'" + item.getType() + "',");
			sb.append("updatetime:'" + item.getUpdateTime() + "',");
			sb.append("},");
		}
		if( files.size() > 0)
			sb.deleteCharAt(sb.lastIndexOf(","));
		sb.append("]");
		filesJson = sb.toString();
		
		this.shareFileDAO.viewcount(entity.getId());
		return "share" ;
	}

	/**
	 * 分享文件
	 * @return
	 */
	public String shareFile(){
		User user = (User)ActionContext.getContext().getSession().get("loginUser");
		String pwd = (System.currentTimeMillis() + "");
		String shareUrlId = System.currentTimeMillis() + "";
		
		for(String id : entity.getId().split(",")){
			if( !id.trim().equals("")){
				ShareFile sf = new ShareFile();
				sf.setId(System.currentTimeMillis() + "");
				sf.setFileId(id);
				sf.setShareUrlId(shareUrlId);
				sf.setFromUser(user.getId());
				sf.setType(entity.getType());
				sf.setPwd(pwd);
				shareFileDAO.save(sf);
				//发送分享文件动态
				Shuoshuo entity = new Shuoshuo();
				entity.setId(IDUtil.generateId());
				entity.setDate(new Date());
				entity.setContent("我分享了文件，快来看看吧。访问地址:http://localhost:8080/clouddisk/share!getShareFiles.action?shareId=" + sf.getId() + "");
				entity.setUserid(user.getId());
				shuoshuoDAO.create(entity);
			}
		}
		
		try {
			String url = "share!getShareFiles.action?shareId=" + shareUrlId ;
			ServletActionContext.getResponse().getWriter().print(url + "," + pwd);
		} catch (IOException e) {
		}
		return null ;
	}
	
	public ShareFile getModel() {
		return entity;
	}
	public String getShareId() {
		return shareId;
	}

	public void setShareId(String shareId) {
		this.shareId = shareId;
	}
	public String getFilesJson() {
		return filesJson;
	}

	public void setFilesJson(String filesJson) {
		this.filesJson = filesJson;
	}
	public ShareFile getEntity() {
		return entity;
	}

	public void setEntity(ShareFile entity) {
		this.entity = entity;
	}
	public PrintWriter getWriter(){
		try {
			return ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			return null ;
		}
	}
}