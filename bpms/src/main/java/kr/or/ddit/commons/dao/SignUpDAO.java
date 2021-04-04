/**
 * @author 작성자명
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * ------------------------------------------
 * 2021. 2. 1.      이선엽               최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.commons.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.member.vo.MemberVO;

@Repository
public interface SignUpDAO {
	public int insertMember(MemberVO memberVO);

	public int idCheck(MemberVO memberVO);
}
