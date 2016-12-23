package gongsakoker.vo;

public class EventVO {
	private int event_no;
	private String event_title;
	private String event_date1;
	private String event_date2;
	private String event_content;
	private String event_title_img;
	private String event_content_img;
	private String event_title_img_path;
	private String event_content_img_path;
	private String event_participation;
	private String event_pay;
	private String event_url;
	private String event_url_text;
	private String event_use_yn;
	
	//페이징
	private String pageNum;
	
	public EventVO() {}

	public int getEvent_no() {
		return event_no;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}

	public String getEvent_title() {
		return event_title;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}

	public String getEvent_date1() {
		return event_date1;
	}

	public void setEvent_date1(String event_date1) {
		this.event_date1 = event_date1;
	}

	public String getEvent_date2() {
		return event_date2;
	}

	public void setEvent_date2(String event_date2) {
		this.event_date2 = event_date2;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public String getEvent_title_img() {
		return event_title_img;
	}

	public void setEvent_title_img(String event_title_img) {
		this.event_title_img = event_title_img;
	}

	public String getEvent_content_img() {
		return event_content_img;
	}

	public void setEvent_content_img(String event_content_img) {
		this.event_content_img = event_content_img;
	}

	public String getEvent_participation() {
		return event_participation;
	}

	public void setEvent_participation(String event_participation) {
		this.event_participation = event_participation;
	}

	public String getEvent_pay() {
		return event_pay;
	}

	public void setEvent_pay(String event_pay) {
		this.event_pay = event_pay;
	}

	public String getEvent_url() {
		return event_url;
	}

	public void setEvent_url(String event_url) {
		this.event_url = event_url;
	}

	public String getEvent_title_img_path() {
		return event_title_img_path;
	}

	public void setEvent_title_img_path(String event_title_img_path) {
		this.event_title_img_path = event_title_img_path;
	}

	public String getEvent_content_img_path() {
		return event_content_img_path;
	}

	public void setEvent_content_img_path(String event_content_img_path) {
		this.event_content_img_path = event_content_img_path;
	}

	public String getEvent_url_text() {
		return event_url_text;
	}

	public void setEvent_url_text(String event_url_text) {
		this.event_url_text = event_url_text;
	}

	public String getEvent_use_yn() {
		return event_use_yn;
	}

	public void setEvent_use_yn(String event_use_yn) {
		this.event_use_yn = event_use_yn;
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	@Override
	public String toString() {
		return "EventVO [event_no=" + event_no + ", event_title=" + event_title + ", event_date1=" + event_date1
				+ ", event_date2=" + event_date2 + ", event_content=" + event_content + ", event_title_img="
				+ event_title_img + ", event_content_img=" + event_content_img + ", event_title_img_path="
				+ event_title_img_path + ", event_content_img_path=" + event_content_img_path + ", event_participation="
				+ event_participation + ", event_pay=" + event_pay + ", event_url=" + event_url + ", event_url_text="
				+ event_url_text + ", event_use_yn=" + event_use_yn + ", pageNum=" + pageNum + "]";
	}
	
}
