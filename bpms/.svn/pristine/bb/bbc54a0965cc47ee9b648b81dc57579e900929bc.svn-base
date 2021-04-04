package kr.or.ddit.projects.scm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepository;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.scm.service.SvnService;
import kr.or.ddit.projects.scm.vo.ScmVO;
import kr.or.ddit.vo.PagingVO;

@Controller
public class SvnController extends BaseController{

	@RequestMapping("/scm/scmForm.do")
	public String scmForm(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, String proId
	) {
		ScmVO scmVO = new ScmVO();
		scmVO.setMemId(authMember.getMemId());
		scmVO.setProId(proId);
		String goPage = "scm/scmRegist";
		if(scmService.retrieveScm(scmVO) != null) {
			goPage = "scm/";
		}
		return "scm/scmRegist";
	}
	
	@RequestMapping("/scm/scmInsert.do")
	public String scmCreate(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, String proId
		, ScmVO scmVO
		, Model model
	){
		
		ServiceResult result = scmService.createScm(scmVO);
		switch(result) {
		case OK:
			break;
		
		}
		
		return "scm/scmRegist";
	}
	
	@RequestMapping("/scm/scmView.do")
	public String logView(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="page", required=true, defaultValue="1")int currentPage
		, String proId
		, ScmVO scmVO
		, Model model
	) throws SVNException, ParseException {
		PagingVO<ScmVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(scmVO);
		pagingVO.setCurrentPage(currentPage);
		
		List<ScmVO> logList = svnService.retrieveSvnLogList(scmVO);
		pagingVO.setDataList(logList);
		
		int totalRecord = logList.size();
		pagingVO.setTotalRecord(totalRecord);
	
		Set<String> providerList = svnService.retrieveProviderList(scmVO);
		
		model.addAttribute("providerList", providerList);
		model.addAttribute("pagingVO", pagingVO);
		return "scm/scmView";
	}
	
	@RequestMapping("/scm/scmChart.do")
	public String graphView(ScmVO scmVO, Model model) throws SVNException, ParseException {
		Map<String, Integer> providerChartMap = svnService.retrieveByProviderToLogCount(scmVO);
		Map<Integer, Integer> monthChartMap = svnService.retrieveByMonthToLogCount(scmVO);
	
		model.addAttribute("scmVO", scmVO);
		model.addAttribute("providerChartMap", providerChartMap);
		model.addAttribute("monthChartMap", monthChartMap);
		return "scm/scmAuthorView";
	}
	
	@RequestMapping(value="/scm/svnFancyTree.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ScmVO> ajaxSVNFancyTree(ScmVO scmVO) throws SVNException {
		DAVRepository svnRepo = svnService.getConnectDAVRepository(scmVO);
		svnRepo.setAuthenticationManager(svnService.getSVNAuthenticationManager(scmVO));
//		model.addAttribute("children", listEntries(svnRepo, scmVO));
		return listEntries(svnRepo, scmVO);
	}
	
	public List<ScmVO> listEntries(DAVRepository svnRepo, ScmVO scmVO) throws SVNException {
		List<ScmVO> nodeList = new ArrayList<>();
		String path = scmVO.getPath();
		if(StringUtils.isBlank(path)) {
			path = "";
		}
		List<SVNDirEntry> svnDirList = (List<SVNDirEntry>) svnRepo.getDir(path, -1, null, (Collection) null);
		for (SVNDirEntry svnDir : svnDirList) {
			ScmVO node = new ScmVO();
			// fancytree key
			node.setPath((path + svnDir.getName() + "/").trim());
			// fancytree title
			node.setPathName(svnDir.getName().trim());
			// tooltip
			node.setMessage(svnDir.getCommitMessage());
			// parent
			node.setParentPath(path.trim());
			// file check
			node.setFile(svnDir.getKind() == SVNNodeKind.FILE);
			nodeList.add(node);
		}
		return nodeList;
	}
}