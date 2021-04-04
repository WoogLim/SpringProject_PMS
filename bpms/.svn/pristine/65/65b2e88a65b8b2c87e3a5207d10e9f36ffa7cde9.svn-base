package kr.or.ddit.commons.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.CodeVO;

/**
 * @author 신광진
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        	수정자         수정내용
 * ------------     --------    ----------------
 * 2021. 1. 27.  	신광진			최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Repository
public interface CodeDAO {

	/**
	 * 모든 코드정보를 조회
	 * 
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CodeVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CodeVO> selectCodeList() throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode와 일치하는 모든 코드조회
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
	public List<CodeVO> selectCodeListByGroupCode(CodeVO codeVO) throws DataAccessException;

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
	public CodeVO selectCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 새로운 코드 등록
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: 1
	 * 실패: 0
	 *         </pre>
	 */
	public int insertCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode, code와 일치하는 코드의 기존 코드정보 수정
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: update된 row 수 (return&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int updateCode(CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 codeVO의 groupCode, code와 일치하는 코드의 기존 코드 삭제 기존 코드 삭제
	 * 
	 * @param codeVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: delete된 row 수(return&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int deleteCode(CodeVO codeVO) throws DataAccessException;

}
