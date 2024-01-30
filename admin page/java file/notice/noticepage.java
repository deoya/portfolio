package notice;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

import admin.javascript;

@Controller
public class noticepage {
	String output = "";
	javascript js = new javascript();
	int result = 0;
	
	
	
	@Resource(name="notice")
	private notice_module nm; 
	@Resource(name="cdn")
	private cdn_module cdn; 
	
	
	// 글 보기
	@GetMapping("/admin_notice_view.do")
	public String admin_notice_view(@RequestParam(defaultValue = "", required = false) String nidx,@RequestParam(defaultValue = "", required = false) String idx, Model m) {
		this.output="";
		if(nidx.equals("")) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_notice.do");
		}
		else {
			notice_dao ndOne = nm.select_noticeOne(nidx);
			m.addAttribute("ndOne",ndOne);
			m.addAttribute("idx",idx);
		}
		
		m.addAttribute("output",this.output);
		return "admin_notice_view";
	}
	
	
	// 글 List에서 삭제
	@GetMapping("/admin_notice_deleteAll.do")
	public String admin_notice_deleteAll(@RequestParam(defaultValue = "", required = false) ArrayList nidx, Model m) {

		
		ArrayList falses = new ArrayList(); // 실패한 ndix 넘버들만 추출
		
		
		this.output="";
		if(nidx.size() == 0) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_notice.do");
		}
		else {
			Collections.reverse(nidx); // 게시판에서 뒤집은 nidx를 원래대로
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("datas", nidx);
			//FTP 서버에서 데이터 삭제
			List<notice_dao> files = nm.select_files(map); // 파일 정보 불러오기
			
			this.cdn = new cdn_module();
			ArrayList idx = cdn.cdn_delete_list(files);// 파일 데이터 확인
			
			if(idx.size() == 0) {// 파일 전체 삭제 성공 시
				this.result = nm.delete_list(map); 	
				if(this.result > 0) {
					this.output = this.js.okay("삭제가 완료 되었습니다", "./admin_notice.do");
				}
				else {
					this.output = this.js.nope("게시글 삭제에 실패하였습니다");
				}
				
			}else { // 파일 일부 실패 시 : 해당 글 제외 하고 DB삭제
				int w = 0;
				int f = 0;
				
				while(w < idx.size()) {
					falses.add(nidx.remove((int)idx.get(w)-f));
					f++;
					w++;
				}
				
				map.put("datas", nidx);
				this.result = nm.delete_list(map); 
			}
			if(this.result > 0 ) {
				this.output = this.js.okay("해당 게시글 외 삭제에 성공하였습니다 [실패 게시글 넘버 : "+falses+"]", "./admin_notice.do");					
			
			}
			else {
				this.output = this.js.nope("게시글 삭제에 실패하였습니다");
			}
			
		}
		
		m.addAttribute("output",this.output);
		return "outputpage";
	}
	
	
	// 글view에서 삭제
	@GetMapping("/admin_notice_delete.do")
	public String admin_notice_delete(@RequestParam(defaultValue = "", required = false) String nidx,
			@RequestParam(defaultValue = "", required = false) String xfile,
			Model m) {
		
		
		this.output="";
		if(nidx.equals("")) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_notice.do");
		}
		else {
			this.result = nm.delete_view(nidx);
			
			
			if(xfile.equals("")) {
				if(this.result > 0) {
					this.output = this.js.okay("삭제가 완료 되었습니다", "./admin_notice.do");
				}
				else {
					this.output = this.js.nope("게시글 삭제에 실패하였습니다");
				}
				
			}else {
				this.cdn = new cdn_module();
				boolean ok = cdn.cdn_delete(xfile);
				if(ok == false) {
					this.output = this.js.nope("게시글 삭제에 실패하였습니다");
				}
				else if(ok == true && this.result > 0) {
					this.output = this.js.okay("삭제가 완료 되었습니다", "./admin_notice.do");
				}
			}
			
		}
		
		m.addAttribute("output",this.output);
		return "outputpage";
	}
	
	// 글 수정 화면
	@GetMapping("/admin_notice_modify.do")
	public String admin_notice_modify(@RequestParam(defaultValue = "", required = false) String nidx, Model m) {
		this.output="";
		if(nidx.equals("")) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_notice.do");
		}
		else {
			notice_dao ndOne = nm.select_noticeOne(nidx);
			m.addAttribute("ndOne",ndOne);
		}
		
		m.addAttribute("output",this.output);
		return "admin_notice_modify";
	}
	// 글 수정 완료
	@PostMapping("/admin_notice_modifyok.do")
	public String admin_notice_modifyok(@ModelAttribute("nd") notice_dao notice_dao,
			@RequestParam("userfile") MultipartFile xfile,
			@RequestParam(defaultValue = "", required = false) String oldfile,
			HttpServletRequest req,
			Model m) {
	
		
	
		
		//Nimportant 가 null인경우
		if(notice_dao.getNimportant() == null) {
			notice_dao.setNimportant("N");
		}
		
		
		//▶파일을 첨부하지 않았을 경우
		if(xfile.getOriginalFilename() == "") {
			this.result = nm.update_notice(notice_dao,"none");
			if(this.result > 0) {
				this.output = this.js.okay("게시글 수정이 완료 되었습니다", "./admin_notice.do");
			}else {
				this.output = this.js.nope("게시글 수정에 실패하였습니다");		
			}
		}
		//▶파일 첨부가 있을 경우 
		else { 
			
			long filesize = xfile.getSize();
			if(filesize > 2097152) { // 2MB
				
				System.out.println("첨부파일 용량 초과 되었습니다");
				this.output = this.js.nope("첨부파일 용량 초과 되었습니다");	
			}
			else {
				this.cdn = new cdn_module();
				boolean oldok = cdn.cdn_delete(oldfile);
				
				if(oldok == true) {
					Date today = new Date();
					SimpleDateFormat fr = new SimpleDateFormat("yyyyMMddHHmmss"); 	
					
					String day = fr.format(today);

					String filename = day+"-"+xfile.getOriginalFilename();
					//------------------------------------------------------------------------
					this.cdn = new cdn_module();
					boolean ok = cdn.cdn(xfile, filename);
					System.out.println(filename);
					if(ok == true) {
						System.out.println("정상적으로 업로드 되었습니다");
						notice_dao.setNfile(filename);
						
						this.result = nm.update_notice(notice_dao,"yse");
						
							if(this.result > 0) {
								this.output = this.js.okay("게시글 수정이 완료 되었습니다", "./admin_notice.do");
							}else {
								this.output = this.js.nope("게시글 수정에 실패하였습니다");		
							}
					}
					else {
						System.out.println("FTP 경로 오류 발생 되었습니다1");
						this.output = this.js.nope("게시글 수정에 실패하였습니다");
					}
				}else {
					System.out.println("FTP 경로 오류 발생 되었습니다2");
					this.output = this.js.nope("게시글 수정에 실패하였습니다");
				}
				
			}
		}
		
		
		
		m.addAttribute("output",this.output);
		
		return "outputpage";
	}
	
	
	// 전체글 불러오기
	@GetMapping("/admin_notice.do")
	public String admin_notice( Model m,@ModelAttribute("nd") notice_dao notice_dao,@RequestParam(required = false, defaultValue = "0") String page) {
		
		int pg_l= 0; // limit 
		int view_no = 1; // 보낼 페이지 변수 
		
		if(page.equals("1") || page.equals("0")) {
			// 페이지의 번호가 없는 경우 또는 1번 페이지 눌렀을 때 
			pg_l = 0;
		}
		else {
			// 다른 페이지를 눌렀을때
			int pg = (Integer.parseInt(page)*3)-3;
			view_no = Integer.parseInt(page);
			pg_l = pg;
		}
		
		
		m.addAttribute("view_no", view_no);
		List<notice_dao> result = nm.select_notice_pg(pg_l);
		m.addAttribute("list",result);
		
		
		//공지사항 체크 글 및 전체 페이지 수 확인 용
		List<notice_dao> nd = nm.select_notice(notice_dao);
		
		m.addAttribute("allnotice",nd);
		
		return "admin_notice";
	}
	
	//글 작성 완료
	@PostMapping("/admin_notice_writeok.do")
	public String admin_notice_writeok(@ModelAttribute("nd") notice_dao notice_dao,
			@RequestParam("userfile") MultipartFile xfile,
			HttpServletRequest req,
			Model m) {
		
		
		//Nimportant 가 null인경우
		if(notice_dao.getNimportant() == null) {
			notice_dao.setNimportant("N");
		}
		
		//▶파일을 첨부하지 않았을 경우
		if(xfile.getOriginalFilename() == "") {
			notice_dao.setNfile("");
			this.result = nm.insert_notice(notice_dao);
			
		}
		 //▶ 파일 첨부가 있을 경우 
		else {
			long filesize = xfile.getSize();
			
			
			if(filesize > 2097152) { // 2MB
				
				System.out.println("첨부파일 용량 초과 되었습니다");
				this.output = this.js.nope("첨부파일 용량 초과 되었습니다");	
			}
			else {
				Date today = new Date();
				SimpleDateFormat fr = new SimpleDateFormat("yyyyMMddHHmmss"); 	
				
				String day = fr.format(today);
				String filename = day+"-"+xfile.getOriginalFilename();
				
				this.cdn = new cdn_module();
				boolean ok = cdn.cdn(xfile, filename);
		
				
				if(ok == true) {
					System.out.println("정상적으로 업로드 되었습니다11");
					notice_dao.setNfile(filename);
					
					this.result = nm.insert_notice(notice_dao);
					
					
				}
				else {
					System.out.println("FTP 경로 오류 발생 되었습니다");
				}
			}
		}
		if(this.result > 0) {
			this.output = this.js.okay("게시글 등록이 완료 되었습니다", "./admin_notice.do");
		}else {
			this.output = this.js.nope("게시글 등록에 실패하였습니다");		
		}
		
		
		m.addAttribute("output",this.output);
	
		return "outputpage";
	}
	
}
