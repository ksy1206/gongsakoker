package gongsakoker.vo;

public class CodeVO {
	private String code_no;
	private String class_code;
	private String category;
	private String code_name;
	private String code_sort;
	
	
	
	public String getCode_no() {
		return code_no;
	}



	public void setCode_no(String code_no) {
		this.code_no = code_no;
	}



	public String getClass_code() {
		return class_code;
	}



	public void setClass_code(String class_code) {
		this.class_code = class_code;
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



	@Override
	public String toString() {
		return "CodeVO [code_no=" + code_no + ", class_code=" + class_code + ", category=" + category + ", code_name="
				+ code_name + ", code_sort=" + code_sort + "]";
	}
	
	

}
