package com.disk.dao;

import java.util.ArrayList;
import java.util.List;
import com.disk.entity.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO extends BaseConnection{
	
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
			pstmt = conn.prepareStatement("delte from t_file where id = ?");
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
	public List<File> getFileByParentId(String parentId, String uid){
		List<File> files = new ArrayList<File>();
		
		try{
			String sql = "select * from t_file where uid = ? " ;
			if( parentId == null )
				sql += "  and parentId is null or parentId = '' ";
			else
				sql += " and parentid = ?  ";
			sql += " order by type desc ";
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
				file.setUpdateTime(new java.util.Date(rs.getDate("updatetime").getTime()));
				file.setuId(rs.getString("uid"));
				file.setParentId(rs.getString("parentid"));
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

	public static void main(String[] args){
		
	}
}