package test.feed.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.feed.dto.FeedDto;
import test.util.DbcpBean;

public class FeedDao {
	
	private static FeedDao dao;

	static {
		dao=new FeedDao();
	}
	private FeedDao() {}
	public static FeedDao getInstance() {
		return dao;
	}
	
	//피드 하나의 정보를 리턴하는 메소드
	public FeedDto getData(int articleNum){
		FeedDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "			SELECT * " + 
					"					FROM " + 
					"						(SELECT result1.*, ROWNUM AS rnum " + 
					"						FROM " + 
					"							(SELECT num, writer, title, content," + 
					"							feed.regdate, imagePath, profile, goodCount, isGood FROM feed " + 
					"							INNER JOIN users ON feed.writer = users.id " + 
					"							ORDER BY num DESC) result1) " + 
					"					 WHERE rnum = ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, articleNum);

			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {
				dto2=new FeedDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setProfile(rs.getString("profile"));
				dto2.setGoodCount(rs.getInt("goodCount"));
				dto2.setIsGood(rs.getString("isGood"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return dto2;
	}
	
		//새 피드 작성
		public boolean insert(FeedDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				
				String sql = "INSERT INTO feed"
						+ " (num,writer,title,content,imagePath,regdate,goodCount)"
						+ " VALUES(board_cafe_seq.NEXTVAL,?,?,?,?,SYSDATE,126)";
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 바인딩한다.
				pstmt.setString(1, dto.getWriter());
				pstmt.setString(2, dto.getTitle());
				pstmt.setString(3, dto.getContent());
				pstmt.setString(4, dto.getImagePath());
				flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}
			if (flag > 0) {
				return true;
			} else {
				return false;
			}
		}
	
}
