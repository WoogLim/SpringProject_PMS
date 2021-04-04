package kr.or.ddit.commons.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

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
@Repository
public interface CustomInfoDAO {
	/**
	 * CustomInfo는 이슈유형, 이슈상태 등에 사용되는 라벨에 대한 정보를 가진다. 예를들어 사용자가 이슈유형을 생성한다면 해당 이슈유형의
	 * 이름, 아이콘클래스, 색상 등을 저장한다.
	 */

	/**
	 * 새로운 custom등록
	 * 
	 * @param customInfoVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: 1
	 * 실패: 0
	 *         </pre>
	 */
	public int insertCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 기존 custom정보 수정
	 * 
	 * @param customInfoVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: update된 row 수 (return&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int updateCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 기존 custom정보 삭제
	 * 
	 * @param customInfoVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 성공: delete된 row 수 (return&gt;0)
	 * 실패: 0
	 *         </pre>
	 */
	public int deleteCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 파라미터의 customInfoVO의 customNo와 일치하는 custom정보 조회
	 * 
	 * @param customInfoVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: CustomInfoVO
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public CustomInfoVO selectCustomInfo(CustomInfoVO customInfoVO) throws DataAccessException;

	/**
	 * 파라미터의 customInfoVO의 groupName과 동일한 custom정보 모두 조회
	 * 
	 * @param customInfoVO
	 * @throws DataAccessException
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;CustomInfoVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<CustomInfoVO> selectCustomInfoList(CustomInfoVO customInfoVO) throws DataAccessException;

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
	public List<CustomInfoVO> selectIssueCustomInfoList();

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
	public List<CustomInfoVO> selectWorkCustomInfoList();

	/**
	 * 모든 이슈중에 파라미터로 받은 customInfoVO의 text와 일치하는 issueType 수 조회
	 * 
	 * @param customInfoVO
	 * @return 존재하는 row 수 (return&ge;0)
	 */
	public int existCountToIssue(CustomInfoVO customInfoVO);

	/**
	 * 모든 일감중에 파라미터로 받은 customInfoVO의 text와 일치하는 workType 수 조회
	 * 
	 * @param customInfoVO
	 * @return 존재하는 row 수 (return&ge;0)
	 */
	public int existCountToWork(CustomInfoVO customInfoVO);

}
