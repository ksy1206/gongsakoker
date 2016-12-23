package gongsakoker.vo;


/**
 * 
 *
 ************************************************
 * DATE          AUTHOR           DESCRIPTION
 * ----------------------------------------------
 * 2015. 11. 18.  박정후   Initial Release
 ************************************************
 *
 */
public class MemberVO
{
	
	//koker_member 
	private String member_no; 
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
	private String hp_reg_id;
	private String hp_kind;
	
	//지도 마커
	private String adius;
	private String chk_code;
	
	
	//koker_code 
	private String code_no; 
	//private String class_code; 
	private String category;
	private String code_name; 
	private String code_sort; 
	
	
	//zip_sido 
	private String sido; 
	private String gugun; 
	private String dong; 
	
	//koker_info 
	private String koker_no;
	//private String member_no;
	//private String class_code;
	//private String category;
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
	
	//koker_catgegory 
	private String category_no;
	//private String koker_no;
	//private String class_code;
	private String ca01;
	private String ca02;
	private String ca03;
	private String ca04;
	private String ca05;
	private String ca06;
	private String ca07;
	private String ca08;
	private String ca09;
	private String ca10;
	private String ca11;
	private String ca12;
	private String ca13;
	private String ca14;
	private String ca15;
	private String ca16;
	private String ca17;
	private String ca18;
	private String ca19;
	private String ca20;
	private String ca21;
	private String ca22;
	private String ca23;
	private String ca24;
	private String ca25;
	private String ca26;
	private String ca27;
	private String ca28;
	private String ca29;
	private String ca30;
	private String ca31;
	private String ca32;
	private String ca33;
	private String ca34;
	private String ca35;
	private String ca36;
	private String ca37;
	private String ca38;
	private String ca39;
	private String ca40;
	
	
	//koker_approve 
	
	private String approve_no;
	private String approve_date;
	private String company_num;
	private String app_content;
	private String tptb;
	

	private String keyword_01;
	private String pageNum;
	
	//koker_charge_member
	
	private String charge_no;
	private String charge_yn;
	private String start_date;
	private String end_date;
	private String spare_time;
	
	private String bookmark_no;
	private String review_count;
	private String review_avg;
	
	
	//koker_state
	private String state;
	
	//koker_rank
	private String rank_no;
	private String ranking;
	private String average;
	
	//내 위치에서 업체까지 거리
	private String distance;
	
	//추천업체
	private String special_no;
	
	//가상번호
	private String vn;
	private String rn;
	
	
	
