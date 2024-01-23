package login;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.commons.dbcp.BasicDataSource;

import admin.admin_dto;

public class db_insert {
	Connection con = null;
	PreparedStatement ps = null;
	int result = 0;
	
	
	public db_insert(BasicDataSource dataSource) {
		try {
			this.con = dataSource.getConnection();
		}
		catch (Exception e) {
			System.out.println("DB 접속 오류 발생" +e);
		}
	} 
	
	
	//관리자 추가
	public int admin_insert(admin_dto adto) {
		
		String sql = "insert into admins values('0',?,?,?,?,?,?,?,now(),'N','0')";
		try {
			security sec = new security(adto.getApass());
			String newPass = sec.md5_se();
			
			System.out.println("dd");
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1,adto.getAid());
			this.ps.setString(2,newPass);
			this.ps.setString(3,adto.getAname());
			this.ps.setString(4,adto.getAemail());
			this.ps.setString(5,adto.getAtel());
			this.ps.setString(6,adto.getAdiv());
			this.ps.setString(7,adto.getAposition());
			
			this.result = this.ps.executeUpdate();
		
			this.ps.close();
			this.con.close();
			
		} catch (Exception e) {

			System.out.println("DB 데이터 추가 도중 오류 발생" +e);
		}
		
		
		return this.result;
	}
	
}
