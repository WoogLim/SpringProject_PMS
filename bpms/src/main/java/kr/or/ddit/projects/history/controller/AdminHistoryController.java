package kr.or.ddit.projects.history.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.vo.CustomInfoVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SortVO;

/**
 * @author 신광진
 * @since 2021. 2. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일       	수정자           수정내용
 * ------------    --------    ----------------------
 * 2021. 2. 13.     신광진           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class AdminHistoryController extends BaseController {
	
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

	@RequestMapping(value="/admin/history/historyList.do", method=RequestMethod.GET)
	public String HistoryList(
		@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage
		, HistoryVO searchDetail
		, Model model
	) {
		String startDate = searchDetail.getSearchStartDate();
		String endDate = searchDetail.getSearchEndDate();
		
		if(StringUtils.isBlank(startDate) || StringUtils.isBlank(endDate)) {
			addSearchFilterInit(searchDetail);
		}
		
		PagingVO<HistoryVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = adminHistoryService.retrieveHistoryListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<HistoryVO> historyList = adminHistoryService.retrieveHistoryList(pagingVO);
		pagingVO.setDataList(historyList);
		
		model.addAttribute("pagingVO", pagingVO);
		return null; // URL지정해주자
	}

	@RequestMapping(value = "/admin/history/historyList.do", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getHistoryListForAjax(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage
			, HistoryVO searchDetail
			, Model model)
	{
		HistoryList(currentPage, searchDetail, model);
		return "jsonView";
	}

}
