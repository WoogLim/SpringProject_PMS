package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 신광진
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 29.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@EqualsAndHashCode(of = { "groupCode", "code" })
@Data
public class CodeVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String groupCode;

	@NotNull
	@Min(0)
	private Integer code;

	@Size(max = 20)
	private String groupName;

	@Size(max = 20)
	private String codeName;

	@Size(max = 10)
	private String createDate;
}
