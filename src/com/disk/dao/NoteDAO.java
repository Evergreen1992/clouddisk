package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.disk.entity.Note;

public class NoteDAO extends BaseConnection{
	//文件列表
	public Note getNote(String id){
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		Note note = new Note();
		try{
			pstmt = conn.prepareStatement("select * from t_note where id = '" + id + "'");
			rs = pstmt.executeQuery();
			while( rs.next()){
				note.setId(rs.getString("id"));
				note.setTitle(rs.getString("title"));
				note.setContent(rs.getString("content"));
				note.setDate(rs.getDate("date"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		return note;
	}
	//新建笔记
	public boolean create(Note note){
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		boolean flag = false;
		try{
			pstmt = conn.prepareStatement("insert into t_note(id,uid,title,content,date) values(?,?,?,?,now())");
			pstmt.setString(1, note.getId());
			pstmt.setString(2, note.getUid());
			pstmt.setString(3, note.getTitle());
			pstmt.setString(4, note.getContent());
			flag = pstmt.executeUpdate() == 1 ;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(pstmt);
			this.close(conn);
		}
		return flag;
	}
	//文件列表
	public List<Note> list(String uid){
		Connection conn = this.getConn();
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		List<Note> data = new ArrayList<Note>();
		try{
			pstmt = conn.prepareStatement("select * from t_note where uid = '" + uid + "'");
			rs = pstmt.executeQuery();
			while( rs.next()){
				Note note = new Note();
				note.setId(rs.getString("id"));
				note.setTitle(rs.getString("title"));
				note.setContent(rs.getString("content"));
				note.setDate(rs.getDate("date"));
				data.add(note);
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
}
