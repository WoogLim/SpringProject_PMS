package kr.or.ddit.projects.chat.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.projects.base.controller.BaseController;
import kr.or.ddit.projects.chat.vo.ChatRoomVO;
import kr.or.ddit.projects.chat.vo.MessageVO;
import kr.or.ddit.projects.member.vo.MemberVO;

@Controller
public class ChatController extends BaseController{
	
	@RequestMapping("/chat/chatList.do")
	public String chatRoomList(
			@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
			,@RequestParam String memId
			,ChatRoomVO chatRoomVO
			,Model model
			) {
		List<ChatRoomVO> selectChatRoomList = chatService.retrieveChatRoomList(memId);
		model.addAttribute("chatRoomList", selectChatRoomList);
		
		return "chat/chatList";
	}
	
	@RequestMapping(value="/chat/chatList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String chatRoomListByAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
			,@RequestParam String memId
			,ChatRoomVO chatRoomVO
			,Model model
			) {
		chatRoomList(memberVO, memId, chatRoomVO, model);
		return "jsonView";
	}
	
	@RequestMapping("/chat/chatView.do")
	public String chatRoomView(HttpSession session
							,@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
							,@RequestParam String proId
							,@RequestParam String chatRoomId
							,@RequestParam String memId
							,Model model
							,ChatRoomVO chatRoomVO
							) {
		
		session.setAttribute("memId", memberVO.getMemId());
		session.setAttribute("proId", proId);
		session.setAttribute("chatRoomId", chatRoomId);
		session.setAttribute("memName", memberVO.getMemName());
		
		ChatRoomVO chatList = chatService.retrieveChatHistory(chatRoomVO);
		
		model.addAttribute("chatList", chatList);
		
		return "chat/chatView";
	}
	
	@RequestMapping(value="/chat/chatView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String chatRoomViewByAjax(HttpSession session
			,@AuthenticationPrincipal(expression="realMember") MemberVO memberVO
			,@RequestParam String proId
			,@RequestParam String chatRoomId
			,@RequestParam String memId
			,Model model
			,MessageVO messageVO
			,ChatRoomVO chatRoomVO
			) {
		
		chatRoomView(session, memberVO, proId, chatRoomId, memId, model, chatRoomVO);
		return "jsonView";
	}
	
	@RequestMapping(value="/chat/chatInsert.do"
				  , method = RequestMethod.POST
				  , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int insertChat(@RequestBody MessageVO messageVO) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		Date time = new Date();
		messageVO.setCreateDate(format.format(time));
		int result = chatService.insertChat(messageVO);	
		return result;
	}
}
