package kr.or.ddit.projects.chat.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.base.service.BaseService;
import kr.or.ddit.projects.chat.service.ChatService;
import kr.or.ddit.projects.chat.vo.ChatRoomVO;
import kr.or.ddit.projects.chat.vo.MessageVO;
import kr.or.ddit.projects.project.vo.ProjectVO;

@Service
public class ChatServiceImpl extends BaseService implements ChatService {
//	public List<MessageVO> retrieveChatList(MessageVO messageVO) {
//		List<MessageVO> list = chatDAO.selectChatList(messageVO);
//		return list;
//	}

	@Override
	public int insertChat(MessageVO messageVO) {
		return chatDAO.insertChat(messageVO);
	}

	@Override
	public ChatRoomVO retrieveChatHistory(ChatRoomVO chatRoomVO) {
		return chatDAO.selectChatHistory(chatRoomVO);
	}

	@Override
	public void createChatRoom(ProjectVO projectVO) throws DataAccessException, CustomException {
		int sqlRes = chatDAO.insertChatRoom(projectVO);
		if(sqlRes < 0) throw new CustomException();
	}

	@Override
	public void createChatMemberList(ProjectVO projectVO) throws DataAccessException, CustomException {
		int sqlRes = chatDAO.insertChatMemberList(projectVO);
		if(sqlRes < projectVO.getProMemberList().size()) throw new CustomException();
	}

	/* (non-Javadoc)
	 * @see kr.or.ddit.projects.chat.service.ChatService#retrieveChatRoomList(java.lang.String)
	 */
	@Override
	public List<ChatRoomVO> retrieveChatRoomList(String memId) {
		return chatDAO.selectChatRoomList(memId);
	}

	/* (non-Javadoc)
	 * @see kr.or.ddit.projects.chat.service.ChatService#retrieveRecentMessage(java.lang.String)
	 */
	@Override
	public List<MessageVO> retrieveRecentMessage(String memId) {
		return chatDAO.selectRecentMessage(memId);
	}
}
