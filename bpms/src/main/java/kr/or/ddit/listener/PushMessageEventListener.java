package kr.or.ddit.listener;

import java.io.IOException;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.vo.Socket_PushMessageVO;
import kr.or.ddit.websocket.event.PushMessageEvent;

@Component
public class PushMessageEventListener {

	@Resource(name = "wsSessionSet")
	private Set<WebSocketSession> wsSessionSet;

	@EventListener(PushMessageEvent.class)
	@Async
	public void eventHandler(PushMessageEvent event) throws IOException {
		Socket_PushMessageVO messageVO = event.getMessageVO();

		ObjectMapper mapper = new ObjectMapper();
		String payload = mapper.writeValueAsString(messageVO);
		for (WebSocketSession wsSession : wsSessionSet) {
			wsSession.sendMessage(new TextMessage(payload));
//			try {
//				Thread.sleep(3000);
//			} catch (InterruptedException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
		}
	}
}
