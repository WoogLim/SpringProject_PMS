package kr.or.ddit.security.auth.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.compress.archivers.dump.DumpArchiveException;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.ddit.security.vo.AuthorityVO;

@Repository
public interface IAuthorityDAO {
	/**
	 * 모든 역할 정보 조회
	 * 
	 * @return
	 */
	public List<AuthorityVO> selectAllAuthorities();

	/**
	 * 역할 계층 구조 조회
	 * 
	 * @return
	 */
	public List<String> roleHierarchy();
	
	/**
	 * 프로젝트 내부에서 사용되는 역할만 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> selectTeamAuthorityList();
	
	/**
	 * 파라미터로 받은 authorityVO의 authority과 동일한 권한의 정보조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우 : AuthorityVO
	 * 검색결과가 없는경우:  null
	 * </pre>
	 */
	public AuthorityVO selectAuthority(AuthorityVO authorityVO);
	
	/**
	 * 파라미터로 받은 authorityVO의 authority와 동일한 권한을 삭제 
	 * @param authority
	 * @return
	 * <pre>
	 * 성공: delete된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 */
	public int deleteAuthority(AuthorityVO authorityVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 authorityVO의 authority와 동일한 권한을 계층구조에서 삭제
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 성공: delete된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 */
	public int deleteRoleHierarchyAuthority(AuthorityVO authorityVO);
	
	/**
	 * 파라미터로 받은 authorityVO의 authority에 해당하는 권한을 사용중인 구성원이 있는지 확인
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우(사용중): return &ge; 1
	 * 검색결과가 없는경우(사용하지 않음): 0
	 * </pre>
	 */
	public int isInUseAuthority(AuthorityVO authorityVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 authorityVO의 authority보다 하위 권한을 모두 조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 * @throws DataAccessException
	 */
	public List<AuthorityVO> selectParentRoleAuthority(AuthorityVO authorityVO) throws DataAccessException;

	/**
	 * 파라미터로 받은 authorityVO의 authority보다 상위 권한을 모두 조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 * @throws DataAccessException
	 */
	public List<AuthorityVO> selectChildRoleAuthority(AuthorityVO authorityVO) throws DataAccessException;
	
	/**
	 * <pre>
	 * 파라미터로 받은 authorityMap을 이용하여 권한 계층구조 등록
	 * key: parentRole(하위권한), childRole(상위권한)
	 * value: key에 해당하는 권한명
	 * </pre>
	 * @param authorityMap
	 * @return
	 * <pre>
	 * 성공: insert된 row 수 (return &gt; 0)
	 * 실패: 0
	 * </pre>
	 * @throws DataAccessException
	 */
	public int insertRoleHierarchy(Map<String, String> authorityMap) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 authorityVO의 authority보다 하위권한을 가진 Role이 존재하는지 조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우(하위가 있는경우): return &gt; 0
	 * 검색결과가 없는경우(하위가 없는경우): 0
	 * </pre>
	 * @throws DataAccessException
	 */
	public int isExistParentRoleAuthority(AuthorityVO authorityVO) throws DataAccessException;
	
	/**
	 * 일반 구성원들의 권한 별 구성원 수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> selectDescriptionListForMember();
	
	/**
	 * 프로젝트 역할 별 구성원 수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;AuthorityVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<AuthorityVO> selectRoleNameListForProject();
}








