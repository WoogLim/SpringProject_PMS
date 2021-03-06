package kr.or.ddit.projects.role.controller;

import java.util.List;

import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.security.vo.AuthorityVO;
import kr.or.ddit.security.vo.ResourceVO;
import kr.or.ddit.vo.NotyMessageVO;

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
public class RoleController extends BaseController {

	// 등록된 권한 
	@RequestMapping(value = "/admin/role/roleListView.do", method = RequestMethod.GET)
	public String getRoleList(Model model) {
		List<AuthorityVO> authorities = securityService.retrieveAllAuthorities();
		model.addAttribute("authorities", authorities);
		return "admin/role/roleListView";
	}

	// 권한 INSERT FORM 이동
	@RequestMapping(value="/admin/role/insert.do", method=RequestMethod.GET)
	public String insertFormView(AuthorityVO authority, Model model) {
		List<AuthorityVO> authorities = securityService.retrieveAllAuthorities();
		model.addAttribute("authorities", authorities);
		List<ResourceVO> resourceList = securityService.retrieveAllResources();
		model.addAttribute("resourceList", resourceList);
		
		if(authority != null && StringUtils.isNotBlank(authority.getAuthority())) {
			AuthorityVO selectedAuthority = securityService.retrieveAuthority(authority);
			model.addAttribute("selectedAuthority", selectedAuthority);
		}
		
		return "admin/role/roleFormView";
	}
	
	// 권한 INSERT
	@RequestMapping(value="/admin/role/insert.do", method=RequestMethod.POST)
	public String createRole(AuthorityVO authority, Model model) {
		String goPage = "redirect:/admin/role/roleListView.do";
		
		return goPage;
		
	}
	
	// 권한 별 기능 JSON
	@RequestMapping(value="/admin/role/roleAuthority.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getResourcesForAuthority(AuthorityVO authority, Model model) {
		List<ResourceVO> resourceList = securityService.retrieveResourceListForAuthority(authority);
		model.addAttribute("resourceList", resourceList);
		return "jsonView";
	}

	// 권한 Update Form 이동
	@RequestMapping(value="/admin/role/update.do", method=RequestMethod.GET)
	public String updateView(AuthorityVO authority, Model model) {
		insertFormView(authority, model);
		return "admin/role/roleUpdateFormView";
	}
	
	// 권한 Update
	@RequestMapping(value="/admin/role/update.do", method=RequestMethod.POST)
	public String updateRole(
			@Valid AuthorityVO roleVO
			, Errors errors
			, RedirectAttributes redirectAtts) 
	{
		String goPage = "redirect:/admin/role/update.do?authority=" + roleVO.getAuthority();
		NotyMessageVO message = SUCCESS_UPDATE_AUTHORITY;
		if (!errors.hasErrors()) {
			ServiceResult result = securityService.updateResourceRole(roleVO);
			if (!ServiceResult.OK.equals(result)) {
				message = EXCEPTION_MESSAGE_FOR_CLIENT;
			}
		} else {
			message = EXIST_USE_AUTHORITY;
		}
		redirectAtts.addFlashAttribute("message", message);
		return goPage;
	}
	
	// 권한 DELETE
	@RequestMapping(value="/admin/role/delete.do", method=RequestMethod.POST)
	public String deleteRole(AuthorityVO authorityVO, RedirectAttributes redirectAtts) {
		String goPage = "redirect:/admin/role/roleListView.do";
		NotyMessageVO message = SUCCESS_REMOVE_AUTHORITY;
		try {
			ServiceResult removeResult = securityService.removeAuthority(authorityVO);
			switch (removeResult) {
			case FAILED: // 실패
				message = EXCEPTION_MESSAGE_FOR_CLIENT;
				break;

			case INUSE: // 사용중인 권한
				message = EXIST_USE_AUTHORITY;
				break;
			
			case EXIST_PARENT_ROLE: // 하위권한이 존재
				message = EXIST_PARENT_ROLE_AUTHORITY;
				break;
				
			case EXIST_ASSIGNED_RESOURCE: // 삭제대상 권한에 보호자원이 할당되어 있음
				message = EXIST_ASSIGNED_RESOURCE_AUTHORITY;
				break;
				
			default:
				// 성공
				break;
			}
		} catch(DataAccessException | CustomException e) {
			message = EXCEPTION_MESSAGE_FOR_CLIENT;
		}
		redirectAtts.addFlashAttribute("message", message);
		return goPage;
		
	}
	
}
