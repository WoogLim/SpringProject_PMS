package kr.or.ddit.projects.project.controller;

import java.security.Provider.Service;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.member.vo.ProMemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.DashBoardVO;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;

/**
 * @author 임건
 * @since 2021. 2. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일            수정자           수정내용
 * ------------     --------    ----------------------
 * 2021. 2. 15.      임건              최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class ProjectController extends BaseController {

	@RequestMapping(value = "/project/main", method = RequestMethod.GET)
	public String getDashBoard(ProjectVO projectVO, Model model) {

		DashBoardVO dashBoardVO = dashBoardService.retrieveDashBoard(projectVO);
		model.addAttribute("dashBoardVO", dashBoardVO);
		
		List<WorkVO> completeWorkListInMonth = workService.retrieveCompleteWorkListInMonth(projectVO);
		model.addAttribute("completeWorkListInMonth", completeWorkListInMonth);
		
		List<ProMemberVO> proMemberList = adminProjectService.retrieveProjectMemberList(projectVO);
		model.addAttribute("proMemberList", proMemberList);
		
		List<ProMemberVO> roleNameList = adminProjectService.retrieveProjectMemberRoleNameList(projectVO);
		model.addAttribute("roleNameList", roleNameList);
		
		List<BoardVO> projectNoticeList = boardService.retrieveLatelyBoardList(projectVO);
		model.addAttribute("projectNoticeList", projectNoticeList);
		
		return "project/main/projectMain";
	}

	@RequestMapping(value="/project/simpleProjectList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getNoPagingProjectList(
			SearchVO searchVO
			, ProjectVO projectVO
			, Model model) 
	{
		PagingVO<ProjectVO> pagingVO = new PagingVO<>(Integer.MAX_VALUE, 5);
		pagingVO.setSearchVO(searchVO);
		
		List<ProjectVO> dataList = projectService.retrieveSimpleProjectList(pagingVO);
		model.addAttribute("dataList", dataList);
		return "jsonView";
	}
	
	@RequestMapping(value="/project/projectMember.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getProjectMemberList(ProjectVO projectVO, Model model) {
		List<ProMemberVO> proMemberList = projectService.retrieveProjectMemberList(projectVO);
		model.addAttribute("proMemberList", proMemberList);
		return "jsonView";
	}
	
	@RequestMapping(value="/project/insertProject.do", method=RequestMethod.GET)
	public String getProjectRequestFrom(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {
		List<AuthorityVO> authorityList = securityService.retrieveTeamAuthorityList();
		model.addAttribute("authorityList", authorityList);
		
		return "project/manage/projectrequest";
	}

	@RequestMapping(value="/project/insertProject.do", method=RequestMethod.POST)
	public String insertProject(ProjectVO projectVO, Model model, RedirectAttributes redirectAtts) {
		NotyMessageVO message = SUCCESS_PROJECT_REQUEST_MESSAGE;
		String goPage = "project/manage/projectrequest";
		try {
			adminProjectService.createProject(projectVO);
			goPage = "redirect:/user/main";
			redirectAtts.addFlashAttribute("message", message);
		} catch(DataAccessException | CustomException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
			model.addAttribute("message", message);
		} 
		return goPage;
	}
	
	@RequestMapping(value="/project/myProjectList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String myProjectListView(@AuthenticationPrincipal(expression="realMember") MemberVO memberVO, Model model, SearchVO searchVO) {
		PagingVO<ProjectVO> pagingVO =new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		pagingVO.setMemId(memberVO.getMemId());
		
		List<ProjectVO> dataList = projectService.retreiveMyProjectList(pagingVO);
		model.addAttribute("dataList", dataList);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/project/memberConfig.do", method=RequestMethod.GET)
	public String projectMemberConfigView() {
		return "project/manage/memberConfigView";
	}
	
	@RequestMapping(value="/project/codeUpdate.do", method=RequestMethod.POST)
	public String updateProjectStatus(ProjectVO projectVO, RedirectAttributes redirectAtts) {
		try {
			projectService.modifyProjectCode(projectVO);
		} catch(DataAccessException | CustomException e) {
			redirectAtts.addFlashAttribute("message", EXCEPTION_MESSAGE_FOR_CLIENT);
		}
		return "redirect:/project/main?proId=" + projectVO.getProId();
	}
	
	@RequestMapping(value="/project/statusCheck.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String projectStatusCheck(ProjectVO projectVO, Model model) {
		try {
			ServiceResult status = projectService.projectCodeCheck(projectVO);
			model.addAttribute("status", status);
		} catch(DataAccessException e) {
			model.addAttribute("message", EXCEPTION_MESSAGE_FOR_CLIENT);
		}
		return "jsonView";
	}
}









