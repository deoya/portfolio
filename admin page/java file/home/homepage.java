package home;

import java.util.ArrayList;
import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.javascript;

@Controller
public class homepage {
	String output = "";
	javascript js = new javascript();
	int result = 0;
	
	
	@Resource(name="homepg")
	private homepage_module hm;
	

	@GetMapping("/admin_siteinfo.do")
	public String admin_siteinfo(Model m) {
		homepg_info_dao result = hm.select_homepg_info();
		m.addAttribute("homepg_info",result);
		
		return "admin_siteinfo";
		
	}
	
	
	@PostMapping("/admin_siteinfo_save.do")
	public String admin_siteinfo_save(@ModelAttribute("hd") homepg_info_dao homepg_dao, Model m) {
		int count = hm.selectCk_homepg_info();
		
		if(count == 0) {
			this.result = hm.insert_homepg_info(homepg_dao);
			if(this.result > 0) {
				this.output = this.js.okay("등록 완료 되었습니다","./admin_siteinfo.do");	
			}
			else {
				this.output = this.js.nope("등록에 실패 하였습니다");
			}
		}
		else {
			this.result = hm.update_homepg_info(homepg_dao);
			
			if(this.result > 0) {
				this.output = this.js.okay("등록 완료 되었습니다","./admin_siteinfo.do");	
			}
			else {
				this.output = this.js.nope("등록에 실패 하였습니다");
			}
		}
		m.addAttribute("output",this.output);
		return "outputpage";

	}
	
}
