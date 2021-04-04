package kr.or.ddit.projects.scm.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepository;

import kr.or.ddit.projects.scm.dao.SvnDAO;
import kr.or.ddit.projects.scm.service.SvnService;
import kr.or.ddit.projects.scm.vo.ScmVO;

@Service
public class SvnServiceImpl implements SvnService{

	@Inject
	SvnDAO svnDAO;
	
	@Override
	public List<ScmVO> retrieveSvnLogList(ScmVO scmVO) throws SVNException, ParseException {
		String startDate = scmVO.getUserStartDate();
		String endDate = scmVO.getUserEndDate();
		scmVO.setLogDate(startDate, endDate);
		List<SVNLogEntry> svnLogEntryList = svnDAO.selectSvnLogList(scmVO);
		List<ScmVO> logList = new ArrayList<>();
		if(svnLogEntryList != null) {
			for (SVNLogEntry svnLogEntry : svnLogEntryList) {
				long revision = svnLogEntry.getRevision();
				String author = svnLogEntry.getAuthor();
				Date date = svnLogEntry.getDate();
				String message = svnLogEntry.getMessage();
	
				String userFilter = scmVO.getProvider();
				boolean userCheck = true;
				// 저자별 필터 값에 값이 있고 log중 일치하는 저자가 있다면.
				
				if(StringUtils.isNotBlank(userFilter) && !author.equals(userFilter)) {
					userCheck = false;
				}
				
				if(userCheck) {
					ScmVO scm = new ScmVO();
					scm.setRevision(revision);
					scm.setAuthor(author);
					scm.setDate(date);
					scm.setMessage(message);
					logList.add(scm);
				}
			}
		}
		return logList;
	}

	@Override
	public DAVRepository getConnectDAVRepository(ScmVO scmVO) throws SVNException {
		return svnDAO.getConnectDAVRepository(scmVO);
	}

	@Override
	public ISVNAuthenticationManager getSVNAuthenticationManager(ScmVO scmVO) {
		return svnDAO.getSVNAuthenticationManager(scmVO);
	}

	@Override
	public Set<String> retrieveProviderList(ScmVO scmVO) throws SVNException, ParseException {
		Set<String> providerList = new TreeSet<>();
		List<SVNLogEntry> logList = svnDAO.selectSvnLogList(scmVO);
		if(logList != null) {
			for (SVNLogEntry svnLogEntry : logList) {
				providerList.add(svnLogEntry.getAuthor());
			}
		}
		return providerList;
	}

	@Override
	public Map<String, Integer> retrieveByProviderToLogCount(ScmVO scmVO) throws SVNException, ParseException {
		String startDate = scmVO.getUserStartDate();
		String endDate = scmVO.getUserEndDate();
		scmVO.setLogDate(startDate, endDate);
		Map<String, Integer> userByCommitCount = new TreeMap<>();
		List<SVNLogEntry> logList = svnDAO.selectSvnLogList(scmVO);
		if(logList != null) {
			for (SVNLogEntry svnLogEntry : logList) {
				String author = svnLogEntry.getAuthor();
				// 저자별 커밋
				Integer commitCnt = userByCommitCount.get(author);
				commitCnt = (commitCnt != null) ? commitCnt+1 : 1;
				userByCommitCount.put(author, commitCnt);
			}
		}
		return userByCommitCount;
	}

	@Override
	public Map<Integer, Integer> retrieveByMonthToLogCount(ScmVO scmVO) throws SVNException, ParseException {
		String startDate = scmVO.getMonthStartDate();
		String endDate = scmVO.getMonthEndDate();
		scmVO.setLogDate(startDate, endDate);
		Map<Integer, Integer> monthByCommitCount = new TreeMap<>();
		List<SVNLogEntry> logList = svnDAO.selectSvnLogList(scmVO);
		if(logList != null) {
			for (SVNLogEntry svnLogEntry : logList) {
				Date date = svnLogEntry.getDate();
				// month의 1월의 값은 0부터 시작
				int month = date.getMonth() + 1;
				Integer commitCnt = monthByCommitCount.get(month);
				commitCnt = (commitCnt != null) ? commitCnt+1 : 1;
				monthByCommitCount.put(month, commitCnt);
			}
		}
		return monthByCommitCount;
	}
}
