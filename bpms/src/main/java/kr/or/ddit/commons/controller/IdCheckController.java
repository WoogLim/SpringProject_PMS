package kr.or.ddit.commons.controller;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;

@Controller
@RequestMapping(value = "/signUp/idCheck.do")
public class IdCheckController extends BaseController {

	@GetMapping(produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String doGet(MemberVO memberVO) {
		ServiceResult result = signUpService.isAlreadyUse(memberVO);
//		return result; 
		return ServiceResult.OK.equals(result) + "";
	}

}
