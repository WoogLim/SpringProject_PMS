package kr.or.ddit.projects.file.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.file.vo.AttatchVO;

@Repository
public interface FileDAO {
	public int insertAttaches(BoardVO boardVO);

	public int deleteAttatches(BoardVO boardVO);

	public AttatchVO selectAttatch(int attNo);
}
