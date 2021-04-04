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
public class ReplyDeleteController extends BaseController{
	@RequestMapping(value="/reply/replyDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@ModelAttribute("reply") ReplyVO reply,
			HttpServletResponse resp) throws ServletException, IOException {
		ServiceResult result = replyService.removeReply(reply);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", result);
		return resultMap;
	}
}
