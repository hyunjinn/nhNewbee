package mysns.sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mysns.member.MemberDAO;
import mysns.util.*;

/**
 * File : MessageDAO.java
 * Desc : SNS 게시글 Data Access Object 클래스
 * @author 황희정(dinfree@dinfree.com)
 *
 */
public class MessageDAO {
	Connection conn;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	public ArrayList<MessageSet> getMsgList(int cnt, String suid) {
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();
		conn = DBManager.getConnection();
		String sql;

		try {
			// 전체 게시물인 경우
			if((suid == null) || (suid.equals(""))) {
				sql = "select * from s_message order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnt);
			}
			// 특정 회원 게시물 only 인 경우
			else{
				sql = "select * from s_message where uid=? order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,suid);
				pstmt.setInt(2,cnt);
			}

			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MessageSet ms = new MessageSet();
				Message m = new Message();
				
				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getDate("date")+" "+rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setUid(rs.getString("uid"));
				m.setPhotoPath(rs.getString("photo_path"));
				ms.setMessage(m);
				datas.add(ms);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				//rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}		
		return datas;
	}
	
	// 특정 메시지에 연관된 메시지, 댓글 목록 , 좋아요 누른 유저 목록 
	public MessageSet getMessageSet(String mid) {
		conn = DBManager.getConnection();
		String sql;
		MessageSet ms = new MessageSet();
		try {
			/** 1.  특정 회원 게시물 only 인 경우 메시지 get */
			sql = "select * from s_message where mid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,mid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Message m = new Message();
				ArrayList<Reply> rlist = new ArrayList<Reply>();
				
				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getDate("date")+" / "+rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setUid(rs.getString("uid"));
				m.setPhotoPath(rs.getString("photo_path"));
				
				/** 2. 댓글 목록 */ 
				String rsql = "select r.*, profile_photo_path " + 
						"from s_reply r " + 
						"left join s_member m on r.uid = m.uid " + 
						"where mid=? order by date desc ";
				pstmt = conn.prepareStatement(rsql);
				pstmt.setInt(1,rs.getInt("mid"));
				ResultSet rrs = pstmt.executeQuery();
				while(rrs.next()) {
					Reply r = new Reply();
					r.setRid(rrs.getInt("rid"));
					r.setUid(rrs.getString("uid"));
					r.setMid(Integer.parseInt(rrs.getString("mid")));
					r.setRmsg(rrs.getString("rmsg"));
					r.setDate(rrs.getDate("date")+"/"+rrs.getTime("date"));
					r.setProfilePath(rrs.getString("profile_photo_path"));
					rlist.add(r);
				}
				rrs.last();
				m.setReplycount(rrs.getRow());
				rrs.close();
				//System.out.println("r count"+rrs.getRow());
				
				ms.setMessage(m);
				ms.setRlist(rlist);
				
				
				
				/** 3. 좋아요 누른사람 목록 */
				String sql2 = "SELECT * FROM s_like where mid = ? order by date desc" ;
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1,rs.getInt("mid"));
				ResultSet rs2 = pstmt.executeQuery();
				ArrayList<Like> likeList = new ArrayList<Like>();
				while(rs2.next()) {
					Like like = new Like();
					like.setMid(rs2.getInt("mid"));
					like.setDate(rs2.getDate("date")+"/"+rs2.getTime("date"));
					like.setUid(rs2.getString("uid"));
					likeList.add(like);
				}
				rs2.last();
				ms.setLikeList(likeList);
				rs2.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				//rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}		
		return ms;
	}
	
	public ArrayList<MessageSet> getAll(int cnt, String suid) {
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();
		conn = DBManager.getConnection();
		String sql;

		try {
			// 전체 게시물인 경우
			if((suid == null) || (suid.equals(""))) {
				sql = "select * from s_message order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnt);
			}
			// 특정 회원 게시물 only 인 경우
			else{
				sql = "select * from s_message where uid=? order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,suid);
				pstmt.setInt(2,cnt);
			}

			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MessageSet ms = new MessageSet();
				Message m = new Message();
				ArrayList<Reply> rlist = new ArrayList<Reply>();
				
				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getDate("date")+" / "+rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setUid(rs.getString("uid"));
				m.setPhotoPath(rs.getString("photo_path"));
				
				String rsql = "select *  from s_reply where mid=? order by date desc";
				pstmt = conn.prepareStatement(rsql);
				pstmt.setInt(1,rs.getInt("mid"));
				ResultSet rrs = pstmt.executeQuery();
				while(rrs.next()) {
					Reply r = new Reply();
					r.setRid(rrs.getInt("rid"));
					r.setUid(rrs.getString("uid"));
					r.setRmsg(rrs.getString("rmsg"));
					r.setDate(rrs.getDate("date")+" "+rrs.getTime("date"));
					rlist.add(r);
				}
				rrs.last();
				m.setReplycount(rrs.getRow());
				//System.out.println("r count"+rrs.getRow());
				
				ms.setMessage(m);
				ms.setRlist(rlist);
				datas.add(ms);
				rrs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				//rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}		
		return datas;
	}
	
	/**
	 * 신규 메시지 등록
	 * @param msg
	 * @return
	 */
	public boolean newMsg(Message msg) {
		conn = DBManager.getConnection();
		String sql = "insert into s_message(uid, msg, date) values(?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getUid());
			pstmt.setString(2, msg.getMsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
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
	 * 메시지 삭제
	 * @param mid
	 * @return
	 */
	public boolean delMsg(int mid) {
		conn = DBManager.getConnection();
		String sql = "delete from s_message where mid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
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
	 * 게시글에 대한 답글 등록, 원 게시물에 대한 mid 필요
	 * @param mid
	 * @param rmsg
	 * @return
	 */
	public boolean newReply(Reply reply) {
		conn = DBManager.getConnection();
		String sql = "insert into s_reply(mid,uid,rmsg,date) values(?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply.getMid());
			pstmt.setString(2, reply.getUid());
			pstmt.setString(3, reply.getRmsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
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
	 * 답글 삭제
	 * @param rid
	 * @return
	 */
	public boolean delReply(int rid) {
		conn = DBManager.getConnection();
		String sql = "delete from s_reply where rid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rid);;
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
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
	 * 좋아요 추가
	 * @param mid
	 */
	public void addFavorite(int mid, String uid) {
		conn = DBManager.getConnection();
		// 좋아요 추가를 위해 favcount 를 +1 해서 update 함
		String sql = "update s_message set favcount=favcount+1 where mid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
			
			// 좋아요 누른 유저정보 추가 
			String sql2 = "insert into s_like (`uid`,`mid`) values (?,?)";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, uid);
			pstmt.setInt(2, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	// 좋아요 해제
	public void deleteFavorite(int mid, String uid) {
		conn = DBManager.getConnection();
		// 좋아요 추가를 위해 favcount 를 +1 해서 update 함
		String sql = "update s_message set favcount=favcount-1 where mid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
			
			// 좋아요 누른 유저정보 삭제
			String sql2 = "delete  from s_like where uid = ? and mid = ? ;";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, uid);
			pstmt.setInt(2, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	// 특정 유저가 특정 게시글에 좋아요 눌렀는지 체크 
	public boolean isUserLikeMessage(String uid, int mid) {
		conn = DBManager.getConnection();
		// 좋아요 추가를 위해 favcount 를 +1 해서 update 함
		String sql = "SELECT * FROM s_like where uid = ? and mid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, mid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			return false;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
		
	}
	
	
	// 특정 게시글에 좋아요를 누른 유저 출력 
	
}
