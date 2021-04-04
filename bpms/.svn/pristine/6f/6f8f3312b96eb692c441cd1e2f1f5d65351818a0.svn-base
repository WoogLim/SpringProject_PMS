package kr.or.ddit.projects.issue.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.NotyMessageVO;
import kr.or.ddit.vo.PagingVO;

@Controller
public class IssueController extends BaseController {
	// 이슈 커스텀 정보 model attribute에 저장
	private void addCustomInfoList(Model model) {
		// 이슈 우선 순위 커스텀 정보
		CustomInfoVO irCustom = new CustomInfoVO();
		// 이슈 유형 커스텀 정보
		CustomInfoVO itCustom = new CustomInfoVO();
		// 이슈 상태 커스텀 정보
		CustomInfoVO isCustom = new CustomInfoVO();
		
		irCustom.setGroupCode(IssueVO.IRGROUPCODE);
		itCustom.setGroupCode(IssueVO.ITGROUPCODE);
		isCustom.setGroupCode(IssueVO.ISGROUPCODE);
		
		List<CustomInfoVO> irCustomList = customInfoService.retrieveCustomInfoList(irCustom);
		List<CustomInfoVO> itCustomList = customInfoService.retrieveCustomInfoList(itCustom);
		List<CustomInfoVO> isCustomList = customInfoService.retrieveCustomInfoList(isCustom);
		
		model.addAttribute("irCustomList", irCustomList);
		model.addAttribute("itCustomList", itCustomList);
		model.addAttribute("isCustomList", isCustomList);
	}
	
	// 회원이 속한 프로젝트 정보 리스트 model attribute에 저장
	private void addProjectList(MemberVO memberVO, Model model) {
		if(memberVO != null) {
			String memId = memberVO.getMemId();
			if(StringUtils.isNotBlank(memId)) {
				List<ProjectVO> projectList = workService.retrieveByMemberToProjectList(memberVO);
				model.addAttribute("projectList", projectList);
			}
		}
	}
	
	// 프로젝트의 속한 멤버 구성원 정보 model attribute에 저장
	private void addProjectMember(IssueVO issueVO, Model model) {
		if(issueVO != null) {
			String proId = issueVO.getProId();
			if(StringUtils.isNotBlank(proId)) {
				List<MemberVO> projectMember = issueService.retrieveByProjectToMemberList(issueVO);
				model.addAttribute("projectMember", projectMember);
			}
		}
	}
	
	@RequestMapping("/issue/issueList.do")
	public void issueList(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, IssueVO issueVO
		, Model model
	) {
		// 커스텀 정보
		addCustomInfoList(model);
		
		// 프로젝트 리스트
		addProjectList(authMember, model);
		
		PagingVO<IssueVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(issueVO);
		pagingVO.setCurrentPage(currentPage);
		
		// 회원 정보 등록
		String memId = authMember.getMemId();
		pagingVO.setMemId(memId);
		
		// 페이징 처리를 위한 토탈 레코드
		int totalRecord = issueService.retrieveIssueCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		// 회원별 일감 리스트
		List<IssueVO> dataList = issueService.retrieveByMemberToIssueList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
	}
	
	
	// 여기까지
	// 일감 비동기 조회
	@RequestMapping(value="/issue/issueList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String issueListAjaxForm(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, IssueVO issueVO
		, Model model
	) {
		issueList(currentPage, authMember, issueVO, model);
		return "jsonView";
	}
	
	// 이슈 상세 조회
	// 없는 이슈인지 체크해야 됨.
	@RequestMapping("/issue/issueView.do")
	public String issueView(
		IssueVO issueVO
		,Model model
	){
		addCustomInfoList(model);
		IssueVO issue = issueService.retrieveIssue(issueVO); 
		model.addAttribute("issueVO", issue);
		return "issue/issueView";
	}
	
	// 이슈 생성 폼 이동
	@GetMapping("/issue/issueInsert.do")
	public String issueForm(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, Model model
	) {
		addCustomInfoList(model);
		addProjectList(authMember, model);
		model.addAttribute("issueVO", new IssueVO());
		return "issue/issueForm";
	}
	
	// 이슈 디테일 셀렉트 박스 init 데이터
	@RequestMapping(value="/issue/issueFormDetailInit.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	String issueFormProjectList(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @ModelAttribute("issueVO") IssueVO issueVO
		, Model model
	) {
		addProjectMember(issueVO, model);
		model.addAttribute("issueVO", issueVO);
		return "jsonView";
	}
	
