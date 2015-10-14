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
	public List<File> getFileByParentId(String parentId, String uid){
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
		for(File i : new FileDAO().getFileByParentId(null, "1")){
			System.out.println(i.getFileName() + " , " + i.getParentId() + " , " + i.getUpdateTime());
		}
	}
}
