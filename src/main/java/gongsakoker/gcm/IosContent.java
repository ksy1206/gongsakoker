package gongsakoker.gcm;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class IosContent implements Serializable {

	private List<String> registration_ids;
	private Map<String, String> notification;
	private boolean content_available;

	
	public void addRegId(String regId) {
		if (registration_ids == null) {
			registration_ids = new LinkedList<String>();
			registration_ids.add(regId);
		}

	}

	public void createData(String title, String message, String mainmessage) {
		if (notification == null) {
			notification = new HashMap<String, String>();
		}
		notification.put("title", title);
		notification.put("sound", message);
		notification.put("body", mainmessage);
		
		content_available = true;

	}

	public List<String> getRegistration_ids() {
		return registration_ids;
	}

	public void setRegistration_ids(List<String> registration_ids) {
		this.registration_ids = registration_ids;
	}

	public Map<String, String> getData() {
		return notification;
	}

	public void setData(Map<String, String> notification) {
		this.notification = notification;
	}

	public boolean isContent_available() {
		return content_available;
	}

	public void setContent_available(boolean content_available) {
		this.content_available = content_available;
	}
	
	
	
}
