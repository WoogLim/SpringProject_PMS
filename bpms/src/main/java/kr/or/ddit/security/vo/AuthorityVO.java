package kr.or.ddit.security.vo;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.core.GrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "authority")
@ToString(of = "authority")
public class AuthorityVO implements GrantedAuthority {

	public AuthorityVO(String authority) {
		super();
		this.authority = authority;
	}

	@NotBlank
	private String authority;
	private String proId;
	private String roleName;
	private String description;
	private String createDate;
	private String modifyDate;

	private String[] resourceId;
	
	// 대시보드 조회용
	private Integer authCnt;
}
