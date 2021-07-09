package test.users.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.users.dto.UsersDto;
import test.util.DbcpBean;

public class UsersDao {
	
	private static UsersDao dao;
	private UsersDao() {}
	public static UsersDao getInstance() {
		if(dao==null) {
			dao=new UsersDao();
		}
		return dao;
	}
	//가입정보를 수정하는 메소드
	public boolean update(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE users"
					+ " SET email=?, profile=?"
					+ " WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getProfile());
			pstmt.setString(3, dto.getId());
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
	
	//프로필 이미지 경로를 수정하는 메소드
	public boolean updateProfile(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE users"
					+ " SET profile=?"
					+ " WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getProfile());
			pstmt.setString(2, dto.getId());
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
	
	//비밀번호를 수정하는 메소드
	public boolean updatePwd(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE users"
					+ " SET pwd=?"
					+ " WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getId());
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
	//인자로 전달된 아이디에 해당하는 정보를 삭제하는 메소드
	public boolean delete(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "DELETE FROM users"
					+ " WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, id);
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
			flag = pstmt.executeUpdate();
			System.out.println("회원정보가 삭제되었습니다..");
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
	
	
	//인자로 전달된 아이디에 해당하는 정보를 리턴하는 메소드
	public UsersDto getData(String id) {
		UsersDto dto=null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT pwd, profile, email, regdate"
					+ " FROM users"
					+ " WHERE id=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, id);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {
				dto=new UsersDto();
				dto.setId(id);
				dto.setPwd(rs.getString("pwd"));
				dto.setProfile(rs.getString("profile"));
				dto.setEmail(rs.getString("email"));
				dto.setRegdate(rs.getString("regdate"));
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
		return dto;
	}
	
	//인자로 전달된 아이디가 DB 에 존재하는지 여부를 리턴하는 메소드
	public boolean isExist(String id) {
		boolean isExist=false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT id"
					+ " FROM users"
					+ " WHERE id=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, id);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//만일 select 된 row 가 있다면
			if (rs.next()) {
				isExist=true; //이미 존재하는 아이디라고 표시 
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
		return isExist;
	}
	
	
	//인자로 전달된 회원정보(id, pwd) 가 유효한 정보인지 여부를 리턴하는 메소드
	public boolean isValid(UsersDto dto) {
		//아이디 비밀번호가 유효한 정보인지 여부를 담을 지역변수 만들고 초기값 부여
		boolean isValid=false;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "SELECT id"
					+ " FROM users"
					+ " WHERE id=? AND pwd=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//만일 select 된 row 가 있다면 
			if (rs.next()) {
				isValid=true;
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
		//isValid 에 들어 있는 값을 리턴해 준다. 
		return isValid;
	}
	
	//회원 정보를 DB 에 저장하는 메소드
	public boolean insert(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "INSERT INTO users"
					+ " (id, pwd, email, regdate)"
					+ " VALUES( ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
			flag = pstmt.executeUpdate();
			System.out.println("회원정보 추가햇습니다.");
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





