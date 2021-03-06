package kr.or.ddit.projects.base.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import kr.or.ddit.commons.service.CodeService;
import kr.or.ddit.commons.service.CustomInfoService;
import kr.or.ddit.commons.service.DashBoardService;
import kr.or.ddit.commons.service.SignUpService;
import kr.or.ddit.projects.board.service.BoardService;
import kr.or.ddit.projects.chat.service.ChatService;
import kr.or.ddit.projects.file.service.FileService;
import kr.or.ddit.projects.history.service.AdminHistoryService;
import kr.or.ddit.projects.history.service.HistoryService;
import kr.or.ddit.projects.issue.service.AdminIssueService;
import kr.or.ddit.projects.issue.service.IssueService;
import kr.or.ddit.projects.kanban.service.KanbanService;
import kr.or.ddit.projects.member.service.AdminMemberService;
import kr.or.ddit.projects.member.service.UserMemberService;
import kr.or.ddit.projects.module.service.ModuleService;
import kr.or.ddit.projects.project.service.AdminProjectService;
import kr.or.ddit.projects.project.service.ProjectService;
import kr.or.ddit.projects.pushmsg.service.PushMsgService;
import kr.or.ddit.projects.reply.service.ReplyService;
import kr.or.ddit.projects.role.service.RoleService;
import kr.or.ddit.projects.schedule.service.ScheduleService;
import kr.or.ddit.projects.scm.service.ScmService;
import kr.or.ddit.projects.scm.service.SvnService;
import kr.or.ddit.projects.storage.service.StorageService;
import kr.or.ddit.projects.work.service.AdminWorkService;
import kr.or.ddit.projects.work.service.WorkService;
import kr.or.ddit.security.auth.service.ISecurityService;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;

