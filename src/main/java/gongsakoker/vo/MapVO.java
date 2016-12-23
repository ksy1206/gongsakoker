package gongsakoker.vo;


/**
 * 
 *
 ************************************************
 * DATE          AUTHOR           DESCRIPTION
 * ----------------------------------------------
 * 2015. 12. 17.  김기윤   Initial Release
 ************************************************
 *
 */
public class MapVO
{
	
	//koker_member 
	private String member_no; 
	private String class_code; 
	
	
	//koker_info 
	private String koker_no;
	private String koker_name;
	private String addr01;
	private String addr02;
	private String call_tel01;
	private String call_tel02;
	private String call_tel03;
	private String logo_name;
	private String logo_fake_name;
	private String logo_path;
	private String latitude;
	private String longitude;
	
	
	//koker_bookmark
	private String bookmark_no;
	
	
	//koker_review
	private String review_count;
	private String review_avg;
	
	
	//koker_rank
	private String ranking;
	
	
	//내 위치에서 업체까지 거리
	private String distance;


	
	public String getMember_no() {
		return member_no;
	}


	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}


	public String getClass_code() {
		return class_code;
	}


	public void setClass_code(String class_code) {
		this.class_code = class_code;
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


	@Override
	public String toString() {
		return "MapVO [member_no=" + member_no + ", class_code=" + class_code + ", koker_no=" + koker_no
				+ ", koker_name=" + koker_name + ", addr01=" + addr01 + ", addr02=" + addr02 + ", call_tel01="
				+ call_tel01 + ", call_tel02=" + call_tel02 + ", call_tel03=" + call_tel03 + ", logo_name=" + logo_name
				+ ", logo_fake_name=" + logo_fake_name + ", logo_path=" + logo_path + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", bookmark_no=" + bookmark_no + ", review_count=" + review_count
				+ ", review_avg=" + review_avg + ", ranking=" + ranking + ", distance=" + distance + "]";
	}
		
}
