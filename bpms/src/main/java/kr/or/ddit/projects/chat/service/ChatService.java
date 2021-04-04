package kr.or.ddit.projects.chat.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import kr.or.ddit.exception.CustomException;
import kr.or.ddit.projects.chat.vo.ChatRoomVO;
import kr.or.ddit.projects.chat.vo.MessageVO;
import kr.or.ddit.projects.project.vo.ProjectVO;

public interface ChatService {

	public int insertChat(MessageVO message);


	public ChatRoomVO retrieveChatHistory(ChatRoomVO chatRoomVO);
	
	// 신광진 (2021. 02. 22 추가)
	/**
	 * 새로운 채팅방 등록
	 * @param projectVO
	 * @throws DataAccessException, CustomException
	 */
	public void createChatRoom(ProjectVO projectVO) throws DataAccessException, CustomException;
	
	/**
	 * 파라미터로 받은 projectVO의 proMemberList를 이용하여 
	 * 채팅방 멤버 등록
	 * @param projectVO
	 * @throws DataAccessException, CustomException
	 */
	public void createChatMemberList(ProjectVO projectVO) throws DataAccessException, CustomException;

	/**
	 * @param memId
	 * @return
	 */
	public List<ChatRoomVO> retrieveChatRoomList(String memId);


	/**
	 * @param memId
	 * @return
	 */
	public List<MessageVO> retrieveRecentMessage(String memId);
}
