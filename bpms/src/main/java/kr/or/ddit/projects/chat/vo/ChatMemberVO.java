/**
 * @author 작성자명
 * @since 2021. 2. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * ----------------------------------------
 * 2021. 2. 24.     이선엽       		최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.projects.chat.vo;

import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "memId")
@Data
public class ChatMemberVO {
	@NotBlank
	@Size(max = 15)
	private String memId;

	@NotBlank
	@Size(max = 15)
	private String chatRoomId;
	
	private List<MessageVO> messageList;
}
