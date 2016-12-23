package gongsakoker.vo;

public class ReviewVO {

	private int review_no;
	private int koker_no;
	private int member_no;
	private String member_id;
	private String review;
	private String comment;
	private String insert_date;
	
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public int getKoker_no() {
		return koker_no;
	}
	public void setKoker_no(int koker_no) {
		this.koker_no = koker_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}
	@Override
	public String toString() {
		return "ReviewVO [review_no=" + review_no + ", koker_no=" + koker_no + ", member_no=" + member_no
				+ ", member_id=" + member_id + ", review=" + review + ", comment=" + comment + ", insert_date="
				+ insert_date + "]";
	}
}
