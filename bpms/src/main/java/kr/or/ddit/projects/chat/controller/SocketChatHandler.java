/**
 * @author 작성자명
 * @since 2021. 2. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.projects.chat.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.projects.base.controller.BaseController;

public class SocketChatHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList;
	
	protected Logger logger = LoggerFactory.getLogger(SocketChatHandler.class);
	
	
	public SocketChatHandler() {
		sessionList = new ArrayList<>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String user = getUser(session);
		logger.info("접속된 세션 : " + user);
		for (WebSocketSession currentSession : sessionList) {
			currentSession.sendMessage(new TextMessage(user + ":" + message.getPayload()));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
	}

	private String getUser(WebSocketSession session) {
		return (String) session.getAttributes().get("memName");
	}
	
//	private String getChatRoomId(WebSocketSession session) {
//		return (String) session.getAttributes().get("chatRoomId");
//	}
//	
	private String getProId(WebSocketSession session) {
		return (String) session.getAttributes().get("ProId");
	}
//
//	public void serverToClient() throws IOException {
//		for(WebSocketSession wSession : sessionList)
//			wSession.sendMessage(new TextMessage("서버 전송 메세지"));				
//	}
}

