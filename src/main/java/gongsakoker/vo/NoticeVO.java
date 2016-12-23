package gongsakoker.vo;

public class NoticeVO {
	private String notice_no;
	private String writer;
	private String title;
	private String content; 
	private String insert_date; 
	private String use_yn; 
	
	public String getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(String notice_no) {
		this.notice_no = notice_no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	@Override
	public String toString() {
		return "NoticeVO [notice_no=" + notice_no + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", insert_date=" + insert_date + ", use_yn=" + use_yn + "]";
	}
		
}
