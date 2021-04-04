package kr.or.ddit.projects.scm.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.BasicAuthenticationManager;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepository;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepositoryFactory;

import kr.or.ddit.projects.scm.dao.SvnDAO;
import kr.or.ddit.projects.scm.vo.ScmVO;

/**
 * @author 전수빈
 * @since 2021. 3. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 3.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Repository
public class SvnDAOImpl implements SvnDAO{
	
	// svn log start revision default 
	private static final long STARTREVISION = 0;
	// svn log end revision default
	private static final long ENDREVISION = -1;
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	// 테스트를 위한 기본 정보
	private void settingTestUserInfo(ScmVO scmVO){
		String scmUrl = "http://112.220.114.130:10001/svn/projects/202007F/team1/source";
		String scmId = "202007_JSB";
		String scmPass = "java";

		scmVO.setScmId(scmId);
		scmVO.setScmPass(scmPass);
		scmVO.setScmUrl(scmUrl);
	}
	
	@Override
	public List<SVNLogEntry>selectSvnLogList(ScmVO scmVO) throws SVNException, ParseException {
		// 지울 예정
		settingTestUserInfo(scmVO);
		////////////////////////////////////
		DAVRepository svnRepo = getConnectDAVRepository(scmVO);
		svnRepo.setAuthenticationManager(getSVNAuthenticationManager(scmVO));
		
		long startRevision = STARTREVISION;
		long endRevision = ENDREVISION;
		
		Date startDate = scmVO.getStartRevisionDate();
		Date endDate = scmVO.getEndRevisionDate();
		// 날짜 조건
		if(startDate != null) {
			startRevision = svnRepo.getDatedRevision(startDate);
		}
		if(endDate != null) {
			endRevision = svnRepo.getDatedRevision(endDate);
		}
		
		Collection<SVNLogEntry> logEntries = null;
		List<SVNLogEntry> logList = null;
		// 없는 기록이면 null이 아니라 svnException 발생
		try {
			logEntries = svnRepo.log(new String[] { "" }, null, startRevision, endRevision, true, true);
			logList = new ArrayList<>(logEntries);
		}catch(SVNException e) {
			
		}
		return logList;
	}

	@Override
	public DAVRepository getConnectDAVRepository(ScmVO scmVO) throws SVNException {
		// 지울 예정
		settingTestUserInfo(scmVO);
		////////////////////////////////////
		return (DAVRepository) DAVRepositoryFactory.create(SVNURL.parseURIEncoded(scmVO.getScmUrl()));
	}

	@Override
	public ISVNAuthenticationManager getSVNAuthenticationManager(ScmVO scmVO) {
		// 지울 예정
		settingTestUserInfo(scmVO);
		////////////////////////////////////
		return new BasicAuthenticationManager(scmVO.getScmId(), scmVO.getScmPass());
	}
}
