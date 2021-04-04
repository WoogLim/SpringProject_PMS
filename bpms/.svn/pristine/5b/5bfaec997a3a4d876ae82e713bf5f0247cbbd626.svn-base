package kr.or.ddit.projects.scm.service.impl;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.scm.service.ScmService;
import kr.or.ddit.projects.scm.vo.ScmVO;

@Service
public class ScmServiceImpl extends BaseService implements ScmService {

	@Override
	public ScmVO retrieveScm(ScmVO scmVO) {
		return scmDAO.selectScm(scmVO);
	}

	@Override
	public ServiceResult createScm(ScmVO scmVO) {
		ServiceResult result = ServiceResult.FAILED;
		if(scmDAO.insertScm(scmVO) > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult removeScm(ScmVO scmVO) {
		ServiceResult result = ServiceResult.FAILED;
		if(scmDAO.deleteScm(scmVO) > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
}
