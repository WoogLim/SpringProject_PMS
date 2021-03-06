package kr.or.ddit.projects.chat.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="chatRoomId")
@Data
public class ChatRoomVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String chatRoomId;
	
	@Size(max = 50)
	private String chatTitle;
	
	private Integer memCount;
	
	@NotBlank
	@Size(max = 15)
	private String proId;
	
	private List<WebSocketSession> sessionList;
	
	private List<ChatMemberVO> chatMemberList;
	
	private List<MessageVO> messageList;
	
	private String memId;
	
}
