package gongsakoker.helper.util.bizlink;

import java.util.Map;

/**
 * bizlink 소켓 응답VO
 * @author 박정후
 *
 */
public class BizlinkResponseVO {

	private String rt;	//reuslt 결과 0:성공 그 외 숫자는 오류코드 참조	
	private String rs;	//reason 실패시 사유
	private String rid;	//ring id 만들어진멘트 아이디 실패면 해당 값은 셋팅 되지 않는다.
	private String vn;	//virtual number 가상번호
	private String rn;	//real number 착신번호
	private String cr_id;//color-ring id 컬러링 아이디
	private String if_id;//infom-ring id알림멘트 아이디
	private String cb_sms;//callback sms 콜백 sms사용여부 Y -사용 N-사용안함
	private String cb_sms_txt;//callback sms text콜백 sms문구
	private String type;//type종류 1.음원파일 , 2.TTS
	private String desc;//description음원 설명
	private String reg_dt;//regist date 등록일
	private Map<String,Object> res;
	private String koker_no;
	private String memo;
	private String memo2;

	
	
	
	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getMemo2() {
		return memo2;
	}
	public void setMemo2(String memo2) {
		this.memo2 = memo2;
	}
	public String getKoker_no() {
		return koker_no;
	}
	public void setKoker_no(String koker_no) {
		this.koker_no = koker_no;
	}
	public Map<String, Object> getRes() {
		return res;
	}
	public void setRes(Map<String, Object> res) {
		this.res = res;
	}
	public String getRt() {
		return rt;
	}
	public void setRt(String rt) {
		this.rt = rt;
	}
	public String getRs() {
		return rs;
	}
	public void setRs(String rs) {
		this.rs = rs;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
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
	public String getCr_id() {
		return cr_id;
	}
	public void setCr_id(String cr_id) {
		this.cr_id = cr_id;
	}
	public String getIf_id() {
		return if_id;
	}
	public void setIf_id(String if_id) {
		this.if_id = if_id;
	}
	public String getCb_sms() {
		return cb_sms;
	}
	public void setCb_sms(String cb_sms) {
		this.cb_sms = cb_sms;
	}
	public String getCb_sms_txt() {
		return cb_sms_txt;
	}
	public void setCb_sms_txt(String cb_sms_txt) {
		this.cb_sms_txt = cb_sms_txt;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	
	

	
	
	
	
	
	
	
}
