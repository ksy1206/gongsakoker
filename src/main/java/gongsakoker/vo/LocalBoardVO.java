package gongsakoker.vo;

public class LocalBoardVO {
	
	private String board_no;
	private String category;
	private String member_no;
	private String member_id;
	private String sido;
	private String gugun;
	private String title;
	private String content;
	private String insert_date;
	private String img01;
	private String img02;
	private String img03;
	private String img_path;
	private String use_yn;
	
	public String getBoard_no() {
		return board_no;
	}
	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMember_no() {
		return member_no;
	}
	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}
	public String getImg01() {
		return img01;
	}
	public void setImg01(String img01) {
		this.img01 = img01;
	}
	public String getImg02() {
		return img02;
	}
	public void setImg02(String img02) {
		this.img02 = img02;
	}
	public String getImg03() {
		return img03;
	}
	public void setImg03(String img03) {
		this.img03 = img03;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	@Override
	public String toString() {
		return "LocalBoardVO [board_no=" + board_no + ", category=" + category + ", member_no=" + member_no
				+ ", member_id=" + member_id + ", sido=" + sido + ", gugun=" + gugun + ", title=" + title + ", content="
				+ content + ", insert_date=" + insert_date + ", img01=" + img01 + ", img02=" + img02 + ", img03="
				+ img03 + ", img_path=" + img_path + ", use_yn=" + use_yn + "]";
	}
}