package kr.or.ddit.projects.member.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "proId")
@Data
public class ProMemberVO {
	@NotBlank
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@NotBlank
	@Size(max = 15)
	private String memId; // 회원 아이디

	@Size(max = 15)
	private String authority; // 권한

	private String attSavename; // 프로필 사진을 가져오기 위한 변수
	private String memName; // 회원이름을 받기 위한 변수
	private String memImg; // Member Profile Image
	
	private String roleName; // 권한에 따른 역할 이름 출력을 위한 변수
	private String roleCnt; // 같은 역할이 몇 명인지 체크하기 위한 변수
}
