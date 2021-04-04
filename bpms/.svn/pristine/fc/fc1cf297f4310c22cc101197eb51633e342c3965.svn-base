package kr.or.ddit.commons.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.commons.service.CustomInfoService;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CustomInfoVO;

/**
 * @author 신광진
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 5.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class CustomInfoServiceImpl extends BaseService implements CustomInfoService {

	@Transactional
	@Override
	public void createCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException {
		customInfoDAO.insertCustomInfo(customInfoVO);
		codeDAO.insertCode(codeVO);
	}

	@Transactional
	@Override
	public void modifyCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException {
		customInfoDAO.updateCustomInfo(customInfoVO);
		codeDAO.updateCode(codeVO);
	}

	@Transactional
	@Override
	public void removeCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException {
		int checkResult = 0;
		String groupCode = customInfoVO.getGroupCode();
		if (groupCode.startsWith("I")) { // ISSUE
			checkResult = customInfoDAO.existCountToIssue(customInfoVO);
		} else if (groupCode.startsWith("W")) { // WORK
			checkResult = customInfoDAO.existCountToWork(customInfoVO);
		}
		if (checkResult > 0)
			throw new CustomException();
		customInfoDAO.deleteCustomInfo(customInfoVO);
		codeDAO.deleteCode(codeVO);
	}

	@Override
	public CustomInfoVO retrieveCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException {
		return customInfoDAO.selectCustomInfo(customInfoVO);
	}

	@Override
	public List<CustomInfoVO> retrieveCustomInfoList(CustomInfoVO customInfoVO) throws DataAccessException {
		return customInfoDAO.selectCustomInfoList(customInfoVO);
	}

	@Override
	public List<CustomInfoVO> retrieveIssueCustomInfoList() {
		return customInfoDAO.selectIssueCustomInfoList();
	}

	@Override
	public List<CustomInfoVO> retrieveWorkCustomInfoList() {
		return customInfoDAO.selectWorkCustomInfoList();
	}

}
