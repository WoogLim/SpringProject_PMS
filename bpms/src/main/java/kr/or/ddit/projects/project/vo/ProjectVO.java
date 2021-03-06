package kr.or.ddit.projects.project.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.chat.vo.ChatRoomVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@ToString(exclude = "proContent")
@EqualsAndHashCode(of = "proId")
@Data
public class ProjectVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@Size(max = 50)
	private String proName; // 프로젝트명

	@Size(max = 4000)
	private String proContent; // 프로젝트 내용

	@Size(max = 1)
	private String proShow; // 프로젝트 공개여부

	@Size(max = 10)
	private String createDate; // 생성날짜

	@Size(max = 10)
	private String modifyDate; // 수정날짜

	@Size(max = 10)
	private String endDate; // 종료 날짜

	@Size(max = 15)
	private String groupCode; // 그룹코드

	private Integer code; // 코드

	@Size(max = 15)
	private String projectManager;

	@Size(max = 15)
	private String proRequester;
	
	@Size(max = 22)
	private int proMemcount;

	// 프로젝트 조회 시 상태를 표시하기 위한 변수
	private String codeName;

	@Size(max = 15)
	private String proParent; // 상위 프로젝트 식별자

	// 프로젝트 수 조회용
	private Integer proCnt;
	
	// Project한 개에 ProjectMember는 여러명
	private List<ProMemberVO> proMemberList;
	private List<WorkVO> workList;
	private List<IssueVO> issueList;
	private List<BoardVO> boardList;

	// Project한 개에 채팅방 한 개
	private ChatRoomVO chatRoomVO;
//	private List<ChatVO> chatList;
	
	// 등록된 개수와 진행률을 간단히 보여주기 위한 변수
	private Integer issueCnt;
	private Integer workCnt;
	private Integer progress;
}
