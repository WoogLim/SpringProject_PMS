package kr.or.ddit.projects.member.vo;

import org.springframework.security.core.userdetails.User;

public class MemberWrapper extends User {

	public MemberWrapper(MemberVO realMember) {
		super(realMember.getMemId(), realMember.getMemPass()
				, !"Y".equals(realMember.getMemDelete())
				, !"Y".equals(realMember.getMemDelete())
				, !"Y".equals(realMember.getMemDelete())
				, !"Y".equals(realMember.getMemDelete())
				, realMember.getAuthorities());
		this.realMember = realMember;
	}

	private MemberVO realMember;
	public MemberVO getRealMember() {
		return realMember;
	}
}
