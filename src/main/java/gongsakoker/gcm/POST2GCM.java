package gongsakoker.gcm;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import com.fasterxml.jackson.databind.ObjectMapper;

public class POST2GCM {
	public static String post(String apiKey, Content content) {
		StringBuffer response = new StringBuffer();
		try {
			URL url = new URL("https://gcm-http.googleapis.com/gcm/send");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");

			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization", "key=" + apiKey);

			conn.setDoOutput(true);

			ObjectMapper mapper = new ObjectMapper();
			
			DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
		
			mapper.writeValue(wr, content);
		

			wr.flush();
			wr.close();

			int responseCode = conn.getResponseCode();

			System.out.println("Sending 'POST' request to URL : " + url);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			
			while((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			
			System.out.println(response.toString());
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return response.toString();
	}
	
	public static String ios_post(String apiKey, IosContent content) {
		StringBuffer response = new StringBuffer();
		try {
			URL url = new URL("https://android.googleapis.com/gcm/send");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");

			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization", "key=" + apiKey);

			conn.setDoOutput(true);

			ObjectMapper mapper = new ObjectMapper();
			
			DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
		
			mapper.writeValue(wr, content);
		

			wr.flush();
			wr.close();

			int responseCode = conn.getResponseCode();

			System.out.println("Sending 'POST' request to URL : " + url);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			
			while((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			
			System.out.println(response.toString());
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return response.toString();
	}
}
