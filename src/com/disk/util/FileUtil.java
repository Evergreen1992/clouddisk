package com.disk.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/*import org.apache.hadoop.conf.Configuration;  
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;*/
/**
 * hadoop　　hdfs文件上传工具类
 * @author xiongxiao
 *
 */
public class FileUtil {
	//private final static String location = "hdfs://127.0.0.1:9000/files/";
	private final static String filePath = "e://fileupload";
	
	/**
	 * 文件删除
	 * @param fileName
	 */
	public static boolean deleteFile(String fileName){
		boolean flag = false ;
		/*try {
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(location + fileName), conf);
			Path path = new Path(location + fileName);
			flag = fs.delete(path, true);
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		return flag ;
	}
	
	/**
	 * hadoop文件下载
	 * @param fileName
	 */
	public static InputStream download(String fileName){
		InputStream in = null ;
		/*try {
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(location + fileName), conf);
			in = fs.open(new Path(location + fileName));
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		try{
			in = new FileInputStream(new File(filePath + "//" + fileName));
		}catch(Exception e){
			
		}
		return in ;
	}
	
	/**
	 * hadoop上传文件
	 * @param fileFrom
	 * @param fileDestination
	 */
	public static void upload(File file, String fileDestination){
		File newFile = new File(filePath + "//" + fileDestination);
		InputStream in = null ;
		OutputStream out = null ;
		byte[] buffer = new byte[1024];
		try{
			in = new FileInputStream(file);
			out = new FileOutputStream(newFile);
			while( in.read(buffer, 0, buffer.length) != -1){
				out.write(buffer, 0, buffer.length);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if( in != null )
				try {
					in.close();
				} catch (IOException e) {
					
				}
			if( out != null )
				try {
					out.close();
				} catch (IOException e) {
					
				}
		}
	}
	
	public static void main(String[] args){
		System.out.println(deleteFile("1445757510276"));
	}
}
