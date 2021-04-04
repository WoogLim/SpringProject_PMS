package kr.or.ddit.projects.scm.dao;

import java.text.ParseException;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepository;

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
public interface SvnDAO {
	/**
	 * 전수빈
	 * 작업 내용 : 로그 내역 조회
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : selectSvnLogList
	 * @param scmVO : 검색 필터 명령어 및 로그 목록을 저장하기 위한 객체
	 * @return : 회원이 로그인한 Svn 서버의 commit log 목록 조회 
	 * @throws SVNException 
	 * @throws ParseException 
	 */
	public List<SVNLogEntry>selectSvnLogList(ScmVO scmVO) throws SVNException, ParseException;
	
	/**
	 * 전수빈
	 * 작업 내용 : svn의 연동하기 위한 메서드
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : getConnectDAVRepository
	 * @param scmVO : svn에 연동하기 위한 url, userId, password를 포함하고 있는 객체 
	 * @return : 회원이 연동한 svn의 repository 정보를 반환
	 * @throws SVNException 
	 */
	public DAVRepository getConnectDAVRepository(ScmVO scmVO) throws SVNException;
	
	/**
	 * 전수빈
	 * 작업 내용 : svn의 연동한 repository에 접근하기 윈한 인증 객체
	 * 작성 날짜 : 2021. 3. 3.
	 * 메서드명 : getSVNAuthenticationManager
	 * @param scmVO
	 * @return : svn에 인증된 객체를 반환
	 */
	public ISVNAuthenticationManager getSVNAuthenticationManager(ScmVO scmVO);
}
