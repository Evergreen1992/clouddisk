package com.disk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.disk.entity.File;
import com.disk.entity.ShareFile;

public class ShareFileDAO extends BaseConnection{
	public List<File> getFileByParentId(String parentId, String uid){
		List<File> files = new ArrayList<File>();
		try{
			String sql = "select * from t_file where uid = ? and parentid = ?" ;
			Connection conn = this.getConn();
			ResultSet rs = null ;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, parentId);
			rs = pstmt.executeQuery();
			
			while( rs.next() ){
				File file = new File();
				file.setId(rs.getString("id"));
				file.setFileName(rs.getString("filename"));
				file.setType(rs.getInt("type"));
				file.setExt(rs.getString("ext"));
				file.setSize(rs.getString("size"));
				files.add(file);
			}
			close(rs);
			close(pstmt);
			close(conn);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return files ;
	}
	//获取分享文件对应的文件
	public File getFile(String sfid){
		File file = new File();
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "select f.* from t_sharefile sf, t_file f where sf.fileid = f.id and sf.id = '" + sfid + "'";
		ResultSet rs = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while( rs.next()){
				file.setId(rs.getString("id"));
				file.setFileName(rs.getString("filename"));
				file.setType(rs.getInt("type"));
				file.setParentId(null);
				file.setSize(rs.getString("size"));
				file.setExt(rs.getString("ext"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return file;
	}
	//浏览量增加
	public boolean viewcount(String id){
		boolean flag = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "";
		sql = "update t_sharefile set viewcount = viewcount + 1 where id = '" + id + "'";	
			
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			flag = pstmt.executeUpdate() == 1 ;
		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}
	//点赞，或踩
	public boolean zanorcai(String id, int type){
		boolean flag = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "";
		if(type == 1){//赞
			sql = "update t_sharefile set likes = likes + 1 where id = '" + id + "'";	
		}else{//踩
			sql = "update t_sharefile set dislikes = dislikes + 1 where id = '" + id + "'";	
		}
			
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			flag = pstmt.executeUpdate() == 1 ;
		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}
	public boolean delete(String id){
		boolean flag = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "delete from t_sharefile where id = '" + id + "'";		
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			flag = pstmt.executeUpdate() == 1 ;
		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}
	public List<ShareFile> getAllShareFile(String uid){
		List<ShareFile> list = new ArrayList<ShareFile>();
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "select sf.date, sf.likes,sf.viewcount, sf.dislikes, f.filename, f.id as 'fid',f.type as 'ftype', sf.type, sf.pwd, sf.id as 'sfid'  from t_file f, t_sharefile sf where f.id = sf.fileid and sf.fromuser = '" + uid + "'";
		ResultSet rs = null ;
		
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while( rs.next()){
				ShareFile sf = new ShareFile();
				sf.setPwd(rs.getString("pwd"));
				sf.setFileName(rs.getString("filename"));
				sf.setType(rs.getInt("type"));
				sf.setId(rs.getString("sfid"));
				sf.setId(rs.getString("sfid"));
				sf.setLikes(rs.getInt("likes"));
				sf.setDislikes(rs.getInt("dislikes"));
				sf.setViewcount(rs.getInt("viewcount"));
				sf.setDate(rs.getDate("date"));
				list.add(sf);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public ShareFile getShareFile(String sId){
		/**
		
		 */
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "select sf.fromuser,sf.date,sf.id, sf.type, sf.score, sf.pwd, sf.shareurlid, u.name from t_sharefile sf, t_user u where sf.id = '" + sId + "' and sf.fromuser = u.id";
		ResultSet rs = null ;
		ShareFile sf = new ShareFile();
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while( rs.next()){
				sf.setPwd(rs.getString("pwd"));
				sf.setScore(rs.getInt("score"));
				sf.setType(rs.getInt("type"));
				sf.setId(rs.getString("id"));
				sf.setFromUser(rs.getString("fromuser"));
				sf.setDate(rs.getDate("date"));
				sf.setShareUserName(rs.getString("name"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return sf ;
	}
	/**
	 * 通过shareid获取分享的文件
	 * @param shareId
	 * @return
	 */
	public List<File> getShareFileById(String shareId){
		List<File> files = new ArrayList<File>();
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "select f.id,f.type, f.filename,f.uid,f.size,f.ext, f.updatetime from t_file f, t_sharefile sf where f.id = sf.fileid and sf.id = '" + shareId + "' ";
		ResultSet rs = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while( rs.next()){
				File file = new File();
				file.setId(rs.getString("id"));
				file.setType(rs.getInt("type"));
				file.setFileName(rs.getString("filename"));
				file.setuId(rs.getString("uid"));
				file.setSize(rs.getString("size"));
				file.setExt(rs.getString("ext"));
				file.setUpdateTime(rs.getDate("updatetime"));
				files.add(file);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return files ;
	}
	
	public boolean save(ShareFile sf){
		boolean result = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement("insert into t_sharefile(id,fromuser,fileid,type,score,pwd,shareurlid,date) values('" +
			sf.getId()+ "','" + sf.getFromUser() + "','" + sf.getFileId()+ "','" + sf.getType() + "','" + sf.getScore() + "','" + sf.getPwd() + "','" + sf.getShareUrlId() + "', now())");
			result = pstmt.execute();
		}catch(Exception e){
			e.printStackTrace();
		}
		return result ;
	}
}
