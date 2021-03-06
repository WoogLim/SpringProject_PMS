package kr.or.ddit.projects.board.controller.workreport;

/**
 * @author 이선엽
 * @since 2021. 2. 7.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * ------------------------------------------
 * 2021. 2.7.       이선엽               최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.validate.groups.DeleteGroup;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;

@Controller
public class WorkReportController extends BaseController {
	// Retrieve
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@RequestMapping(value = "/workReport/workReportList.do", method = RequestMethod.GET)
	public String getWorkReportList(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@ModelAttribute("searchVO") SearchVO searchVO, @ModelAttribute("pagingVO") PagingVO<BoardVO> pagingVO,
			Model model) {
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCode(12);
		int totalRecord = boardService.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<BoardVO> boardList = boardService.retrieveBoardList(pagingVO);
		pagingVO.setDataList(boardList);

		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "workreport/workReportList";
	}

	@RequestMapping(value = "/workReport/workReportList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method = RequestMethod.GET)
	public String getWorkReportListByAjax(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@ModelAttribute("searchVO") SearchVO searchVO, PagingVO<BoardVO> pagingVO, Model model) {
		getWorkReportList(currentPage, searchVO, pagingVO, model);
		return "jsonView";
	}

	@RequestMapping(value = "/workReport/workReportView.do", method = RequestMethod.GET)
	public String getWorkReport(
			@RequestParam(value = "boardNo", required = true) int boardNo 
			,BoardVO boardVO
			,Model model) {
		boardVO = boardService.retrieveBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		return "workreport/workReportView";
	}
	// =====================================================================================

	// Insert
	@RequestMapping(value = "/workReport/workReportInsert.do", method = RequestMethod.GET)
	public String insertForm(BoardVO boardVO, Model model) {
		boardVO = boardService.retrieveForm(boardVO);
		model.addAttribute("form", boardVO);
		return "workreport/workReportForm";
	}

	@RequestMapping(value = "/workReport/workReportInsert.do", method = RequestMethod.POST)
	public String doInsert(
			@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
			, @RequestParam("proId") String proId
			, @Validated(InsertGroup.class) @ModelAttribute("boardVO") BoardVO boardVO
			, BindingResult errors
			, Model model
			, RedirectAttributes redirectAttr
	){
		String goPage = null;
		if (!errors.hasErrors()) {
			ServiceResult result = boardService.createBoard(boardVO);
			switch (result) {
			case OK:
				goPage = "redirect:/workReport/workReportView.do?boardNo=" + boardVO.getBoardNo();
				logger.info("insertView : ------------{}", boardVO.getBoardNo());
				redirectAttr.addAttribute("proId", proId);
				break;

			default:
				model.addAttribute("message", NotyMessageVO.builder("서버 오류가 발생했습니다.").build());
				goPage = "workReport/workReportList";
				break;
			}
		} else {
			goPage = "workReport/workReportList";
		}
		return goPage;
	}

	// =====================================================================================
	// Delete
	@RequestMapping(value = "/workReport/workReportDelete.do", method = RequestMethod.POST)
	public String doDelete(
		@Validated(DeleteGroup.class) BoardVO boardVO
		, @RequestParam("proId") String proId
		, Errors errors
		, RedirectAttributes redirectAttributes
	){
		String goPage = "redirect:/workReport/workReportView/" + boardVO.getBoardNo();
		NotyMessageVO message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = boardService.removeBoard(boardVO);
			switch (result) {
			case FAILED:
				message = NotyMessageVO.builder("서버 오류").build();
				break;
			default:
				goPage = "redirect:/workReport/workReportList.do";
				redirectAttributes.addAttribute("proId", proId);
				break;
			}
		} else {
			message = NotyMessageVO.builder("누락된 내용이 있는지 확인해주세요.").build();
		}
		if (message != null)
			redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}

	// =====================================================================================
	// Update
	@RequestMapping(value = "/workReport/workReportUpdate.do", method = RequestMethod.GET)
	public String updateForm(@RequestParam("boardNo") int boardNo, BoardVO boardVO, Model model) {

		boardVO = (BoardVO) boardService.retrieveBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		return "workreport/workReportForm";
	}

	@RequestMapping(value = "/workReport/workReportUpdate.do", method = RequestMethod.POST)
	public String doUpdate(
		@RequestParam("proId") String proId
		, @Validated(UpdateGroup.class) BoardVO boardVO
		, BindingResult errors
		, RedirectAttributes redirectAttributes
		, Model model
	) {
		String goPage = null;
		if (!errors.hasErrors()) {
			ServiceResult result = boardService.modifyBoard(boardVO);
			switch (result) {
			case OK:
				goPage = "redirect:/workReport/workReportView.do?boardNo=" + boardVO.getBoardNo();
				redirectAttributes.addAttribute("proId", proId);
				break;
			default:
				model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				goPage = "workReport/workReportForm";
				break;
			}
		} else {
			goPage = "workReport/workReportForm";
		}
		return goPage;
	}

}