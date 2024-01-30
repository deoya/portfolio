package login;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.commons.dbcp.BasicDataSource;

public class db_update {
	Connection con = null;
	PreparedStatement ps = null;
	String result = null;
	
	public db_update(BasicDataSource dataSource) {
		try {
			this.con = dataSource.getConnection();
		}
		catch (Exception e) {
			System.out.println("DB연결 오류!" + e);
		}
	}
	
	//로그인 오류 횟수 제한
	public String loginnum(String aid ,int num) {
		
		try {
			String sql = "update admins set apwdck=? where aid=?";
			this.ps = this.con.prepareStatement(sql);
			
			this.ps.setInt(1,num);
			this.ps.setString(2,aid);
			
			int success = this.ps.executeUpdate();
			
			if(success > 0) {
				this.result = "ok";
			}
			else {
				this.result = "no";
			}
			
			this.ps.close();
			this.con.close();
			
			
		} catch (Exception e) {
			System.out.println("DB 데이터 수정 오류!" + e);
		}
		
		return this.result;
	}
	
	public String inok(String aidx) {
		try {
			String sql = "update admins set approval='Y' where aidx=?";
			this.ps = this.con.prepareStatement(sql);
			
			this.ps.setString(1,aidx);
			int success = this.ps.executeUpdate();
			
			if(success > 0) {
				this.result = "ok";
			}
			else {
				this.result = "no";
			}
			
			this.ps.close();
			this.con.close();
			
			
		} catch (Exception e) {
			System.out.println("DB 데이터 수정 오류!" + e);
		}
		
		
		return this.result;
	}
	public String inblock(String aidx) {
		try {
			String sql = "update admins set approval='N' where aidx=?";
			this.ps = this.con.prepareStatement(sql);
			
			this.ps.setString(1,aidx);
			int success = this.ps.executeUpdate();
			
			if(success > 0) {
				this.result = "ok";
			}
			else {
				this.result = "no";
			}
			
			this.ps.close();
			this.con.close();
			
			
		} catch (Exception e) {
			System.out.println("DB 데이터 수정 오류!" + e);
		}
		
		
		return this.result;
	}
}
