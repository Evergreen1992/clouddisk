package com.disk.util;

public class IDUtil {
	public static String generateId(){
		return System.currentTimeMillis() + "";
	}
	
	public static void main(String[] args){
		System.out.println(generateId());
	}
}
