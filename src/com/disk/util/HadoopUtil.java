/*package com.disk.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import org.apache.hadoop.conf.Configuration;  
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;

*//**
 * hadoop　　hdfs文件上传工具类
 * @author xiongxiao
 *
 *//*
public class HadoopUtil {
	
	public static void upload(){
		try {
			String dst = "hdfs://127.0.0.1:9000/files/xx3.txt";
			String localSrc = "/home/xiongxiao/xx.txt";
			InputStream in = new BufferedInputStream(new FileInputStream(localSrc));
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(dst), conf);
			OutputStream out = fs.create(new Path(dst), new Progressable(){
				public void progress(){
					System.out.print("上传中~");
				}
			});
			
			IOUtils.copyBytes(in, out, 4096, true);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		upload();
	}
}
*/