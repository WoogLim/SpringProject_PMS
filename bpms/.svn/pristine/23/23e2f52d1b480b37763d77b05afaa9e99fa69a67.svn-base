package kr.or.ddit.projects.board.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;

public interface BoardService {

	public ServiceResult createBoard(BoardVO boardVO);
	public ServiceResult modifyBoard(BoardVO boardVO);
	public ServiceResult removeBoard(BoardVO boardVO);
	
	public int retrieveBoardCount(PagingVO<BoardVO> paging);
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging);
	public BoardVO retrieveBoard(BoardVO boardVO);
	
	/**
	 * 가장 최근날짜에 생성된 서버공지 5개를 조회
	 * @return
	 * <pre>
	 * 검색결과가 있는경우: List&lt;BoardVO&gt;
	 * 검색결과가 없는경우: null
	 * </pre>
	 */
	public List<BoardVO> retrieveBoardListForMain();
	
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
	public List<BoardVO> retrieveLatelyBoardList(ProjectVO projectVO);
	/**
	 * @param boardVO
	 * @return
	 */
	public BoardVO retrieveForm(BoardVO boardVO);
}
