package gongsakoker.vo;



public class CommunityVO {

	//koker_community    	//koker_community_recommend
	String cm_no;
	String cm_content;
	String cm_insert_date;
	String cm_use_yn;
	String member_no;

	//koker_community_reply
	String reply_no;
	String reply_content;
	String reply_insert_date;
	String reply_use_yn;
	
	//koker_report_community
	String report_no;
	String report_grade;
	String report_content;
	String report_category;
	String report_insert_date;
	String report_use_yn;
	
	//koker_c_s_board
	String c_s_no;
	String c_s_code;
	String c_s_title;
	String c_s_content;
	String c_s_insert_date;
	String c_s_use_yn;
	String admin_name;
	
	//koker_member 
	private String member_id; 
	private String member_code; 
	private String password; 
	private String use_yn; 
	private String block_yn; 
	private String name; 
	private String class_code; 
	private String hp; 
	private String hp01; 
	private String hp02;
	private String hp03; 
	private String click_wrap01; //click_wrap01
	private String click_wrap02; //click_wrap02
	private String click_wrap03; //click_wrap03
	private String click_wrap04; //click_wrap04
	private String insert_date; 
	private String delete_date; 
	private String push_yn; 
	
	//koker_info 
	private String koker_no;
	private String category;
	private String koker_name;
	private String zip_code;
	private String addr01;
	private String addr02;
	private String call_tel01;
	private String call_tel02;
	private String call_tel03;
	private String holiday;
	private String call_stime;
	private String call_ntime;
	private String koker_title;
	private String koker_content;
	private String koker_url;
	private String logo_name;
	private String logo_fake_name;
	private String logo_path;
	private String file01_name;
	private String file01_fake_name;
	private String file01_path;
	private String file02_name;
	private String file02_fake_name;
	private String file02_path;
	private String file03_name;
	private String file03_fake_name;
	private String file03_path;
	private String latitude;
	private String longitude;
	private String business_file01_name;
	private String business_file01_path;
	private String business_file02_name;
	private String business_file02_path;
	private String work_state;
	private String koker_auth;
	
	//추천 총갯수 and 댓글 총 갯수
	private String recommend_count;
	private String reply_count;
	
