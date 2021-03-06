package kr.or.ddit.projects.history.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.history.vo.HistoryVO;
import kr.or.ddit.projects.issue.vo.IssueVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.CustomPaginationInfo;
import kr.or.ddit.vo.PagingVO;

@Controller
public class HistoryController extends BaseController {

	// 검색 날짜 필터에 값이 없다면 현재 날짜를 기준으로 7일간의 기록을 검색해야 함.
	private void addSearchFilterInit(HistoryVO history) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 마지막 날짜
		String searchEndDate = sdf.format(cal.getTime());
		cal.add(Calendar.DATE, -7);
		// 시작 날짜
		String searchStartDate = sdf.format(cal.getTime());
		history.setSearchEndDate(searchEndDate);
		history.setSearchStartDate(searchStartDate);
	}
	
	@GetMapping("history/historyList.do")
	public String HistoryList(
		@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
		, @AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, HistoryVO historyVO
		, Model model
	) {
		
		String startDate = historyVO.getSearchStartDate();
		String endDate = historyVO.getSearchEndDate();
		
		if(StringUtils.isBlank(startDate) || StringUtils.isBlank(endDate)) {
			addSearchFilterInit(historyVO);
		}
		
		PagingVO<HistoryVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(historyVO);
		
		String memId = authMember.getMemId();
		pagingVO.setMemId(memId);

		int totalRecord = historyService.selectHistoryListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<HistoryVO> historyList = historyService.selectHistoryList(pagingVO);
		pagingVO.setDataList(historyList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "history/historyList";
	}
	
	@RequestMapping(value="/history/historyList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String historyListForAjax(
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			, @AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, HistoryVO historyVO
			, Model model) 
	{
		HistoryList(currentPage, authMember, historyVO, model);
		return "jsonView";
	}
}