	@RequestMapping(value="/issue/issueToWorkSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String issueToWorkSearch(
		@ModelAttribute("issueVO") IssueVO issueVO
		, Model model
	) {
		if(issueVO != null) {
			if(StringUtils.isNotBlank(issueVO.getWorkSearch()) || StringUtils.isNotBlank(issueVO.getProId())) {
				List<WorkVO> workList = issueService.retrieveByProjectToWorkList(issueVO);
				model.addAttribute("workList", workList);
			}
		}
		return "jsonView";
	}
	
	// 이슈 생성 메서드
	// 하이버네이트 사용
	@PostMapping("/issue/issueInsert.do")
	public String issueInsert(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="proId") String[] proId
		, @Validated(InsertGroup.class) @ModelAttribute("issueVO") IssueVO issueVO
		, BindingResult errors
		, RedirectAttributes redirectAttr
		, Model model
	) {
		String boardWriter = authMember.getMemId();
		issueVO.setBoardWriter(boardWriter);
		issueVO.setProId(proId[0]);
		String goPage = "issue/issueForm";
		if(!errors.hasErrors()) {
			ServiceResult result = issueService.createIssue(issueVO);
			switch (result) {
				case OK:
					goPage =  "redirect:/issue/issueList.do";
					break;
				case DISABLE:
					model.addAttribute("message", NotyMessageVO.builder("선택하신 일감은 존재 하지 않는 일감이거나 사용 하실 수 없는 일감입니다.").build());
					break;
				default:
					model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				break;
			}
		}
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(issueVO, model);
		model.addAttribute("issueVO", issueVO);
		if(proId.length > 1) {
			if(StringUtils.isNotBlank(proId[1])) {
				redirectAttr.addAttribute("proId", proId[1]);
			}
		}
		return goPage;
	}
	
	// 이슈 업데이트 폼 이동
	// 수정할 이슈 유무 체크 필요
	@GetMapping("/issue/issueUpdate.do")
	public String workUpdateForm(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, IssueVO issueVO
		, Model model
	) {
		IssueVO issue = issueService.retrieveIssue(issueVO);
	
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(issue, model);
		
		model.addAttribute("issueVO", issue);
		return "issue/issueForm";
	}
	
	// 이슈 수정 메서드
	@PostMapping("/issue/issueUpdate.do")
	public String workUpdate(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="proId") String[] proId
		, @Validated(UpdateGroup.class) IssueVO issueVO
		, BindingResult errors
		, RedirectAttributes redirectAttr
		, Model model
	) {
		String goPage = "issue/issueForm";
		issueVO.setProId(proId[0]);
		if(!errors.hasErrors()) {
			ServiceResult result = issueService.modifyIssue(issueVO);
			switch (result) {
			case OK:
				goPage = "redirect:/issue/issueList.do";
				break;
			case DISABLE:
				model.addAttribute("message", NotyMessageVO.builder("수정 하신 연결 일감은 존재 하지 않는 일감이거나 사용 하실 수 없는 일감입니다.").build());
				break;
			case NOTEXIST:
				model.addAttribute("message", NotyMessageVO.builder("존재 하지 않는 이슈 입니다.").build());
				break;
			default:	
				model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
				break;
			}
		}
		addCustomInfoList(model);
		addProjectList(authMember, model);
		addProjectMember(issueVO, model);
		model.addAttribute("issueVO", issueVO);
		if(proId.length > 1) {
			if(StringUtils.isNotBlank(proId[1])) {
				redirectAttr.addAttribute("proId", proId[1]);
			}
		}
		return goPage;
	}
	
	// 이슈 삭제 메서드
	@RequestMapping("/issue/issueDelete.do")
	public String issueDelete(
		@RequestParam(value="proId") String proId
		,IssueVO issueVO
		,RedirectAttributes redirectAttr
		,Model model
	) {
		ServiceResult result = issueService.removeIssue(issueVO);
		String goPage = "issue/issueView";
		switch(result){
		case OK:
			goPage = "redirect:/issue/issueList.do";
			break;
		case NOTEXIST:
			model.addAttribute("message", NotyMessageVO.builder("존재 하지 않는 이슈입니다!!!").build());
			break;
		default:	
			model.addAttribute("message", NotyMessageVO.builder("서버 오류").build());
			break;
		}
		addCustomInfoList(model);
		addProjectMember(issueVO, model);
		model.addAttribute("issueVO", issueVO);
		if(StringUtils.isNotBlank(proId)) {
			redirectAttr.addAttribute("proId", proId);
		}
		return goPage;
	}
}
