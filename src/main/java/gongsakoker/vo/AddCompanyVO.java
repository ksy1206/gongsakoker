package gongsakoker.vo;

public class AddCompanyVO {
	private int company_no;
	private String company_name;
	private String company_addr;
	private String company_tel;
	private String company_reason;
	private int member_no;
	private String company_recommender;
	private String company_call_ok;
	
	public int getCompany_no() {
		return company_no;
	}
	public void setCompany_no(int company_no) {
		this.company_no = company_no;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getCompany_addr() {
		return company_addr;
	}
	public void setCompany_addr(String company_addr) {
		this.company_addr = company_addr;
	}
	public String getCompany_tel() {
		return company_tel;
	}
	public void setCompany_tel(String company_tel) {
		this.company_tel = company_tel;
	}
	public String getCompany_reason() {
		return company_reason;
	}
	public void setCompany_reason(String company_reason) {
		this.company_reason = company_reason;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getCompany_recommender() {
		return company_recommender;
	}
	public void setCompany_recommender(String company_recommender) {
		this.company_recommender = company_recommender;
	}
	public String getCompany_call_ok() {
		return company_call_ok;
	}
	public void setCompany_call_ok(String company_call_ok) {
		this.company_call_ok = company_call_ok;
	}
	@Override
	public String toString() {
		return "AddCompanyVO [company_no=" + company_no + ", company_name=" + company_name + ", company_addr="
				+ company_addr + ", company_tel=" + company_tel + ", company_reason=" + company_reason + ", member_no="
				+ member_no + ", company_recommender=" + company_recommender + ", company_call_ok=" + company_call_ok
				+ "]";
	}	
}
