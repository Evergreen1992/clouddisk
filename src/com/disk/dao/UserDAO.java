package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.disk.entity.User;

public class UserDAO extends BaseConnection{
	/**
	 * 用户注册
	 * @param name
	 * @param pwd
	 * @return
	 */
	public boolean create(String name, String pwd){
		String sql = "insert into t_user(id,name,pwd) values('" + System.currentTimeMillis() + "','" + name + "','" + pwd + "') ";
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		int result = -1 ;
		try{
			pstmt = conn.prepareStatement(sql);
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
			close(conn);
		}
		return result == 1 ? true : false;
	}
	/**
	 * 用户名验证
	 * @param name
	 * @return
	 */
	public boolean validate(String name){
		String sql = "select  count(*) from t_user where name = '" + name + "' ";
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		int result = -1 ;
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
			close(conn);
		}
		return result >= 1 ? true : false;
	}
	/**
	 * 用户登录
	 * @param name
	 * @param pwd
	 * @return
	 */
	public User login(String name, String pwd){
		String sql = "select  *  from t_user where name = '" + name + "'  and pwd = '" + pwd + "' ";
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		User user = null ;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if( rs == null )
				return null ;
			while(rs.next()){
				user = new User();
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
			close(conn);
		}
		return user ;
	}
}