/**
 * @author 신광진
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 26.     신광진         최초작성
 * 2021. 1. 28.     신광진		 codeService 추가
 * 2021. 1. 29.     신광진		 pushMsgService 추가
 * 2021. 1. 29.     신광진		 boardService 추가
 * 2021. 2. 04.     신광진		 roleService 추가
 * 2021. 2. 4.      이선엽		 signUpService 추가
 * 2021. 2. 05.     이선엽		 customInfoService 추가
 * 2021. 2. 09.     신광진		 adminIssueService 추가
 * 2021. 2. 09.     신광진		 adminWorkService 추가
 * 2021. 2. 13.     신광진		 adminHistoryService 추가
 * 2021. 2. 15.     신광진		 memberService -> adminMemberService로 변경
 * 2021. 2. 18.     신광진		 dashBoardService 추가
 * 2021. 2. 21.     신광진		 projectService 추가
 * 2021. 2. 22.     신광진		 securityService 추가
 * 2021. 2. 22.     신광진		 Model 추가
 * 2021. 2. 23.     신광진		 copyModelAttributeToDest 추가
 * 2021. 3. 5.      임  건                     storageService 추가
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public class BaseController {

	protected CustomPaginationInfo<? extends Object> paginationInfo;
	protected Logger logger = LoggerFactory.getLogger(BaseController.class);

	// 단순 Exception Message
	protected static final NotyMessageVO EXCEPTION_MESSAGE_FOR_CLIENT = NotyMessageVO.builder("서버오류로 인해 작업에 실패하였습니다")
			.build();
	protected static final NotyMessageVO SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT = NotyMessageVO.builder("요청 작업을 완료하였습니다")
			.build();

	// ISSUE CUSTOM_INFO 관련 Message
	protected static final NotyMessageVO ISSUE_TYPE_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 이슈유형으로 발행된 이슈가 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO ISSUE_RANK_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 이슈 우선순위로 발행된 이슈가 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO ISSUE_STATUS_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 이슈상태로 발행된 이슈가 존재하여 삭제할 수 없습니다.").build();

	// WORK CUSTOM_INFO 관련 Message
	protected static final NotyMessageVO WORK_TYPE_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 일감유형으로 설정된 일감이 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO WORK_RANK_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 일감 우선순위로 설정된 일감이 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO WORK_STATUS_EXIST_IN_PROJECT = NotyMessageVO.builder("해당 일감상태로 설정된 일감이 존재하여 삭제할 수 없습니다.").build();

	// initPassword 관련 Message
	protected static final NotyMessageVO SUCCESS_INIT_PASSWORD_MESSAGE = NotyMessageVO.builder("초기화 비밀번호를 이메일로 발송하였습니다.").build();
	protected static final NotyMessageVO FAILED_INIT_PASSWORD_MESSAGE = NotyMessageVO.builder("비밀번호 초기화를 실패하였습니다").build();

	// MEMBER 관련 Message
	protected static final NotyMessageVO SUCCESS_MEMBER_MODIFY_MESSAGE = NotyMessageVO.builder("회원정보 변경을 완료하였습니다").build();
	protected static final NotyMessageVO FAILED_MEMBER_MODIFY_MESSAGE = NotyMessageVO.builder("회원정보 변경을 실패하였습니다.").build();
	protected static final NotyMessageVO MEMBER_NOT_EXIST_MESSAGE = NotyMessageVO.builder("요청한 회원정보가 존재하지 않습니다.").build();

	// PUSH_MESSAGE 관련 Message
	protected static final NotyMessageVO SUCCESS_SEND_PUSH_MESSAGE = NotyMessageVO.builder("푸시 메시지가 발송되었습니다.").build();
	protected static final NotyMessageVO FAILED_SEND_PUSH_MESSAGE = NotyMessageVO.builder("푸시 메시지 발송을 실패하였습니다").build();
	protected static final NotyMessageVO SUCCESS_REMOVE_PUSH_MESSAGE = NotyMessageVO.builder("푸시 메시지가 삭제되었습니다.").build();
	protected static final NotyMessageVO FAILED_REMOVE_PUSH_MESSAGE = NotyMessageVO.builder("푸시 메시지 삭제를 실패하였습니다").build();
	
	// PROJECT 관련 Message
	protected static final NotyMessageVO SUCCESS_PROJECT_REQUEST_MESSAGE = NotyMessageVO.builder("프로젝트 요청이 완료되었습니다").build();

	// AJAX 관련 MESSAGE
	protected static final NotyMessageVO SUCCESS_AJAX_COMMAND = NotyMessageVO.builder("OK").build();
	protected static final NotyMessageVO FAILED_AJAX_COMMAND = NotyMessageVO.builder("FAILED").build();
	
	// AUTHORITY 관련 MESSAGE
	protected static final NotyMessageVO SUCCESS_UPDATE_AUTHORITY = NotyMessageVO.builder("권한수정을 완료하였습니다").build();
	protected static final NotyMessageVO SUCCESS_INSERT_AUTHORITY = NotyMessageVO.builder("권한등록을 완료하였습니다").build();
	protected static final NotyMessageVO SUCCESS_REMOVE_AUTHORITY = NotyMessageVO.builder("권한삭제를 완료하였습니다").build();
	protected static final NotyMessageVO EXIST_USE_AUTHORITY = NotyMessageVO.builder("해당 권한으로 등록된 사용자가 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO EXIST_PARENT_ROLE_AUTHORITY = NotyMessageVO.builder("해당 권한의 상위권한이 존재하여 삭제할 수 없습니다.").build();
	protected static final NotyMessageVO EXIST_ASSIGNED_RESOURCE_AUTHORITY = NotyMessageVO.builder("해당 권한에게 할당된 보호자원이 존재하여 삭제할 수 없습니다.").build();
	
	
	@Inject
	protected KanbanService kanbanService;

	@Inject
	protected ChatService chatService;

	@Inject
	protected FileService fileService;

	@Inject
	protected StorageService storageService;

	@Inject
	protected HistoryService historyService;

	@Inject
	protected IssueService issueService;

	@Inject
	protected AdminMemberService adminMemberService;

	@Inject
	protected UserMemberService userMemberService;

	@Inject
	protected ModuleService moduleService;

	@Inject
	protected ReplyService replyService;

	@Inject
	protected ScheduleService scheduleService;

	@Inject
	protected ScmService scmService;
	
	@Inject
	protected SvnService svnService;

	@Inject
	protected WorkService workService;

	@Inject
	protected AdminProjectService adminProjectService;

	@Inject
	protected CodeService codeService;

	@Inject
	protected PushMsgService pushMsgService;

	@Inject
	protected BoardService boardService;

	@Inject
	protected RoleService roleService;

	protected NotyMessageVO getNotyMessage(String message) {
		return NotyMessageVO.builder(message).build();
	}

	@Inject
	protected SignUpService signUpService;

	@Inject
	protected CustomInfoService customInfoService;

	@Inject
	protected AdminIssueService adminIssueService;

	@Inject
	protected AdminWorkService adminWorkService;

	@Inject
	protected AdminHistoryService adminHistoryService;
	
	@Inject
	protected DashBoardService dashBoardService;
	
	@Inject
	protected ProjectService projectService;
	
	@Inject
	protected ISecurityService securityService;

	protected void copyModelAttributeToDest(Object dest, Model model, String attributeName) throws IllegalAccessException, InvocationTargetException {
		if(model.containsAttribute(attributeName)) {
			Map<String, Object> modelMap = model.asMap();
			BeanUtils.copyProperties(dest, modelMap.get(attributeName));
		}
	}
}
