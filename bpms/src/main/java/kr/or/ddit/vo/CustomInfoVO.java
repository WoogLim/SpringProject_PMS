package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * @author 신광진
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 5.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Getter
@Setter
public class CustomInfoVO implements Serializable {

	@NotNull
	@Min(0)
	private Integer customNo;

	@Size(max = 15)
	private String groupCode;

	@NotBlank
	@Size(max = 24)
	private String text;

	@NotBlank
	@Size(max = 30)
	private String iconClass;

	@Size(max = 7)
	private String textColor;

	@Size(max = 7)
	private String iconColor;

	@Size(max = 7)
	private String backgroundColor;

	private Integer code;
}
