package kr.or.ddit.commons.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.service.CodeService;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.vo.CodeVO;

/**
 * @author 신광진
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 1. 27.     신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class CodeServiceImpl extends BaseService implements CodeService {

	@Override
	public List<CodeVO> retrieveCodeList() throws DataAccessException {
		return codeDAO.selectCodeList();
	}

	@Override
	public CodeVO retrieveCode(CodeVO codeVO) throws DataAccessException {
		return codeDAO.selectCode(codeVO);
	}

	@Override
	public List<CodeVO> retrieveCodeListByGroupCode(CodeVO codeVO) throws DataAccessException {
		return codeDAO.selectCodeListByGroupCode(codeVO);
	}

	@Override
	public void createCode(CodeVO codeVO) throws DataAccessException {
		codeDAO.insertCode(codeVO);
	}

	@Override
	public void modifyCode(CodeVO codeVO) throws DataAccessException {
		codeDAO.updateCode(codeVO);
	}

	@Override
	public void removeCode(CodeVO codeVO) throws DataAccessException {
		codeDAO.deleteCode(codeVO);
	}

}