	public String getCm_no() {
		return cm_no;
	}
	public void setCm_no(String cm_no) {
		this.cm_no = cm_no;
	}
	public String getCm_content() {
		return cm_content;
	}
	public void setCm_content(String cm_content) {
		this.cm_content = cm_content;
	}
	public String getCm_insert_date() {
		return cm_insert_date;
	}
	public void setCm_insert_date(String cm_insert_date) {
		this.cm_insert_date = cm_insert_date;
	}
	public String getCm_use_yn() {
		return cm_use_yn;
	}
	public void setCm_use_yn(String cm_use_yn) {
		this.cm_use_yn = cm_use_yn;
	}
	public String getMember_no() {
		return member_no;
	}
	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}
	public String getReply_no() {
		return reply_no;
	}
	public void setReply_no(String reply_no) {
		this.reply_no = reply_no;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_insert_date() {
		return reply_insert_date;
	}
	public void setReply_insert_date(String reply_insert_date) {
		this.reply_insert_date = reply_insert_date;
	}
	public String getReply_use_yn() {
		return reply_use_yn;
	}
	public void setReply_use_yn(String reply_use_yn) {
		this.reply_use_yn = reply_use_yn;
	}
	public String getReport_no() {
		return report_no;
	}
	public void setReport_no(String report_no) {
		this.report_no = report_no;
	}
	public String getReport_grade() {
		return report_grade;
	}
	public void setReport_grade(String report_grade) {
		this.report_grade = report_grade;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public String getReport_category() {
		return report_category;
	}
	public void setReport_category(String report_category) {
		this.report_category = report_category;
	}
	public String getReport_insert_date() {
		return report_insert_date;
	}
	public void setReport_insert_date(String report_insert_date) {
		this.report_insert_date = report_insert_date;
	}
	public String getReport_use_yn() {
		return report_use_yn;
	}
	public void setReport_use_yn(String report_use_yn) {
		this.report_use_yn = report_use_yn;
	}
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getBlock_yn() {
		return block_yn;
	}
	public void setBlock_yn(String block_yn) {
		this.block_yn = block_yn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getClass_code() {
		return class_code;
	}
	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getHp01() {
		return hp01;
	}
	public void setHp01(String hp01) {
		this.hp01 = hp01;
	}
	public String getHp02() {
		return hp02;
	}
	public void setHp02(String hp02) {
		this.hp02 = hp02;
	}
	public String getHp03() {
		return hp03;
	}
	public void setHp03(String hp03) {
		this.hp03 = hp03;
	}
	public String getClick_wrap01() {
		return click_wrap01;
	}
	public void setClick_wrap01(String click_wrap01) {
		this.click_wrap01 = click_wrap01;
	}
	public String getClick_wrap02() {
		return click_wrap02;
	}
	public void setClick_wrap02(String click_wrap02) {
		this.click_wrap02 = click_wrap02;
	}
	public String getClick_wrap03() {
		return click_wrap03;
	}
	public void setClick_wrap03(String click_wrap03) {
		this.click_wrap03 = click_wrap03;
	}
	public String getClick_wrap04() {
		return click_wrap04;
	}
	public void setClick_wrap04(String click_wrap04) {
		this.click_wrap04 = click_wrap04;
	}
	public String getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}
	public String getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(String delete_date) {
		this.delete_date = delete_date;
	}
	public String getPush_yn() {
		return push_yn;
	}
	public void setPush_yn(String push_yn) {
		this.push_yn = push_yn;
	}
	public String getKoker_no() {
		return koker_no;
	}
	public void setKoker_no(String koker_no) {
		this.koker_no = koker_no;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getKoker_name() {
		return koker_name;
	}
	public void setKoker_name(String koker_name) {
		this.koker_name = koker_name;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getAddr01() {
		return addr01;
	}
	public void setAddr01(String addr01) {
		this.addr01 = addr01;
	}
	public String getAddr02() {
		return addr02;
	}
	public void setAddr02(String addr02) {
		this.addr02 = addr02;
	}
	public String getCall_tel01() {
		return call_tel01;
	}
	public void setCall_tel01(String call_tel01) {
		this.call_tel01 = call_tel01;
	}
	public String getCall_tel02() {
		return call_tel02;
	}
	public void setCall_tel02(String call_tel02) {
		this.call_tel02 = call_tel02;
	}
	public String getCall_tel03() {
		return call_tel03;
	}
	public void setCall_tel03(String call_tel03) {
		this.call_tel03 = call_tel03;
	}
	public String getHoliday() {
		return holiday;
	}
	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}
	public String getCall_stime() {
		return call_stime;
	}
	public void setCall_stime(String call_stime) {
		this.call_stime = call_stime;
	}
	public String getCall_ntime() {
		return call_ntime;
	}
	public void setCall_ntime(String call_ntime) {
		this.call_ntime = call_ntime;
	}
	public String getKoker_title() {
		return koker_title;
	}
	public void setKoker_title(String koker_title) {
		this.koker_title = koker_title;
	}
	public String getKoker_content() {
		return koker_content;
	}
	public void setKoker_content(String koker_content) {
		this.koker_content = koker_content;
	}
	public String getKoker_url() {
		return koker_url;
	}
	public void setKoker_url(String koker_url) {
		this.koker_url = koker_url;
	}
	public String getLogo_name() {
		return logo_name;
	}
	public void setLogo_name(String logo_name) {
		this.logo_name = logo_name;
	}
	public String getLogo_fake_name() {
		return logo_fake_name;
	}
	public void setLogo_fake_name(String logo_fake_name) {
		this.logo_fake_name = logo_fake_name;
	}
	public String getLogo_path() {
		return logo_path;
	}
	public void setLogo_path(String logo_path) {
		this.logo_path = logo_path;
	}
	public String getFile01_name() {
		return file01_name;
	}
	public void setFile01_name(String file01_name) {
		this.file01_name = file01_name;
	}
	public String getFile01_fake_name() {
		return file01_fake_name;
	}
	public void setFile01_fake_name(String file01_fake_name) {
		this.file01_fake_name = file01_fake_name;
	}
	public String getFile01_path() {
		return file01_path;
	}
	public void setFile01_path(String file01_path) {
		this.file01_path = file01_path;
	}
	public String getFile02_name() {
		return file02_name;
	}
	public void setFile02_name(String file02_name) {
		this.file02_name = file02_name;
	}
	public String getFile02_fake_name() {
		return file02_fake_name;
	}
	public void setFile02_fake_name(String file02_fake_name) {
		this.file02_fake_name = file02_fake_name;
	}
	public String getFile02_path() {
		return file02_path;
	}
	public void setFile02_path(String file02_path) {
		this.file02_path = file02_path;
	}
	public String getFile03_name() {
		return file03_name;
	}
	public void setFile03_name(String file03_name) {
		this.file03_name = file03_name;
	}
	public String getFile03_fake_name() {
		return file03_fake_name;
	}
	public void setFile03_fake_name(String file03_fake_name) {
		this.file03_fake_name = file03_fake_name;
	}
	public String getFile03_path() {
		return file03_path;
	}
	public void setFile03_path(String file03_path) {
		this.file03_path = file03_path;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getBusiness_file01_name() {
		return business_file01_name;
	}
	public void setBusiness_file01_name(String business_file01_name) {
		this.business_file01_name = business_file01_name;
	}
	public String getBusiness_file01_path() {
		return business_file01_path;
	}
	public void setBusiness_file01_path(String business_file01_path) {
		this.business_file01_path = business_file01_path;
	}
	public String getBusiness_file02_name() {
		return business_file02_name;
	}
	public void setBusiness_file02_name(String business_file02_name) {
		this.business_file02_name = business_file02_name;
	}
	public String getBusiness_file02_path() {
		return business_file02_path;
	}
	public void setBusiness_file02_path(String business_file02_path) {
		this.business_file02_path = business_file02_path;
	}
	public String getWork_state() {
		return work_state;
	}
	public void setWork_state(String work_state) {
		this.work_state = work_state;
	}
	public String getKoker_auth() {
		return koker_auth;
	}
	public void setKoker_auth(String koker_auth) {
		this.koker_auth = koker_auth;
	}
	public String getRecommend_count() {
		return recommend_count;
	}
	public void setRecommend_count(String recommend_count) {
		this.recommend_count = recommend_count;
	}
	public String getReply_count() {
		return reply_count;
	}
	public void setReply_count(String reply_count) {
		this.reply_count = reply_count;
	}
	@Override
	public String toString() {
		return "CommunityVO [cm_no=" + cm_no + ", cm_content=" + cm_content + ", cm_insert_date=" + cm_insert_date
				+ ", member_no=" + member_no + ", reply_no=" + reply_no + ", reply_content=" + reply_content
				+ ", reply_insert_date=" + reply_insert_date + ", reply_use_yn=" + reply_use_yn + ", report_no="
				+ report_no + ", report_grade=" + report_grade + ", report_content=" + report_content
				+ ", report_category=" + report_category + ", report_insert_date=" + report_insert_date
				+ ", report_use_yn=" + report_use_yn + ", c_s_no=" + c_s_no + ", c_s_code=" + c_s_code + ", c_s_title="
				+ c_s_title + ", c_s_content=" + c_s_content + ", c_s_insert_date=" + c_s_insert_date + ", c_s_use_yn="
				+ c_s_use_yn + ", admin_name=" + admin_name + ", member_id=" + member_id + ", member_code="
				+ member_code + ", password=" + password + ", use_yn=" + use_yn + ", block_yn=" + block_yn + ", name="
				+ name + ", class_code=" + class_code + ", hp=" + hp + ", hp01=" + hp01 + ", hp02=" + hp02 + ", hp03="
				+ hp03 + ", click_wrap01=" + click_wrap01 + ", click_wrap02=" + click_wrap02 + ", click_wrap03="
				+ click_wrap03 + ", click_wrap04=" + click_wrap04 + ", insert_date=" + insert_date + ", delete_date="
				+ delete_date + ", push_yn=" + push_yn + ", koker_no=" + koker_no + ", category=" + category
				+ ", koker_name=" + koker_name + ", zip_code=" + zip_code + ", addr01=" + addr01 + ", addr02=" + addr02
				+ ", call_tel01=" + call_tel01 + ", call_tel02=" + call_tel02 + ", call_tel03=" + call_tel03
				+ ", holiday=" + holiday + ", call_stime=" + call_stime + ", call_ntime=" + call_ntime
				+ ", koker_title=" + koker_title + ", koker_content=" + koker_content + ", koker_url=" + koker_url
				+ ", logo_name=" + logo_name + ", logo_fake_name=" + logo_fake_name + ", logo_path=" + logo_path
				+ ", file01_name=" + file01_name + ", file01_fake_name=" + file01_fake_name + ", file01_path="
				+ file01_path + ", file02_name=" + file02_name + ", file02_fake_name=" + file02_fake_name
				+ ", file02_path=" + file02_path + ", file03_name=" + file03_name + ", file03_fake_name="
				+ file03_fake_name + ", file03_path=" + file03_path + ", latitude=" + latitude + ", longitude="
				+ longitude + ", business_file01_name=" + business_file01_name + ", business_file01_path="
				+ business_file01_path + ", business_file02_name=" + business_file02_name + ", business_file02_path="
				+ business_file02_path + ", work_state=" + work_state + ", koker_auth=" + koker_auth + "]";
	}
}
