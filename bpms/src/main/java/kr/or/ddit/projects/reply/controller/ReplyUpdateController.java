package kr.or.ddit.projects.reply.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.reply.vo.ReplyVO;

@Controller
public class ReplyUpdateController extends BaseController {
	@RequestMapping(value = "/reply/replyUpdate.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> update(@ModelAttribute("reply") ReplyVO reply, HttpServletResponse resp)
			throws ServletException, IOException {
		ServiceResult result = replyService.modifyReply(reply);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", result);
		return resultMap;
	}
}
