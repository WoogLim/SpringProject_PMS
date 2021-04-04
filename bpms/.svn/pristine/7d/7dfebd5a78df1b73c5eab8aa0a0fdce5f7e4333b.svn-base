package kr.or.ddit.commons.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;

/**
 * @author 전수빈
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * 2021. 2. 1.      전수빈	 로그인 페이지 연동 메서드 추가
 * 2021. 2. 1.		전수빈 	 로그인 메서드 추가
 * 2021. 2. 1.		전수빈	 로그 아웃 메서드 추가
 *      </pre>
 */
@Controller
public class LoginController extends BaseController {

	@RequestMapping("/login/loginForm.do")
	public String loginForm() {
		return "BPMSlogin";
	}
}
