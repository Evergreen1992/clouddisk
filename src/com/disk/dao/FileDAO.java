package com.disk.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.disk.entity.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO extends BaseConnection{
	//文件类型统计
	public Map<String, Integer> getCountByType(String uid){
		Map<String, Integer> count = new HashMap<String, Integer>();
		
		try{
			String sql = "select ext as type , count(ext) from t_file where uid = '" + uid + "' group by ext";
			Connection conn = this.getConn();
			ResultSet rs = null ;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while( rs.next() ){
				if( rs.getString("type") == "unknow" || rs.getString("type").trim().equals("")){
					count.put("others", rs.getInt("count(ext)"));
				}else{
					count.put(rs.getString("type"), rs.getInt("count(ext)"));
				}
			}
			close(rs);
			close(pstmt);
			close(conn);
		}catch(Exception e){
			e.printStackTrace();
		}
		return count ;
	}
	
	/**
	 * 搜索文件
	 * @param entity
	 * @param uid
	 * @return
	 */
	public List<File> search(String name, String uid){
		List<File> files = new ArrayList<File>();
		
		try{
			String sql = "select  *  from t_file where uid = '" + uid + "'  and  filename like '%" + name + "%'   order by type asc ";
			Connection conn = this.getConn();
			ResultSet rs = null ;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while( rs.next() ){
				File file = new File();
				file.setId(rs.getString("id"));
				file.setFileName(rs.getString("filename"));
				file.setType(rs.getInt("type"));
				file.setUpdateTime(new java.util.Date(rs.getDate("updatetime").getTime()));
				file.setuId(rs.getString("uid"));
				file.setParentId(rs.getString("parentid"));
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
	
	/**
	 * 重命名
	 * @param ids
	 * @param name
	 * @return
	 */
	public int rename(String id, String name){
		Connection conn = null;
		PreparedStatement pstmt = null ;
		int count = 0 ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement("update t_file set filename = ?  where id = ? ");
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			count = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return count ;
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	public boolean updateParentId(File entity){
		boolean flag = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement("update t_file set parentId = ?  where id = ?");
			pstmt.setString(1, entity.getParentId());
			pstmt.setString(2, entity.getId());
			if( pstmt.executeUpdate() == 1)
				flag = true ;
		}catch(Exception e){
			e.printStackTrace();
		}
		return flag ;
	}
	
	/**
	 * 删除文件
	 * @param entity
	 * @return
	 */
	public boolean delete(String id){
		boolean flag = false ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement("delete from t_file where id = ?");
			pstmt.setString(1, id);
			if( pstmt.executeUpdate() == 1)
				flag = true ;
		}catch(Exception e){
			e.printStackTrace();
		}
		return flag ;
	}
	
	/**
	 * 修改文件名
	 * @param file
	 * @return
	 */
	public boolean updateName(File file){
		boolean flag = true ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement("update t_file set filename = ? where id = ?");
			pstmt.setString(1, file.getFileName());
			pstmt.setString(2, file.getId());
			if( pstmt.executeUpdate() == 1)
				flag = true ;
			else
				flag = false ;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return flag ;
	}
	
	/**
	 * 创建文件
	 * @param file
	 * @return
	 */
	public boolean create(File file){
		boolean flag = true ;
		Connection conn = null;
		PreparedStatement pstmt = null ;
		String sql = "insert into t_file(id, filename, type, uid, updatetime, parentid, size, ext) values(?,?,?,?,now(),?,?,?)";
		
		try{
			conn = this.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, file.getId());
			pstmt.setString(2, file.getFileName());
			pstmt.setInt(3, file.getType());
			pstmt.setString(4, file.getuId());
			pstmt.setString(5, file.getParentId());
			pstmt.setString(6, file.getSize());
			pstmt.setString(7, file.getExt());
			if(pstmt.executeUpdate() == 1){
				flag = true;
			}else{
				flag = false ;
			}
		}catch(Exception e){
			e.printStackTrace();
			flag = false ;
		}
		
		return flag ;
	}
	
	/**
	 * 返回用户id为uid，parentId下的文件
	 * @param parentId uid
	 * @return
	 */
	public List<File> getFileByParentId(String parentId, String uid, String fileType){
		List<File> files = new ArrayList<File>();
		
		try{
			String sql = "select * from t_file where uid = ? " ;
			//查询条件
			if( fileType.equals("1")){//查询所有文件
				if( parentId == null ){
					sql += "  and parentId is null  ";
				}else{
					sql += " and parentid = ?  ";
				}
				sql += " order by type desc ";
			}else if(fileType.equals("2")){//图片
				sql += " and ext in('.jpg','.png','.gif') ";
				sql += " order by type desc ";
			}else if(fileType.equals("3")){//文档
				sql += " and ext in('.doc','.docx','.txt','.pdf') ";
				sql += " order by type desc ";
			}else if(fileType.equals("4")){//视频
				sql += " and ext in('.rmvb','.mp4','.webm') ";
				sql += " order by type desc ";
			}else if(fileType.equals("5")){//音乐
				sql += " and ext in('.mp3') ";
				sql += " order by type desc ";
			}else if(fileType.equals("6")){//我的分享
				sql = "select tf.* from t_file tf, t_sharefile tsf where tf.id = tsf.fileid  and tf.uid = ? ";
				sql += " order by tf.type desc ";
			}
			
			
			Connection conn = this.getConn();
			ResultSet rs = null ;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			if( parentId != null )
				pstmt.setString(2, parentId);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ){
				File file = new File();
				file.setId(rs.getString("id"));
				file.setFileName(rs.getString("filename"));
				file.setType(rs.getInt("type"));
				file.setUpdateTime(rs.getDate("updatetime"));
				rs.getDate("updatetime");
				file.setTimeDetailString(rs.getDate("updatetime") + " " + rs.getTime("updatetime"));
				file.setuId(rs.getString("uid"));
				file.setParentId(rs.getString("parentid"));
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
}