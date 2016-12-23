package gongsakoker.vo;

import java.util.List;

public class QaVO {
	
	private int qa_no;
	private String qa_name;
	private String qa_content;
	private String qa_date;
	private String qa_delete;
	private String qa_answer;
	private int qa_question_no;
	private int member_no;
	private int koker_no;
	private List<Object> answerVo;
	
	
	public int getQa_no() {
		return qa_no;
	}
	public void setQa_no(int qa_no) {
		this.qa_no = qa_no;
	}
	public String getQa_name() {
		return qa_name;
	}
	public void setQa_name(String qa_name) {
		this.qa_name = qa_name;
	}
	public String getQa_content() {
		return qa_content;
	}
	public void setQa_content(String qa_content) {
		this.qa_content = qa_content;
	}
	public String getQa_date() {
		return qa_date;
	}
	public void setQa_date(String qa_date) {
		this.qa_date = qa_date;
	}
	public String getQa_delete() {
		return qa_delete;
	}
	public void setQa_delete(String qa_delete) {
		this.qa_delete = qa_delete;
	}
	public String getQa_answer() {
		return qa_answer;
	}
	public void setQa_answer(String qa_answer) {
		this.qa_answer = qa_answer;
	}
	public int getQa_question_no() {
		return qa_question_no;
	}
	public void setQa_question_no(int qa_question_no) {
		this.qa_question_no = qa_question_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getKoker_no() {
		return koker_no;
	}
	public void setKoker_no(int koker_no) {
		this.koker_no = koker_no;
	}
	public List<Object> getAnswerVo() {
		return answerVo;
	}
	public void setAnswerVo(List<Object> answerVo) {
		this.answerVo = answerVo;
	}
	@Override
	public String toString() {
		return "QaVO [qa_no=" + qa_no + ", qa_name=" + qa_name + ", qa_content=" + qa_content + ", qa_date=" + qa_date
				+ ", qa_delete=" + qa_delete + ", qa_answer=" + qa_answer + ", qa_question_no=" + qa_question_no
				+ ", member_no=" + member_no + ", koker_no=" + koker_no + ", answerVo=" + answerVo + "]";
	}
	
	
	
}
