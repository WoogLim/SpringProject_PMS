package kr.or.ddit.websocket.event;

import org.springframework.context.ApplicationEvent;

import kr.or.ddit.vo.Socket_PushMessageVO;

public class PushMessageEvent extends ApplicationEvent {

	private Socket_PushMessageVO messageVO;

	public PushMessageEvent(Socket_PushMessageVO source) {
		super(source);
		this.messageVO = source;
	}

	public Socket_PushMessageVO getMessageVO() {
		return messageVO;
	}
}
