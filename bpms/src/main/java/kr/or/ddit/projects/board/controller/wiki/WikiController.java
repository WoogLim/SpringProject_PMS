package kr.or.ddit.projects.board.controller.wiki;

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
import org.springframework.web.bind.annotation.ModelAttribute;
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
public class WikiController extends BaseController{
	//Retrieve
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@RequestMapping(value="/wiki/wikiList.do", method = RequestMethod.GET)
	public String getWikiList(
		@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
		, @ModelAttribute("searchVO") SearchVO searchVO
		, PagingVO<BoardVO> pagingVO
		, Model model
	){
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCode(7);
		int totalRecord = boardService.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<BoardVO> boardList = boardService.retrieveBoardList(pagingVO);
		pagingVO.setDataList(boardList);
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "wiki/wikiList";
	}
	
	@RequestMapping(value="/wiki/wikiView.do", method = RequestMethod.GET)
	public String getWiki(@RequestParam(value="boardNo", required=true) int boardNo , Model model) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardNo(boardNo);
		boardVO.setCode(7);
		boardVO = boardService.retrieveBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		return "wiki/wikiView";
	}
	
	//=====================================================================================
	//Insert
	@RequestMapping(value="/wiki/wikiInsert.do", method = RequestMethod.GET)
	public String insertForm() {
		return "wiki/wikiForm";
	}
	
	@RequestMapping(value="/wiki/wikiInsert.do", method = RequestMethod.POST)
	public String doInsert(
		@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
		, @RequestParam("proId") String proId
		, @Validated(InsertGroup.class) @ModelAttribute("wiki") BoardVO boardVO
		, BindingResult errors
		, RedirectAttributes redirectAttr
		, Model model
	){
		String goPage = null;
		boardVO.setBoardWriter(memberVO.getMemName());
		boardVO.setCode(7);
		if(!errors.hasErrors()) {
			ServiceResult result = boardService.createBoard(boardVO);
			switch (result) {
			case OK:
				goPage = "redirect:/wiki/wikiView.do?boardNo=" + boardVO.getBoardNo();
				redirectAttr.addAttribute("proId", proId);
				break;
			default:
				model.addAttribute("message", NotyMessageVO.builder("?????? ????????? ??????????????????.").build());
				goPage = "wiki/wikiList";
				break;
			}
		}else {
			goPage = "wiki/wikiList";
		}
		return goPage;
	}	
	
	//=====================================================================================
	//Delete	
	@RequestMapping(value="/wiki/wikiDelete.do", method=RequestMethod.POST)
	public String doDelete(
		@RequestParam("proId") String proId
		, @Validated(DeleteGroup.class) BoardVO boardVO
		, Errors errors
		, RedirectAttributes redirectAttr
	){
		String goPage = "redirect:/wiki/wikiView/"+boardVO.getBoardNo();
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = boardService.removeBoard(boardVO);
			switch (result) {
			case FAILED:
				message = NotyMessageVO.builder("?????? ??????").build();
				break;
			default:
				goPage = "redirect:/wiki/wikiList.do";
				redirectAttr.addAttribute("proId", proId);
				break;
			}
		}else {
			message = NotyMessageVO.builder("????????? ????????? ????????? ??????????????????.").build();
		}
		if(message!=null) redirectAttr.addFlashAttribute("message", message);
		return goPage;
	}
	
	//=====================================================================================
	//Update
	@RequestMapping(value="/wiki/wikiUpdate.do", method = RequestMethod.GET)
	public String updateForm(
		@RequestParam("boardNo") int boardNo
		,Model model
	) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardNo(boardNo);
		boardVO.setCode(7);
		
		boardVO = (BoardVO) boardService.retrieveBoard(boardVO);
		model.addAttribute("wiki", boardVO);
		return "wiki/wikiForm";
	}
	
	@RequestMapping(value="/wiki/wikiUpdate.do", method=RequestMethod.POST)
	public String doUpdate(
			@RequestParam("proId") String proId
			,@Validated(UpdateGroup.class) BoardVO boardVO
			,BindingResult errors
			,RedirectAttributes redirectAttr
			,Model model
	){
		String goPage = null;
		if(!errors.hasErrors()) {
			ServiceResult result = boardService.modifyBoard(boardVO);
			switch (result) {
				case OK:
					goPage = "redirect:/wiki/wikiView.do?boardNo="+boardVO.getBoardNo();
					redirectAttr.addAttribute("proId", proId);
					break;
				default:
					model.addAttribute("message", NotyMessageVO.builder("?????? ??????").build());
					goPage = "wiki/wikiForm";
					break;
			}
		}else {
			goPage = "wiki/wikiForm";
		}
		return goPage;
	}
	
}
