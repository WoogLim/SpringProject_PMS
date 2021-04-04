package kr.or.ddit.projects.issue.controller;

import java.io.Reader;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;
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
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
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
public class AdminIssueController extends BaseController {

	private static final String ISSUE_CATEGORY_QUERY_STRING = "?groupCode=IT";
	private static final String ISSUE_STATUS_QUERY_STRING = "?groupCode=IS";
	private static final String ISSUE_RANK_QUERY_STRING = "?groupCode=IR";

	// ISSUE CUSTOMINFO LIST RETRIEVE
	@RequestMapping(value = "/admin/issue/customInfoList.do", method = RequestMethod.GET)
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
		case "IT":
			goPage = "admin/issue/categoryListView";
			break;

		case "IR":
			goPage = "admin/issue/rankListView";
			break;

		default:
			goPage = "admin/issue/statusListView";
		}
		return goPage;
	}

	// ISSUE CUSTOMINFO INSERT
	@RequestMapping(value = "/admin/issue/customInfoInsert.do", method = RequestMethod.POST)
	public String insertCategory(CustomInfoVO customInfoVO, CodeVO codeVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			customInfoService.createCustomInfo(customInfoVO, codeVO);
		} catch (DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return getRedirectPageURL(customInfoVO.getGroupCode());
	}

	// ISSUE CUSTOMINFO UPDATE
	@RequestMapping(value = "/admin/issue/customInfoUpdate.do", method = RequestMethod.POST)
	public String updateCategory(CustomInfoVO customInfoVO, CodeVO codeVO, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			customInfoService.modifyCustomInfo(customInfoVO, codeVO);
		} catch (DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return getRedirectPageURL(customInfoVO.getGroupCode());
	}

	// ISSUE CUSTOMINFO DELETE
	@RequestMapping(value = "/admin/issue/customInfoDelete.do", method = RequestMethod.POST)
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
		return getRedirectPageURL(customInfoVO.getGroupCode());
	}

	// groupCode에 따라 URL을 설정해줌
	public String getRedirectPageURL(String groupCode) {
		String redirectPageURL = "redirect:/admin/issue/customInfoList.do";
		switch (groupCode) {
		case "IT":
			redirectPageURL += ISSUE_CATEGORY_QUERY_STRING;
			break;

		case "IR":
			redirectPageURL += ISSUE_RANK_QUERY_STRING;
			break;

		default:
			redirectPageURL += ISSUE_STATUS_QUERY_STRING;
			break;
		}
		return redirectPageURL;
	}

	// groupCode에 따른 ExceptionMessage를 설정함
	public NotyMessageVO getExceptionMsg(CustomInfoVO customInfoVO) {
		NotyMessageVO message = null;
		String groupCode = customInfoVO.getGroupCode();
		switch (groupCode) {
		case "IT":
			message = ISSUE_TYPE_EXIST_IN_PROJECT;
			break;

		case "IR":
			message = ISSUE_RANK_EXIST_IN_PROJECT;
			break;

		default:
			message = ISSUE_STATUS_EXIST_IN_PROJECT;
			break;
		}
		return message;
	}

	// ISSUE LIST
	@RequestMapping(value = "/admin/issue/issueList.do", method = RequestMethod.GET)
	public String getAllIssueList(
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage, SortVO sortVO,
			IssueVO searchDetail, Model model) {
		PagingVO<IssueVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSortVO(sortVO);

		int totalRecord = adminIssueService.retrieveIssueCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<IssueVO> dataList = adminIssueService.retrieveIssueList(pagingVO);
		pagingVO.setDataList(dataList);

		List<IssueVO> issueDirectorList = adminIssueService.retrieveIssueDirectorList(pagingVO);
		model.addAttribute("issueDirectorList", issueDirectorList);

		List<IssueVO> boardWriterList = adminIssueService.retrieveBoardWriterList(pagingVO);
		model.addAttribute("boardWriterList", boardWriterList);

		CustomPaginationInfo<IssueVO> paginationInfo = new CustomPaginationInfo<>(pagingVO);
		model.addAttribute("pagination", paginationInfo);

		List<CustomInfoVO> issueCustomInfoList = customInfoService.retrieveIssueCustomInfoList();
		model.addAttribute("issueCustomInfoList", issueCustomInfoList);

		List<ProjectVO> projectList = adminProjectService.retrieveNoPagingProjectList();
		model.addAttribute("projectList", projectList);

		return "admin/issue/issueListView";
	}

}
