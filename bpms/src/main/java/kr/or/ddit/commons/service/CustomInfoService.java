package kr.or.ddit.commons.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

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
public interface CustomInfoService {
	/**
	 * CustomInfo는 이슈유형, 이슈상태 등에 사용되는 라벨에 대한 정보를 가진다. 예를들어 사용자가 이슈유형을 생성한다면 해당 이슈유형의
	 * 이름, 아이콘클래스, 색상 등을 저장한다.
	 */

	/**
	 * 새로운 custom등록
	 * 
	 * @param customInfoVO
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void createCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException;

	/**
	 * 기존 custom정보 수정
	 * 
	 * @param customInfoVO
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void modifyCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException;

	/**
	 * 기존 custom정보 삭제
	 * 
	 * @param customInfoVO
	 * @param codeVO
	 * @throws DataAccessException
	 */
	public void removeCustomInfo(CustomInfoVO customInfoVO, CodeVO codeVO) throws DataAccessException;

	/**
	 * 파라미터의 customInfoVO의 customNo와 일치하는 custom정보 조회
	 * 
	 * @param customInfoVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: CustomInfoVO
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public CustomInfoVO retrieveCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 파라미터의 customInfoVO의 groupName과 동일한 custom정보 모두 조회
	 * 
	 * @param customInfoVO
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CustomInfoVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CustomInfoVO> retrieveCustomInfoList(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 등록된 모든 Issue관련 CustomInfo정보 조회
	 * 
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CustomInfoVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CustomInfoVO> retrieveIssueCustomInfoList();

	/**
	 * 등록된 모든 Work관련 CustomInfo정보 조회
	 * 
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CustomInfoVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CustomInfoVO> retrieveWorkCustomInfoList();

}
