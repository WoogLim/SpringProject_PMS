package kr.or.ddit.projects.reply.service.impl;

/**
 * @author 이선엽
 * @since 2021. 2. 6.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자                       수정내용
 * ---------------------------------------------
 * 2021. 2. 6.      이선엽                      최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.reply.service.ReplyService;
import kr.or.ddit.projects.reply.vo.ReplyVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class ReplyServiceImpl extends BaseService implements ReplyService {

	@Override
	public int retrieveReplyCount(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyCount(pagingVO);
	}

	@Override
	public List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyList(pagingVO);
	}

	@Override
	public ServiceResult createReply(ReplyVO replyVO) {
		int cnt = replyDAO.insertReply(replyVO);
		ServiceResult result = ServiceResult.FAILED;
		if(cnt > 0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult removeReply(ReplyVO reply) {
		int rowcnt = replyDAO.deleteReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(rowcnt>0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult modifyReply(ReplyVO reply) {
		int rowcnt = replyDAO.updateReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(rowcnt>0) result = ServiceResult.OK;
		return result;
	}

}
