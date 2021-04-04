package kr.or.ddit.projects.issue.service.impl;

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
import kr.or.ddit.projects.issue.service.IssueService;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.service.impl.WorkServiceImpl;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class IssueServiceImpl extends BaseService implements IssueService {

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
	public ServiceResult createIssue(IssueVO issueVO) {
		ServiceResult result = ServiceResult.FAILED;
		if (issueVO != null) {
			// 연결 일감은 nullable임 default는 true
			boolean workCheck = true;
			// 만약 연결 일감의 값이 존재한다면
			if(StringUtils.isNotBlank(issueVO.getWorkId())) {
				WorkVO issueToWork = issueDAO.issueToWorkCheck(issueVO);
				if(issueToWork == null) {
					workCheck = false;
				}
			}
			if(workCheck) {
				// 이슈 게시판 코드 값.
				issueVO.setCode(2);
				if (boardDAO.insertBoard(issueVO) > 0) {
					if (issueDAO.insertIssue(issueVO) > 0) {
						// 이슈 발행 성공 시 작업 내역 기록 생성
						HistoryVO history = new HistoryVO(issueVO, HistoryVO.HISTORYINSERT);
						historyDAO.insertHistory(history);
						// 이슈 첨부 파일 저장
						processAttatches(issueVO);
						result = ServiceResult.OK;
					}
				}
			}else {
				result = ServiceResult.DISABLE;
			}
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult modifyIssue(IssueVO issueVO) {
		ServiceResult result = ServiceResult.FAILED;
		IssueVO issue = issueDAO.selectIssue(issueVO);
		if(issue != null) {
			boolean workCheck = true;
			// 만약 연결 일감의 값이 존재 한다면
			if(StringUtils.isNotBlank(issueVO.getWorkId())) {
				WorkVO issueToWork = issueDAO.issueToWorkCheck(issueVO);
				if(issueToWork == null) {
					workCheck = false;
				}
			}
			if(workCheck) {
				if (boardDAO.updateBoard(issueVO) > 0) {
					if (issueDAO.updateIssue(issueVO) > 0) {
						// 이슈 수정 성공 시 작업 내역 기록 생성
						issueVO.setCode(2);
						HistoryVO history = new HistoryVO(issueVO, HistoryVO.HISTORYUPDATE);
						historyDAO.insertHistory(history);
						// 첨부파일 수정 및 또는 새로운 첨부 파일 등록
						processAttatches(issueVO);
						processDeleteAttatch(issueVO);
						result = ServiceResult.OK;
					}
				}
			}else {
				result = ServiceResult.DISABLE;
			}
		}
		return result;
	}

	@Override
	public ServiceResult removeIssue(IssueVO issueVO) {
		ServiceResult result = ServiceResult.FAILED;
		if (issueVO != null) {
			if (issueDAO.deleteIssue(issueVO) > 0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	@Override
	public int retrieveIssueCount(PagingVO<IssueVO> issueVO) {
		return issueDAO.selectIssueListCount(issueVO);
	}

	@Override
	public List<IssueVO> retrieveIssueList(PagingVO<IssueVO> pagingVO) {
		return issueDAO.selectIssueList(pagingVO);
	}

	@Override
	public IssueVO retrieveIssue(IssueVO issue) {
		return issueDAO.selectIssue(issue);
	}

	@Override
	public List<IssueVO> retrieveByMemberToIssueList(PagingVO<IssueVO> issueVO) {
		return issueDAO.selectByMemberToIssueList(issueVO);
	}

	@Override
	public List<ProjectVO> retrieveByMemberToProjectList(MemberVO memberVO) {
		return issueDAO.selectByMemberToProjectList(memberVO);
	}

	@Override
	public List<MemberVO> retrieveByProjectToMemberList(IssueVO issueVO) {
		return issueDAO.selectByProjectToMemberList(issueVO);
	}

	@Override
	public List<IssueVO> retrieveTodayIssueList(ProjectVO projectVO) {
		return issueDAO.selectTodayIssueList(projectVO);
	}

	@Override
	public List<WorkVO> retrieveByProjectToWorkList(IssueVO issueVO) {
		return issueDAO.selectByProjectToWorkList(issueVO);
	}
}
