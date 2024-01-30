package main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("main")
public class main_module {
	@Inject
	private SqlSessionFactory sqlSessionFactory;
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate ms;
	
	//예매리스트등록
	public int insert_reserve(main_dao dao) {
		int result = ms.insert("MainDB.insert_user_reserve", dao);
		
		return result;
	}
	
	//좌석 불러오기
	public List<String> seat_ch(main_dao dao){
		List<String> seat = ms.selectList("MainDB.select_seat_form", dao);
	
		return seat;
	}
	
	// 출발지 불러오기
	public List<String> select_airplane_start(){
		List<String> start = ms.selectList("MainDB.select_start_point");
		return start;
	}
	
	//api 제작
	public JSONObject select_airplane(){
		List<main_dao> m = ms.selectList("MainDB.select_air_plane");//전체 출력
		List<Object> start = ms.selectList("MainDB.select_start_point"); // 출발지 출력
		List<main_dao> end = null;
		int w = 0;
		JSONObject jo = new JSONObject();
		
		while(w < start.size()) {
			JSONArray ja = new JSONArray();
			
			end = ms.selectList("MainDB.select_end_point",start.get(w)); // 도착지 출력
				
			int ww=0;
			while(ww < end.size()) {
				
				ja.add(end.get(ww));
				ww++;
			}
			jo.put(start.get(w), ja);
			w++;
		}
		

		return jo;

	}
}
 