/**
 * 
 */
package kr.or.ddit.projects.schedule.vo;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.board.vo.BoardVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 작성자명
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 9.     김근호             최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Data
@EqualsAndHashCode(of = "calId")
public class CalendarVO implements Serializable {

	@Min(0)
	private Integer calId;

	@Size(max = 20)
	private String calRank;

	@Size(max = 20)
	private String calType;

	@Size(max = 20)
	private String calState;

	@Size(max = 1)
	private String calShow;

	@NotBlank(message = "시작일은 필수 입력 사항입니다.")
	private String startDate;

	@NotBlank(message = "마감일은 필수 입력 사항입니다.")
	private String endDate;

	@Size(max = 5)
	private String progress;

	@Size(max = 15)
	private String director;

	@NotBlank(message = "타이틀은 필수 입력 사항입니다.")
	@Size(max = 200)
	private String boardTitle;

	@Size(max = 4000)
	private String boardContent;

	@Size(max = 15)
	private String proId;

	private String code;

	@Size(max = 200)
	private String calLocation;
}
