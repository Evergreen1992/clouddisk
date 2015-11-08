package com.disk.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * 获取数据库连接对象．
 * @author xiongxiao
 *
 */
public class BaseConnection {
	
	public static final String url = "jdbc:mysql://127.0.0.1/clouddisk";  
    public static final String name = "com.mysql.jdbc.Driver";  
    public static final String user = "root";  
    public static final String password = "root";  
	
	public Connection getConn(){
		Connection conn = null ;
		try {
			Class.forName(name);
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  conn ;
	}
	
	public void close(Connection conn){
		if( conn != null )
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	public void close(PreparedStatement pstmt){
		if( pstmt != null )
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	public void close(ResultSet rs){
		if( rs != null )
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
}
