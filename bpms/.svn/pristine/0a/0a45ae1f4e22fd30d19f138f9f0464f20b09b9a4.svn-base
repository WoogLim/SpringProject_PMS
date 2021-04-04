package kr.or.ddit.projects.kanban.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "kboardId")
@Data
public class KanbanVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String kboardId; // 게시판 아이디

	@NotBlank
	@Size(max = 20)
	private String kboardTitle; // 제목

	@Size(max = 7)
	private String createDate; // 생성 날짜

	@Size(max = 7)
	private String modifyDate; // 수정 날짜

	@NotBlank
	@Size(max = 15)
	private String kstickerId; // 스티커 번호

	@NotBlank
	@Size(max = 15)
	private String memId; // 회원 아이디

	// 하나의 칸반보드에 여러개의 스티커가 포함될 수 있다.
	private List<KanbanStickerVO> stickerList;
}
