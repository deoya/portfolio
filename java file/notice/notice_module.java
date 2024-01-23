package notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("notice")
public class notice_module {
	SqlSession se = null;
	List<notice_dao> nd = null;
	
	@Inject  
	private SqlSessionFactory sqlSessionFactory; 

	@Resource(name="sqlSession")
	private SqlSessionTemplate ns;
	
	// 전체글 불러오기
	public List select_notice(notice_dao notice_dao) {
		
		try {
			this.se = sqlSessionFactory.openSession();
			this.nd = this.se.selectList("NoticeDB.admin_notice_select"); 
			
		}
		catch (Exception e) {
			System.out.println("DB 접속 오류 발생 " + e);
		}
		finally {
			this.se.close();
		}
		return this.nd;
	}
	
	// 페이지 불러오기
	public List select_notice_pg(Integer nidx) {
		this.nd = ns.selectList("NoticeDB.admin_notice_pg_select", nidx);
		return this.nd;
	}
	
	
	// 글 view 불러오기 + 조회수 1 증가
	public notice_dao select_noticeOne(String nidx) {
		
		ns.update("NoticeDB.admin_notice_viewcount", nidx);
		notice_dao ndOne  = ns.selectOne("NoticeDB.admin_noticeOne_select", nidx);
		
		return ndOne;
	}
	
	// 게시글 저장
	public int insert_notice(notice_dao notice_dao) {
		int result = ns.insert("NoticeDB.admin_notice_insert", notice_dao);
		return result;
	}
	// 게시글 수정
	public int update_notice(notice_dao notice_dao, String a) {

		int result = 0;
		
		if(a == "none") { // 첨부파일 변경사항이 없을 경우
			result = ns.update("NoticeDB.admin_notice_updateFileNone",notice_dao);
		}
		else {
			result = ns.update("NoticeDB.admin_notice_updateFileYes",notice_dao);			
		}
		
		return result;
	}
	
	
	// 게시글 view 에서 삭제
	public int delete_view(String nidx) {
		int result = ns.delete("NoticeDB.admin_notice_deleteView",nidx);
		
		return result;
	}
	// 게시글 List 에서 삭제
	public int delete_list(Map<String, Object> nidx) {
		int result = ns.delete("NoticeDB.admin_notice_deleteList",nidx);
		System.out.println(result);
		return result;
	}
	// 파일 데이터 조회
	public List<notice_dao> select_files(Map<String, Object> list) {
		List<notice_dao> result  = ns.selectList("NoticeDB.admin_notice_file_list",list);
		return result;
	}
	
}
