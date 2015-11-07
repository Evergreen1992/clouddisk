package com.disk.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.disk.dao.FileDAO;
import com.disk.entity.User;
import com.disk.util.FileExt;
import com.disk.util.HadoopUtil;
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
	private String flag = "";//play:播放　　

	/**
	 * 文件下载/在线播放
	 * @return
	 */
	public String fileDownload(){
		InputStream in = null ;
		OutputStream out = null ;
		HttpServletResponse resp = ServletActionContext.getResponse();
		String ext = "";
		String fileName = entity.getFileName();
		if( fileName != null && fileName.contains("."))
			ext = fileName.substring(fileName.lastIndexOf("."), fileName.length() );
		
		try{
			if( this.flag.equals("play") == false){//下载模式
				resp.setHeader("Content-Disposition","attachment; filename=" + entity.getFileName());  
				resp.setCharacterEncoding("utf-8");
			}else{//播放视频模式
				if( ext.equals(".wmv") ){
					resp.setContentType("video/wmv");
				}else if( ext.equals(".mp4")){
					resp.setContentType("video/mp4");
				}else if( ext.equals(".flv")  || ext.equals(".f4v")){
					resp.setContentType("video/flv");
				}else if( ext.equals(".webm")){
					resp.setContentType("video/webm");
				}else if( ext.equals(".mp3")){
					resp.setContentType("audio/mpeg");
				}
			}
			out = resp.getOutputStream();
			in = HadoopUtil.download(entity.getId());
			int len = 0 ;
			byte[] buf = new byte[1024 * 1024];
			
			while( (len = in.read(buf, 0 , buf.length)) != -1){
				out.write(buf, 0, len);
			}

			out.flush();
		}catch(Exception e){

		}finally{
			try {
				out.close();
				in.close();
			} catch (IOException e) {
			}
		}
		return null ;
	}
	
	/**
	 * 按照文件名搜索
	 * @return
	 */
	public String search(){
		User loginUser = (User)ActionContext.getContext().getSession().get("loginUser");
		FileDAO dao = new FileDAO();
		List<com.disk.entity.File> files = new ArrayList<com.disk.entity.File>();
		files = dao.search(this.entity.getFileName(), loginUser.getId());
		JSONArray jsonArr = JSONArray.fromObject(files);
		try {
			this.getWriter().print(jsonArr.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	/**
	 * 文件重命名
	 * @return
	 */
	public String rename(){
		FileDAO dao = new FileDAO();
		int count = 0 , len = 0 ;
		for(String item : entity.getId().split(",")){
			if( item != null && item.trim().length() >= 1 ){
				len ++ ;
				count += dao.rename(item, entity.getFileName());
			}
		}
	
		try {
			this.getWriter().print(count == len ? true : false);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	//修改父节点id
	public String updateParentId(){
		
		boolean flag = false ;
		FileDAO dao = new FileDAO();
		flag = dao.updateParentId(entity);
		
		try {
			this.getWriter().print(flag);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
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
					if( !id.trim().equals(""))
						HadoopUtil.deleteFile(id);
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
		User u = (User)ActionContext.getContext().getSession().get("loginUser");
		FileDAO dao = new FileDAO();
		String fileSize = "";
		long fLen = this.file.length();
		
		//计算文件大小
		if( (fLen) / (1024 * 1024 * 1024) > 0 ){//GB
			fileSize = fLen / (1024 * 1024 * 1024) + "GB";
		}else if( fLen  / (1024 * 1024) > 0 ){//MB
			fileSize = fLen / (1024 * 1024 ) + "MB";
		}else if( fLen / 1024 > 0 ){//KB
			fileSize = fLen / (1024 ) + "KB";
		}else{
			fileSize = fLen + "B";
		}
		entity.setFileName(this.fileFileName);
		entity.setId(IDUtil.generateId());
		entity.setuId(u.getId());
		entity.setUpdateTime(new java.util.Date());
		entity.setExt(FileExt.getExe(this.fileContentType));//文件后缀名
		entity.setSize(fileSize);
		entity.setType(1);
		if( entity.getParentId() == null || entity.getParentId().equals("")){
			entity.setParentId(null);
		}
		//hadoop上传
		HadoopUtil.upload(this.file , entity.getId());
		try {
			boolean flag = dao.create(entity) ;
			this.getWriter().print( flag == false ? false : entity.getId());
		} catch (IOException e) {

		}
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
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
}