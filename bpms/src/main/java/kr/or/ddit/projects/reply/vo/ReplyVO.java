package kr.or.ddit.projects.reply.vo;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "replyNo")
@ToString(exclude = { "replyContent" })
public class ReplyVO {
	@NotNull
	@Min(0)
	private Integer replyNo; // 댓글 번호

	@NotBlank
	@Size(max = 20)
	private String replyTitle; // 댓글 제목

	@Size(max = 4000)
	private String replyContent; // 댓글 내용

	@NotBlank
	@Size(max = 200)
	private String replyPass; // 댓글 비밀번호

	@NotBlank
	@Size(max = 20)
	private String replyWriter; // 댓글 작성자

	@Size(max = 10)
	private String createDate; // 댓글 생성 날짜

	@Size(max = 10)
	private String modifyDate; // 댓글 수정 날짜

	@NotNull
	@Min(0)
	private Integer replyParent; // 상위 댓글 번호

	@NotNull
	@Min(0)
	private Integer boardNo; // 게시판 번호
	
	private Integer level;
	
	private List<ReplyVO> replyList;

	private Integer rnum;
}
