/**
 * @author 작성자명
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.commons.service.impl;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.service.SignUpService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.member.vo.MemberVO;

@Service
public class SignUpServiceImpl extends BaseService implements SignUpService {

	@Inject
	private PasswordEncoder passwordEncoder;

	private void encodePassword(MemberVO memberVO) {
		String encoded = passwordEncoder.encode(memberVO.getMemPass());
		memberVO.setMemPass(encoded);
	}

	@Override
	public ServiceResult RegistMember(MemberVO memberVO) {
		ServiceResult result = null;
		if (adminMemberDAO.selectMember(memberVO) == null) {
			encodePassword(memberVO);
			int cnt = signUpDAO.insertMember(memberVO);
			if (cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.PKDUPLICATED;
		}
		return result;
	}

	@Override
	public ServiceResult isAlreadyUse(MemberVO memberVO) {
		ServiceResult result = null;
		int cnt = signUpDAO.idCheck(memberVO);
		if (cnt > 0) {
			result = ServiceResult.PKDUPLICATED;
		} else {
			result = ServiceResult.OK;
		}
		return result;
	}

}
