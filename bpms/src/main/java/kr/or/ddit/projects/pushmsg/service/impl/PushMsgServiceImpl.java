package kr.or.ddit.projects.pushmsg.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.MemberWrapper;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.service.PushMsgService;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 29.     신광진       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class PushMsgServiceImpl extends BaseService implements PushMsgService {

	@Override
	public ServiceResult createPushMsg(PushMessageVO pushMsgVO, ProjectVO projectVO) {
		return null;
	}

	@Override
	public void removePushMsg(MemberVO memberVO) throws DataAccessException, CustomException {
		int sqlResult = pushMsgDAO.deletePushMsg(memberVO);
		if(sqlResult < memberVO.getPushMsgList().size()) throw new CustomException();
	}

	@Override
	public int retrievePushMsgCount(PagingVO<PushMessageVO> pagingVO) {
		return pushMsgDAO.selectPushMsgCount(pagingVO);
	}

	@Override
	public PushMessageVO retrievePushMsg(PushMessageVO pushMsgVO) {
		return pushMsgDAO.selectPushMsg(pushMsgVO);
	}

	@Override
	public List<PushMessageVO> retrievePushMsgList(PagingVO<PushMessageVO> pagingVO) {
		return pushMsgDAO.selectPushMsgList(pagingVO);
	}

	@Transactional
	@Override
	public void createProjectRejectMsg(PushMessageVO pushMsgVO, ProjectVO projectVO) throws DataAccessException, CustomException {
		int cnt = pushMsgDAO.insertProjectRejectMsg(pushMsgVO);
		if (cnt > 0) {
			int proMemberCount = adminMemberDAO.selectProMemberCount(projectVO);
			int removeMemberCnt = adminMemberDAO.deleteProMember(projectVO);
			if(removeMemberCnt == proMemberCount) {
				cnt += adminProjectDAO.deleteProject(projectVO);
				if (cnt < 2) throw new CustomException();
			} else {
				throw new CustomException();
			}
		} else {
			throw new CustomException();
		}
	}

	@Override
	public List<PushMessageVO> retrieveUnConfirmedPushMsgList(MemberVO memberVO) {
		return pushMsgDAO.selectUnConfirmedPushMsgList(memberVO);
	}

	@Override
	public int retrieveUnConfimedPushMsgCount(MemberVO memberVO) {
		return pushMsgDAO.selectUnConfimedPushMsgCount(memberVO);
	}

	@Override
	public int modifyPushMsg(PushMessageVO pushMsgVO) throws DataAccessException, CustomException {
		int sqlResult = pushMsgDAO.updatePushMsg(pushMsgVO);
		if(sqlResult < 0) throw new CustomException();
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int unConfirmedPushMsgCount = 0;
		if(principal instanceof MemberWrapper) {
			unConfirmedPushMsgCount = pushMsgDAO.selectUnConfimedPushMsgCount(((MemberWrapper)principal).getRealMember());
			((MemberWrapper)principal).getRealMember().setUnConfirmedPushMsgCount(unConfirmedPushMsgCount);
		}
		return unConfirmedPushMsgCount;
		
	}
}















