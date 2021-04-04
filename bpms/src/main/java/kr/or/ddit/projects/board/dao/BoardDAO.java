package kr.or.ddit.projects.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface BoardDAO {

	public int insertBoard(BoardVO boardVO);

	public int updateBoard(BoardVO boardVO);

	public int deleteBoard(BoardVO boardVO);

	public int selectBoardCount(PagingVO<BoardVO> paging);

	public List<BoardVO> selectBoardList(PagingVO<BoardVO> paging);

	public BoardVO selectBoard(BoardVO boardVO);

	/**
	 * 가장 최근날짜에 생성된 서버공지 5개를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;BoardVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<BoardVO> selectBoardListForMain();
	
	/**
	 * 파라미터로 받은 projectVO의 proId와 일치하는 프로젝트에서
	 * 가장 최근에 생성된 프로젝트 공지 2개를 조회
	 * @param projectVO
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;BoardVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<BoardVO> selectLatelyBoardList(ProjectVO projectVO);

	/**
	 * @param boardVO
	 * @return
	 */
	public BoardVO selectForm(BoardVO boardVO);
}
