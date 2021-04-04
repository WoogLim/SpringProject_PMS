package kr.or.ddit.security.voter;

import java.util.Collection;

import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.util.Assert;

public class CustomRoleHierarchyVoter extends CustomRoleVoter {
	private RoleHierarchy roleHierarchy = null;

	public CustomRoleHierarchyVoter(RoleHierarchy roleHierarchy) {
		Assert.notNull(roleHierarchy, "RoleHierarchy must not be null");
		this.roleHierarchy = roleHierarchy;
	}

	@Override
	Collection<? extends GrantedAuthority> extractAuthorities(
			Authentication authentication) {
		return roleHierarchy.getReachableGrantedAuthorities(authentication
				.getAuthorities());
	}
	
	@Override
	Collection<? extends GrantedAuthority> customExtractAuthorities(
			Collection<? extends GrantedAuthority> authorities){
		return roleHierarchy.getReachableGrantedAuthorities(authorities);
	}
	
}
