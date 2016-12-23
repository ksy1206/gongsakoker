package gongsakoker.vo;



public class AdminVO {

	private int admin_no;
	private String admin_id;
	private String admin_pw;
	private String admin_name;
	private String cntName;
	private String cnt;
	
	public AdminVO() {
		
		
	}
	
	public int getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(int admin_no) {
		this.admin_no = admin_no;
	}

	public String getAdmin_id() {
		return admin_id;
	}
	
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	
	public String getAdmin_pw() {
		return admin_pw;
	}
	
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
	
	public String getAdmin_name() {
		return admin_name;
	}
	
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}

	public String getCntName() {
		return cntName;
	}

	public void setCntName(String cntName) {
		this.cntName = cntName;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "AdminVO [admin_no=" + admin_no + ", admin_id=" + admin_id + ", admin_pw=" + admin_pw + ", admin_name="
				+ admin_name + ", cntName=" + cntName + ", cnt=" + cnt + "]";
	}
	
}
