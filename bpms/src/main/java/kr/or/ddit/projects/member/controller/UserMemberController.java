package kr.or.ddit.projects.member.controller;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.kanban.vo.KanbanStickerVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.projects.work.vo.WorkVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SortVO;

/**
 * @author 임건
 * @since 2021. 2. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 2. 15.    	  임건           	최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class UserMemberController extends BaseController {

	@Inject
	private AuthenticationManager authenticationManager;
	
	@Inject
	PasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/member/mypage", method=RequestMethod.GET)
	public String getMyPage(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {
		MemberVO selectedMember = userMemberService.retrieveMember(memberVO);
		model.addAttribute("memberVO", selectedMember);
		
		CustomInfoVO customInfoVO = new CustomInfoVO();
		customInfoVO.setGroupCode("WT");
		List<WorkVO> workList = userMemberService.retrieveWorkListByMember(memberVO);
		List<CustomInfoVO> workCustomInfoList = customInfoService.retrieveCustomInfoList(customInfoVO);
		model.addAttribute("workList", workList);
		model.addAttribute("workCustomInfoList", workCustomInfoList);
		
		customInfoVO.setGroupCode("IT");
		List<IssueVO> issueList = userMemberService.retrieveIssueListByMember(memberVO);
		List<CustomInfoVO> issueCustomInfoList = customInfoService.retrieveCustomInfoList(customInfoVO);
		model.addAttribute("issueList", issueList);
		model.addAttribute("issueCustomInfoList", issueCustomInfoList);
		
		List<ProjectVO> projectList = adminProjectService.retrieveProjectListByMember(memberVO);
		model.addAttribute("projectList", projectList);
		
		List<KanbanStickerVO> mystickerList = kanbanService.retrieveStickerList(memberVO);
		model.addAttribute("mystickerList", mystickerList);
		
		return "member/mypage/userMyPage";
	}
	
	@RequestMapping(value="/member/mymessage", method=RequestMethod.GET)
	public String getMyMessage(
			@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
			, @RequestParam(name="currentPage", required=false, defaultValue="1") int currentPage
			, PushMessageVO searchDetail
			, Model model)
	{
		PagingVO<PushMessageVO> pagingVO = new PagingVO<>(5, 5);
		pagingVO.setMemId(memberVO.getMemId());
		
		// 삭제 후 상태유지
		try {
			copyModelAttributeToDest(searchDetail, model, "searchDetail");
		} catch (IllegalAccessException | InvocationTargetException e) {
			logger.info(e.getMessage());
		}
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = pushMsgService.retrievePushMsgCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<PushMessageVO> dataList = pushMsgService.retrievePushMsgList(pagingVO);
		pagingVO.setDataList(dataList);
		
		CustomPaginationInfo<PushMessageVO> pagination = new CustomPaginationInfo<>(pagingVO);
		model.addAttribute("pagination", pagination);
		
		return "member/mypage/userMessageBox";
	}

	@RequestMapping(value="/member/mySetting", method=RequestMethod.GET)
	public String getMyInfoSetting(@AuthenticationPrincipal(expression = "realMember") MemberVO memberVO, Model model) {
		MemberVO selectedMember = userMemberService.retrieveMember(memberVO);
		model.addAttribute("memberVO", selectedMember);
		
		return "member/mypage/userInfoSetting";
	}
	
	/**
	 * 현재 비밀번호와 같은지 비교해 본인 인증
	 * @param pass
	 * @param member
	 * @return
	 */
	@RequestMapping(value="/member/passCheck", method=RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String setCheckPass(@RequestParam("pwd") String pass, 
								Authentication member) throws UnsupportedEncodingException {
		ServiceResult result = null;
		
		try {
		// 아이디와 패스워드로, Security 가 알아 볼 수 있는 token 객체로 변경한다.
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(member.getName(), pass);
        logger.info("[1.접속중인 아이디] :" + member.getName());
        logger.info("[1.접속중인 비밀번호와 비교] :" + pass);
		// AuthenticationManager 에 token 을 넘기면 UserDetailsService 가 받아 처리하도록 한다.
		Authentication authentication = authenticationManager.authenticate(token);
		
		// 실제 SecurityContext 에 authentication 정보를 등록한다.
		SecurityContextHolder.getContext().setAuthentication(authentication);
		result = ServiceResult.OK;
		logger.info("본인 확인 OK");
		} catch(Exception e) {
			result = ServiceResult.FAILED;
			logger.info("본인 확인 실패 FAILED");
		}
		return result.name();
	}
	
	/**
	 * 새 패스워드가 기존 비밀번호와 다른지 비교
	 * @param pass
	 * @param member
	 * @return
	 */	
	@RequestMapping(value="/member/setPassCheck", method=RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String idCheck(@RequestParam("newPwd") String pass,
						  @AuthenticationPrincipal(expression="realMember") MemberVO member) {
		ServiceResult result = null;
		logger.info("비밀번호 비교");
		
	      if (passwordEncoder.matches(pass, member.getMemPass())) {
	          result = ServiceResult.FAILED;
	          logger.info("[2.현재 비밀번호와 같음 FAILED]");         
	       } else {
	          result = ServiceResult.OK;
	          logger.info("[2.현재 비밀번호와 다름 OK]");
	       }
	       return result.name();
	}
	
	/**
	 * 패스워드 변경
	 * @param mem_pass
	 * @param member
	 * @return
	 */
	@RequestMapping(value="/member/updatePass", method=RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String myPassUpdate(@RequestParam("memPass") String memPass,
			@AuthenticationPrincipal(expression="realMember") MemberVO member) {
		
		member.setMemPass(memPass);
		
		ServiceResult result = userMemberService.memberModifyPassword(member);
		
		return result.name();
	}
	
	@RequestMapping(value="/member/updateImg", method=RequestMethod.POST)
	@ResponseBody
	public String myImageUpdate(@AuthenticationPrincipal(expression="realMember") MemberVO member, @RequestParam("memImg") MultipartFile memImg) {
		
		ServiceResult result = userMemberService.memberImgUpdate(member, memImg);
		
		return result.name();
	}
	
	@RequestMapping(value="/member/noPagingMemberList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getNoPagingMemberList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, MemberVO searchDetail
			, SearchVO searchVO
			, SortVO sortVO
			, Model model) 
	{
		PagingVO<MemberVO> pagingVO = new PagingVO<>(Integer.MAX_VALUE, 5);
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
		
		return "jsonView";
	}
}







