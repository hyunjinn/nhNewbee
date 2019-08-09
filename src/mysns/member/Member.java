package mysns.member;

import java.util.Date;

/**
 * File : Member.java
 * Desc : SNS 회원 Data Object 클래스
 * @author 황희정(dinfree@dinfree.com)
 *
 */
public class Member {	
	// 회원 이름
	private String name;
	
	// 회원 아이디(로그인용)
	private String uid;
	
	// 로그인 비밀번호
	private String passwd;
	
	// 이메일 주소
	private String email;
	
	// 가입일
	private Date date;
//추가 
	private String hobby; 	

	private String birth;
	
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	
	
	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String id) {
		this.uid = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
}
