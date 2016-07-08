package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.disk.entity.FriendApply;
import com.disk.entity.User;

public class FriendDAO extends BaseConnection{
	//查找好友是否存在
	public boolean checkFriend(String uId, String friendId){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("select count(*) as 'count' from t_friend where uid = '" + uId + "' and friendid = '" + friendId + "'");
			rs = pstmt.executeQuery();
			rs.next();
			if( rs.getInt("count") == 1)
				flag = true;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	//加载好友列表
	public List<User> listFriend(String uid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		List<User> list = new ArrayList<User>();
		try{
			pstmt = conn.prepareStatement("select u.id ,u.name from t_friend f, t_user u where (f.friendid = u.id and f.uid = '" + uid + "') ");
			rs = pstmt.executeQuery();
			while( rs.next()){
				User u = new User();
				u.setId(rs.getString("id"));
				u.setName(rs.getString("name"));
				list.add(u);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return list;
	}
	//添加好友
	public boolean addFriend(String id, String uid, String friendid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("insert into t_friend(id,uid,friendid) values('" + id + "','" + uid + "','" + friendid + "')");
			if(pstmt.executeUpdate() == 1){
				flag = true ;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	//删除申请
	public boolean deleteApply(String id){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("delete from t_friendapply where id = '" + id + "'");
			if(pstmt.executeUpdate() == 1){
				flag = true ;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	public List<FriendApply> list(String uid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		List<FriendApply> list = new ArrayList<FriendApply>();
		try{
			pstmt = conn.prepareStatement("select fp.id , u.name,u.id as 'userid' from t_user u, t_friendapply fp where fp.toUid = '" + uid + "' and fp.fromUid = u.id");
			rs = pstmt.executeQuery();
			while( rs.next()){
				FriendApply fp = new FriendApply();
				fp.setId(rs.getString("id"));
				fp.setName(rs.getString("name"));
				fp.setToUid(rs.getString("userid"));
				list.add(fp);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return list;
	}
	//查找用户是否存在
	public boolean friendApply(String id, String fromid, String toid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("insert into t_friendapply(id,fromUid,toUid) values('" + id + "','" + fromid + "','" + toid + "')");
			if(pstmt.executeUpdate() == 1){
				flag = true ;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	//查找用户是否存在
	public String checkIfExists(String uid){
		Connection conn = this.getConn();
		ResultSet rs = null ;
		PreparedStatement pstmt = null ;
		String id = null ;
		try{
			pstmt = conn.prepareStatement("select id from t_user where name = '" + uid + "'");
			rs = pstmt.executeQuery();
			if(rs.next()){
				id = rs.getString("id");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return id;
	}
}