package kr.or.ddit.security.voter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.manager.DummyProxySession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.FilterInvocation;

import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.MemberWrapper;
import kr.or.ddit.security.vo.AuthorityVO;

public class CustomRoleVoter implements AccessDecisionVoter<Object> {
	private String rolePrefix = "ROLE_";

	public String getRolePrefix() {
		return rolePrefix;	
	}

	public void setRolePrefix(String rolePrefix) {
		this.rolePrefix = rolePrefix;
	}

	public boolean supports(ConfigAttribute attribute) {
		if ((attribute.getAttribute() != null)
				&& attribute.getAttribute().startsWith(getRolePrefix())) {
			return true;
		}
		else {
			return false;
		}
	}

	public boolean supports(Class<?> clazz) {
		return true;
	}

	public int vote(Authentication authentication, Object object,
			Collection<ConfigAttribute> attributes) {

		if(authentication == null) {
			return ACCESS_DENIED;
		}
		int result = ACCESS_ABSTAIN;
		
		// 프로젝트 아이디 확인
		HttpServletRequest req = ((FilterInvocation)object).getRequest();
		String proId = req.getParameter("proId");
		
		// 인증객체(anonymous인 경우 getPrincipal()은 String을 return함)
		Object principal = authentication.getPrincipal();
		MemberVO realMember = null;
		if(principal instanceof MemberWrapper) {
			realMember = ((MemberWrapper)principal).getRealMember();
		}
		
		GrantedAuthority memberAuthority = null;
		List<AuthorityVO> customAuthorities = new ArrayList<>();
		if(realMember != null) {
			
			memberAuthority = new SimpleGrantedAuthority(realMember.getMemRole());
			customAuthorities.add(new AuthorityVO(memberAuthority.toString()));
			if(!"ROLE_RESTRICTED".equals(memberAuthority.getAuthority()) 
					&& !"ROLE_ADMIN".equals(memberAuthority.getAuthority()) 
					&& StringUtils.isNotBlank(proId)) 
			{
				boolean isMember = false;
				for(AuthorityVO authVO : realMember.getAuthorities()) {
					if(proId.equals(authVO.getProId())) {
						customAuthorities.remove(0);
						customAuthorities.add(authVO);
						realMember.setCurrentAuthority(authVO.getAuthority());
						isMember = true;
						break;
					}
				}
				if(!isMember) return ACCESS_DENIED;
			}
		}
		
		// reachable role List를 가져오는 부분 (roleHierarchyVoter)
		Collection<? extends GrantedAuthority> authorities = null;
		if(realMember != null) {
			authorities = customExtractAuthorities(customAuthorities);
		} else {
			authorities = extractAuthorities(authentication);
		}
		
		for (ConfigAttribute attribute : attributes) {
			if (this.supports(attribute)) {
				result = ACCESS_DENIED;
				
				for (GrantedAuthority authority : authorities) {
					if (attribute.getAttribute().equals(authority.getAuthority())) {
						return ACCESS_GRANTED;
					}
				}
			}
		}

		return result;
	}

	Collection<? extends GrantedAuthority> extractAuthorities(
			Authentication authentication) {
		return authentication.getAuthorities();
	}
	
	Collection<? extends GrantedAuthority> customExtractAuthorities(
			Collection<? extends GrantedAuthority> authorities){
		return authorities;
	}
	
}
