package utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class HttpUtils {
    public static String getUsernameFromFlask(int userId) {
        try {
            URL url = new URL("http://localhost:5000/get_username/" + userId);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseStr = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                responseStr.append(line);
            }

            reader.close();
            JSONObject json = new JSONObject(responseStr.toString());
            return json.getString("username");

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}