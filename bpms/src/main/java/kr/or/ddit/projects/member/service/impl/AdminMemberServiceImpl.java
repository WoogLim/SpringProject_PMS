package kr.or.ddit.projects.member.service.impl;

import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.service.AdminMemberService;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.MailVO;
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
 * 2021. 1. 29.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class AdminMemberServiceImpl extends BaseService implements AdminMemberService {

	@Override
	public MemberVO retrieveMemberByUserName(String mem_id) {
		return adminMemberDAO.selectMemberByUserName(mem_id);
	}

	@Override
	public MemberVO retrieveMember(MemberVO memberVO) {
		return adminMemberDAO.selectMember(memberVO);
	}

	@Override
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO) {
		return adminMemberDAO.selectMemberCount(pagingVO);
	}

	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		return adminMemberDAO.selectMemberList(pagingVO);
	}

	@Override
	public ServiceResult createMember(MemberVO memberVO) {
		String plainPassword = memberVO.getMemPass();
		passwordEncoder(memberVO);
		int createRes = adminMemberDAO.insertMember(memberVO);
		ServiceResult ret = null;
		if (createRes > 0) {
			ret = ServiceResult.OK;
			MailVO mailVO = new MailVO(memberVO.getMemMail(),
					"아이디: " + memberVO.getMemId() + "\n 비밀번호: " + plainPassword);
			ServiceResult sendMailRes = mailService.sendMail(mailVO);

			// 메일발송 성공, 실패 여부에 따른 로직구현이 필요함.
			if (sendMailRes == ServiceResult.FAILED) {
				logger.info("메일발송 실패");
			} else {
				logger.info("메일발송 성공");
			}
		} else {
			ret = ServiceResult.FAILED;
		}
		return ret;
	}

	@Override
	public ServiceResult modifyMember(MemberVO memberVO) {
		MemberVO retrieveRes = retrieveMember(memberVO);
		ServiceResult ret = ServiceResult.OK;
		if (retrieveRes != null) {
			int updateRes = adminMemberDAO.updateMember(memberVO);
			if (updateRes < 1)
				ret = ServiceResult.FAILED;
		} else {
			ret = ServiceResult.NOTEXIST;
		}
		return ret;
	}

	@Override
	public ServiceResult removeMember(MemberVO memberVO) {
		MemberVO retrieveRes = retrieveMember(memberVO);
		ServiceResult ret = ServiceResult.OK;
		if (retrieveRes != null) {
			int deleteRes = adminMemberDAO.deleteMember(memberVO);
			if (deleteRes < 1)
				ret = ServiceResult.FAILED;
		} else {
			ret = ServiceResult.NOTEXIST;
		}
		return ret;
	}

	@Override
	public ServiceResult duplicationCheckForMemId(MemberVO memberVO) {
		MemberVO duplicationCheckRes = adminMemberDAO.duplicationCheckForMemId(memberVO);
		ServiceResult ret = ServiceResult.OK;
		if (duplicationCheckRes != null)
			ret = ServiceResult.PKDUPLICATED;
		return ret;
	}

	@Override
	public void passwordEncoder(MemberVO memberVO) {
		String encodedPassword = passwordEncoder.encode(memberVO.getMemPass());
		memberVO.setMemPass(encodedPassword);
	}

	@Override
	public ServiceResult changeLockStatus(MemberVO memberVO) {
		MemberVO retrieveRes = retrieveMember(memberVO);
		ServiceResult ret = ServiceResult.OK;
		if (retrieveRes != null) {
			if(!"ROLE_ADMIN".equals(retrieveRes.getMemRole())) {
				int updateRes = adminMemberDAO.changeLockStatus(memberVO);
				if (updateRes < 1)
					ret = ServiceResult.FAILED;
			} else {
				ret = ServiceResult.DISABLE;
			}
		} else {
			ret = ServiceResult.NOTEXIST;
		}
		return ret;
	}

	@Override
	public ServiceResult initPassword(MemberVO memberVO) {
		MemberVO selectedMember = adminMemberDAO.selectMember(memberVO);
		ServiceResult ret = ServiceResult.OK;
		if (selectedMember != null) {
			String rawPassowrd = UUID.randomUUID().toString();
			memberVO.setMemPass(rawPassowrd);
			passwordEncoder(memberVO);
			int initRes = adminMemberDAO.initPassword(memberVO);
			if (initRes > 0) {
				ret = mailService.sendMail(
						new MailVO(selectedMember.getMemMail(), "초기화 된 비밀번호: " + rawPassowrd, "BPMS계정 비밀번호 초기화 알림"));
			} else {
				ret = ServiceResult.FAILED;
			}
		} else {
			ret = ServiceResult.NOTEXIST;
		}
		return ret;
	}

	@Override
	public List<MemberVO> retrieveMemberListForMain() {
		return adminMemberDAO.selectMemberListForMain();
	}

	////////////////////////////////////////////////////////
	// proMember 관련
	///////////////////////////////////////////////////////
	@Override
	public void createProMemberByProjectVO(ProjectVO projectVO) throws DataAccessException, CustomException {
		int sqlRes = adminMemberDAO.insertProMemberByProjectVO(projectVO);
		if(sqlRes < projectVO.getProMemberList().size()) throw new CustomException();
	}

	@Override
	public void createProMember(ProjectVO projectVO) throws DataAccessException, CustomException {
		int sqlRes = adminMemberDAO.insertProMember(projectVO);
		if(sqlRes < 0) throw new CustomException();
	}

	@Override
	public int removeProMember(ProjectVO projectVO) {
		return adminMemberDAO.deleteProMember(projectVO);
	}

	@Override
	public int retrieveProMemberCount(ProjectVO projectVO) {
		return adminMemberDAO.selectProMemberCount(projectVO);
	}

}
