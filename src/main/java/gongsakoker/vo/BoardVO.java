package gongsakoker.vo;



public class BoardVO {

	//koker_board table
	private String board_no;
	private String board_title;
	private String board_content;
	private String board_write;
	private String board_date;
	private String board_phone;
	private String board_code;
	private String board_complete;
	private int member_no;
	
	// koker_board_answer table
	private int answer_no;
	private String answer_content;
	private String answer_date;
	private String answer_write;
	

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_write() {
		return board_write;
	}

	public void setBoard_write(String board_write) {
		this.board_write = board_write;
	}

	public String getBoard_date() {
		return board_date;
	}

	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}

	public String getBoard_phone() {
		return board_phone;
	}

	public void setBoard_phone(String board_phone) {
		this.board_phone = board_phone;
	}

	public String getBoard_code() {
		return board_code;
	}

	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}

	public int getAnswer_no() {
		return answer_no;
	}

	public void setAnswer_no(int answer_no) {
		this.answer_no = answer_no;
	}

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public String getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}

	public String getAnswer_write() {
		return answer_write;
	}

	public void setAnswer_write(String answer_write) {
		this.answer_write = answer_write;
	}

	public String getBoard_complete() {
		return board_complete;
	}

	public void setBoard_complete(String board_complete) {
		this.board_complete = board_complete;
	}

	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_title=" + board_title + ", board_content=" + board_content
				+ ", board_write=" + board_write + ", board_date=" + board_date + ", board_phone=" + board_phone
				+ ", board_code=" + board_code + ", board_complete=" + board_complete + ", member_no=" + member_no
				+ ", answer_no=" + answer_no + ", answer_content=" + answer_content + ", answer_date=" + answer_date
				+ ", answer_write=" + answer_write + "]";
	}

}
