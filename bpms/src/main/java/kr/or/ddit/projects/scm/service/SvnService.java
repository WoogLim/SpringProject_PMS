package kr.or.ddit.projects.scm.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepository;

import kr.or.ddit.projects.scm.vo.ScmVO;

public interface SvnService {
	
	/**
	 * 전수빈
	 * 작업 내용 : 커밋 기록 목록 조회
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : selectSvnLogList
	 * @param scmVO
	 * @return : 
	 * @throws ParseException 
	 * @throws SVNException 
	 */
	public List<ScmVO>retrieveSvnLogList(ScmVO scmVO) throws SVNException, ParseException;
	
	/**
	 * 전수빈
	 * 작업 내용 : svn에 연동하기 위한 메서드
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : getConnectDAVRepository
	 * @param scmVO
	 * @return : 사용자가 로그인 한 정보의 svn의 repository 정보를 DAVRepository 객체 반환
	 * @throws SVNException 
	 */
	public DAVRepository getConnectDAVRepository(ScmVO scmVO) throws SVNException;
	
	/**
	 * 전수빈
	 * 작업 내용 : svn에 대한 log정보를 가져오기 위한 인증 메서드
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : getSVNAuthenticationManager
	 * @param scmVO
	 * @return : 사용자가 로그인한 정보의 인증을 ISVNAuthenticationManager 객체 반환
	 */
	public ISVNAuthenticationManager getSVNAuthenticationManager(ScmVO scmVO);
	
	/**
	 * 전수빈
	 * 작업 내용 : 사용자가 속해 있는 커밋 로그 내역 조회
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : retrieveProviderList
	 * @param scmVO
	 * @return : 
	 * @throws ParseException 
	 * @throws SVNException 
	 */
	public Set<String> retrieveProviderList(ScmVO scmVO) throws SVNException, ParseException;
	
	/**
	 * 전수빈
	 * 작업 내용 : 사용자별 커밋 기록 수를 가져오기 위한 메서드
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : retrieveByProviderToLogCount
	 * @param scmVO
	 * @return : 
	 * @throws ParseException 
	 * @throws SVNException 
	 */
	public Map<String, Integer> retrieveByProviderToLogCount(ScmVO scmVO) throws SVNException, ParseException;
	
	/**
	 * 전수빈
	 * 작업 내용 : 월별 커밋 기록 수를 가져오기 위한 메서드
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : retrieveByMonthToLogCount
	 * @param scmVO
	 * @return : 
	 * @throws ParseException 
	 * @throws SVNException 
	 */
	public Map<Integer, Integer> retrieveByMonthToLogCount(ScmVO scmVO) throws SVNException, ParseException;
}
