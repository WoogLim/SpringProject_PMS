package kr.or.ddit.projects.module.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "moduleId")
@Data
public class ModuleVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String moduleId; // 모듈 ID

	@NotBlank
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@NotBlank
	@Size(max = 20)
	private String moduleName; // 모듈명

	@Size(max = 10)
	private String createDate; // 생성 날짜

	@Size(max = 10)
	private String modifyDate; // 수정 날짜

	@NotNull
	@Min(0)
	private Integer code; // 코드

	@NotBlank
	@Size(max = 10)
	private String groupCode; // 그룹코드
}
