package kr.or.ddit.projects.project.controller;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SortVO;

/**
 * @author 신광진
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일            수정자           수정내용
 * ------------     --------    ----------------------
 * 2021. 1. 26.      신광진           최초작성
 * 2021. 2. 10.      신광진     adminProjectController로 이름변경
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class AdminProjectController extends BaseController {

	// Retrieve requestProject
	@RequestMapping(value="/admin/project/requestProjectList.do", method=RequestMethod.GET)
	public String getRequestProject(Model model) {
		List<ProjectVO> reqList = adminProjectService.retrieveRequestProjectList();
		model.addAttribute("reqList", reqList);
		return "admin/project/requestProjectView";
	}

	// Retrieve Project
	@RequestMapping(value = "/admin/project/projectList.do", method = RequestMethod.GET)
	public String getHierarchyProjectList(CodeVO codeVO, ProjectVO searchDetail, SortVO sortVO, Model model) {

		PagingVO<ProjectVO> pagingVO = new PagingVO<>(Integer.MAX_VALUE, 5);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSortVO(sortVO);

		List<ProjectVO> dataList = adminProjectService.retrieveHierarchyProjectList(pagingVO);
		pagingVO.setDataList(dataList);

		CustomPaginationInfo<ProjectVO> paginationInfo = new CustomPaginationInfo<ProjectVO>(pagingVO);
		model.addAttribute("pagination", paginationInfo);

		List<CodeVO> codeList = codeService.retrieveCodeListByGroupCode(codeVO);
		model.addAttribute("codeList", codeList);

		return "admin/project/projectListView";
	}

	// UPDATE (프로젝트 최초승인)
	@RequestMapping(value = "/admin/project/accept.do", method = RequestMethod.POST)
	public String acceptProject(
			ProjectVO projectVO
			, PushMessageVO pushMsgVO
			, RedirectAttributes redirectAtts)
	{
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			adminProjectService.acceptProject(projectVO, pushMsgVO);
		} catch(DataAccessException | CustomException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return "redirect:/admin/project/requestProjectList.do";
	}

	// URL지정해야함
	@RequestMapping(value="/admin/project/update.do", method=RequestMethod.POST)
	public String updateProject(
			ProjectVO projectVO
			, RedirectAttributes redirectAtts)
	{
		NotyMessageVO message = SIMPLE_SUCCESS_MESSAGE_FOR_CLIENT;
		try {
			adminProjectService.updateProject(projectVO);
		} catch(DataAccessException | CustomException e) { 
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return null;
	}

	@RequestMapping(value="/admin/dashBoard", method=RequestMethod.GET)
	public String adminProjectDashBoardView(Model model) {
		List<WorkVO> workStateList = adminWorkService.retrieveWorkListByState();
		model.addAttribute("workStateList", workStateList);
		
		List<IssueVO> issueStateList = adminIssueService.retrieveIssueByState();
		model.addAttribute("issueStateList", issueStateList);
		
		List<ProjectVO> projectStateList = adminProjectService.retrieveProjectListByState();
		model.addAttribute("projectStateList", projectStateList);
		
		List<AuthorityVO> descriptionList = securityService.retrieveDescriptionListForMember();
		model.addAttribute("descriptionList", descriptionList);
		
		List<AuthorityVO> roleNameList = securityService.retrieveRoleNameListForProject();
		model.addAttribute("roleNameList", roleNameList);
		
		
		
		return "admin/dashBoard/dashBoardView";
	}
	
	@RequestMapping(value="/admin/dashBoard", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String adminProjectDashBoardViewForAjax(Model model) {
		adminProjectDashBoardView(model);
		return "jsonView";
	}
}











