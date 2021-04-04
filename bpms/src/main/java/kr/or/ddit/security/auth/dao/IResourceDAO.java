package kr.or.ddit.security.auth.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.security.vo.ResourceVO;

@Repository
public interface IResourceDAO {
	/**
	 * 전체 자원(메뉴) 조회
	 * @return
	 */
	public List<ResourceVO> selectAllResources();
	
	/**
	 * FilterInvocationMetadataSource 에 의해 사용될 자원에 대한 접근제어 설정 조회
	 * @return
	 */
	public List<ResourceVO> selectAllSortedResources();
	
	/**
	 * 역할별 접근 가능한 자원의 목록 조회
	 * @param authority
	 * @return
	 */
	public List<ResourceVO> selectResourceListForAuthority(AuthorityVO authority);
	
	/**
	 * 역할별 접근 가능한 자원을 갱신하기 전 기존 설정 제거
	 * @param authority
	 * @return
	 */
	public int deleteResourceRole(AuthorityVO authority);
	
	/**
	 * 역할별 접근 가능한 자원을 갱신
	 * @param authority
	 * @return
	 */
	public int insertResourceRole(AuthorityVO authority);
	
	/**
	 * 파라미터로 받은 authorityVO의 authority와 일치하는 권한으로 할당된 
	 * 보호자원(secured Resource)이 있는지 조회
	 * @param authorityVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우(보호자원 존재): return &gt; 0
	 * 검색결과가 없는경우(보호자원 없음): 0
	 * </pre>
	 */
	public int isExistAssignedResource(AuthorityVO authorityVO);
	
	
	
}
