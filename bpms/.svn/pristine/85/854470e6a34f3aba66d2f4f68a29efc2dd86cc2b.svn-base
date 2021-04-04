package kr.or.ddit.commons.service.impl;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.service.MailService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MailVO;

@Service
public class MailServiceImpl implements MailService {

	@Inject
	private JavaMailSenderImpl mailSender;

	public ServiceResult sendMail(MailVO mailVO) {
		ServiceResult ret = ServiceResult.OK;
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, "UTF-8");

			helper.setFrom(mailVO.getFrom());
			helper.setTo(mailVO.getTo());
			helper.setSubject(mailVO.getSubject());
			helper.setText(mailVO.getText());

			mailSender.send(mail);
		} catch (Exception e) {
			ret = ServiceResult.FAILED;
		}
		return ret;
	}
}
