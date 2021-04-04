package kr.or.ddit.commons.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.vo.CodeVO;

/**
 * @author 신광진
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자          수정내용
 * ------------    --------    ----------------------
 * 2021. 1. 27.     신광진  		최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public interface CodeService {

	/**
	 * 모든 코드정보를 조회
	 * 
	 * @return
	 * @throws DataAccessException
	 * 
	 *                             <pre>
	 * 검색결과가 있는경우: List&lt;CodeVO&gt;
	 * 검색결과가 없는경우: null
	 *                             </pre>
	 */
	public List<CodeVO> retrieveCodeList() throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 그룹코드와 일치하는 모든 코드조회
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CodeVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CodeVO> retrieveCodeListByGroupCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode와 code가 모두 일치하는 Code조회
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: CodeVO
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public CodeVO retrieveCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 새로운 코드 등록
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void createCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode, code와 일치하는 코드의 기존 코드정보 수정
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void modifyCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode, code와 일치하는 코드의 기존 코드 삭제
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void removeCode(CodeVO codeVO) throws DataAccessException;
}
