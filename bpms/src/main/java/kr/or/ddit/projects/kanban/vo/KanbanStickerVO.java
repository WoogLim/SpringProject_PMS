package kr.or.ddit.projects.kanban.vo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.validate.groups.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@ToString(exclude = "kstickerContent")
@EqualsAndHashCode(of = "kstickerId")
@Data
public class KanbanStickerVO implements Serializable {

	@Size(max = 15)
	private String kstickerId; // 스티커 번호

	@NotBlank(groups = { InsertGroup.class })
	@Size(max = 15)
	private String kstickerTitle; // 스티커 제목

	@Size(max = 4000)
	private String kstickerContent; // 내용

	@Size(max = 10)
	private String createDate; // 생성 날짜

	@Size(max = 10)
	private String modifyDate; // 수정 날짜

	@NotBlank(groups = { InsertGroup.class })
	@Size(max = 15)
	private String kboardId;

	private Integer kstickerSort; // 스티커 정렬 순번
}
