package kr.or.ddit.projects.member.controller;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SortVO;


/**
 * @author 신광진
 * @since 2021. 1. 31.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 1. 31.     신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
@Controller
public class AdminMemberController extends BaseController {

	// INSERT
	@RequestMapping(value="/admin/member/memberInsert.do", method=RequestMethod.GET)
	public String goInsertPage() {
		return "admin/member/memberFormView";
	}
	
	@RequestMapping(value="/admin/member/memberInsert.do", method=RequestMethod.POST)
	public String insertMember(
			@Validated MemberVO memberVO
			, Errors errors
			, RedirectAttributes redirectAtts) 
	{
		String goPage = "admin/member/memberFormView";
		String message = null;
		if(!errors.hasErrors()) {
			// Mail 구현해야함
			ServiceResult createRes = adminMemberService.createMember(memberVO);
			switch (createRes) {
			case FAILED:
				message = "회원등록을 실패했습니다.";
				break;

			default:
				message = memberVO.getMemId() + "[" + memberVO.getMemName() + "] 이 구성원으로 등록되었습니다.";
				goPage = "redirect:/admin/member/memberList.do";
				break;
			}
		}
		if(message != null) {
			redirectAtts.addFlashAttribute("message", getNotyMessage(message));
		}
		return goPage;
	}
	
	// UPDATE (LOCK STATUS)
	@RequestMapping(value="/admin/member/changeLockStatus.do", method=RequestMethod.POST)
	public String changeLockStatus(MemberVO memberVO, Model model) {
		ServiceResult changeRes = adminMemberService.changeLockStatus(memberVO);
		NotyMessageVO message = null;
		switch (changeRes) {
			case FAILED:
				message = getNotyMessage("요청작업을 실패하였습니다.");
				break;
	
			case NOTEXIST:
				message = getNotyMessage(memberVO.getMemId() + " 계정이 존재하지 않습니다.");
				break;
				
			case DISABLE:
				message = getNotyMessage("관리자 계정은 잠금처리 할 수 없습니다");
				break;
				
			default:
				String msgSuffix = "N".equals(memberVO.getMemAlive()) ? "비활성화 되었습니다." : "활성화 되었습니다.";
				message = getNotyMessage(memberVO.getMemId() + "님의 계정이 " + msgSuffix);
				break;
		}
		model.addAttribute("message", message);
		model.addAttribute("result", changeRes);
		return "admin/member/memberListView";
	}
	
	@RequestMapping(value="/admin/member/changeLockStatus.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String changeLockStatusForAjax(MemberVO memberVO, Model model) {
		// 계정 잠금처리 후 결과를 비동기로 반환
		changeLockStatus(memberVO, model);
		return "jsonView";
	}
	
	// UPDATE (회원 상세보기에서 회원정보 변경)
	@RequestMapping(value="/admin/member/memberUpdate.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String updateMember(MemberVO memberVO, Model model) {
		NotyMessageVO message = null;
		try {
			ServiceResult result = adminMemberService.modifyMember(memberVO);
			switch (result) {
			case NOTEXIST:
				message = MEMBER_NOT_EXIST_MESSAGE;
				break;
				
			case FAILED:
				message = FAILED_MEMBER_MODIFY_MESSAGE;
				break;
				
			default:
				message = SUCCESS_MEMBER_MODIFY_MESSAGE;
				break;
			}
			model.addAttribute("result", result);
		} catch(DataAccessException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}

		model.addAttribute("message", message);
		return "jsonView";
	}
	
	
	// DELETE
	@RequestMapping(value="/admin/member/deleteMember.do", method=RequestMethod.POST)
	public String deleteMember(MemberVO memberVO, Model model) {
		ServiceResult removeRes = adminMemberService.removeMember(memberVO);
		NotyMessageVO message = null;
		switch (removeRes) {
		case FAILED:
			message = getNotyMessage("계정삭제를 실패하였습니다");
			break;
		case NOTEXIST: 
			message = getNotyMessage(memberVO.getMemId() + "회원이 존재하지 않습니다");
			break;
		default:
			message = getNotyMessage(memberVO.getMemId() + "회원 계정을 삭제하였습니다");
			break;
		}
		model.addAttribute("message", message);
		model.addAttribute("result", removeRes);
		return "admin/member/memberListView";
	}
	
	@RequestMapping(value="/admin/member/deleteMember.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String deleteMemberForAjax(MemberVO memberVO, Model model) {
		deleteMember(memberVO, model);
		return "jsonView";
	}
	
	@RequestMapping(value="/admin/member/initPassword.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String initPassword(MemberVO memberVO, Model model) {
		ServiceResult result = adminMemberService.initPassword(memberVO);
		NotyMessageVO message = null;
		switch (result) {
		case NOTEXIST:
			message = getNotyMessage(memberVO.getMemId() + " 회원이 존재하지 않습니다");
			break;

		case FAILED:
			message = FAILED_INIT_PASSWORD_MESSAGE;
			
		default:
			message = SUCCESS_INIT_PASSWORD_MESSAGE;
			break;
		}
		model.addAttribute("message", message);
		model.addAttribute("result", result);
		return "jsonView";
	}
	
	@RequestMapping(value="/admin/member/duplicationCheck.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult duplicationCheckForMemId(MemberVO memberVO) {
		ServiceResult duplicationCheckRes = adminMemberService.duplicationCheckForMemId(memberVO);
		return duplicationCheckRes;
	}
	
	// 회원목록 조회
	@RequestMapping(value="/admin/member/memberList.do", method=RequestMethod.GET)
	public String getMemberList(	
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, MemberVO searchDetail
			, SearchVO searchVO
			, SortVO sortVO
			, Model model) 
	{
		PagingVO<MemberVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSortVO(sortVO);
		
		int totalRecord = adminMemberService.retrieveMemberCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<MemberVO> dataList = adminMemberService.retrieveMemberList(pagingVO);
		pagingVO.setDataList(dataList);
		
		paginationInfo = new CustomPaginationInfo<>(pagingVO);
		model.addAttribute("pagination", paginationInfo);
		return "admin/member/memberListView";
	}
	
	// 회원목록 비동기 조회
	@RequestMapping(value="/admin/member/memberList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getMemberListForAjax(	
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage 
			, MemberVO searchDetail
			, SearchVO searchVO
			, SortVO sortVO
			, Model model) 
	{
		getMemberList(currentPage, searchDetail, searchVO, sortVO, model);
		return "jsonView";
	}
	
	@RequestMapping(value="/admin/member/memberDetail.do", method=RequestMethod.GET)
	public String getMember(MemberVO memberVO, Model model) {
		MemberVO selectedMember = adminMemberService.retrieveMember(memberVO);
		model.addAttribute("memberVO", selectedMember);
		
		CustomInfoVO customInfoVO = new CustomInfoVO();
		customInfoVO.setGroupCode("WT");
		List<WorkVO> workList = adminWorkService.retrieveWorkListByMember(memberVO);
		List<CustomInfoVO> workCustomInfoList = customInfoService.retrieveCustomInfoList(customInfoVO);
		model.addAttribute("workList", workList);
		model.addAttribute("workCustomInfoList", workCustomInfoList);
		
		customInfoVO.setGroupCode("IT");
		List<IssueVO> issueList = adminIssueService.retrieveIssueListByMember(memberVO);
		List<CustomInfoVO> issueCustomInfoList = customInfoService.retrieveCustomInfoList(customInfoVO);
		model.addAttribute("issueList", issueList);
		model.addAttribute("issueCustomInfoList", issueCustomInfoList);
		
		List<ProjectVO> projectList = adminProjectService.retrieveProjectListByMember(memberVO);
		model.addAttribute("projectList", projectList);
		
		return "admin/member/memberDetailView";
	}
	
}












