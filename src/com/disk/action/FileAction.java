package com.disk.action;

import java.io.File;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 文件相关操作action
 * @author xiongxiao
 */
public class FileAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	
	private File file; //上传的文件
	private String fileFileName; //文件名称
    private String fileContentType; //文件类型
	
	/**
	 * 文件上传
	 * @return
	 */
	public String uploadFile(){
		System.out.println("文件:" + this.fileFileName + " , " + this.fileContentType + " , " + this.file);
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
}