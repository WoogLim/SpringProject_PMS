package kr.or.ddit.projects.scm.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString(exclude = { "scmNo", "scmPass" })
@EqualsAndHashCode(of= {"proId", "scmNo"})
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class ScmVO {
	
	private static final String MONTHSTARTDATEPATTERN = "%s-01-01";
	private static final String MONTHENDDATEPATTERN = "%s-12-31";
	
	// 날짜 필터를 위한 변수
	private Calendar cal = Calendar.getInstance();
	private SimpleDateFormat logRevisionDate = new SimpleDateFormat("yyyy-MM-dd");
	private final int defaultYear = cal.get(Calendar.YEAR);
	
	// 현재 사용자가 svn에 연동 되어 있는지 체크 하기 위한 컬럼들
	@NotBlank
	@Size(max = 15)
	private String proId; // 프로젝트 식별자

	@NotBlank
	@Size(max = 20)
	private Integer scmNo; // 저장소 번호

	@NotBlank
	@Size(max = 200)
	private String scmId; // 저장소 아이디

	@NotNull
	@Min(0)
	private String scmPass; // 저장소 패스워드
	
	@NotNull
	private String scmUrl; // 저장소 url

	@NotNull
	@Min(0)
	private Integer code; // 코드

	@NotBlank
	@Size(max = 10)
	private String groupCode; // 그룹코드

	@NotBlank
	@Size(max = 15)
	private String memId; // 등록한 회원 아이디
	
	// 기록 및 fancytree data를 담기 위한 컬럼들
	private long revision;	// 리비전 넘버
	
	@JsonProperty("key")
	private String path;
	
	@JsonProperty("title")
	private String pathName;
	
	@JsonProperty("parentId")
	private String parentPath;
	
	private String author; // 커밋 회원 아이디
	
	@JsonProperty("tooltip")
	private String message; // 커밋 기록 내용

	private String date; // 커밋 날짜
	
	public void setDate(Date date) {
		SimpleDateFormat logDateFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
		this.date = logDateFormat.format(date); 
	}
	
	public boolean file;
	public boolean isLazy() {
		return !file;
	}
	public boolean isFolder() {
		return !file;
	}
	
	// log 조회용 Date 컬럼
	private Date startRevisionDate;
	
	private Date endRevisionDate;
	
	public void setLogDate(String startDate, String endDate) throws ParseException {
		if(StringUtils.isNotBlank(startDate)) {
			this.startRevisionDate = logRevisionDate.parse(startDate);
		}
		if(StringUtils.isNotBlank(endDate)) {
			this.endRevisionDate = logRevisionDate.parse(endDate);
		}
	}
	
	// svn 로그 목록의 페이징 처리를 위한 변수
	private List<Long> startRowRevisionList;

	// filter 컬럼
	private String provider;	// 사용자
	
	private String userStartDate;	// 유저가 선택한 시작 날짜
	
	private String userEndDate;	// 유저가 선택한 마지막 날짜
	
	private String year;	// 유저가 선택한 년도

	private String monthStartDate;	// 유저가 선택한 년도의 시작 월 시작 날짜 : %s-01-01 
	
	private String monthEndDate; // 유저가 선택한 년도의 마지막 월 마지막 날짜 : %s-12-31
	
	public void setYear(String year) {
		if(StringUtils.isBlank(year)) {
			year = Integer.toString(this.defaultYear);
		}
		this.year = year;
		this.monthStartDate = String.format(MONTHSTARTDATEPATTERN, year);
		this.monthEndDate = String.format(MONTHENDDATEPATTERN, year);
	}
		
	//github 커밋 기록 필요 컬럼
	private String sha; // 깃허브 커밋 ID
	
	private String shortSha;
	
	private String gitRepository; // 깃허브 저장소
	
	private Integer commitCount; // 커밋 카운트
	
	private List<ScmVO> scmList;
}
