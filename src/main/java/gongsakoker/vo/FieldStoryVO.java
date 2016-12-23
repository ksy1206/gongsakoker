package gongsakoker.vo;

public class FieldStoryVO {
	
	//현장 스토리 메인
	private String fs_no;
	private String member_no;
	private String member_id;
	private String sido;
	private String gugun;
	private String title;
	private String content;
	private String insertDate;
	private String img01;
	private String img02;
	private String img03;
	private String img_path;
	private String use_yn;
	private String img01realName;
	private String img02realName;
	private String img03realName;
	private String logo_name;
	private String koker_name;
	private String list_select;
	
	public String getKoker_name() {
		return koker_name;
	}
	public void setKoker_name(String koker_name) {
		this.koker_name = koker_name;
	}
	public String getList_select() {
		return list_select;
	}
	public void setList_select(String list_select) {
		this.list_select = list_select;
	}
	//현장 스토리 댓글
	private String ans_no;
	private String ans_content;
	private String ans_insertDate;
	
	//댓글, 추천 count
	private String answer_count;
	private String recommend_count;
	
	//공지사항
	private String c_s_no;
	private String c_s_code;
	private String c_s_title;
	private String c_s_content;
	private String c_s_insert_date;
	private String c_s_use_yn;
	private String admin_name;
	
	
	
	public String getC_s_no() {
		return c_s_no;
	}
	public void setC_s_no(String c_s_no) {
		this.c_s_no = c_s_no;
	}
	public String getC_s_code() {
		return c_s_code;
	}
	public void setC_s_code(String c_s_code) {
		this.c_s_code = c_s_code;
	}
	public String getC_s_title() {
		return c_s_title;
	}
	public void setC_s_title(String c_s_title) {
		this.c_s_title = c_s_title;
	}
	public String getC_s_content() {
		return c_s_content;
	}
	public void setC_s_content(String c_s_content) {
		this.c_s_content = c_s_content;
	}
	public String getC_s_insert_date() {
		return c_s_insert_date;
	}
	public void setC_s_insert_date(String c_s_insert_date) {
		this.c_s_insert_date = c_s_insert_date;
	}
	public String getC_s_use_yn() {
		return c_s_use_yn;
	}
	public void setC_s_use_yn(String c_s_use_yn) {
		this.c_s_use_yn = c_s_use_yn;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getLogo_name() {
		return logo_name;
	}
	public void setLogo_name(String logo_name) {
		this.logo_name = logo_name;
	}
	public String getAnswer_count() {
		return answer_count;
	}
	public void setAnswer_count(String answer_count) {
		this.answer_count = answer_count;
	}
	public String getRecommend_count() {
		return recommend_count;
	}
	public void setRecommend_count(String recommend_count) {
		this.recommend_count = recommend_count;
	}
	public String getAns_no() {
		return ans_no;
	}
	public void setAns_no(String ans_no) {
		this.ans_no = ans_no;
	}
	public String getAns_content() {
		return ans_content;
	}
	public void setAns_content(String ans_content) {
		this.ans_content = ans_content;
	}
	public String getAns_insertDate() {
		return ans_insertDate;
	}
	public void setAns_insertDate(String ans_insertDate) {
		this.ans_insertDate = ans_insertDate;
	}
	public String getFs_no() {
		return fs_no;
	}
	public void setFs_no(String fs_no) {
		this.fs_no = fs_no;
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
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
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
	public String getImg01realName() {
		return img01realName;
	}
	public void setImg01realName(String img01realName) {
		this.img01realName = img01realName;
	}
	public String getImg02realName() {
		return img02realName;
	}
	public void setImg02realName(String img02realName) {
		this.img02realName = img02realName;
	}
	public String getImg03realName() {
		return img03realName;
	}
	public void setImg03realName(String img03realName) {
		this.img03realName = img03realName;
	}
	@Override
	public String toString() {
		return "FieldStoryVO [fs_no=" + fs_no + ", member_no=" + member_no + ", member_id=" + member_id + ", sido="
				+ sido + ", gugun=" + gugun + ", title=" + title + ", content=" + content + ", insertDate=" + insertDate
				+ ", img01=" + img01 + ", img02=" + img02 + ", img03=" + img03 + ", img_path=" + img_path + ", use_yn="
				+ use_yn + ", img01realName=" + img01realName + ", img02realName=" + img02realName + ", img03realName="
				+ img03realName + ", logo_name=" + logo_name + ", koker_name=" + koker_name + ", list_select="
				+ list_select + ", ans_no=" + ans_no + ", ans_content=" + ans_content + ", ans_insertDate="
				+ ans_insertDate + ", answer_count=" + answer_count + ", recommend_count=" + recommend_count
				+ ", c_s_no=" + c_s_no + ", c_s_code=" + c_s_code + ", c_s_title=" + c_s_title + ", c_s_content="
				+ c_s_content + ", c_s_insert_date=" + c_s_insert_date + ", c_s_use_yn=" + c_s_use_yn + ", admin_name="
				+ admin_name + "]";
	}
	
	
}
