package main;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class mainpage {
	String output = "";
	javascript js = new javascript();
	
	
	@Resource(name="main")
	private main_module mm;

	//api제작
	@RequestMapping("/index.do")
	public void index(Model m) {
		JSONObject list = mm.select_airplane();
		List<String> start = mm.select_airplane_start();
	
		m.addAttribute("list", list);
		m.addAttribute("start", start);
	}
	//시트 형태 조회
	@RequestMapping("/index_seat_ch.do")
	public void index_seat_ch(HttpServletResponse res,
			@RequestParam(required = false, defaultValue = "") String start_point,
			@RequestParam(required = false, defaultValue = "") String end_point) throws Exception{
		main_dao dao = new main_dao();
		dao.setStart_point(start_point);
		dao.setEnd_point(end_point);
		List<String> seat = mm.seat_ch(dao);
		
		JSONArray ja = new JSONArray();
		
		int ww=0;
		while(ww < seat.size()) {
			
			ja.put(seat.get(ww));
			ww++;
		}
		
		
		PrintWriter pw = res.getWriter();
		pw.print(ja);
		pw.close();
		
	}
	@RequestMapping("/reserveok.do")
	public String reserveok(@ModelAttribute main_dao dao,Model m) {
		int result = mm.insert_reserve(dao);
		
		if(result > 0) {
			this.output = js.okay("예매가 완료되었습니다","./index.do");
		}
		else {
			this.output = js.nope("예매에 실패하였습니다");			
		}
		
		m.addAttribute("output",this.output);
	
		return "outputpage";
	}
	
}
