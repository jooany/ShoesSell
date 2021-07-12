package test.resell.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.resell.dto.ResellDto;
import test.util.DbcpBean;

public class ResellDao {
	private static ResellDao dao;
	private ResellDao() {}
	public static ResellDao getInstance() {
		if(dao==null) {
			dao=new ResellDao();
		}
		return dao;
	}
	//조회수 증가 시키는 메소드
	public boolean addViewCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE resell"
					+ " SET viewCount=viewCount+1"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
			flag = pstmt.executeUpdate();
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
	
	//글 하나의 정보를 수정하는 메소드
	public boolean update(ResellDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE resell"
					+ " SET title=?,content=?,imagePath=?"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getImagePath());
			pstmt.setInt(4, dto.getNum());
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
			flag = pstmt.executeUpdate();
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
	
	//글 하나의 정보를 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "DELETE FROM resell"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
			flag = pstmt.executeUpdate();
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
	//글하나의 정보를 리턴하는 메소드
	public ResellDto getData(int num) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT num,title,writer,content,viewCount,regdate,imagePath,kind"
					+ " FROM resell"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
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
	
	//글하나의 정보를 리턴하는 메소드
	public ResellDto getKind(ResellDto dto) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"	(SELECT num,title,writer,content,viewCount,regdate,imagePath,kind," + 
					"	LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
					"	LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
					"	FROM resell" + 
					"	ORDER BY num DESC)" + 
					" WHERE kind=?";
			
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getKind());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
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
	
	//글하나의 정보를 리턴하는 메소드
	public ResellDto getData(ResellDto dto) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"	(SELECT num,title,writer,content,viewCount,regdate,imagePath,kind," + 
					"	LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
					"	LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
					"	FROM resell" + 
					"	ORDER BY num DESC)" + 
					" WHERE num=?";
			
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
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
	public ResellDto getDataT(ResellDto dto) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"	(SELECT num,title,writer,content,viewCount,regdate,imagePath,kind," + 
					"	LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
					"	LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
					"	FROM resell"+ 
					"   WHERE title LIKE '%'||?||'%'" + 
					"	ORDER BY num DESC)" + 
					" WHERE num=?";
			
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setInt(2, dto.getNum());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
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
	public ResellDto getDataW(ResellDto dto) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"	(SELECT num,title,writer,content,viewCount,regdate,imagePath,kind," + 
					"	LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
					"	LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
					"	FROM resell"+ 
					"   WHERE writer LIKE '%'||?||'%'" + 
					"	ORDER BY num DESC)" + 
					" WHERE num=?";
			
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getNum());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
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
	public ResellDto getDataTC(ResellDto dto) {
		ResellDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"	(SELECT result.*," + 
					"	LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
					"	LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
					"	FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind "
					+ 		 " FROM resell "
					+ 		 " WHERE kind=? ) result1"+ 
					"   WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'" + 
					"	ORDER BY num DESC)" + 
					" WHERE num=?";
			
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if(rs.next()) {
				dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
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
	
	
	
	//새글 저장하는 메소드 
	public boolean insert(ResellDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete 문 구성
			String sql = "INSERT INTO resell"
					+ " (num,writer,title,content,viewCount,regdate,imagePath,kind)"
					+ " VALUES(resell_seq.NEXTVAL,?,?,?,0,SYSDATE,?,?)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getImagePath());
			pstmt.setString(5, dto.getKind());
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
	//글 목록을 리턴하는 메소드 
	public List<ResellDto> getList(ResellDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<ResellDto> list=new ArrayList<ResellDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result2.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT result1.* " + 
					"		        FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind"  + 
					"					  FROM resell " + 
					"					  WHERE kind=? ) result1 " + 
					"		        ORDER BY num DESC) result2)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				ResellDto dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				list.add(dto2);
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
		return list;
	}
	//전체 글의 갯수를 리턴하는 메소드
	public int getCount(ResellDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "+  
					"		  FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind " + 
					"			    FROM resell " + 
					"			    WHERE kind=? ) ";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
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
		return count;
	}
	
	public int getCountMain() {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num"
					+ " FROM resell";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
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
		return count;
	}
	/*
	 *  Title 검색일때 실행할 메소드
	 *  ResellDto 의 title 이라는 필드에 검색 키워드가 들어 있다.
	 */
	public List<ResellDto> getListT(ResellDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<ResellDto> list=new ArrayList<ResellDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result2.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT result1.* " + 
					"				 FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind" + 
					"					   FROM resell " + 
					"					   WHERE kind=? ) result1 " + 
					"			    WHERE title LIKE '%' || ? || '%'" +					
					"		        ORDER BY num DESC) result2)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(2, dto.getTitle());
			pstmt.setInt(3, dto.getStartRowNum());
			pstmt.setInt(4, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				ResellDto dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				list.add(dto2);
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
		return list;
	}
	/*
	 *  Writer 검색일때 실행할 메소드
	 *  ResellDto 의 writer 이라는 필드에 검색 키워드가 들어 있다.
	 */
	public List<ResellDto> getListW(ResellDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<ResellDto> list=new ArrayList<ResellDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result2.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT result1.* " + 
					"				 FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind " + 
					"					   FROM resell " + 
					"					   WHERE kind=? ) result1  "+ 
					"			    WHERE writer LIKE '%' || ? || '%'"+					
					"		        ORDER BY num DESC) result2)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(2, dto.getWriter());
			pstmt.setInt(3, dto.getStartRowNum());
			pstmt.setInt(4, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				ResellDto dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				list.add(dto2);
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
		return list;
	}
	/*
	 *  Title, Content 검색일때 실행할 메소드
	 *  ResellDto 의 title, content 이라는 필드에 검색 키워드가 들어 있다.
	 */
	public List<ResellDto> getListTC(ResellDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<ResellDto> list=new ArrayList<ResellDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result2.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT result1.* " + 
					"				 FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind" + 
					"		               FROM resell " + 
					"					   WHERE kind=? ) result1 "+ 
					"			    WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"+					
					"		        ORDER BY num DESC) result2)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getStartRowNum());
			pstmt.setInt(5, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				ResellDto dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				list.add(dto2);
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
		return list;
	}
	//제목 검색했을때 전체 row 의 갯수 리턴
	public int getCountT(ResellDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM (SELECT result1.* " + 
					"		  FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind" + 
					"				FROM resell " + 
					"				WHERE kind=? ) result1 "
					+ " WHERE kind=? AND (title LIKE '%'||?||'%') ";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(1, dto.getTitle());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
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
		return count;
	}
	//작성자 검색했을때 전체 row 의 갯수 리턴
	public int getCountW(ResellDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM (SELECT result1.*" + 
					"		  FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind" + 
					"				FROM resell " + 
					"				WHERE kind=? ) result1"
					+ " WHERE writer LIKE '%'||?||'%' ";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(2, dto.getWriter());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
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
		return count;
	}
	//제목, 내용 검색했을때 전체 row 의 갯수 리턴
	public int getCountTC(ResellDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM (SELECT result1.*" + 
					"		  FROM (SELECT num,title,writer,content,viewCount,regdate,imagePath,kind" + 
					"			    FROM resell " + 
					"			    WHERE kind=? ) result1 )" +
					" WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getKind());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
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
		return count;
	}
	
	//메인에서 쓰일 업로드된 모든 사진의 정보를 리턴하는 메소드 
	public List<ResellDto> getListMain(ResellDto dto){
		List<ResellDto> list=new ArrayList<ResellDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result1.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT num, writer, title, content, viewCount, regdate, imagePath, kind" + 
					"		        FROM resell"+
					"		        ORDER BY viewCount DESC) result1)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			
			pstmt=conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				ResellDto dto2=new ResellDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setKind(rs.getString("kind"));
				dto2.setRowNum(rs.getInt("rnum"));
				list.add(dto2);
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
		return list;
	}
}