	public String getVn() {
		return vn;
	}
	public void setVn(String vn) {
		this.vn = vn;
	}
	public String getRn() {
		return rn;
	}
	public void setRn(String rn) {
		this.rn = rn;
	}
	public String getWork_state() {
		return work_state;
	}
	public void setWork_state(String work_state) {
		this.work_state = work_state;
	}
	public String getBookmark_no() {
		return bookmark_no;
	}
	public void setBookmark_no(String bookmark_no) {
		this.bookmark_no = bookmark_no;
	}
	public String getReview_count() {
		return review_count;
	}
	public void setReview_count(String review_count) {
		this.review_count = review_count;
	}
	public String getReview_avg() {
		return review_avg;
	}
	public void setReview_avg(String review_avg) {
		this.review_avg = review_avg;
	}
	public String getSpare_time() {
		return spare_time;
	}
	public void setSpare_time(String spare_time) {
		this.spare_time = spare_time;
	}
	public String getCharge_no() {
		return charge_no;
	}
	public void setCharge_no(String charge_no) {
		this.charge_no = charge_no;
	}
	public String getCharge_yn() {
		return charge_yn;
	}
	public void setCharge_yn(String charge_yn) {
		this.charge_yn = charge_yn;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
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
	public String getCategory_no() {
		return category_no;
	}
	public void setCategory_no(String category_no) {
		this.category_no = category_no;
	}
	public String getCa01() {
		return ca01;
	}
	public void setCa01(String ca01) {
		this.ca01 = ca01;
	}
	public String getCa02() {
		return ca02;
	}
	public void setCa02(String ca02) {
		this.ca02 = ca02;
	}
	public String getCa03() {
		return ca03;
	}
	public void setCa03(String ca03) {
		this.ca03 = ca03;
	}
	public String getCa04() {
		return ca04;
	}
	public void setCa04(String ca04) {
		this.ca04 = ca04;
	}
	public String getCa05() {
		return ca05;
	}
	public void setCa05(String ca05) {
		this.ca05 = ca05;
	}
	public String getCa06() {
		return ca06;
	}
	public void setCa06(String ca06) {
		this.ca06 = ca06;
	}
	public String getCa07() {
		return ca07;
	}
	public void setCa07(String ca07) {
		this.ca07 = ca07;
	}
	public String getCa08() {
		return ca08;
	}
	public void setCa08(String ca08) {
		this.ca08 = ca08;
	}
	public String getCa09() {
		return ca09;
	}
	public void setCa09(String ca09) {
		this.ca09 = ca09;
	}
	public String getCa10() {
		return ca10;
	}
	public void setCa10(String ca10) {
		this.ca10 = ca10;
	}
	public String getCa11() {
		return ca11;
	}
	public void setCa11(String ca11) {
		this.ca11 = ca11;
	}
	public String getCa12() {
		return ca12;
	}
	public void setCa12(String ca12) {
		this.ca12 = ca12;
	}
	public String getCa13() {
		return ca13;
	}
	public void setCa13(String ca13) {
		this.ca13 = ca13;
	}
	public String getCa14() {
		return ca14;
	}
	public void setCa14(String ca14) {
		this.ca14 = ca14;
	}
	public String getCa15() {
		return ca15;
	}
	public String getCa16() {
		return ca16;
	}
	public void setCa16(String ca16) {
		this.ca16 = ca16;
	}
	public String getCa17() {
		return ca17;
	}
	public void setCa17(String ca17) {
		this.ca17 = ca17;
	}
	public String getCa18() {
		return ca18;
	}
	public void setCa18(String ca18) {
		this.ca18 = ca18;
	}
	public String getCa19() {
		return ca19;
	}
	public void setCa19(String ca19) {
		this.ca19 = ca19;
	}
	public String getCa20() {
		return ca20;
	}
	public void setCa20(String ca20) {
		this.ca20 = ca20;
	}
	public String getCa21() {
		return ca21;
	}
	public void setCa21(String ca21) {
		this.ca21 = ca21;
	}
	public String getCa22() {
		return ca22;
	}
	public void setCa22(String ca22) {
		this.ca22 = ca22;
	}
	public String getCa23() {
		return ca23;
	}
	public void setCa23(String ca23) {
		this.ca23 = ca23;
	}
	public String getCa24() {
		return ca24;
	}
	public void setCa24(String ca24) {
		this.ca24 = ca24;
	}
	public String getCa25() {
		return ca25;
	}
	public void setCa25(String ca25) {
		this.ca25 = ca25;
	}
	public String getCa26() {
		return ca26;
	}
	public void setCa26(String ca26) {
		this.ca26 = ca26;
	}
	public String getCa27() {
		return ca27;
	}
	public void setCa27(String ca27) {
		this.ca27 = ca27;
	}
	public String getCa28() {
		return ca28;
	}
	public void setCa28(String ca28) {
		this.ca28 = ca28;
	}
	public String getCa29() {
		return ca29;
	}
	public void setCa29(String ca29) {
		this.ca29 = ca29;
	}
	public String getCa30() {
		return ca30;
	}
	public void setCa30(String ca30) {
		this.ca30 = ca30;
	}
	public String getCa31() {
		return ca31;
	}
	public void setCa31(String ca31) {
		this.ca31 = ca31;
	}
	public String getCa32() {
		return ca32;
	}
	public void setCa32(String ca32) {
		this.ca32 = ca32;
	}
	public String getCa33() {
		return ca33;
	}
	public void setCa33(String ca33) {
		this.ca33 = ca33;
	}
	public String getCa34() {
		return ca34;
	}
	public void setCa34(String ca34) {
		this.ca34 = ca34;
	}
	public String getCa35() {
		return ca35;
	}
	public void setCa35(String ca35) {
		this.ca35 = ca35;
	}
	public String getCa36() {
		return ca36;
	}
	public void setCa36(String ca36) {
		this.ca36 = ca36;
	}
	public String getCa37() {
		return ca37;
	}
	public void setCa37(String ca37) {
		this.ca37 = ca37;
	}
	public String getCa38() {
		return ca38;
	}
	public void setCa38(String ca38) {
		this.ca38 = ca38;
	}
	public String getCa39() {
		return ca39;
	}
	public void setCa39(String ca39) {
		this.ca39 = ca39;
	}
	public String getCa40() {
		return ca40;
	}
	public void setCa40(String ca40) {
		this.ca40 = ca40;
	}
	public void setCa15(String ca15) {
		this.ca15 = ca15;
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
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getCode_no() {
		return code_no;
	}
	public void setCode_no(String code_no) {
		this.code_no = code_no;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getCode_sort() {
		return code_sort;
	}
	public void setCode_sort(String code_sort) {
		this.code_sort = code_sort;
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
	public String getApprove_no() {
		return approve_no;
	}
	public void setApprove_no(String approve_no) {
		this.approve_no = approve_no;
	}
	public String getApprove_date() {
		return approve_date;
	}
	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}
	public String getCompany_num() {
		return company_num;
	}
	public void setCompany_num(String company_num) {
		this.company_num = company_num;
	}
	public String getApp_content() {
		return app_content;
	}
	public void setApp_content(String app_content) {
		this.app_content = app_content;
	}
	public String getTptb() {
		return tptb;
	}
	public void setTptb(String tptb) {
		this.tptb = tptb;
	}
	public String getKeyword_01() {
		return keyword_01;
	}
	public void setKeyword_01(String keyword_01) {
		this.keyword_01 = keyword_01;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRank_no() {
		return rank_no;
	}
	public void setRank_no(String rank_no) {
		this.rank_no = rank_no;
	}
	public String getRanking() {
		return ranking;
	}
	public void setRanking(String ranking) {
		this.ranking = ranking;
	}
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public String getKoker_auth() {
		return koker_auth;
	}
	public void setKoker_auth(String koker_auth) {
		this.koker_auth = koker_auth;
	}
	public String getAverage() {
		return average;
	}
	public void setAverage(String average) {
		this.average = average;
	}
	public String getSpecial_no() {
		return special_no;
	}
	public void setSpecial_no(String special_no) {
		this.special_no = special_no;
	}
	public String getAdius() {
		return adius;
	}
	public void setAdius(String adius) {
		this.adius = adius;
	}
	public String getChk_code() {
		return chk_code;
	}
	public void setChk_code(String chk_code) {
		this.chk_code = chk_code;
	}
	public String getHp_reg_id() {
		return hp_reg_id;
	}
	public void setHp_reg_id(String hp_reg_id) {
		this.hp_reg_id = hp_reg_id;
	}
	public String getHp_kind() {
		return hp_kind;
	}
	public void setHp_kind(String hp_kind) {
		this.hp_kind = hp_kind;
	}
	
	@Override
	public String toString() {
		return "MemberVO [member_no=" + member_no + ", member_id=" + member_id + ", member_code=" + member_code
				+ ", password=" + password + ", use_yn=" + use_yn + ", block_yn=" + block_yn + ", name=" + name
				+ ", class_code=" + class_code + ", hp=" + hp + ", hp01=" + hp01 + ", hp02=" + hp02 + ", hp03=" + hp03
				+ ", click_wrap01=" + click_wrap01 + ", click_wrap02=" + click_wrap02 + ", click_wrap03=" + click_wrap03
				+ ", click_wrap04=" + click_wrap04 + ", insert_date=" + insert_date + ", delete_date=" + delete_date
				+ ", push_yn=" + push_yn + ", hp_reg_id=" + hp_reg_id + ", hp_kind=" + hp_kind + ", adius=" + adius
				+ ", chk_code=" + chk_code + ", code_no=" + code_no + ", category=" + category + ", code_name="
				+ code_name + ", code_sort=" + code_sort + ", sido=" + sido + ", gugun=" + gugun + ", dong=" + dong
				+ ", koker_no=" + koker_no + ", koker_name=" + koker_name + ", zip_code=" + zip_code + ", addr01="
				+ addr01 + ", addr02=" + addr02 + ", call_tel01=" + call_tel01 + ", call_tel02=" + call_tel02
				+ ", call_tel03=" + call_tel03 + ", holiday=" + holiday + ", call_stime=" + call_stime + ", call_ntime="
				+ call_ntime + ", koker_title=" + koker_title + ", koker_content=" + koker_content + ", koker_url="
				+ koker_url + ", logo_name=" + logo_name + ", logo_fake_name=" + logo_fake_name + ", logo_path="
				+ logo_path + ", file01_name=" + file01_name + ", file01_fake_name=" + file01_fake_name
				+ ", file01_path=" + file01_path + ", file02_name=" + file02_name + ", file02_fake_name="
				+ file02_fake_name + ", file02_path=" + file02_path + ", file03_name=" + file03_name
				+ ", file03_fake_name=" + file03_fake_name + ", file03_path=" + file03_path + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", business_file01_name=" + business_file01_name
				+ ", business_file01_path=" + business_file01_path + ", business_file02_name=" + business_file02_name
				+ ", business_file02_path=" + business_file02_path + ", work_state=" + work_state + ", koker_auth="
				+ koker_auth + ", category_no=" + category_no + ", ca01=" + ca01 + ", ca02=" + ca02 + ", ca03=" + ca03
				+ ", ca04=" + ca04 + ", ca05=" + ca05 + ", ca06=" + ca06 + ", ca07=" + ca07 + ", ca08=" + ca08
				+ ", ca09=" + ca09 + ", ca10=" + ca10 + ", ca11=" + ca11 + ", ca12=" + ca12 + ", ca13=" + ca13
				+ ", ca14=" + ca14 + ", ca15=" + ca15 + ", ca16=" + ca16 + ", ca17=" + ca17 + ", ca18=" + ca18
				+ ", ca19=" + ca19 + ", ca20=" + ca20 + ", ca21=" + ca21 + ", ca22=" + ca22 + ", ca23=" + ca23
				+ ", ca24=" + ca24 + ", ca25=" + ca25 + ", ca26=" + ca26 + ", ca27=" + ca27 + ", ca28=" + ca28
				+ ", ca29=" + ca29 + ", ca30=" + ca30 + ", ca31=" + ca31 + ", ca32=" + ca32 + ", ca33=" + ca33
				+ ", ca34=" + ca34 + ", ca35=" + ca35 + ", ca36=" + ca36 + ", ca37=" + ca37 + ", ca38=" + ca38
				+ ", ca39=" + ca39 + ", ca40=" + ca40 + ", approve_no=" + approve_no + ", approve_date=" + approve_date
				+ ", company_num=" + company_num + ", app_content=" + app_content + ", tptb=" + tptb + ", keyword_01="
				+ keyword_01 + ", pageNum=" + pageNum + ", charge_no=" + charge_no + ", charge_yn=" + charge_yn
				+ ", start_date=" + start_date + ", end_date=" + end_date + ", spare_time=" + spare_time
				+ ", bookmark_no=" + bookmark_no + ", review_count=" + review_count + ", review_avg=" + review_avg
				+ ", state=" + state + ", rank_no=" + rank_no + ", ranking=" + ranking + ", average=" + average
				+ ", distance=" + distance + ", special_no=" + special_no + ", vn=" + vn + ", rn=" + rn + "]";
	}
	
}
