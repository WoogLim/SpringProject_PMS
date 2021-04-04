/**
 * 
 */
package kr.or.ddit.projects.schedule.vo;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.work.vo.WorkVO;
import lombok.Data;

/**
 * @author 작성자명
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 5.     김근호              최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Data
public class GanttVO extends WorkVO {
	@NotBlank	
	private String boardTitle;
	
	private String ganttDate;
	
	private String ganttLanguage;
	
	private String workType;
	
}
