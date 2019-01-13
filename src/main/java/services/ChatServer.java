package services;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

@ServerEndpoint("/chat")
public class ChatServer {
	static Set<Session> chatroomUsers = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session userSession) {
		chatroomUsers.add(userSession);		
	}
	
	@OnMessage
	public void onMessage(String message, Session userSession) {
		String username = (String) userSession.getUserProperties().get("username");
		if (username == null) {
			userSession.getUserProperties().put("username", message);
			try {
				userSession.getBasicRemote().sendText(buildJsonData("System", "You are now connected as " + message));
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			Iterator<Session> iterator = chatroomUsers.iterator();
			while(iterator.hasNext()) {
				try {
					iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@OnClose
	public void onClose(Session userSession) {
		chatroomUsers.remove(userSession);
	}
	
	private String buildJsonData(String username, String message) {
		JsonObject json = Json.createObjectBuilder().add("message", username + ": " + message).build();
		StringWriter sw = new StringWriter();
		try (JsonWriter jw = Json.createWriter(sw)) {
			jw.write(json);
		}
		return sw.toString();
	}
}
