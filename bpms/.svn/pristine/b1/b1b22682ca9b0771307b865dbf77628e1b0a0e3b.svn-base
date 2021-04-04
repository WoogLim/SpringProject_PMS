package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class MailVO {
	private String from = "shinkwang23@naver.com";
	private String to;
	private String subject = "BPMS 계정정보 등록알림";
	private String text;

	public MailVO(String to, String text) {
		this.to = to;
		this.text = text;
	}

	public MailVO(String to, String text, String subject) {
		this(to, text);
		this.subject = subject;
	}
}
