package kr.or.ddit.projects.issue.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.validate.groups.DeleteGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 전수빈
 * @since 2021. 2. 5.
 * @version 1.0
 * @param <T>
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 5.      작성자명       	최초작성
 * 2021. 2. 5.      전수빈		memId 추가
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@EqualsAndHashCode(of = "issueId")
@Data
public class IssueVO extends BoardVO implements Serializable {
	
	// 이슈 우선 순위 그룹 코드 값
	public static final String IRGROUPCODE = "IR"; 
	// 이슈 유형 그룹 코드 값
	public static final String ITGROUPCODE = "IT"; 
	// 이슈 상태 그룹 코드 값
	public static final String ISGROUPCODE = "IS";
	
	@NotNull(groups = { UpdateGroup.class, DeleteGroup.class })
	@Min(0)
	private Integer issueId; // 이슈 아이디

	@NotBlank(message = "우선 순위는 필수 입력입니다.")
	@Size(max = 20)
	private String issueRank; // 우선 순위

	@NotBlank(message = "이슈 유형는 필수 입력입니다.")
	@Size(max = 20)
	private String issueType; // 이슈 유형

	@NotBlank(message = "이슈 상태는 필수 입력입니다.")
	@Size(max = 20)
	private String issueState; // 이슈 상태

	@Size(max = 20)
	private String issueShow; // 이슈 공개 여부

	@NotBlank(message = "시작 날짜는 필수 입력입니다.")
	@Size(max = 10)
	private String startDate; // 시작 날짜

	@Size(max = 10)
	private String modifyDate; // 수정 날짜

	@NotBlank(message = "완료 날짜는 필수 입력입니다.")
	@Size(max = 10)
	private String endDate; // 완료 날짜

	@Size(max = 5)
	private String progress; // 진척도

	@NotBlank(message = "이슈 담당자는 필수 입력입니다.")
	@Size(max = 15)
	private String issueDirector; // 이슈 담당자

	@Pattern(regexp="^[0-9]*$", message="숫자만 입력할 수 있습니다.(일감 아이디를 입력해 주세요.)")
	private String workId; // 연결된 일감
	
	private String filterList; // 이슈 조회 유형 (전체 일감 조회, 담당 일감 조회, 미완료 일감 조회, 완료된 일감 조회) // left menu 변경 이후 안쓰는 변수
	
	private String sort; // 이슈 아이디 오름차순/내림차순 정렬 
	
	private String filterProject; // 이슈 프로젝트 필터 변수
	
	private String workSearch; // 연결할 일감 검색
	
	private String project; // url 이동시 가 

	private String proName; // 소속된 프로젝트 명
	
	private String memName;// 일감 조회 시 회원이름 출력을 위한 변수
	
	private Integer issueCntPerState; // 타입 별 이슈 개수 출력을 위한 변수
}
