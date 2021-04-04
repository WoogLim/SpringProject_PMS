package kr.or.ddit.projects.work.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.file.vo.AttatchVO;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.service.WorkService;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 신광진
 * @since 2021. 2. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자         수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 4.    신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Service
public class WorkServiceImpl extends BaseService implements WorkService {

	private static final Logger LOGGER = LoggerFactory.getLogger(WorkServiceImpl.class);

	@Value("#{appInfo.boardFolder}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}

	private int processAttatches(BoardVO boardVO) {
		List<AttatchVO> attatchList = boardVO.getAttatchList();
		int cnt = 0;
		if (attatchList != null && !attatchList.isEmpty()) {
			cnt += fileDAO.insertAttaches(boardVO);
			try {
				for (AttatchVO attatch : attatchList) {
					attatch.saveTo(saveFolder);
				}
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return cnt;
	}

	private int processDeleteAttatch(BoardVO boardVO) {
		int cnt = 0;
		int[] delAttNos = boardVO.getDelAttNos();
		if (delAttNos != null && delAttNos.length > 0) {
			String[] saveNames = new String[delAttNos.length];
			for (int i = 0; i < delAttNos.length; i++) {
				saveNames[i] = fileDAO.selectAttatch(delAttNos[i]).getAttSavename();
			}
			cnt = fileDAO.deleteAttatches(boardVO);
			if (cnt == saveNames.length) {
				for (String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}
		return cnt;
	}

	@Transactional
	@Override
	public ServiceResult createWork(WorkVO workVO) {
		ServiceResult result = ServiceResult.FAILED;
		if (workVO != null) {
			// 상위 일감은 nullable임 default는 true
			boolean parentCheck = true;
			// 만약 상위 일감의 값이 존재 한다면
			if (StringUtils.isNotBlank(workVO.getWorkParent())) {
				WorkVO parentWork = workDAO.parenthWorkCheck(workVO);
				if (parentWork == null) {
					parentCheck = false;
				}
			}
			if (parentCheck) {
				// 일감 게시판 코드 값.
				workVO.setCode(3);
				if (boardDAO.insertBoard(workVO) > 0) {
					if (workDAO.insertWork(workVO) > 0) {
						// 일감 생성 성공 시 작업 내역 기록 생성
						HistoryVO history = new HistoryVO(workVO, HistoryVO.HISTORYINSERT);
						historyDAO.insertHistory(history);
						// 첨부 파일 저장
						processAttatches(workVO);
						result = ServiceResult.OK;
					}
				}
			} else {
				result = ServiceResult.DISABLE;
			}
		}
		return result;
	}

	@Override
	public ServiceResult modifyWork(WorkVO workVO) {
		ServiceResult result = ServiceResult.FAILED;
		WorkVO work = workDAO.selectWork(workVO);
		if (work != null) {
			// 상위 일감은 nullable임 default는 true
			boolean parentCheck = true;
			// 만약 상위 일감의 값이 존재 한다면
			if (StringUtils.isNotBlank(workVO.getWorkParent())) {
				WorkVO parentWork = workDAO.parenthWorkCheck(workVO);
				if (parentWork == null) {
					parentCheck = false;
				}
			}
			// 상위 일감 체크에 성공 했다면
			if(parentCheck) {
				if (boardDAO.updateBoard(workVO) > 0) {
					if (workDAO.updateWork(workVO) > 0) {
						// 일감 수정 성공 시 작업 내역 기록 생성
						workVO.setCode(3);
						HistoryVO history = new HistoryVO(workVO, HistoryVO.HISTORYUPDATE);
						historyDAO.insertHistory(history);
						// 첨부파일 수정 및 또는 새로운 첨부 파일 등록
						processAttatches(workVO);
						processDeleteAttatch(workVO);
						result = ServiceResult.OK;
					}
				}
			}else {
				result = ServiceResult.DISABLE;
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public ServiceResult removeWork(WorkVO workVO) {
		ServiceResult result = ServiceResult.FAILED;
		WorkVO work = workDAO.selectWork(workVO);
		if (work != null) {
			if (workDAO.deleteWork(work) > 0) {
				result = ServiceResult.OK;
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public int retrieveWorkCount(PagingVO<WorkVO> pagingVO) {
		return workDAO.selectWorkListCount(pagingVO);
	}

	@Override
	public WorkVO retrieveWork(WorkVO workVO) {
		return workDAO.selectWork(workVO);
	}

	@Override
	public List<WorkVO> retrieveWorkList(PagingVO<WorkVO> pagingVO) {
		return workDAO.selectWorkList(pagingVO);
	}

	@Override
	public List<WorkVO> retrieveByMemberToWorkList(PagingVO<WorkVO> pagingVO) {
		return workDAO.selectByMemberToWorkList(pagingVO);
	}

	@Override
	public List<ProjectVO> retrieveByMemberToProjectList(MemberVO memberVO) {
		return workDAO.selectByMemberToProjectList(memberVO);
	}

	@Override
	public List<MemberVO> retrieveByProjectToMemberList(WorkVO workVO) {
		return workDAO.selectByProjectToMemberList(workVO);
	}

	@Override
	public WorkVO parenthWorkCheck(WorkVO workVO) {
		return workDAO.parenthWorkCheck(workVO);
	}

	@Override
	public List<WorkVO> retrieveCompleteWorkListInMonth(ProjectVO projectVO) {
		return workDAO.selectCompleteWorkListInMonth(projectVO);
	}

	@Override
	public List<WorkVO> retrieveByProjectToWorkList(WorkVO workVO) {
		return workDAO.selectByProjectToWorkList(workVO);
	}
}
