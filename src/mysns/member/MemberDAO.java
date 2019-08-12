package mysns.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mysns.util.*;
/**
 * File : MemberDAO.java
 * Desc : SNS 회원 등록 및 로그인 처리 클래스
 * @author 황희정(dinfree@dinfree.com)
 *
 */
public class MemberDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	Logger logger = LoggerFactory.getLogger(MemberDAO.class);

	/**
	 * 신규 회원 등록
	 * @param member
	 * @return
	 */
	public boolean addMember(Member member) {
		conn = DBManager.getConnection();
		String sql = "insert into s_member(name, uid, passwd, email,date, hobby, birth, profile_photo_path) values(?,?,?,?,now(),?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getUid());
			pstmt.setString(3, member.getPasswd());
			pstmt.setString(4, member.getEmail());
			//추가			
			pstmt.setString(5, member.getHobby());
			pstmt.setString(6, member.getBirth());
			pstmt.setString(7, member.getProfilePhotoPath());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 회원 로그인
	 * @param uid
	 * @param passwd
	 * @return
	 */
	public boolean login(Member member) {
		String uid = member.getUid();
		String passwd = member.getPasswd();
		conn = DBManager.getConnection();
		String sql = "select uid, passwd, hobby,profile_photo_path from s_member where uid = ?";
		boolean result = false;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString("passwd").equals(passwd) ) {
				member.setHobby(rs.getString("hobby"));
				member.setProfilePhotoPath(rs.getString("profile_photo_path"));
				result=true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 메인화면 우측 신규회원 목록
	 * @return
	 */
	public ArrayList<String> getNewMembers() {
		ArrayList<String> nmembers = new ArrayList<String>();
		conn = DBManager.getConnection();
		// 회원 목록은 7개 까지만 가져옴
		String sql = "select * from s_member order by date desc limit 0,5";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				nmembers.add(rs.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nmembers;
	}

	//지나간 친구 생일 (7일전까지)
	public ArrayList<String> getBeforeBirthMembers(){
		conn = DBManager.getConnection();
		ArrayList<String> beforMembers = new ArrayList<String>();
		//회원 목록은 일주일 치만 가져옴 

		String sql = "select name, birth from s_member where birth is not null " +
				" and  date_format(now(),'%m%d') - date_format(birth,'%m%d') between 1 and 7 order by birth";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				beforMembers.add("'"+ rs.getString("name")+" '님의 생일 : "+rs.getString("birth"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return beforMembers;

	}
	//생일인 친구들
	public ArrayList<String> getBirthMembers(){

		conn = DBManager.getConnection();
		ArrayList<String> birthMembers = new ArrayList<String>();
		//회원 목록은 일주일 치만 가져옴 

		String sql = "select name, birth from s_member where birth is not null " +
				"and  date_format(birth,'%m%d') = date_format(now(),'%m%d')";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				birthMembers.add("'"+ rs.getString("name")+" '님의 생일 : "+rs.getString("birth"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return birthMembers;


	}
	//앞으로 7일동안 생일인 친구들	
	public ArrayList<String> getAfterBirthMembers(){

		conn = DBManager.getConnection();
		ArrayList<String> afterMembers = new ArrayList<String>();
		//회원 목록은 일주일 치만 가져옴 

		String sql = "select name, birth " + 
				"from s_member where birth is not null " + 
				"and  date_format(now(),'%m%d') - date_format(birth,'%m%d') " + 
				"between 1 and 7 order by birth";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				afterMembers.add("'"+ rs.getString("name")+" '님의 생일 : "+rs.getString("birth"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return afterMembers;

	}


	// 취미가 같은 친구들 목록 
	public ArrayList<Member> getSameHobbyUsers(String hobby){

		conn = DBManager.getConnection();

		String sql = "select uid, name, hobby from s_member where hobby = ?" ;
		ArrayList<Member> rlist = new ArrayList<Member>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hobby);

			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {

				Member m = new Member();
				m.setHobby(rs.getString("hobby"));
				m.setUid(rs.getString("uid"));
				m.setName(rs.getString("name"));

				rlist.add(m);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rlist; 
	}
	
	// 프로필용 - 멤버정보 get
	public Member getMemberByUid(String uid) {
		conn = DBManager.getConnection();

		String sql = "select * from s_member where uid = ?" ;
		Member member = new Member();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);

			ResultSet rs = pstmt.executeQuery();
			Member m = new Member();
			while(rs.next()) {
				m.setUid(rs.getString("uid"));
				m.setName(rs.getString("name"));
				m.setPasswd(rs.getString("passwd"));
				m.setEmail(rs.getString("email")); 
				m.setBirth(rs.getString("birth"));
				m.setHobby(rs.getString("hobby"));
				m.setProfilePhotoPath(rs.getString("profile_photo_path"));
			}
			return m;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}

