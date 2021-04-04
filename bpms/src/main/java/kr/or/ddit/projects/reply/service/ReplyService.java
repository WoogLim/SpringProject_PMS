package kr.or.ddit.projects.reply.service;

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

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.reply.vo.ReplyVO;
import kr.or.ddit.vo.PagingVO;

public interface ReplyService {

	int retrieveReplyCount(PagingVO<ReplyVO> pagingVO);

	List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO);

	ServiceResult createReply(ReplyVO replyVO);

	ServiceResult removeReply(ReplyVO reply);

	ServiceResult modifyReply(ReplyVO reply);

}
