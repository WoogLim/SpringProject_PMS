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

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
@EqualsAndHashCode(of="msgId")
@Data
public class MessageVO {
	@NotNull 
	@Min(0)
	private Long msgId;
	
	@NotBlank
	@Size(max=15)
	private String chatRoomId;

	@NotBlank
	@Size(max=20)
	private String msgWriter;
	
	@Size(max=4000)
	private String msgContent;
	
	@Size(max=7)
	private String createDate;
	
	private String memId;
	
}

