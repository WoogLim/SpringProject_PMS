package kr.or.ddit.projects.member.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.projects.project.vo.ProjectVO;
import kr.or.ddit.projects.pushmsg.vo.PushMessageVO;
import kr.or.ddit.security.vo.AuthorityVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@ToString(exclude = "memPass")
@EqualsAndHashCode(of = "memId")
@Data
public class MemberVO implements Serializable {
	@NotBlank
	@Size(max = 15)
	private String memId; // 회원 아이디
	
	@NotBlank
	@Size(max = 200)
	private String memPass; // 회원 패스워드
	
	@NotBlank
	@Size(max = 50)
	private String memName; // 회원명
	
	@NotBlank
	@Size(max = 50)
	private String memMail; // 회원 메일
	
	@NotBlank
	@Size(max = 30)
	private String memHp; // 회원 핸드폰 번호
	
	@Size(max = 10)
	private String createDate; // 생성 날짜
	
	@Size(max = 10)
	private String modifyDate; // 수정 날짜
	
	@Size(max = 1)
	private String memAlive; // 회원 활성화 상태
	
	@Size(max = 1)
	private String memDelete; // 회원 탈퇴 여부
	
	@Size(max = 1)
	private String adminRole; // 관리자 여부

	@Size(max = 400)
	private String memImg; // 회원 프로필 이미지(MetaData)
	
	private List<AuthorityVO> authorities; // 한 사람은 여러 권한을 가질 수 있음
	private String currentAuthority;
	private String memRole; // 한 사람은 하나의 Role을 가짐
	private List<ProjectVO> projectList; // 소속 프로젝트 리스트를 받기위한 변수
	private List<PushMessageVO> pushMsgList; // 회원이 받은 푸시메시지
	private Integer unConfirmedPushMsgCount; // 회원이 확인하지 않은 푸시메시지 개수
	
	private MultipartFile memImage;
	public void setMem_image(MultipartFile memImage) {
		if(memImage!=null && !memImage.isEmpty() ) {
			this.memImage = memImage;
			this.memImg = UUID.randomUUID().toString();
		}
	}
   
    public void saveTo(File saveFolder) throws IOException {
    	if(memImage!=null) {
    		memImage.transferTo(new File(saveFolder, memImg));
    	}
    }

}
