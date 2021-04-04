package kr.or.ddit.projects.work.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 전수빈
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class WorkController extends BaseController {

	// 일감 커스텀 정보 model attribute에 저장
	private void addCustomInfoList(Model model) {
		// 일감 우선 순위 커스텀 정보
		CustomInfoVO wrCustom = new CustomInfoVO();
		// 일감 유형 커스텀 정보
		CustomInfoVO wtCustom = new CustomInfoVO();
		// 일감 상태 커스텀 정보
		CustomInfoVO wsCustom = new CustomInfoVO();

		wrCustom.setGroupCode(WorkVO.WRGROUPCODE);
		wtCustom.setGroupCode(WorkVO.WTGROUPCODE);
		wsCustom.setGroupCode(WorkVO.WSGROUPCODE);

		List<CustomInfoVO> wrCustomList = customInfoService.retrieveCustomInfoList(wrCustom);
		List<CustomInfoVO> wtCustomList = customInfoService.retrieveCustomInfoList(wtCustom);
		List<CustomInfoVO> wsCustomList = customInfoService.retrieveCustomInfoList(wsCustom);

		model.addAttribute("wrCustomList", wrCustomList);
		model.addAttribute("wtCustomList", wtCustomList);
		model.addAttribute("wsCustomList", wsCustomList);
	}

	// 회원이 속한 프로젝트 정보 리스트 model attribute에 저장
	private void addProjectList(MemberVO memberVO, Model model) {
		if (memberVO != null) {
			String memId = memberVO.getMemId();
			if (StringUtils.isNotBlank(memId)) {
				List<ProjectVO> projectList = workService.retrieveByMemberToProjectList(memberVO);
				model.addAttribute("projectList", projectList);
			}
		}
	}

	// 프로젝트의 속한 멤버 구성원 정보 model attribute에 저장
	private void addProjectMember(WorkVO workVO, Model model) {
		if (workVO != null) {
			String proId = workVO.getProId();
			if (StringUtils.isNotBlank(proId)) {
				List<MemberVO> projectMember = workService.retrieveByProjectToMemberList(workVO);
				model.addAttribute("projectMember", projectMember);
			}
		}
	}

	@RequestMapping("/work/workList.do")
	public void workList(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		, @AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, WorkVO workVO
		, Model model
	) {
		// 커스텀 정보
		addCustomInfoList(model);

		// 프로젝트 리스트
		addProjectList(authMember, model);

		PagingVO<WorkVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(workVO);
		pagingVO.setCurrentPage(currentPage);
		
		// 회원 정보 등록
		String memId = authMember.getMemId();
		pagingVO.setMemId(memId);

		// 페이징 처리를 위한 토탈 레코드
		int totalRecord = workService.retrieveWorkCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		// 회원별 일감 리스트
		List<WorkVO> dataList = workService.retrieveByMemberToWorkList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
	}

	// 일감 비동기 조회
	@RequestMapping(value="/work/workList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String workListAjaxForm(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		,@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		,WorkVO workVO
		,Model model
	) {
		workList(currentPage, authMember, workVO, model);
		return "jsonView";
	}

	// 일감 상세 조회
	// 없는 일감인지 체크해야 됨.
	@RequestMapping("/work/workView.do")
	public String workView(WorkVO workVO, Model model) {
		addCustomInfoList(model);
		WorkVO work = workService.retrieveWork(workVO);
		model.addAttribute("workVO", work);
		return "work/workView";
	}

	// 일감 생성 폼 이동
	@GetMapping("/work/workInsert.do")
	public String workForm(
		@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, WorkVO workVO
		, Model model
	) {
		addCustomInfoList(model);
		addProjectList(authMember, model);
		model.addAttribute("workVO", new WorkVO());
		return "work/workForm";
	}

	// 일감 디테일 셀렉트 박스 init 데이터
	@RequestMapping(value = "/work/workFormDetailInit.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String workFormProjectList(
		@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, WorkVO workVO
		, Model model
	) {
		addProjectMember(workVO, model);
		model.addAttribute("workVO", workVO);
		return "jsonView";
	}
	
	@RequestMapping(value="/work/workParentSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String workParentSearch(
		WorkVO workVO
		,Model model
	) {
		if(workVO != null) {
			if(StringUtils.isNotBlank(workVO.getParentSearch()) || StringUtils.isNotBlank(workVO.getProId())) {
				List<WorkVO> workList = workService.retrieveByProjectToWorkList(workVO); 
				model.addAttribute("workList", workList);
			}
		}
		return "jsonView";
	}
	
	// 일감 생성 메서드
	// 하이버네이트 사용
	@PostMapping("/work/workInsert.do")
	public String workInsert(
		@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, @RequestParam(value="proId") String[] proId
		, @Validated(InsertGroup.class) WorkVO workVO
		, BindingResult errors
		, RedirectAttributes redirectAttr
		, Model model
	) {
		String boardWriter = authMember.getMemId();
		workVO.setBoardWriter(boardWriter);
		workVO.setProId(proId[0]);
		String goPage = "work/workForm";
		if (!errors.hasErrors()) {
			ServiceResult result = workService.createWork(workVO);
			switch (result) {
			case OK:
				goPage = "redirect:/work/workList.do";
				break;
			case DISABLE:
				model.addAttribute("message", NotyMessageVO.builder("선택하신 상위 일감은 존재 하지 않는 일감이거나 사용 하실 수 없는 일감입니다.").build());
				break;
			default:
				model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				break;
			}
		} 
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(workVO, model);
		model.addAttribute("workVO", workVO);
		if(proId.length > 1) {
			if(StringUtils.isNotBlank(proId[1])) {
				redirectAttr.addAttribute("proId", proId[1]);
			}
		}
		return goPage;
	}

	// 일감 업데이트 폼 이동
	// 수정할 일감 유무 체크 필요
	@GetMapping("/work/workUpdate.do")
	public String workUpdateForm(
		@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, WorkVO workVO
		, Model model
	) {
		WorkVO work = workService.retrieveWork(workVO);
		String goPage = "work/workForm";
		
		if(work == null) {
			goPage = "redirect:/work/workList.do";
			model.addAttribute("message", NotyMessageVO.builder("존재하지 않는 일감입니다.").build());
		}
		
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(work, model);
		model.addAttribute("workVO", work);
		return goPage;
	}

	// 일감 수정 메서드
	@PostMapping("/work/workUpdate.do")
	public String workUpdate(
		@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		, @RequestParam(value="proId") String[] proId
		, @Validated(UpdateGroup.class) WorkVO workVO
		, BindingResult errors
		, RedirectAttributes redirectAttr
		, Model model
	) {
		String boardWriter = authMember.getMemId();
		workVO.setBoardWriter(boardWriter);
		workVO.setProId(proId[0]);
		String goPage = "work/workForm";
		if (!errors.hasErrors()) {
			ServiceResult result = workService.modifyWork(workVO);
			switch (result) {
			case OK:
				goPage = "redirect:/work/workList.do";
				break;
			case DISABLE:
				model.addAttribute("message", NotyMessageVO.builder("수정 하신 상위 일감은 존재 하지 않는 일감이거나 사용 하실 수 없는 일감입니다.").build());
				break;
			case NOTEXIST:
				model.addAttribute("message", NotyMessageVO.builder("존재 하지 않는 일감 입니다.").build());
				break;
			default:
				model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				break;
			}
		} 
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(workVO, model);
		model.addAttribute("workVO", workVO);
		if(proId.length > 1) {
			if(StringUtils.isNotBlank(proId[1])) {
				redirectAttr.addAttribute("proId", proId[1]);
			}
		}
		return goPage;
	}

	// 일감 삭제 메서드
	@RequestMapping("/work/workDelete.do")
	public String workDelete(
		@RequestParam(value="proId") String proId
		, WorkVO workVO
		, Model model
		, RedirectAttributes redirectAttr
	) {
		ServiceResult result = workService.removeWork(workVO);
		String goPage = "work/workView";
		switch (result) {
		case OK:
			goPage = "redirect:/work/workList.do";
			break;
		case NOTEXIST:
			model.addAttribute("message", NotyMessageVO.builder("존재 하지 않는 일감입니다!!!").build());
			break;
		default:
			model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
			break;
		}
		addCustomInfoList(model);
		addProjectMember(workVO, model);
		model.addAttribute("workVO", workVO);
		if(StringUtils.isNotBlank(proId)) {
			redirectAttr.addAttribute("proId", proId);
		}
		return goPage;
	}
	
	@RequestMapping(value="/work/completeWorkList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getCompleteWorkListInMonth(ProjectVO projectVO, Model model) {
		List<WorkVO> completeWorkListInMonth = workService.retrieveCompleteWorkListInMonth(projectVO);
		model.addAttribute("completeWorkListInMonth", completeWorkListInMonth);
		return "jsonView";
	}
	
}
