package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.disk.entity.Message;

public class MessageDAO extends BaseConnection{
	public List<Message> list(String uid, String touid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		List<Message> data = new ArrayList<Message>();
		try{
			pstmt = conn.prepareStatement("select * from t_message where (uid = '" + uid + "' and touid = '" + touid + "') or (uid='" + touid + "' and touid='" + uid + "') order by date desc");
			rs = pstmt.executeQuery();
			while(rs.next()){
				Message entity = new Message();
				entity.setId(rs.getString("id"));
				entity.setTimeStr(rs.getDate("date") + " " + rs.getTime("date"));
				entity.setContent(rs.getString("content"));
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
	public boolean create(Message entity){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false ;
		try{
			pstmt = conn.prepareStatement("insert into t_message(id,uid,touid,date,content) values('" +entity.getId()+ "','" + entity.getuId()+ "','" + entity.getToUid() + "',now(),'" + entity.getContent() + "')");
			System.out.println("insert into t_message(id,uid,touid,date,content) values('" +entity.getId()+ "','" + entity.getuId()+ "','" + entity.getToUid() + "',now(),'" + entity.getContent() + "')");
			flag = pstmt.executeUpdate() == 1 ;
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
