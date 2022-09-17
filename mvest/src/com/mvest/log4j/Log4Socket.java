package com.mvest.log4j;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
 
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/jsp/log/socket")
public class Log4Socket {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
    public void onMessageAll(String message) throws IOException {
    if(clients == null || clients.isEmpty()) return;
        synchronized(clients) {
            for(Session client : clients) {
            	 if(client != null && client.isOpen()) {
                     client.getBasicRemote().sendText(message);
                 }
            }
        }
    }
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println(message);
        synchronized(clients) {
            for(Session client : clients) {
            	  if(!client.equals(session)) {
                    client.getBasicRemote().sendText(message);
                }
            }
        }
    }
    
    @OnOpen
    public void onOpen(Session session) {
        System.out.println(session);
        try {
			onMessage("connected", session);
		} catch (IOException e) {
			e.printStackTrace();
		}
        clients.add(session);
      
    }
    
    @OnClose
    public void onClose(Session session) {
    	try {
			onMessage("disconnected", session);
		} catch (IOException e) {
			e.printStackTrace();
		}
        clients.remove(session);
    }
    
}