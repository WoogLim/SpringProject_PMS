package kr.or.ddit.projects.file.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.UUID;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.io.FileUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.validate.groups.DeleteGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * ATTATCH
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(of = "attNo")
@ToString(exclude = "realFile")
public class AttatchVO implements Serializable {

	public AttatchVO(MultipartFile realFile) {
		this.realFile = realFile;
		this.attSavename = UUID.randomUUID().toString();
		this.attOriginname = realFile.getOriginalFilename();
		this.attMime = realFile.getContentType();
		this.attFilesize = realFile.getSize();
		this.attFancy = FileUtils.byteCountToDisplaySize(attFilesize);
	}

	private transient MultipartFile realFile;

	public void saveTo(File saveFolder) throws IOException {
		if (realFile != null) {
			realFile.transferTo(new File(saveFolder, attSavename));
		}
	}

	@NotNull
	@Min(0)
	private Integer attNo;

	@NotBlank
	@Size(max = 30)
	private String attOriginname;

	@NotBlank
	@Size(max = 200)
	private String attSavename;

	@NotBlank
	@Size(max = 50)
	private String attMime;

	@NotNull
	@Min(0)
	private long attFilesize;

	@NotBlank
	@Size(max = 20)
	private String attFancy;

	@NotNull
	@Min(0)
	private Integer attDowncount;

	@Size(max = 7)
	private String createDate;

	private Integer boardNo;
}
