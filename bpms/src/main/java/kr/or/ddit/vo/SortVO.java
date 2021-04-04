package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 신광진
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일            수정자         수정내용
 * ------------     --------    ----------------------
 * 2021. 1. 27.      신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SortVO {
	private String sortCondition; // 정렬조건
	private String sortType; // 정렬타입 (ASC, DESC)
	
	// 기간별 조회를 위한 변수
	private String startDate; // 시작날짜
	private String endDate; // 종료날짜
}
