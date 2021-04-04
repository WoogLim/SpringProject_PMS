package kr.or.ddit.vo;

import kr.or.ddit.enumpkg.PushMessageType;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class Socket_PushMessageVO {
	private PushMessageType messageType;
	private String message;
}
