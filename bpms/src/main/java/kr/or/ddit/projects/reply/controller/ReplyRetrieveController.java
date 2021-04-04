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
package kr.or.ddit.projects.reply.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.reply.vo.ReplyVO;
import kr.or.ddit.vo.PagingVO;

@Controller
public class ReplyRetrieveController extends BaseController {
	@Inject
	private WebApplicationContext container;

	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@RequestMapping(value = "/reply/replyList.do", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ReplyVO> list(@RequestParam(value = "boardNo", required = true) int boardNo,
			@RequestParam(value = "page", required = true, defaultValue = "1") int currentPage,
			HttpServletRequest resp) throws ServletException, IOException {

		ReplyVO searchDetail = new ReplyVO();
		searchDetail.setBoardNo(boardNo);

		PagingVO<ReplyVO> pagingVO = new PagingVO<>(5, 5);
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = replyService.retrieveReplyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<ReplyVO> replyList = replyService.retrieveReplyList(pagingVO);
		pagingVO.setDataList(replyList);
		return pagingVO;

	}

}
