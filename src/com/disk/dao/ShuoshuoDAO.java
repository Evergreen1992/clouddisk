package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.disk.entity.Shuoshuo;

public class ShuoshuoDAO extends BaseConnection{
	public boolean zan(String id){
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("update t_shuoshuo set likes = likes + 1 where id = '" + id + "'");
			flag = pstmt.executeUpdate() == 1;
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	public List<Shuoshuo> list(String userid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		List<Shuoshuo> data = new ArrayList<Shuoshuo>();
		try{
			pstmt = conn.prepareStatement("select u.name, s.date, s.id, s.content, s.type, s.likes "
					+ "from t_shuoshuo s, t_user u "
					+ "where s.userid = u.id and (s.userid = '" + userid + "' or s.userid in(select friendid from t_friend where uid = '" + userid + "'))"
					+ " order by s.date desc");
			rs = pstmt.executeQuery();
			while(rs.next()){
				Shuoshuo entity = new Shuoshuo();
				entity.setId(rs.getString("id"));
				entity.setContent(rs.getString("content"));
				entity.setDate(rs.getDate("date"));
				entity.setUsername(rs.getString("name"));
				entity.setType(rs.getInt("type"));
				entity.setLikes(rs.getInt("likes"));
				entity.setTimestr(rs.getDate("date") + " " + rs.getTime("date"));
				data.add(entity);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return data;
	}
	public boolean create(Shuoshuo entity){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("insert into t_shuoshuo(id,userid,content,date,type,likes) values(?,?,?,now(),?,?) ");
			pstmt.setString(1, entity.getId());
			pstmt.setString(2, entity.getUserid());
			pstmt.setString(3, entity.getContent());
			pstmt.setInt(4, entity.getType());
			pstmt.setInt(5, entity.getLikes());
			flag = pstmt.executeUpdate() == 1;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
}