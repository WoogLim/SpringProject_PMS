package kr.or.ddit.projects.chat.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.chat.vo.ChatRoomVO;
import kr.or.ddit.projects.chat.vo.MessageVO;
import kr.or.ddit.projects.project.vo.ProjectVO;

@Repository
public interface ChatDAO {

	int insertChat(MessageVO messageVO);

	ChatRoomVO selectChatHistory(ChatRoomVO chatRoomVO);
	
	// 신광진 (2021. 02. 22 추가)
	/**
	 * 새로운 채팅방 등록
	 * @param projectVO
	 * @return
	 * <pre>
	 * 성공: 1
	 * 실패: 0
	 * </pre>
	 * @throws DataAccessException
	 */
	public int insertChatRoom(ProjectVO projectVO) throws DataAccessException;
	
	/**
	 * 파라미터로 받은 projectVO의 proMemberList를 이용하여 
	 * 채팅방 멤버 등록
	 * @param projectVO
	 * @return
	 * <pre>
	 * 성공: insert된 row 수 (return &gt; 0)
	 * 실패: 0 or return &lt; projectVO.proMemberList.size()
	 * </pre>
	 * @throws DataAccessException
	 */
	public int insertChatMemberList(ProjectVO projectVO) throws DataAccessException;

	/**
	 * @param memId
	 * @return
	 */
	public List<ChatRoomVO> selectChatRoomList(String memId);

	/**
	 * @param memId
	 * @return
	 */
	public List<MessageVO> selectRecentMessage(String memId);
}
