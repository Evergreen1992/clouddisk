package com.disk.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.FileDAO;
import com.disk.entity.User;
import com.disk.util.IDUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import net.sf.json.JSONArray;

/**
 * 文件相关操作action
 * @author xiongxiao
 */
public class FileAction extends ActionSupport implements ModelDriven<com.disk.entity.File>{
	private static final long serialVersionUID = 1L;
	
	private java.io.File file; //上传的文件
	private String fileFileName; //文件名称
    private String fileContentType; //文件类型
	private com.disk.entity.File entity = new com.disk.entity.File();
	
	/**
	 * 
	 * @return
	 */
	public String delete(){
		try {
			FileDAO dao = new FileDAO();
			if( entity.getId() != null ){
				for(String id : entity.getId().split(",")){
					dao.delete(id);
				}
			}
			this.getWriter().print("true");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	/**
	 * 文件上传
	 * @return
	 */
	public String uploadFile(){
		System.out.println("文件:" + this.fileFileName + " , " + this.fileContentType + " , " + this.file);
		return null ;
	}
	
	/**
	 * 
	 * @return
	 */
	public String createFolder(){
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		FileDAO dao = new FileDAO();
		entity.setId(IDUtil.generateId());
		entity.setuId(u.getId());
		entity.setUpdateTime(new java.util.Date());
		entity.setExt("");
		entity.setSize("");
		entity.setType(2);
		if( entity.getParentId() == null || entity.getParentId().equals("")){
			entity.setParentId(null);
		}
		
		try {
			boolean flag = dao.create(entity) ;
			this.getWriter().print( flag == false ? false : entity.getId());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	/**
	 * 查询文件列表
	 * @return
	 */
	public String listUserFile(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		FileDAO dao = new FileDAO();
		List<com.disk.entity.File> files = new ArrayList<com.disk.entity.File>();
		files = dao.getFileByParentId(this.entity.getParentId(), loginUser.getId());
		JSONArray jsonArr = JSONArray.fromObject(files);
		try {
			this.getWriter().print(jsonArr.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}

	public String main(){
		System.out.println("actions");
		return null ;
	}
	
	public java.io.File getFile() {
		return this.file;
	}

	public void setFile(java.io.File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileName) {
		this.fileFileName = fileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public com.disk.entity.File getEntity() {
		return entity;
	}

	public void setEntity(com.disk.entity.File entity) {
		this.entity = entity;
	}

	public com.disk.entity.File getModel() {
		return this.entity;
	}

	public PrintWriter getWriter() throws IOException{
		return ServletActionContext.getResponse().getWriter();
	}
}