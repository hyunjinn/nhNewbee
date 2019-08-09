import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mysns.member.MemberDAO;
import mysns.util.DBManager;

public class test {

	public static void main(String[] args) {
		
		Connection conn;
		PreparedStatement pstmt;
		Statement stmt;
		ResultSet rs;
		//Logger logger = LoggerFactory.getLogger(MemberDAO.class);
		
		System.out.println("시작! ");
		conn = DBManager.getConnection();
		
	}

}
