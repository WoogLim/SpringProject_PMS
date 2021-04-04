package kr.or.ddit.projects.reply.controller;

import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.reply.vo.ReplyVO;

@Controller
public class ReplyInsertController extends BaseController {

	@RequestMapping(value = "/reply/replyInsert.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, ServiceResult> insert(@ModelAttribute("reply") ReplyVO replyVO, HttpServletResponse resp) {
		ServiceResult result = replyService.createReply(replyVO);
		Map<String, ServiceResult> resultMap = Collections.singletonMap("result", result);
		return resultMap;
	}
}
