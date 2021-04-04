package kr.or.ddit.projects.pushmsg.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.member.vo.MemberVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "pushNo")
@Data
public class PushMessageVO {
	@NotNull
	@Min(0)
	private Integer pushNo; // 푸시메세지 번호

	@NotNull
	@Size(max = 30)
	private String pushTitle; // 푸시메시지 제목
	
	@NotBlank
	@Size(max = 15)
	private String pushSender; // 푸시메시지 발신자

	@Size(max = 4000)
	private String pushContent; // 푸시메시지 내용

	@Size(max = 10)
	private String createDate; // 발신 날짜

	@NotBlank
	@Size(max = 15)
	private String pushReceiver; // 푸시메시지 수신자

	@Size(max = 1)
	private String pushOpen; // 푸시메시지 확인여부 default: N
	
	private MemberVO memberVO;
}
