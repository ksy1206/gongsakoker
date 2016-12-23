package gongsakoker.helper.util.bizlink;

import java.util.Properties;

/**
 * bizlink config
 * @author 박정후
 *
 */
public class BizlinkConfig {

	private Properties bizlink;	// bizlink 정보
	

	public Properties getBizlink() {
		return bizlink;
	}
	public void setBizlink(Properties bizlink) {
		this.bizlink = bizlink;
	}
	
	
	
	public String getIid(){
		return bizlink.getProperty("iid");
	}
	public String getSvr_url(){
		return bizlink.getProperty("svr_url");
	}
	public String getUrl(){
		return bizlink.getProperty("url");
	}
	public String getCr_id(){
		return bizlink.getProperty("cr_id");
	}
	public String getIf_id(){
		return bizlink.getProperty("if_id");
	}
	public String getState(){
		return bizlink.getProperty("state");
	}

}
