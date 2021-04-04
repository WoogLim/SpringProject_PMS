package kr.or.ddit.projects.work.vo;

import java.io.Serializable;
import java.util.List;

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

@EqualsAndHashCode(of = "workId")
@Data
public class WorkVO extends BoardVO implements Serializable {
	
	// 일감 우선 순위 그룹 코드 값
	public static final String WRGROUPCODE = "WR";
	// 일감 유형 그룹 코드 값
	public static final String WTGROUPCODE = "WT";
	// 일감 상태 그룹 코드 값
	public static final String WSGROUPCODE = "WS";
	
	@NotNull(groups = { UpdateGroup.class, DeleteGroup.class })
	@Min(0)
	private Integer workId; // 일감 아이디

	@NotBlank(message = "우선 순위는 필수 입력입니다.")
	@Size(max = 20)
	private String workRank; // 일감 순위

	@NotBlank(message = "일감 유형은 필수 입력입니다.")
	@Size(max = 20)
	private String workType; // 일감 유형

	@NotBlank(message = "일감 상태는 필수 입력입니다.")
	@Size(max = 20)
	private String workState; // 일감 상태

	@Size(max = 20)
	private String workShow; // 공개 여부

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

	@NotBlank(message = "담당자는 필수 입력입니다.")
	@Size(max = 15)
	private String workDirector; // 담당자

	@Pattern(regexp="^[0-9]*$", message="숫자만 입력할 수 있습니다.(일감 아이디를 입력해 주세요.)")
	private String workParent; // 상위 일감

	private String proName; // 프로젝트 명
	
	private String memName;// 일감 조회 시 이름출력을 위한 변수

	private List<WorkVO> childWorkList; // 하위 일감 목록
	
	private Integer completeWorkCnt; // 프로젝트 내에 현재 달에 완료된 일감
	
	private String filterList;	// 일감 조회 유형 (전체 일감 조회, 담당 일감 조회, 미완료 일감 조회, 완료된 일감 조회) // left menu 변경 이후 안쓰는 변수
	
	private String sort; // 일감 아이디 오름차순/내림차순 정렬 
	
	private String filterProject; // 프로젝트 필터
	
	private String parentSearch; // 상위 일감 검색 값.
	
	private Integer workCntPerState; // 상태별 일감 개수 조회용
	
	
}