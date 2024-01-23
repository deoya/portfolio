package login;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.admin_dto;
import admin.javascript;
import home.homepage_module;
import home.homepg_info_dao;
import login.db_insert;
import login.db_select;

@Controller
public class loginpage {
	String output = null;
	javascript js = new javascript();
	
	@Autowired
	BasicDataSource dataSource;
	
	@Resource(name="homepg")
	private homepage_module hm;
	
	//★★관리자 회원가입
	@PostMapping("/masterjoinok.do")
	public String masterjoinok(Model m,
			@RequestParam String aid,
			@RequestParam String apass,
			@RequestParam String aname,
			@RequestParam String aemail,
			@RequestParam String atel,
			@RequestParam String adiv,
			@RequestParam String aposition
			) {
		admin_dto adto = new admin_dto();
		adto.setAid(aid);
		adto.setAdiv(adiv);
		adto.setAemail(aemail);
		adto.setAname(aname);
		adto.setApass(apass);
		adto.setAposition(aposition);
		adto.setAtel(atel);
		
		db_insert dbin = new db_insert(dataSource);
		int success = dbin.admin_insert(adto);
		
		if(success > 0 ) {
			this.output = this.js.okay("정상적으로 관리자등록을 완료 하였습니다", "./index.jsp");
		}else {
			this.output = this.js.nope("관리자 등록에 실패하였습니다");
		}
		
		m.addAttribute("output", this.output);
		return "outputpage";
	}
	
	
	
	//★★회원가입 아이디 중복 체크
	@GetMapping("/idcheck.do")
	public void idcheck(@RequestParam String aid,HttpServletResponse res) {
		db_select dbs = new db_select(dataSource);
		String msg = dbs.idck(aid);
		try {
			PrintWriter pw = res.getWriter();	
			pw.print(msg);
			pw.close();
		}
		catch (Exception e) {
			System.out.println("ajax 전달 오류!"+e);
		}
	}
	
	
	//★★로그인
	@PostMapping("/loginck.do")
	public String loginck(HttpServletRequest req, @RequestParam String aid, @RequestParam String apass, Model m) {
		HttpSession session = req.getSession();
	
		db_select dbs = new db_select(dataSource);	
		String success = dbs.loginck(aid,apass);
		
		if(success == null || success == "") {
			this.output = this.js.nope("아이디를 다시 확인하여 주세요 ");

		}
		else {
			String admininfo[] = success.split(",");
			if(admininfo[0].equals("o")) {
				if(admininfo[3].equals("N")) {
					this.output = this.js.nope("관리자의 승인처리가 필요합니다");
					
				}
				else {
					
					//사이트 기본설정 입력시 footer 반영
					homepg_info_dao result = hm.select_homepg_info();
					ArrayList<String> home = new ArrayList<String>();
					home.add(result.getHcompany());
					home.add(result.getHcompany_num());
					home.add(result.getHceo());
					home.add(result.getHceo_hp());
					home.add(result.getHreport_num());
					home.add(result.getHprovide_num());
					home.add(result.getHpost_code());
					home.add(result.getHaddr());
					home.add(result.getHinfo_officer());
					home.add(result.getHinfo_email());
					session.setAttribute("info", home);
					
					
					session.setAttribute("aid", admininfo[1]);
					session.setAttribute("aname", admininfo[2]);
					this.output = this.js.okay("정상적으로 로그인 되었습니다", "./admin_main.jsp");
					// 횟수 초기화
					db_update dbu = new db_update(dataSource);
					dbu.loginnum(aid, 0);
					
					
					
				}
			}
			else {
				int num = Integer.parseInt(admininfo[2]);
				if (num > 4) {
					this.output = this.js.nope("패스워드 오류를 5번 초과하셨습니다. 센터에 문의하여 주시기 바랍니다.");
				}
				else {
					num++;
					db_update dbu = new db_update(dataSource);
					dbu.loginnum(aid, num);
					this.output = this.js.nope("아이디 및 비밀번호를 다시 확인하여 주세요.오류 발생 횟수가 5번을 초과하면 자동 차단됩니다. 오류 횟수"+num);
				}
			}
		}
	
		
		m.addAttribute("output",output);
		return "outputpage";
		
		
	}
	//★★로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest req, Model m) {
		HttpSession sesseion =  req.getSession();
		sesseion.removeAttribute("aid");
		sesseion.removeAttribute("aname");
		//sesseion.removeAttribute("info");
		
		this.output = this.js.okay("정상적으로 로그아웃 되었습니다","./index.jsp");
		
		m.addAttribute("output", this.output);
		return "outputpage";
	}
	
	
	//★★관리자 리스트
	@RequestMapping("/api_json.do") 
	public String apiserver(Model m) {
		db_select dbs = new db_select(dataSource);
		String datalist = dbs.api();
		m.addAttribute("datalist",datalist);
		return null;
	}
	
	
	
	@GetMapping("/inok.do")
	public String inok(@RequestParam String aidx, Model m) {
		
		db_update dbu = new db_update(dataSource);
		String result =  dbu.inok(aidx);
		if(result == "ok") {
			this.output = this.js.okay("정상적으로 승인처리 되었습니다","./admin_main.jsp");
		}
		else {
			this.output = this.js.nope("처리가 되지 않았습니다. 잠시후 다시 이용하여 주시기 바랍니다");
		}
		
		m.addAttribute("output", this.output);
		return "outputpage";
	}
	
	@GetMapping("/inblock.do")
	public String inblock(@RequestParam String aidx, Model m) {
		
		db_update dbu = new db_update(dataSource);
		String result =  dbu.inblock(aidx);
		if(result == "ok") {
			this.output = this.js.okay("정상적으로 미승인처리 되었습니다","./admin_main.jsp");
		}
		else {
			this.output = this.js.nope("처리가 되지 않았습니다. 잠시후 다시 이용하여 주시기 바랍니다");
		}
		
		m.addAttribute("output", this.output);
		return "outputpage";
	}
	

	
}
