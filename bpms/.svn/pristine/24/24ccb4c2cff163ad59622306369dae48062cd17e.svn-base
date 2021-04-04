package kr.or.ddit.projects.board.controller.projectnotice;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SortVO;

/**
 * @author 김근호
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 *      [[개정이력(Modification Information)]] 수정일 수정자 수정내용 -------- --------
 *      ---------------------- 2021. 1. 28. 김근호 최초작성 Copyright (c) 2021 by DDIT
 *      All right reserved
 */
@Controller
@RequestMapping("/proNotice")
public class ProNoticeRetrieveController extends BaseController {
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@RequestMapping("proNoticeList.do")
	public String noticeList(
		@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage
		, @ModelAttribute("pagingVO") PagingVO<BoardVO> pagingVO
		, @ModelAttribute("searchVO") SearchVO searchVO
		, @ModelAttribute("sortVO") SortVO sortVO
		, Model model
	){
		int code = 1;
		pagingVO.setCode(code);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSortVO(sortVO);

		pagingVO.setTotalRecord(boardService.retrieveBoardCount(pagingVO));
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDataList(boardService.retrieveBoardList(pagingVO));

		paginationInfo = new CustomPaginationInfo<>(pagingVO);

		model.addAttribute("paginationInfo", paginationInfo);

		return "board/projectnotice/projectNoticeList";
	}

	@RequestMapping(value = "proNoticeList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String noticeListForAjax(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@ModelAttribute("pagingVO") PagingVO<BoardVO> pagingVO, @ModelAttribute("searchVO") SearchVO searchVO,
			@ModelAttribute("sortVO") SortVO sortVO, Model model) {
		noticeList(currentPage, pagingVO, searchVO, sortVO, model);
		return "jsonView";
	}

	@RequestMapping("proNoticeView.do")
	public String noticeView(@RequestParam(value = "boardNo", required = true) int boardNo, Model model) {
		BoardVO pronotice = new BoardVO();
		pronotice.setBoardNo(boardNo);

		pronotice = (BoardVO) boardService.retrieveBoard(pronotice);
		model.addAttribute("pronotice", pronotice);
		return "board/projectnotice/projectNoticeView";
	}

//	@RequestMapping("proNoticeView.do")
//	public String noticeView(
//			@ModelAttribute(name="pronotice") BoardVO pronotice, 
//			Model model) {
//		pronotice = boardService.retrieveBoard(pronotice);
//		model.addAttribute("pronotice", pronotice);
//		
//		return "board/projectnotice/projectNoticeView";
//	}

}
