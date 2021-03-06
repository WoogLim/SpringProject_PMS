package kr.or.ddit.security.auth.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.security.vo.ResourceVO;

public interface ISecurityService {
	/**
	 * 모든 역할 정보 조회
	 * 
	 * @return
	 */
	public List<AuthorityVO> retrieveAllAuthorities();

	/**
	 * 전체 자원(메뉴) 조회
	 * 
	 * @return
	 */
	public List<ResourceVO> retrieveAllResources();

	/**
	 * 역할별 접근 가능한 자원의 목록 조회
	 * 
	 * @param authority
	 * @return
	 */
	public List<ResourceVO> retrieveResourceListForAuthority(AuthorityVO authority);

	/**
	 * 역할별 접근 가능한 자원 정보 갱신
	 * 
	 * @param authority
	 * @return
	 */
	public ServiceResult updateResourceRole(AuthorityVO authority);
	
	/**
	 * 프로젝트 내부에서 사용되는 역할만 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> retrieveTeamAuthorityList();
	
	/**
	 * 파라미터로 받은 authority의 authority과 동일한 권한의 정보조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우 : AuthorityVO
	 * 검색결과가 없는경우:  null
	 * </pre>
	 */
	public AuthorityVO retrieveAuthority(AuthorityVO authorityVO);

	/**
	 * 파라미터로 받은 authorityVO의 authority와 동일한 권한을 삭제
	 * @param authorityVO
	 * @return 
	 * <pre>
	 * 성공: ServiceResult.OK
	 * 실패: ServiceResult.FAILED
	 * 해당 권한을 사용중: ServiceResult.INUSE
	 * 해당 권한의 하위가 존재: ServiceResult.EXIST_PARENT_ROLE
	 * </pre>
	 * @throws DataAccessException
	 * @throws CustomException
	 */
	public ServiceResult removeAuthority(AuthorityVO authorityVO) throws DataAccessException, CustomException;
	
	/**
	 * 일반 구성원들의 권한 별 구성원 수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> retrieveDescriptionListForMember();
	
	/**
	 * 프로젝트 역할 별 구성원 수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> retrieveRoleNameListForProject();

}


