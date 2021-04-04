package kr.or.ddit.projects.storage.vo;

import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.ddit.projects.file.vo.AttatchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="proId")
@Data
public class StorageVO {
	
	@NotBlank
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@NotBlank
	@Size(max = 15)
	private String typeCode; // CODE

	@NotBlank
	@Size(max = 15)
	private String groupCode; // GROUP_CODE
	
	private List<AttatchVO> attatchList;
}
