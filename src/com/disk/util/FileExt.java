package com.disk.util;

public class FileExt {
	public static String getExe(String str){
		String ext = "";
		switch(str){
		case "audio/mpeg":
			ext = ".mp3";
			break;
		case "image/png":
			ext = ".png";
			break ;
		case "application/msword":
			ext = ".doc";
			break ;
		case "image/gif":
			ext = ".gif";
			break ;
		case "application/zip":
			ext = ".zip";
			break ;
		case "image/jpeg":
			ext = ".jpg";
			break ;
		case "text/plain":
			ext = ".txt";
			break ;
		case "video/mp4":
			ext = ".mp4";
			break ;
		case "video/x-wav":
			ext = ".wav";
			break ;
		case "video/flv":
			ext = ".flv";
			break ;
		case "audio/mp3":
			ext = ".mp3";
			break ;
		case "video/f4v":
			ext = ".flv";
			break ;
		case "video/webm":
			ext = ".webm";
			break ;
		case "application/pdf":
			ext = ".pdf";
			break;
		case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
			ext = ".docx";
			break;
		default :
			ext = "unknown";
			break ;
		}
		return ext;
	}
}
