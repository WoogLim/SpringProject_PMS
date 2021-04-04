package kr.or.ddit.projects.project.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.project.service.AdminProjectService;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 1. 26.     신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class AdminProjectServiceImpl extends BaseService implements AdminProjectService {

	@Transactional
	@Override
	public void createProject(ProjectVO projectVO) throws DataAccessException {
		int sqlResult = adminProjectDAO.insertProject(projectVO);
		List<ProMemberVO> proMemberList = projectVO.getProMemberList();
		if(sqlResult > 0) {
			if(proMemberList != null) {
				sqlResult += adminMemberDAO.insertProMemberByProjectVO(projectVO);
				if(sqlResult < proMemberList.size()) throw new CustomException(); 
			}
		} else {
			throw new CustomException();
		}
	}

	@Transactional
	@Override
	public void acceptProject(ProjectVO projectVO, PushMessageVO pushMsgVO) throws DataAccessException, CustomException {
		ProjectVO retrieveProject = retrieveProject(projectVO);
		if (retrieveProject != null) {
			if(projectVO.getCode() == 2) {
				// 프로젝트 최초승인 
				List<ProMemberVO> proMemberList = adminProjectDAO.selectProjectMemberList(projectVO);
				
				HashMap<String, Object> hashMap = new HashMap<>();
				hashMap.put("proMemberList", proMemberList);
				hashMap.put("pushMsgVO", pushMsgVO);
				hashMap.put("proId", projectVO.getProId());
				int messageInsertResult = pushMsgDAO.insertProjectAcceptMsg(hashMap); // 구성원들에게 메시지 전송
				if(messageInsertResult == proMemberList.size()) {
					int chatRoomInsertResult = chatDAO.insertChatRoom(retrieveProject); // 채팅방 생성
					if(chatRoomInsertResult > 0) {
						retrieveProject.setProMemberList(proMemberList);
						int chatMemberInsertResult = chatDAO.insertChatMemberList(retrieveProject); // 채팅방에 구성원 입력
						if(chatMemberInsertResult < proMemberList.size()) throw new CustomException();
					} else {
						throw new CustomException();
					}
				} else {
					throw new CustomException();
				}
			} 
			int updateRes = adminProjectDAO.updateProject(projectVO); // 프로젝트 상태변경
			if (updateRes < 1) throw new CustomException();
		} else {
			throw new CustomException();
		}
	}

	@Override
	public ServiceResult deleteProject(ProjectVO projectVO) {
		ServiceResult ret = ServiceResult.OK;
		Object retrieveRes = retrieveProject(projectVO);
		if (retrieveRes != null) {
			int deleteRes = adminProjectDAO.deleteProject(projectVO);
			if (deleteRes < 1)
				ret = ServiceResult.FAILED;
		} else {
			ret = ServiceResult.NOTEXIST;
		}
		return ret;
	}

	@Override
	public int retrieveProjectCount(PagingVO<ProjectVO> pagingVO) {
		return adminProjectDAO.selectProjectListCount(pagingVO);
	}

	@Override
	public List<ProjectVO> retrieveProjectList(PagingVO<ProjectVO> pagingVO) {
		return adminProjectDAO.selectProjectList(pagingVO);
	}

	@Override
	public ProjectVO retrieveProject(ProjectVO projectVO) {
		return adminProjectDAO.selectProject(projectVO);
	}

	@Override
	public List<ProjectVO> retrieveRequestProjectList() {
		return adminProjectDAO.selectRequestProjectList();
	}

	@Override
	public List<ProjectVO> retrieveNoPagingProjectList() {
		return adminProjectDAO.selectNoPagingProjectList();
	}

	@Override
	public List<ProjectVO> retrieveHierarchyProjectList(PagingVO<ProjectVO> pagingVO) {
		return adminProjectDAO.selectHierarchyProjectList(pagingVO);
	}

	@Override
	public List<ProjectVO> retrieveProjectListForMain() {
		return adminProjectDAO.selectProjectListForMain();
	}

	@Override
	public List<ProjectVO> retrieveProjectListByMember(MemberVO memberVO) {
		return adminProjectDAO.selectProjectListByMember(memberVO);
	}

	@Override
	public List<ProMemberVO> retrieveProjectMemberList(ProjectVO projectVO) {
		return adminProjectDAO.selectProjectMemberList(projectVO);
	}

	@Override
	public List<ProMemberVO> retrieveProjectMemberRoleNameList(ProjectVO projectVO) {
		return adminProjectDAO.selectProjectMemberRoleNameList(projectVO);
	}

	@Override
	public void updateProject(ProjectVO projectVO) throws DataAccessException, CustomException {
		int sqlResult = adminProjectDAO.updateProject(projectVO);
		if(sqlResult < 1) throw new CustomException();
	}

	@Override
	public List<ProjectVO> retrieveProjectListByState() {
		return adminProjectDAO.selectProjectListByState();
	}
	
	

}
