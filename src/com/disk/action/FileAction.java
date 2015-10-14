package com.disk.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.FileDAO;
import com.disk.entity.File;
import com.disk.entity.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import net.sf.json.JSONArray;

/**
 * 文件相关操作action
 * @author xiongxiao
 */
public class FileAction extends ActionSupport implements ModelDriven<File>{
	private static final long serialVersionUID = 1L;
	
	private File file; //上传的文件
	private String fileFileName; //文件名称
    private String fileContentType; //文件类型
	private String parentId ;//父节点id
	private File entity = new File();
	/**
	 * 文件上传
	 * @return
	 */
	public String uploadFile(){
		System.out.println("文件:" + this.fileFileName + " , " + this.fileContentType + " , " + this.file);
		return null ;
	}
	
	/**
	 * 查询文件列表
	 * @return
	 */
	public String listUserFile(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		FileDAO dao = new FileDAO();
		List<File> files = new ArrayList<File>();
		files = dao.getFileByParentId(parentId, loginUser.getId());
		JSONArray jsonArr = JSONArray.fromObject(files);
		System.out.println(jsonArr.toString());
		try {
			ServletActionContext.getResponse().getWriter().print(jsonArr.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}

	public String main(){
		System.out.println("actions");
		return null ;
	}
	
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
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
	public File getEntity() {
		return entity;
	}

	public void setEntity(File entity) {
		this.entity = entity;
	}

	public File getModel() {
		return this.entity;
	}
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}