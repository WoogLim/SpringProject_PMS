package kr.or.ddit.security;

import javax.inject.Inject;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.projects.member.dao.AdminMemberDAO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.MemberWrapper;

@Service("customUserService")
public class Authentication implements UserDetailsService {

	@Inject
	private AdminMemberDAO dao;

	@Inject
	private MessageSourceAccessor accessor;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO member = dao.selectMemberByUserName(username);
		if(member==null) {
			String message = accessor.getMessage("DigestAuthenticationFilter.usernameNotFound", new Object[] {username});
			throw new UsernameNotFoundException(message);
		}
		return new MemberWrapper(member);
	}
}
