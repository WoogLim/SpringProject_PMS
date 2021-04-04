package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.MemberWrapper;

public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		String saveId = request.getParameter("rememberme");
		String mem_id = authentication.getName();
		Cookie idCookie = new Cookie("idCookie", mem_id);
		idCookie.setPath(request.getContextPath()); // app전역에서 사용하도록 Path설정
		int maxAge = 0;
		if (StringUtils.isNotBlank(saveId)) {
			maxAge = 60 * 60 * 24 * 7;
		}
		idCookie.setMaxAge(maxAge);
		response.addCookie(idCookie);

		Object principal = authentication.getPrincipal();
		MemberVO memberVO = ((MemberWrapper)principal).getRealMember();
		
		if("ROLE_ADMIN".equals(memberVO.getMemRole())) {
			setTargetUrlParameter("admin");
			request.setAttribute("userRole", "/admin/main");
		} else {
			setTargetUrlParameter("user");
			request.setAttribute("user", "/user/main");
		}
		super.handle(request, response, authentication);
	}
}
