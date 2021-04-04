package kr.or.ddit.projects.file.service.impl;

import org.springframework.stereotype.Service;

import kr.or.ddit.exception.CustomTransactionException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.file.service.FileService;
import kr.or.ddit.projects.file.vo.AttatchVO;

@Service
public class FileServiceImpl extends BaseService implements FileService {

	@Override
	public AttatchVO download(int att_no) {
		AttatchVO attatch = fileDAO.selectAttatch(att_no);
		if (attatch == null)
			throw new CustomTransactionException(att_no + "파일없음");

		return attatch;
	}

}
