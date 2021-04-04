package kr.or.ddit.projects.storage.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.storage.vo.StorageVO;

/**
 * @author 임건
 * @since 2021. 2. 4
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일            수정자           수정내용
 * ------------     --------    ----------------------
 * 2021. 3. 5.      임건          	최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Controller
public class StorageController extends BaseController {

	@RequestMapping(value="/storage/storageView.do", method=RequestMethod.GET)
	public String kanbanboardList(@AuthenticationPrincipal(expression="realMember") MemberVO member, Model model)
			throws JsonProcessingException {

		return "storage/projectStorage";
	}
	
	@RequestMapping(value="/storage/storageViewFiles.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> projectNoticeFiles(@ModelAttribute("storage") StorageVO storage, Model model){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		StorageVO storageVO = storageService.retrievProjectFiles(storage);
		
		resultMap.put("projectFiles", storageVO);
		return resultMap;
	}
	
}
