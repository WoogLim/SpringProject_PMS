package kr.or.ddit.projects.board.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.projects.file.vo.AttatchVO;
import kr.or.ddit.projects.member.vo.MemberVO;
import kr.or.ddit.projects.reply.vo.ReplyVO;
import kr.or.ddit.validate.groups.DeleteGroup;
import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @author 전수빈
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      작성자명       	최초작성
 * 2021. 2. 1.		전수빈		historyUri 변수 추가
 * 2021. 2. 2.		김근호		attatchVO 관련 변수 추가
 * 2021. 2. 5.      이선엽                validation 검증 위한 어노테이션 내용 수정
 * 2021. 2. 6.      이선엽                게시판 댓글 용 replyList 추가
 * 2021. 3. 3.		이선엽 		일일업무보고 양식용 wrFormNo, wrForm 추가
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
@Data
@EqualsAndHashCode(of = "boardNo")
@ToString(exclude = { "boardFiles", "attatchList", "replyList" })
public class BoardVO implements Serializable {
	@NotNull(groups = { UpdateGroup.class, DeleteGroup.class })
	@Min(0)
	private Integer boardNo; // 게시판 번호

	@NotBlank(groups = { InsertGroup.class, UpdateGroup.class }, message = "제목은 필수 입력 사항입니다.")
	@Size(max = 200)
	private String boardTitle; // 게시판 제목

	@Size(max = 4000)
	private String boardContent; // 게시판 내용

	@Size(max = 15)
	private String boardWriter; // 게시판 작성자

	@Size(max = 1)
	private String boardShow; // 게시판 공개 여부

	@Size(max = 10)
	private String createDate; // 게시판 생성 날짜

	@Size(max = 10)
	private String modifyDate; // 게시판 수정 날짜

//	@NotBlank(message = "프로젝트는 필수 입력 사항입니다.")
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@Size(max = 15)
	private String groupCode; // 그룹코드

	private Integer code; // 코드

	private Integer rnum;

	private int[] delAttNos;

	private transient List<MultipartFile> boardFiles;

	public void setBoardFiles(List<MultipartFile> boardFiles) {
		if (boardFiles == null || boardFiles.size() == 0)
			return;
		this.boardFiles = boardFiles;
		this.attatchList = new ArrayList<>();
		for (MultipartFile tmp : boardFiles) {
			if (StringUtils.isBlank(tmp.getOriginalFilename()))
				continue;
			attatchList.add(new AttatchVO(tmp));
		}
	}

	private transient List<AttatchVO> attatchList;

	private transient List<ReplyVO> replyList;

	private int attNo;
	
	private MemberVO memberVO;
	
	private int wrFormNo;
	private String wrForm;
}