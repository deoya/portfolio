package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.commons.dbcp.BasicDataSource;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class db_select {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String result = null;
	
	public db_select(BasicDataSource dataSource){
		try {
			this.con = dataSource.getConnection();
		}
		catch (Exception e) {
			System.out.println("DB연결 오류!!" + e);
		}
	}
	
	public String idck(String aid) {
		try {
			String sql = "select count(*) as ctn from admins where aid=?";
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, aid);
			this.rs = this.ps.executeQuery();
			while(this.rs.next()) {
				if(this.rs.getString("ctn").equals("0")) {
					this.result = "0";
				}
				else {
					this.result = "1";
				}
			}
			this.rs.close();
			this.ps.close();
			this.con.close();
			
			
		} catch (Exception e) {
			System.out.println("DB 데이터 찾기 오류!!" + e);
		}
		
		
		return this.result ;
	}
	
	//로그인 확인
	public String loginck(String aid, String apass) {
		
		security sec = new security(apass);
		String newPass = sec.md5_se();
		
		String sql = "select * from admins where aid=?";
		try {
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, aid);
			this.rs = this.ps.executeQuery();
			while(this.rs.next()) {
				if(aid.equals(this.rs.getString("aid"))) {
					
					if(newPass.equals(this.rs.getString("apass"))) {
						this.result = "o"+","+this.rs.getString("aid")+","+this.rs.getString("aname")+","+this.rs.getString("approval");
					}else {
						this.result = "x"+","+this.rs.getString("aid")+","+this.rs.getString("apwdck");
					}
					
			
				}
			}
			this.rs.close();
			this.ps.close();
			this.con.close();
		} catch (Exception e) {
			System.out.println("DB 데이터 찾기 오류!!" + e);
		}
		
		
		return this.result;
	}
	

	@SuppressWarnings("unchecked")
	public String api() {
		try {
			String sql = "select * from admins order by aidx";
			this.ps = this.con.prepareStatement(sql);
			this.rs = this.ps.executeQuery();
			
			
			JSONObject jo2 = new JSONObject(); 
			JSONArray ja2 = new JSONArray();
			JSONArray ja = new JSONArray();
			while(this.rs.next()) {
				JSONObject jo = new JSONObject(); 
				jo.put("aidx", this.rs.getString("aidx"));
				jo.put("aid", this.rs.getString("aid"));
				jo.put("aname", this.rs.getString("aname"));
				jo.put("aemail", this.rs.getString("aemail"));
				jo.put("atel", this.rs.getString("atel"));
				jo.put("adiv", this.rs.getString("adiv"));
				jo.put("aposition", this.rs.getString("aposition"));
				jo.put("adate", this.rs.getString("adate"));
				jo.put("approval", this.rs.getString("approval"));
				ja.add(jo); 
			}
			jo2.put("admin", ja);
			this.result = jo2.toJSONString();
			this.rs.close();
			this.ps.close();
			this.con.close();
			
		}catch (Exception e) {
			System.out.println("DB문법 오류 " + e);
		}
		return this.result;
		
	}
	
}
