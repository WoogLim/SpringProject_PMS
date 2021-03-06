package kr.or.ddit.projects.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;

@Repository
public interface UserMemberDAO {

	/**
	 * 사용자가 속한 프로젝트 리스트 정보를 초회
	 * 
	 * @param mem_id
	 * @return
	 * 
	 *         <pre>
	 * 검색결과가 있는경우: List&lt;ProjectVO&gt;
	 * 검색결과가 없는경우: null
	 *         </pre>
	 */
	public List<ProjectVO> retrieveMemberProjectList(MemberVO memberVO);

	public List<ProjectVO> retrieveProjectNoticeList(MemberVO memberVO);
	
	public int updateMemberPass(MemberVO memberVO);

	public MemberVO selectMember(MemberVO memberVO);

	public List<WorkVO> selectWorkListByMember(MemberVO memberVO);

	public List<IssueVO> selectIssueListByMember(MemberVO memberVO);

	public int updateMemberImg(MemberVO member);
}
