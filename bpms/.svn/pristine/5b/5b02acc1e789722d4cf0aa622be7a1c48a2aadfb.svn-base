package kr.or.ddit.projects.base.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.or.ddit.commons.dao.CodeDAO;
import kr.or.ddit.commons.dao.CustomInfoDAO;
import kr.or.ddit.commons.dao.DashBoardDAO;
import kr.or.ddit.commons.dao.SignUpDAO;
import kr.or.ddit.commons.service.MailService;
import kr.or.ddit.projects.board.dao.BoardDAO;
import kr.or.ddit.projects.chat.dao.ChatDAO;
import kr.or.ddit.projects.file.dao.FileDAO;
import kr.or.ddit.projects.history.dao.AdminHistoryDAO;
import kr.or.ddit.projects.history.dao.HistoryDAO;
import kr.or.ddit.projects.issue.dao.AdminIssueDAO;
import kr.or.ddit.projects.issue.dao.IssueDAO;
import kr.or.ddit.projects.kanban.dao.KanbanDAO;
import kr.or.ddit.projects.member.dao.AdminMemberDAO;
import kr.or.ddit.projects.member.dao.UserMemberDAO;
import kr.or.ddit.projects.module.dao.ModuleDAO;
import kr.or.ddit.projects.project.dao.AdminProjectDAO;
import kr.or.ddit.projects.project.dao.ProjectDAO;
import kr.or.ddit.projects.pushmsg.dao.PushMsgDAO;
import kr.or.ddit.projects.reply.dao.ReplyDAO;
import kr.or.ddit.projects.role.dao.RoleDAO;
import kr.or.ddit.projects.schedule.dao.ScheduleDAO;
import kr.or.ddit.projects.scm.dao.ScmDAO;
import kr.or.ddit.projects.work.dao.AdminWorkDAO;
import kr.or.ddit.projects.work.dao.WorkDAO;
import kr.or.ddit.security.auth.dao.IAuthorityDAO;
import kr.or.ddit.security.auth.dao.IResourceDAO;

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
 * 2021. 1. 26.    신광진         최초작성
 * 2021. 1. 28.    신광진         codeDAO 추가
 * 2021. 1. 29.    신광진         pushMsgDAO 추가
 * 2021. 1. 29.    신광진         boardDAO 추가
 * 2021. 2. 01.    신광진         passwordEncoder추가
 * 2021. 2. 01.    신광진         mailService추가
 * 2021. 2. 04.    신광진         roleDAO추가
 * 2021. 2. 05.    신광진         customInfoDAO추가
 * 2021. 2. 09.    신광진         adminIssueDAO추가
 * 2021. 2. 13.    신광진         adminHistoryDAO추가
 * 2021. 2. 15.    신광진         memberDAO -> adminMemberDAO로 변경
 * 2021. 2. 18.    신광진		  dashBoardDAO 추가
 * 2021. 2. 21.    신광진		  projectDAO 추가
 * 2021. 2. 22.    신광진		  authDAO 추가
 * 2021. 2. 22.    신광진		  resDAO 추가
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public class BaseService {

	@Inject
	protected PasswordEncoder passwordEncoder;
	protected static final Logger logger = LoggerFactory.getLogger(BaseService.class);

	// 프로젝트 관련 상태코드
	protected static final int CODE_WAIT = 1;
	protected static final int CODE_PROGRESS = 2;
	protected static final int CODE_PAUSE = 3;
	protected static final int CODE_COMPLETE = 4;
	
	@Inject
	protected KanbanDAO kanbanDAO;

	@Inject
	protected ChatDAO chatDAO;

	@Inject
	protected FileDAO fileDAO;

	@Inject
	protected HistoryDAO historyDAO;

	@Inject
	protected IssueDAO issueDAO;

	@Inject
	protected AdminMemberDAO adminMemberDAO;

	@Inject
	protected UserMemberDAO userMemberDAO;

	@Inject
	protected ModuleDAO moduleDAO;

	@Inject
	protected ReplyDAO replyDAO;

	@Inject
	protected ScheduleDAO scheduleDAO;

	@Inject
	protected ScmDAO scmDAO;

	@Inject
	protected WorkDAO workDAO;

	@Inject
	protected AdminProjectDAO adminProjectDAO;

	@Inject
	protected CodeDAO codeDAO;

	@Inject
	protected PushMsgDAO pushMsgDAO;

	@Inject
	protected BoardDAO boardDAO;

	@Inject
	protected MailService mailService;

	@Inject
	protected RoleDAO roleDAO;

	@Inject
	protected SignUpDAO signUpDAO;

	@Inject
	protected CustomInfoDAO customInfoDAO;

	@Inject
	protected AdminIssueDAO adminIssueDAO;

	@Inject
	protected AdminWorkDAO adminWorkDAO;

	@Inject
	protected AdminHistoryDAO adminHistoryDAO;
    
    @Inject
    protected DashBoardDAO dashBoardDAO;

    @Inject
    protected ProjectDAO projectDAO;
    
	@Inject
	protected IAuthorityDAO authDAO;

	@Inject
	protected IResourceDAO resDAO;
}
