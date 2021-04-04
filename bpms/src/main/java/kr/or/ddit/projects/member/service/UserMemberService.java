package kr.or.ddit.projects.member.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;

public interface UserMemberService {
	
	/**
	 * 사용자가 속한 프로젝트 리스트 정보를 초회
	 * @param mem_id
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveMemberProjectList(MemberVO memberVO);

	
	/**
	 * 사용자가 속한 프로젝트의 공지사항 리스트를 조회
	 * @param mem_id
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<ProjectVO> retrieveProjectNoticeList(MemberVO memberVO);

	/**
	 * 사용자의 패스워드 변경
	 * @param memberVO
	 * @return
	 */
	public ServiceResult memberModifyPassword(MemberVO memberVO);
	
	/**
	 * 사용자의 정보 조회
	 * @param memberVO
	 * @return
	 */
	public MemberVO retrieveMember(MemberVO memberVO);
	
	/**
	 * 사용자의 일감 리스트 조회
	 * @param memberVO
	 * @return
	 */
	public List<WorkVO> retrieveWorkListByMember(MemberVO memberVO);
	
	/**
	 * 사용자의 이슈 리스트 조회
	 * @param memberVO
	 * @return
	 */
	public List<IssueVO> retrieveIssueListByMember(MemberVO memberVO);

	/**
	 * 사용자의 프로필 이미지 변경
	 * @param memberVO
	 * @return
	 */
	public ServiceResult memberImgUpdate(MemberVO member, MultipartFile memImg);

}
