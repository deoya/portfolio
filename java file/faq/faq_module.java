package faq;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import airplane.airplane_dao;

@Repository("faqpg")
public class faq_module {
	@Inject
	private SqlSessionFactory sqlSessionFactory_f;
	
	@Resource(name="sqlSession_f")
	private SqlSessionTemplate fs;
	
	//faq 글 등록
	public int insert_faq(faq_dao dao){
		int result = fs.insert("FaqDB.insert_faq",dao);
		return result;
	}
	// faq 전체 글 불러오기
	public List<faq_dao> select_faq_all(){
		List<faq_dao> result = fs.selectList("FaqDB.select_faq_all");
		return result;
	}
	//faq 글 보기
	public faq_dao select_faq_one(String fidx) {
		faq_dao result = fs.selectOne("FaqDB.select_faq_one",fidx);
		return result;
	}
	//faq 글 수정
	public int update_faq(faq_dao dao) {
		int result = fs.update("FaqDB.update_faq", dao);
		return result;
	}
	//faq 글 삭제
	public int delete_faq(String fidx){
		int result = fs.delete("FaqDB.delete_faq", fidx);
		return result;
	}
	//검색
	public List<faq_dao> search_faq(String search){
		List<faq_dao> result = fs.selectList("FaqDB.search_faq", search);
		return result;
	}
	// 페이지 불러오기
	public List<faq_dao> select_fag_pg(int pg_l) {
		List<faq_dao> fd = fs.selectList("FaqDB.faq_pg_select", pg_l);
		return fd;
	}
	
	
}
