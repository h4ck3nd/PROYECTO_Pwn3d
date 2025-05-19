package dao;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import com.google.gson.*;

public class ViewUsuariosDAO {
    private static final String API_URL = "http://localhost:5000/get_usuarios";

    public List<Map<String, String>> obtenerUsuarios() throws Exception {
        URL url = new URL(API_URL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer contenido = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            contenido.append(inputLine);
        }
        in.close();
        con.disconnect();

        List<Map<String, String>> usuarios = new ArrayList<>();
        Gson gson = new Gson();
        JsonArray jsonArray = JsonParser.parseString(contenido.toString()).getAsJsonArray();

        for (JsonElement element : jsonArray) {
            JsonObject obj = element.getAsJsonObject();
            Map<String, String> user = new HashMap<>();
            user.put("id", obj.get("id").getAsString());
            user.put("nombre", obj.get("nombre").getAsString());
            user.put("apellidos", obj.get("apellidos").getAsString());
            user.put("email", obj.get("email").getAsString());
            user.put("usuario", obj.get("usuario").getAsString());
            user.put("fecha_nacimiento", obj.get("fecha_nacimiento").getAsString());
            user.put("rol", obj.get("rol").getAsString());
            usuarios.add(user);
        }
        return usuarios;
    }
}