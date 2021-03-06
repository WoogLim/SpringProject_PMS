package kr.or.ddit.commons.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.RequestErrorMessageVO;

@Controller
public class ErrorController {
	
	@RequestMapping("/common/error.do")
	public String error(HttpServletRequest req){
		Integer statusCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
		String errorMsg = "";
		if(statusCode != null) {
			switch(statusCode) {
			case 400 :
				errorMsg = "잘못된 요청입니다!!!";
				break;
			case 403 :
				errorMsg = "접근 권한이 없습니다";
				break;
			case 404 :
				errorMsg = "존재하지 않는 페이지입니다!!!";
				break;
			case 500 :
				errorMsg = "서버 오류가 발생하였습니다 잠시 후에 다시 시도해 주세요";
				break;
			case 503 :
				errorMsg = "현재 서버를 사용하실 수 없습니다. 잠시 후에 다시 시도해 주세요";
				break;
			default : 
				errorMsg = "알수 없는 에러";
				break;
			}
		}else {
			statusCode = 500;
		}
		RequestErrorMessageVO errorMsgVO = new RequestErrorMessageVO();
		errorMsgVO.setStatusCode(statusCode);
		errorMsgVO.setErrorMsg(errorMsg);
		req.setAttribute("errorMsgVO", errorMsgVO);
		return "bpms/error";
	}
}
