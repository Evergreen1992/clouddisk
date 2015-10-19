package com.disk.dao;

import java.util.ArrayList;
import java.util.List;
import com.disk.entity.File;
import com.disk.util.IDUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO extends BaseConnection{
	
	/**
	 * 创建文件
	 * @param file
	 * @return
	 */
	public boolean create(File file){
		boolean flag = true ;
		/*Connection conn = null;
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
		}*/
		
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
		/*for(File i : new FileDAO().getFileByParentId(null, "1")){
			System.out.println(i.getFileName() + " , " + i.getParentId() + " , " + i.getUpdateTime());
		}*/
		/*File file = new File();
		file.setId("222222222222");
		file.setFileName("hello.pdf");
		file.setType(1);
		file.setExt(".pdf");
		file.setParentId(null);
		file.setuId("1");
		file.setSize("10M");
		new FileDAO().create(file);*/
		File entity = new File();
		entity.setId(IDUtil.generateId());
		entity.setuId("1");
		entity.setUpdateTime(new java.util.Date());
		entity.setExt("");
		entity.setSize("");
		entity.setType(2);
		System.out.println(new FileDAO().create(entity));
	}
}