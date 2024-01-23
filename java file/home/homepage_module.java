package home;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("homepg")
public class homepage_module {
	@Inject  
	private SqlSessionFactory sqlSessionFactory_h; 

	@Resource(name="sqlSession_h")
	private SqlSessionTemplate hs;
	
	// 등록된 데이터 업데이트
	public int update_homepg_info(homepg_info_dao homepg_dao) {
		
		hs.delete("HomepgDB.homepg_info_update");
		int result = hs.insert("HomepgDB.homepg_info_insert",homepg_dao);
		
		return result;
	}
	
	
	//이미 등록된 데이터가 있는지 확인
	public int selectCk_homepg_info() {
		Integer result = hs.selectOne("HomepgDB.homepg_info_selectOne");
		return  result;
	}
	
	//info 저장
	public int insert_homepg_info(homepg_info_dao homepg_dao) {
		int result = hs.insert("HomepgDB.homepg_info_insert",homepg_dao);
		return result;
	}
	
	
	// 등록된 데이터 조회
	public homepg_info_dao select_homepg_info() {
		System.out.println("dddd");
		homepg_info_dao result = hs.selectOne("HomepgDB.homepg_info_select");
		return result;
		//return null;
	}
	
	
	
}
