package kr.or.ddit.filter;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.LocaleResolver;

public class I18nSupportFilter extends OncePerRequestFilter {

	@Inject
	LocaleResolver localeResolver;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {

		// 저장된 Cookie에서 Locale정보를 찾기위해 localeResolver를 주입받아서 사용
		LocaleContextHolder.setLocale(localeResolver.resolveLocale(request));
		filterChain.doFilter(request, response);
	}

}
