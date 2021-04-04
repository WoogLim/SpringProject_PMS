package kr.or.ddit.projects.file.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enumpkg.Browser;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.board.vo.BoardVO;
import kr.or.ddit.projects.file.vo.AttatchVO;

@Controller
public class FileDownloadController extends BaseController {

	@RequestMapping(value = "/board/download.do")
	public String download(@RequestParam(value = "attNo") int attNo,
			@RequestHeader(value = "User-Agent", required = false) String agent, Model model) {
		Browser browser = Browser.getBrowserConstant(agent);
		AttatchVO attatch = fileService.download(attNo);
		model.addAttribute("attatch", attatch);

		return "downloadView";
	}

}
