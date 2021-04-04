package kr.or.ddit.projects.scm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.kohsuke.github.GHCommit;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GHTree;
import org.kohsuke.github.GHTreeEntry;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.scm.vo.ScmVO;
import kr.or.ddit.vo.PagingVO;

@Controller
public class GitController extends BaseController {
	GitHub github;
	GHRepository repository;
	
	String scmId = "shinkwang95";
	String scmPass = "godjinni23$";
	String gitRepository = "KOR-SHIN/KOR-SHIN";
	
	@RequestMapping("/scm/gitView.do")
	public String gitCommitList(
			@RequestParam(value="page", required=true, defaultValue="1")int currentPage,
			@ModelAttribute("scmVO") ScmVO scmVO, Model model
			) throws IOException{
		PagingVO<ScmVO> pagingVO = new PagingVO<>();
		List<ScmVO> gitList = new ArrayList<>();
		
		String sha = null;
		String shortSha = null;
		
		github = new GitHubBuilder().withPassword(scmId, scmPass).build();
		repository = github.getRepository(gitRepository);
		List<GHCommit> commitList = repository.listCommits().toList();
		for(GHCommit commits : commitList) {
			sha = commits.getSHA1();
			ScmVO gitVO = new ScmVO();
			shortSha = sha.substring(0, 7);

			gitVO.setShortSha(shortSha);
			gitVO.setAuthor(commits.getCommitShortInfo().getAuthor().getName());
			gitVO.setMessage(commits.getCommitShortInfo().getMessage());
			gitVO.setDate(commits.getCommitShortInfo().getCommitDate());
			gitList.add(gitVO);
		}
		
		pagingVO.setDataList(gitList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "scm/gitView";
	}
	
	@RequestMapping("/scm/gitTree.do")
	public String gitTree(
			@ModelAttribute("scmVO") ScmVO scmVO, Model model
			) throws IOException {
		github = new GitHubBuilder().withPassword(scmId, scmPass).build();
		repository = github.getRepository(gitRepository);
		
		GHTree tree;
		String sha = scmVO.getSha();
		tree = repository.getTree(sha);
		List<GHTreeEntry> trees =  tree.getTree();
		String newPath = trees.get(0).getPath();		//webStrudy01
		
		GHTree treeEntry = tree.getEntry(newPath).asTree();
		for(GHTreeEntry sub : treeEntry.getTree()) {		//(--)
			System.out.println("--" + sub.getPath());
			String ty = sub.getType();
			
			if(ty.equals("tree")) {
				GHTree treeEntryy = sub.asTree();
				//"forder":true,"children":[]
			}
		}
		return "";
	}
	
}
