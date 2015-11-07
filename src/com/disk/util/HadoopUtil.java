package com.disk.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import org.apache.hadoop.conf.Configuration;  
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;
/**
 * hadoop　　hdfs文件上传工具类
 * @author xiongxiao
 *
 */
public class HadoopUtil {
	private final static String location = "hdfs://127.0.0.1:9000/files/";
	
	/**
	 * 文件删除
	 * @param fileName
	 */
	public static boolean deleteFile(String fileName){
		boolean flag = false ;
		try {
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(location + fileName), conf);
			Path path = new Path(location + fileName);
			flag = fs.delete(path, true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return flag ;
	}
	
	/**
	 * hadoop文件下载
	 * @param fileName
	 */
	public static InputStream download(String fileName){
		InputStream in = null ;
		try {
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(location + fileName), conf);
			in = fs.open(new Path(location + fileName));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return in ;
	}
	
	/**
	 * hadoop上传文件
	 * @param fileFrom
	 * @param fileDestination
	 */
	public static void upload(File file, String fileDestination){
		try {
			String dst = location + fileDestination;
			InputStream in = new BufferedInputStream(new FileInputStream(file));
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(dst), conf);
			OutputStream out = fs.create(new Path(dst), new Progressable(){
				public void progress(){
					//System.out.print("... ");
				}
			});
			//System.out.println();
			IOUtils.copyBytes(in, out, 4096, true);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		System.out.println(deleteFile("1445757510276"));
	}
}
