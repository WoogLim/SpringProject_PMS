package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import kr.or.ddit.projects.work.vo.WorkVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DashBoardVO implements Serializable {

	private Integer workCnt;			// 총 일감 개수
	private Integer proProgress;		// 프로젝트 진척도
	private Integer completeWorkCnt;	// 완료된 일감 개수
	private Integer issueCnt;			// 총 이슈 개수
	private Integer proElapsedDate;		// 프로젝트 진행 시작 후 경과일
	private String proName;				// 프로젝트 제목
	private String proId;				// 프로젝트 아이디
	private String codeName;			// 프로젝트 상태
}
