package gongsakoker.gcm;

import java.util.ArrayList;

public class GcmSender {
	
	private static final String apiKey = "AIzaSyDoxCjwO0jQLk3wL6iq_IIAuKVlGzw9KAU";
	private static final String TAG = "GcmSender";
	private static final int quantity = 1000;
	
	public GcmSender() {
		System.out.println(TAG + " >> " + "prepared");
	}
	
	//안드로이드
	private Content createContent(String regId, String title, String what, String mainMessage) {
		Content c = new Content();
		
		c.addRegId(regId);
		c.createData(title, what, mainMessage);
		return c;
	}
	
	//안드로이드
	public ArrayList<String> postMultiGCM(ArrayList<String> regList, String mainTitle, String what, String mainMessage) {
		ArrayList<String> responses = new ArrayList<String>();

		int listSize = regList.size();
		//list가 1000개 미만일 때
		if (listSize < quantity-1) {
			Content content = createContent(regList.get(0), mainTitle, what, mainMessage);
			for (int i = 1; i < regList.size(); i++) {
				content.addRegId(regList.get(i));
			}
			String response = POST2GCM.post(apiKey, content);
			responses.add(response);
		} else {
			//list가 1000개 이상일 때
			int max = listSize/quantity;
			for(int a=0;a<max;a++) {
				int count =1;
				//콘텐츠를 천개마다 0번을 생성한다..
				Content content = createContent(regList.get(a*quantity), mainTitle, what, mainMessage);
				while(count <= quantity-1) {
					//콘텐츠를 하나씩 돌아가며999까지 추가하고 
					content.addRegId(regList.get((a*quantity)+count));
					count++;
				}
				//그렇게 x000 ~ x999까지 모인 content를 전송한다.
				String response = POST2GCM.post(apiKey, content);
				//
				responses.add(response);
			}
			Content content = createContent(regList.get(max*quantity), mainTitle, what, mainMessage);
			for (int i = (max*quantity)+1; i < regList.size(); i++) {
				content.addRegId(regList.get(i));
			}
			String response = POST2GCM.post(apiKey, content);
			responses.add(response);
		}

		return responses;
	}
	public String postSingleGCM(String regId, String mainTitle, String what, String mainMessage) {

		Content content = createContent(regId, mainTitle, what, mainMessage);

		String response = POST2GCM.post(apiKey, content);

		return response;
	}
	//안드로이드
	
	//IOS 일때 이걸로 전송----------------------------------------------------------------------
	private IosContent createIosContent(String regId, String title, String what, String mainMessage) {
		IosContent c = new IosContent();
		
		c.addRegId(regId);
		c.createData(title, what, mainMessage);
		return c;
	}
	
	public ArrayList<String> postMultiIosGCM(ArrayList<String> regList, String mainTitle, String what, String mainMessage) {
		ArrayList<String> responses = new ArrayList<String>();

		int listSize = regList.size();
		//list가 1000개 미만일 때
		if (listSize < quantity-1) {
			IosContent iosContent = createIosContent(regList.get(0), mainTitle, what, mainMessage);
			for (int i = 1; i < regList.size(); i++) {
				iosContent.addRegId(regList.get(i));
			}
			String response = POST2GCM.ios_post(apiKey, iosContent);
			responses.add(response);
		} else {
			//list가 1000개 이상일 때
			int max = listSize/quantity;
			for(int a=0;a<max;a++) {
				int count =1;
				//콘텐츠를 천개마다 0번을 생성한다..
				IosContent iosContent = createIosContent(regList.get(a*quantity), mainTitle, what, mainMessage);
				while(count <= quantity-1) {
					//콘텐츠를 하나씩 돌아가며999까지 추가하고 
					iosContent.addRegId(regList.get((a*quantity)+count));
					count++;
				}
				//그렇게 x000 ~ x999까지 모인 content를 전송한다.
				String response = POST2GCM.ios_post(apiKey, iosContent);
				//
				responses.add(response);
			}
			IosContent iosContent = createIosContent(regList.get(max*quantity), mainTitle, what, mainMessage);
			for (int i = (max*quantity)+1; i < regList.size(); i++) {
				iosContent.addRegId(regList.get(i));
			}
			String response = POST2GCM.ios_post(apiKey, iosContent);
			responses.add(response);
		}

		return responses;
	}
	
	public String postSingleIosGCM(String regId, String mainTitle, String what, String mainMessage) {

		IosContent iosContent = createIosContent(regId, mainTitle, what, mainMessage);

		String response = POST2GCM.ios_post(apiKey, iosContent);

		return response;
	}
	
}
