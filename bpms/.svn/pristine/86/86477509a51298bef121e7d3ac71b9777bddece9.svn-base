package kr.or.ddit.projects.work.controller;

import java.util.List;

import javax.resource.spi.work.Work;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SortVO;

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
@Controller
public class AdminWorkController extends BaseController {
	private static final String WORK_CATEGORY_QUERY_STRING = "?groupCode=WT";
	private static final String WORK_STATUS_QUERY_STRING = "?groupCode=WS";
	private static final String WORK_RANK_QUERY_STRING = "?groupCode=WR";

	// WORK CUSTOMINFO LIST RETRIEVE
	@RequestMapping(value = "/admin/work/customInfoList.do", method = RequestMethod.GET)
	public String getIssueCategoryList(CustomInfoVO customInfoVO, Model model,
			@RequestParam("groupCode") String groupCode) {
		try {
			List<CustomInfoVO> categoryList = customInfoService.retrieveCustomInfoList(customInfoVO);
			model.addAttribute("categoryList", categoryList);
		} catch (DataAccessException e) {
			model.addAttribute("message", EXCEPTION_MESSAGE_FOR_CLIENT);
			logger.error("retrieveCustomInfoList 에러");
		}

		String goPage = null;
		switch (groupCode) {
		case "WT":
			goPage = "admin/work/categoryListView";
			break;

		case "WR":
			goPage = "admin/work/rankListView";
			break;

		default:
			goPage = "admin/work/statusListView";
		}
		return goPage;
	}

	// WORK CUSTOMINFO INSERT
	@RequestMapping(value = "/admin/work/customInfoInsert.do", method = RequestMethod.POST)
	public String insertCategory(CustomInfoVO customInfoVO, CodeVO codeVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			customInfoService.createCustomInfo(customInfoVO, codeVO);
		} catch (DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return getRedirectPage(customInfoVO);
	}

	// WORK CUSTOMINFO UPDATE
	@RequestMapping(value = "/admin/work/customInfoUpdate.do", method = RequestMethod.POST)
	public String updateCategory(CustomInfoVO customInfoVO, CodeVO codeVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			customInfoService.modifyCustomInfo(customInfoVO, codeVO);
		} catch (DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return getRedirectPage(customInfoVO);
	}

	// WORK CUSTOMINFO DELETE
	@RequestMapping(value = "/admin/work/customInfoDelete.do", method = RequestMethod.POST)
	public String deleteCategory(CustomInfoVO customInfoVO, CodeVO codeVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			customInfoService.removeCustomInfo(customInfoVO, codeVO);
		} catch (DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		} catch (CustomException e) {
			message = getExceptionMsg(customInfoVO);
		}
		redirectAtts.addFlashAttribute("message", message);
		return getRedirectPage(customInfoVO);
	}

	// groupCode에 따라 URL을 설정해줌
	public String getRedirectPage(CustomInfoVO customInfoVO) {
		String redirectPageURL = "redirect:/admin/work/customInfoList.do";
		String groupCode = customInfoVO.getGroupCode();
		switch (groupCode) {
		case "WT":
			redirectPageURL += WORK_CATEGORY_QUERY_STRING;
			break;

		case "WR":
			redirectPageURL += WORK_RANK_QUERY_STRING;
			break;

		default:
			redirectPageURL += WORK_STATUS_QUERY_STRING;
			break;
		}
		return redirectPageURL;
	}

	public NotyMessageVO getExceptionMsg(CustomInfoVO customInfoVO) {
		NotyMessageVO message = null;
		String groupCode = customInfoVO.getGroupCode();
		switch (groupCode) {
		case "WT":
			message = WORK_TYPE_EXIST_IN_PROJECT;
			break;

		case "WR":
			message = WORK_RANK_EXIST_IN_PROJECT;
			break;

		default:
			message = WORK_STATUS_EXIST_IN_PROJECT;
			break;
		}
		return message;
	}

	// WORK LIST
	@RequestMapping(value = "/admin/work/workList.do", method = RequestMethod.GET)
	public String getAllIssueList(
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage, SortVO sortVO,
			WorkVO searchDetail, Model model) {
		PagingVO<WorkVO> pagingVO = new PagingVO<>(9999, 5);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSortVO(sortVO);

		List<WorkVO> dataList = adminWorkService.retrieveWorkList(pagingVO);
		pagingVO.setDataList(dataList);

		List<WorkVO> workDirectorList = adminWorkService.retrieveWorkDirectorList(pagingVO);
		model.addAttribute("workDirectorList", workDirectorList);

		List<WorkVO> boardWriterList = adminWorkService.retrieveBoardWriterrList(pagingVO);
		model.addAttribute("boardWriterList", boardWriterList);

		paginationInfo = new CustomPaginationInfo<>(pagingVO);
		model.addAttribute("pagination", paginationInfo);

		List<CustomInfoVO> workCustomInfoList = customInfoService.retrieveWorkCustomInfoList();
		model.addAttribute("workCustomInfoList", workCustomInfoList);

		List<ProjectVO> projectList = adminProjectService.retrieveNoPagingProjectList();
		model.addAttribute("projectList", projectList);

		return "admin/work/workListView";
	}
}
