package notice;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;


@Repository("cdn")
public class cdn_module {
	FTPClient ftp  = new FTPClient();
	
	FTPClientConfig cf = new FTPClientConfig();
	boolean ok = false;
	String host = 개인정보로 비워 두었습니다
	String user = 
	String pass = 
	int port = 

	public cdn_module() {
	
		try {
			this.ftp.setControlEncoding("utf-8");
			this.ftp.configure(this.cf);
			this.ftp.connect(this.host, this.port);
			this.ftp.login(this.user, this.pass);
		
		} catch (Exception e) {
			System.out.println("FTP 접속 정보 오류 및 접속 사용자 아이디/패스워드 오류 !");
		}
		
	}
	// FTP 파일 업로드
	public boolean cdn(MultipartFile xfile, String filename) {
		try {
			this.ftp.setFileType(FTP.BINARY_FILE_TYPE);
			int result = this.ftp.getReplyCode();
			this.ok = this.ftp.storeFile("/www/"+filename, xfile.getInputStream());
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("FTP 데이터 저장 오류");
		}
		finally {
			try {
				this.ftp.disconnect();				
			}
			catch (Exception ee) {
				System.out.println("서버 루프로 인하여 접속 종료 장애가 있습니다");
			}
		}
		return this.ok;
	}
	
	
	// view 에서 FIP 파일 삭제
	public boolean cdn_delete(String xfile) {
		try {
			this.ok = this.ftp.deleteFile("/www/"+xfile);
		} catch (Exception e) {
			System.out.println("FTP 데이터 삭제 오류");
		}
		finally {
			try {
				this.ftp.disconnect();				
			}
			catch (Exception ee) {
				System.out.println("서버 루프로 인하여 접속 종료 장애가 있습니다");
			}
		}
		return this.ok;
	}
	
	// 다수의 파일 FTP서버에서 삭제
	public ArrayList cdn_delete_list(List<notice_dao> files) {
		
		ArrayList<Boolean> okck = new ArrayList<Boolean>(); 
		ArrayList idx = new ArrayList(); //false 위치값 찾기
		
		int result = 0;
		
		try {
			int w = 0;
			
			while(w < files.size()) { // 정상 삭제 : true - 삭제 실패 : false
				if(files.get(w).getNfile().equals("")){  // 파일첨부가 없는 데이터는 인덱스 넘버 조회를 위해 true로 반영
					okck.add(true);	
				}
				else {
					okck.add(this.ftp.deleteFile("/www/"+files.get(w).getNfile()));					
				}
				w++;
			}
			
			w = 0;
			
			while(w < okck.size()) {
				if(okck.get(w).equals(false)) {
					idx.add(w);
				}
				w++;
			}
			
			
		} catch (Exception e) {
			System.out.println("FTP 데이터 리스트 삭제 오류");
		}
		finally {
			try {
				this.ftp.disconnect();				
			}
			catch (Exception ee) {
				System.out.println("서버 루프로 인하여 접속 종료 장애가 있습니다");
			}
		}
		
		return idx;
	} 
	
}
