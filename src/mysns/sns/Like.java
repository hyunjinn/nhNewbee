package mysns.sns;

// 게시글에 따른 좋아요 누른사람 정보

public class Like {
	private int id;
	
	// 좋아요 누른 사람 uid
	private String uid;
	
	// 좋아요 누른 게시글 번호
	private int mid;
	
	// 좋아요 누른 시간 
	private String date;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return this.uid + " - " + this.date ;
	}
	
}
