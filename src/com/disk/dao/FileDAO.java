package com.disk.dao;

import java.util.ArrayList;
import java.util.List;
import com.disk.entity.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO extends BaseConnection{
	/**
	 * 返回用户id为uid，parentId下的文件
	 * @param parentId uid
	 * @return
	 */
	public List<File> getFileByParentId(Integer parentId, int uid){
		List<File> files = new ArrayList<File>();
		
		try{
			String sql = "select * from t_file where uid = ? " ;
			if( parentId == null )
				sql += " ";
			else
				sql += " and parentid = ?";
			Connection conn = this.getConn();
			ResultSet rs = null ;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			if( parentId != null )
				pstmt.setInt(2, parentId);
			
			rs = pstmt.executeQuery();
			
			while( rs != null ){
				File file = new File();
				file.setId(rs.getInt("id"));
				file.setFileName(rs.getString("filename"));
				file.setType(rs.getInt("type"));
				file.setUpdateTime(rs.getDate("updatetime"));
				file.setUId(rs.getInt("uid"));
				file.setParentId(rs.getInt("parentid"));
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
