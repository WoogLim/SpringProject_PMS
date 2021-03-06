package kr.or.ddit.projects.board.controller.servernotice;
/**
 * @author 이선엽
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.     이선엽       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.view.ExcelDownloadViewWithJxls;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SortVO;

@Controller
public class ServerNoticeRetrieveController extends BaseController {
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@RequestMapping(value="/serverNotice/downloadExcel.do", params="jxls=true")
	public ExcelDownloadViewWithJxls excelJXLS(
			@RequestParam(value = "page", required = true, defaultValue = "1") int currentPage
			,@ModelAttribute("pagingVO") PagingVO<BoardVO> paging
			,@ModelAttribute("searchVO")  SearchVO searchVO
			, Model model
			,@ModelAttribute("sortVO")  SortVO sortVO
			,@RequestParam(value="mng", required=false, defaultValue="N") String mng 
			, @AuthenticationPrincipal(expression="realMember") MemberVO memberVO) {
		
		getServerNoticeList(currentPage, paging, searchVO, model, sortVO, mng, memberVO);
		
		CustomPaginationInfo<BoardVO> pagination = (CustomPaginationInfo<BoardVO>) model.asMap().get("paginationInfo");
		PagingVO<BoardVO> pagingVO = pagination.getPagingVO();
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "서버 공지 게시판 리스트.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/boardTemplate.xlsx");
			}
		};
	}
	
	@GetMapping("/serverNotice/serverNoticeList.do")
	public String getServerNoticeList(
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,@ModelAttribute("pagingVO") PagingVO<BoardVO> pagingVO
			,@ModelAttribute("searchVO")  SearchVO searchVO
			, Model model
			,@ModelAttribute("sortVO")  SortVO sortVO
			,@RequestParam(value="mng", required=false, defaultValue="N") String mng 
			, @AuthenticationPrincipal(expression="realMember") MemberVO memberVO) 
	{
		
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCode(6);
		int totalRecord = boardService.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<BoardVO> boardList = boardService.retrieveBoardList(pagingVO);
		pagingVO.setDataList(boardList);
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		if("Y".equals(mng)) {
			return "admin/serverNotice/serverNoticeList";
		} else {
			return "serverNotice/serverNoticeList";
		}
	}
	
	@GetMapping(value="/serverNotice/serverNoticeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getServerNoticeListByAjax(
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,@ModelAttribute("pagingVO") PagingVO<BoardVO> pagingVO
			,@ModelAttribute("searchVO")  SearchVO searchVO
			, Model model
			,@ ModelAttribute("sortVO")  SortVO sortVO
			,@RequestParam(value="mng", required=false, defaultValue="N") String mng 
			, @AuthenticationPrincipal(expression="realMember") MemberVO memberVO) {
		getServerNoticeList(currentPage, pagingVO, searchVO, model, sortVO, mng, memberVO);
		return "jsonView";
	}
	
	@RequestMapping("/serverNotice/serverNoticeView.do")
	public String getServerNotice(
		@RequestParam(value = "boardNo", required = true) int boardNo
	  , Model model
	  , BoardVO boardVO
	  , @AuthenticationPrincipal(expression="realMember") MemberVO memberVO
	  , @RequestParam(value="mng", required=false, defaultValue="N") String mng
	){
//		BoardVO boardVO = new BoardVO();
//		boardVO.setBoardNo(boardNo);
//		boardVO.setGroupCode("B");
//		boardVO.setCode(6);
		boardVO = boardService.retrieveBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		
		String goPage = "serverNotice/serverNoticeView";
		if("Y".equals(mng)) {
			goPage = "admin/serverNotice/serverNoticeView";
		}
		return goPage;
	}

}
