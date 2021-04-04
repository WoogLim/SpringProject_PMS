package kr.or.ddit.security.auth.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mchange.v1.cachedstore.Autoflushing;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.security.auth.ReloadableFilterInvocationSecurityMetadataSource;
import kr.or.ddit.security.auth.dao.IAuthorityDAO;
import kr.or.ddit.security.auth.dao.IResourceDAO;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.security.vo.ResourceVO;

@Service
public class SecurityServiceImpl extends BaseService implements ISecurityService {
	
	@Inject
	private ReloadableFilterInvocationSecurityMetadataSource filterInvocationSecurityMetadataSource;

	@Override
	public List<AuthorityVO> retrieveAllAuthorities() {
		return authDAO.selectAllAuthorities();
	}

	@Override
	public List<ResourceVO> retrieveAllResources() {
		return resDAO.selectAllResources();
	}

	@Override
	public List<ResourceVO> retrieveResourceListForAuthority(AuthorityVO authority) {
		return resDAO.selectResourceListForAuthority(authority);
	}

	@Transactional
	@Override
	public ServiceResult updateResourceRole(AuthorityVO authority) {
		int cnt = resDAO.deleteResourceRole(authority);
		String[] resources = authority.getResourceId();
		
		if (resources != null && resources.length > 0) {
			cnt += resDAO.insertResourceRole(authority);
		}
		ServiceResult result = ServiceResult.FAILED;
		if (cnt > 0) {
			result = ServiceResult.OK;
			filterInvocationSecurityMetadataSource.reload(); // 역할별 접근제어 설정이 변경되면, 설정 데이터 캐싱 메타데이터를 리로딩해야 함.
		}
		return result;
	}

	@Override
	public List<AuthorityVO> retrieveTeamAuthorityList() {
		return authDAO.selectTeamAuthorityList();
	}

	@Override
	public AuthorityVO retrieveAuthority(AuthorityVO authorityVO) {
		return authDAO.selectAuthority(authorityVO);
	}

	@Transactional
	@Override
	public ServiceResult removeAuthority(AuthorityVO authorityVO) throws DataAccessException, CustomException {
		ServiceResult ret = ServiceResult.OK;
		
		if(authDAO.isInUseAuthority(authorityVO) == 0) {
			if(authDAO.isExistParentRoleAuthority(authorityVO) == 0) {
				if(resDAO.isExistAssignedResource(authorityVO) == 0) {
					int sqlResult = authDAO.deleteRoleHierarchyAuthority(authorityVO);
					if (sqlResult > 0) {
						sqlResult += authDAO.deleteAuthority(authorityVO);
						if(sqlResult < 2) throw new CustomException();
					} else {
						throw new CustomException();
					}
				} else {
					ret = ServiceResult.EXIST_ASSIGNED_RESOURCE;
				}
			} else {
				ret = ServiceResult.EXIST_PARENT_ROLE;
			}
		} else {
			ret = ServiceResult.INUSE;
		}
		return ret;
	}

	@Override
	public List<AuthorityVO> retrieveDescriptionListForMember() {
		return authDAO.selectDescriptionListForMember();
	}

	@Override
	public List<AuthorityVO> retrieveRoleNameListForProject() {
		return authDAO.selectRoleNameListForProject();
	}

}








