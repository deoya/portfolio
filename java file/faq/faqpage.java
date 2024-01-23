package faq;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.javascript;
import airplane.airplane_dao;

@Controller
public class faqpage {
	String output = "";
	javascript js = new javascript();
	int result = 0;
	
	@Resource(name="faqpg")
	private faq_module fm;
	
	//faq
	@RequestMapping("/admin_faq.do")
	public void admin_faq(@RequestParam(required = false, defaultValue = "") String search
			,@RequestParam(required = false, defaultValue = "0") String page, Model m) {
		//페이지 
		List<faq_dao> ea = null;
		int pg_l= 0; 
		int view_no = 1; 
		
		if(page.equals("1") || page.equals("0")) {
			 ea = fm.select_faq_all();
			pg_l = 0;
		}
		else {
			 ea = fm.select_faq_all();
			int pg = (Integer.parseInt(page)*10)-10;
			view_no = Integer.parseInt(page);
			pg_l = pg;
		}
		
		m.addAttribute("view_no", view_no); //페이지 넘버링
		List<faq_dao> result = fm.select_fag_pg(pg_l); // 페이지 결과 리스트
		
		
		
		if(search.equals("")) {
			ea = fm.select_faq_all();
			
		}else {
			result = fm.search_faq(search);
			ea = result;
		}
		
		m.addAttribute("search", search);			
		m.addAttribute("list", result);
		m.addAttribute("ea", ea.size());
	}
	
	//faq 등록 완료
	@PostMapping("/admin_faq_writeok.do")
	public String admin_faq_writeok(@ModelAttribute faq_dao dao, Model m) {
		this.result = fm.insert_faq(dao);
	
		
		if(this.result > 0) {

			this.output = this.js.okay("FAQ 작성이 완료 되었습니다", "./admin_faq.do");
		}else {
			this.output = this.js.nope("FAQ 작성에 실패하였습니다");		
		}
		m.addAttribute("output",this.output);
		return "outputpage";
	}
	//faq 확인 및 수정 페이지
	@GetMapping("/admin_faq_modify.do")
	public void admin_faq_modify(@RequestParam(defaultValue = "", required = false) String fidx, Model m) {
		this.output="";
		if(fidx.equals("")) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_faq.do");
		}
		else {
			faq_dao fdOne = fm.select_faq_one(fidx);
			m.addAttribute("fdOne",fdOne);
		}
	}
	
	// faq 글 수정
	@PostMapping("/admin_faq_modifyok.do")
	public String admin_faq_modifyok(@ModelAttribute faq_dao dao, Model m){
		this.result = fm.update_faq(dao);
		if(this.result > 0) {
			this.output = this.js.okay("FAQ 수정이 완료 되었습니다", "./admin_faq.do");
		}else {
			this.output = this.js.nope("FAQ 수정에 실패하였습니다");		
		}
		m.addAttribute("output",this.output);
		return "outputpage";
	}
	// faq 글 삭제
	@GetMapping("/admin_faq_deleteok.do")
	public String admin_faq_deleteok(@RequestParam(required = false, defaultValue = "") String fidx, Model m) {
		this.output="";
		if(fidx.equals("")) {
			this.output = this.js.okay("올바른 접근 방식이 아닙니다","./admin_faq.do");
		}
		else {
			this.result = fm.delete_faq(fidx);
			if(this.result > 0) {
				this.output = this.js.okay("FAQ 삭제가 완료 되었습니다", "./admin_faq.do");
			}else {
				this.output = this.js.nope("FAQ 삭제에 실패하였습니다");		
			}
		}
		m.addAttribute("output",this.output);
		return "outputpage"; 
	}
	@RequestMapping("/admin_faq_write.do")
	public void amdin_faq_write() {}
	
	
	
}
