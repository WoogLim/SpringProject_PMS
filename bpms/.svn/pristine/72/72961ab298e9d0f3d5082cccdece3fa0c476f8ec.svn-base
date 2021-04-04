/**
 * @author 작성자명
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * ------------------------------------------
 * 2021. 2. 1.      이선엽               최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.commons.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.enumpkg.PushMessageType;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.Socket_PushMessageVO;
import kr.or.ddit.websocket.event.PushMessageEvent;

@Controller
@RequestMapping("/login/signUp.do")
public class SignUpController extends BaseController {

	@Inject
	private ApplicationEventPublisher publisher;

	@GetMapping
	public String getSignUpForm() {
		return "login/signUp";
	}

	@PostMapping
	public String signUp(@Validated(InsertGroup.class) @ModelAttribute("memberVO") MemberVO memberVO,
			BindingResult errors, Model model) {
		String goPage = null;
		if (!errors.hasErrors()) {
			ServiceResult result = signUpService.RegistMember(memberVO);
			switch (result) {
			case PKDUPLICATED:
				goPage = "/login/signUp";
				model.addAttribute("message", NotyMessageVO.builder("아이디 중복").build());
				break;
			case FAILED:
				goPage = "/login/signUp";
				model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				break;
			case OK:
				Socket_PushMessageVO source = new Socket_PushMessageVO(PushMessageType.REGISTERED,
						memberVO.getMemName() + "가입 성공");
				PushMessageEvent event = new PushMessageEvent(source);
				publisher.publishEvent(event);
				goPage = "redirect:/login/loginForm.do";
				break;
			}
		} else {
			goPage = "/login/signUp";
		}
		return goPage;
	}
}
