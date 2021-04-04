package kr.or.ddit.projects.member.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.service.AdminMemberService;
import kr.or.ddit.projects.member.service.UserMemberService;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 임건
 * @since 2021. 2. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 15.    임건		      최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class UserMemberServiceImpl extends BaseService implements UserMemberService {

	@Value("#{appInfo.profileFolder}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
	}
	
	@Inject
	private PasswordEncoder passwordEncoder;

	private void encodePassword(MemberVO memberVO) {
		String encoded = passwordEncoder.encode(memberVO.getMemPass());
		memberVO.setMemPass(encoded);
	}

	@Override
	public List<ProjectVO> retrieveMemberProjectList(MemberVO memberVO) {
		return userMemberDAO.retrieveMemberProjectList(memberVO);
	}

	@Override
	public List<ProjectVO> retrieveProjectNoticeList(MemberVO memberVO) {
		return userMemberDAO.retrieveProjectNoticeList(memberVO);
	}

	@Override
	public ServiceResult memberModifyPassword(MemberVO memberVO) {
		ServiceResult result = null;
		encodePassword(memberVO);
		
		int cnt = userMemberDAO.updateMemberPass(memberVO);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public MemberVO retrieveMember(MemberVO memberVO) {
		return userMemberDAO.selectMember(memberVO);
	}

	@Override
	public List<WorkVO> retrieveWorkListByMember(MemberVO memberVO) {
		return userMemberDAO.selectWorkListByMember(memberVO);
	}

	@Override
	public List<IssueVO> retrieveIssueListByMember(MemberVO memberVO) {
		return userMemberDAO.selectIssueListByMember(memberVO);
	}

	@Override
	public ServiceResult memberImgUpdate(MemberVO member, MultipartFile memImg) {
		
		MemberVO memberVO = userMemberDAO.selectMember(member);
		ServiceResult result = ServiceResult.FAILED;
		
		if(memberVO.getMemImg() != null && !memberVO.getMemImg().isEmpty()) {
			FileUtils.deleteQuietly(new File(saveFolder, memberVO.getMemImg()));
		}
		
		member.setMem_image(memImg);
		
		int rowcnt = userMemberDAO.updateMemberImg(member);
		if(rowcnt > 0) {
			try {
				member.saveTo(saveFolder);
				result = ServiceResult.OK;
			} catch(IOException e) {
				throw new RuntimeException(e);
			}
		}
		
		return result;
	}
}
