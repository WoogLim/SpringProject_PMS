package kr.or.ddit.projects.project.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 1. 26.     신광진           최초작성
 * 2021. 1. 28      신광진     retrieveRequestProjectList 추가
 * 
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
public interface AdminProjectService {

	/**
	 * 새로운 프로젝트 생성
	 * @param projectVO
	 */
	public void createProject(ProjectVO projectVO) throws DataAccessException;
	
	/**
	 * 프로젝트 요청 최초승인
	 * @param projectVO
	 * @param pushMsgVO TODO
	 * @throws DataAccessException TODO
	 * @throws CustomException TODO
	 */
	public void acceptProject(ProjectVO projectVO, PushMessageVO pushMsgVO) throws DataAccessException, CustomException;
	
	/**
	 * 기존 프로젝트 정보 수정
	 * @param projectVO
	 * @throws DataAccessException
	 * @throws CustomException
	 */
	public void updateProject(ProjectVO projectVO) throws DataAccessException, CustomException;
	
	/**
	 * 기존 프로젝트 삭제
	 * @param projectVO
	 * @return 
	 * <pre>
	 * 성공: OK
	 * 실패: FAILED
	 * 존재하지 않음: NOTEXIST
	 * </pre> 
	 */
	public ServiceResult deleteProject(ProjectVO projectVO);
	
	/**
	 * 등록되어 있는 프로젝트 수 조회 <br>
	 * 파라미터로 받은 pagingVO에 검색조건이 포함된 경우 검색조건과 일치하는
	 * 프로젝트의 수 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: return&gt;0
	 * 검색결과가 없는경우: 0
	 * </pre>
	 */
	public int retrieveProjectCount(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 모든 프로젝트 조회
	 * 파라미터로 받은 pagingVO에 검색조건이 포함된 경우 검색조건과 일치하는
	 * 프로젝트를 모두 조회
	 * @param pagingVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우:null
	 * </pre>
	 */
	public List<ProjectVO> retrieveProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 등록된 모든 프로젝트를 조회
	 * 대기상태의 프로젝트는 조회하지 않음
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우:null
	 * </pre>
	 */
	public List<ProjectVO> retrieveNoPagingProjectList();
	
	/**
	 * 파라미터로 받은 ProjectVO의 pro_id와 일치하는 프로젝트 조회
	 * @param projectVO
	 * @return 
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우:null
	 * </pre>
	 */
	public ProjectVO retrieveProject(ProjectVO projectVO);
	
	/**
	 * 승인대기 상태의 모든 프로젝트를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우:null
	 * </pre>
	 */
	public List<ProjectVO> retrieveRequestProjectList();
	
	/**
	 * 현재 등록되어 있는 프로젝트를 계층구조로 조회
	 * @param pagingVO TODO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveHierarchyProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 메인화면에 display하기위해 최근 등록된 프로젝트 5개 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveProjectListForMain();
	
	/**
	 * 파라미터로 받은 memberVO의 memId와 일치하는 회원이 소속된 프로젝트를 모두 조회
	 * @param memberVO
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveProjectListByMember(MemberVO memberVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 소속된 구성원을 모두 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProMemberVO&lt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProMemberVO> retrieveProjectMemberList(ProjectVO projectVO);
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에 소속된 구성원들의
	 * 역할 이름을 모두 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProMemberVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProMemberVO> retrieveProjectMemberRoleNameList(ProjectVO projectVO);

	/**
	 * 등록된 모든 프로젝트의 상태별 개수를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProMemberVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveProjectListByState();
	
}



















