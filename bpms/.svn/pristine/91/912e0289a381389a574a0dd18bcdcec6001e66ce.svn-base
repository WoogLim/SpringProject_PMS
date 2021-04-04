package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.sun.mail.iap.Response;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	private String errorPage;
	
	public void setErrorPage(String errorPage) {
		this.errorPage = errorPage;
	}
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		if (!response.isCommitted()) {
			if (errorPage != null) {
				request.setAttribute(WebAttributes.ACCESS_DENIED_403,
						accessDeniedException);
				
				response.setStatus(HttpServletResponse.SC_FORBIDDEN);
				request.setAttribute("javax.servlet.error.status_code", new Integer(403));

				RequestDispatcher dispatcher = request.getRequestDispatcher(errorPage);
				dispatcher.forward(request, response);
			}
			else {
				response.sendError(HttpServletResponse.SC_FORBIDDEN,
						accessDeniedException.getMessage());
			}
		}		
	}

	
}
