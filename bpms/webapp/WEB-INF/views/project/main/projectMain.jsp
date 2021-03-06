<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------    -------- -----------------
* 2021. 2. 15.	임건			최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
span#workCntSpan:hover {
	cursor: pointer;
}

span#issueCntSpan:hover {
	cursor: pointer;
}

</style>
<div class="page-inner">
	<div class="dashboard-header">
		<security:authentication property="principal" var="principal"/>
		<c:set value="${principal.realMember }" var="realMember"/>
		
		<%-- 프로젝트 명 --%>
		<div class="project-name">${dashBoardVO.proName }</div>
		
		<c:if test="${dashBoardVO.codeName eq '완료' }">
			<%-- 프로젝트 진행 상태 --%>
			<button class="projectactive-status no-drag" data-toggle="modal" data-target="#set__statuschange" data-status="complete">
				<img src="${pageContext.request.contextPath }/assets/img/dashboard/project-complete.png" alt=""> 
				<span>프로젝트 완료</span>
			</button>	
		</c:if>

		<c:if test="${dashBoardVO.codeName eq '진행' }">
			<%-- 프로젝트 진행 상태 --%>
			<button class="projectactive-status no-drag" data-toggle="modal" data-target="#set__statuschange" data-status="progress">
				<img src="${pageContext.request.contextPath }/assets/img/dashboard/project-Active.svg" alt=""> 
				<span>프로젝트 진행중</span>
			</button>
		</c:if>

		<c:if test="${dashBoardVO.codeName eq '정지' }">
			<button class="projectinactive-status no-drag" data-toggle="modal" data-target="#set__statuschange" data-status="pause">
				<i class="fas fa-pause"></i>
				<span style="margin-left:5px;">프로젝트 정지</span>
			</button>
		</c:if>
		
		<%-- 프로젝트 진척도 100%인 경우 요청가능 --%>
		<c:if test="${not (dashBoardVO.codeName eq '완료') and (dashBoardVO.proProgress eq 100) and (dashBoardVO.codeName ne '정지')}">
			<button class="projectactive-status no-drag" data-toggle="modal" data-target="#set__statuschange" style="background-color: #4CAF50" data-status="completeRequest">
				<i class="fas fa-check"></i>
				<span style="margin-left:5px;">프로젝트 완료하기</span>
			</button>
		</c:if>
	</div>

	<%-- 대쉬보드 상위 카드 --%>
	<div class="dashboard-cardbox">
		<div class="simpleinfo-card">
			<div class="dashcard-container">
				<%-- 총 일감 --%>
				<span class="dashcard-title"> 총 일감 </span> 
				<%-- 총 일감 갯수 --%>
				<span class="dashcard-content dashcard-count" id="workCntSpan">${dashBoardVO.workCnt }</span>
			</div>
		</div>

		<div class="simpleinfo-card">
			<div class="dashcard-container">
				<%-- 총 이슈 --%>
				<span class="dashcard-title"> 총 이슈 </span> 
				<%-- 총 이슈 갯수 --%>
				<span class="dashcard-content dashcard-count" id="issueCntSpan">${dashBoardVO.issueCnt }</span>
			</div>
		</div>

		<div class="simpleinfo-card">
			<div class="dashcard-container">
				<%-- 총 완료 작업 --%>
				<span class="dashcard-title"> 완료 작업 </span>
				<%-- 총 완료 작업 갯수 --%>
				<span class="dashcard-content dashcard-count">${dashBoardVO.completeWorkCnt }</span>
			</div>
		</div>

		<div class="simpleinfo-card">
			<div class="dashcard-container">
				<%-- 진척도 --%>
				<span class="dashcard-title">진척도</span>
				<%-- 일감/총 일감 갯수 * 100 --%>
				<span class="dashcard-content dashcard-percent">${dashBoardVO.proProgress }</span>
			</div>
		</div>

		<div class="simpleinfo-card">
			<div class="dashcard-container">
				<%-- 프로젝트 경과일 --%>
				<span class="dashcard-title">프로젝트 경과</span>
				<%-- 프로젝트 시작일로부터 +일 --%>
				<span class="dashcard-content dashcard-day">${dashBoardVO.proElapsedDate }</span>
			</div>
		</div>
	</div>

	<%-- 프로젝트 진척도 그래프 --%>
	<div class="dashboard-contentbox">
		<div class="dashboard-projectwork">

			<div class="project-prograss">
				<div class="dashwork-title">
					<%-- 프로젝트 진척도 그래프 --%>
					<span class="dashcard-title">프로젝트 진척도</span> 
					<%-- 프로젝트 경과일 --%>
					<span class="dashcard-title dashboard-date"></span>
				</div>
				<div class="projectwork-calendar">
					<canvas id="dashboard-calendar">
						<%-- 프로젝트 진척도 그래프 --%>
					</canvas>
					<div class="project-attainment no-drag">
						<span class="attainment-prograss">
							<%-- 프로젝트 진척도 --%>
							<span class="prograss-value">${dashBoardVO.proProgress }</span>
						</span> 
						<span class="project-totalwork"> 
							<%-- 프로젝트 일감 총 개수 --%>
							<span class="prograss-value">${dashBoardVO.workCnt }</span>
						</span> 
						<span class="project-donework"> 
							<%-- 프로젝트 완료 일감 --%>
							<span class="prograss-value">${dashBoardVO.completeWorkCnt }</span>
						</span>
					</div>
				</div>
			</div>
		</div>
	
		<%-- 프로젝트 구성원 --%>
		<div class="dashboard-projectinfo">
			<div class="dashboard-memberList">
				<div class="dashwork-title">
					<span class="dashcard-title"> 프로젝트 구성원 </span>
				</div>
				<div class="project-memberrole">
					<ul class="dashproject-memberlist">

						<c:if test="${not empty roleNameList }">
							<c:forEach items="${roleNameList }" var="authVO">
							
								<c:if test="${not empty proMemberList }">
									<%-- break효과를 주기위한 flag --%>
									<c:set value="true" var="loopFlag"/> 
									<c:forEach items="${proMemberList }" var="proMemberVO" varStatus="status">
										<c:if test="${loopFlag }">
										
											<%-- 같은 ROLE을 가진 사람이 한 명인 경우 --%>
											<c:if test="${authVO.roleCnt eq 1 and (authVO.roleName eq proMemberVO.roleName) }">
												<li class="projectrole-memberlist no-drag">
													<span class="projectrole-box"> 
														<i class="fas fa-circle"></i> 
														<span class="projectrole-name">${authVO.roleName }</span>
													</span>
													<div class="projectrole-player">
														<div class="avatar-sm" onclick="memberDetailView('${proMemberVO.memId}')">
															<c:if test="${proMemberVO.memImg eq null }">
																<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
																	class="avatar-img rounded-circle">
															</c:if>
															<c:if test="${proMemberVO.memImg ne null }">
																<img src="${pageContext.request.contextPath }/assets/img/profile/${proMemberVO.memImg }" alt="..."
																	class="avatar-img rounded-circle">
															</c:if>
														</div>
														<div class="notice-writername">${proMemberVO.memName }</div>
													</div>
												</li>
											</c:if>
										
											<%-- 같은 ROLE을 가진 사람이 여러명인 경우 --%>										
											<c:if test="${authVO.roleCnt gt 1 and (authVO.roleName eq proMemberVO.roleName) }">
												<li class="projectrole-memberlist no-drag">
													<span class="projectrole-box"> 
														<i class="fas fa-circle"></i>
														<span class="projectrole-name">${authVO.roleName }</span>
													</span>
													
													<c:set value="false" var="loopFlag"/>
													<c:set value="${authVO.roleName }" var="tmpRoleName"/>
													<div class="projectrole-player">
														<div class="avatar-group">
															<c:forEach items="${proMemberList }" var="tmpPromemberVO" begin="${status.index }">
																<c:if test="${tmpPromemberVO.roleName eq tmpRoleName }">
																	<div class="avatar pro-member" onclick="memberDetailView('${tmpPromemberVO.memId}')">
																		<c:if test="${tmpPromemberVO.memImg eq null }">
																			<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
																				class="avatar-img rounded-circle border border-white toggle-person">
																		</c:if>
																		<c:if test="${not tmpPromemberVO.memImg eq null }">
																			<img src="${pageContext.request.contextPath }/assets/img/profile/${tmpPromemberVO.memImg }" alt="..."
																				class="avatar-img rounded-circle border border-white toggle-person">
																		</c:if>
																		<p class="person-name" data-personid="">${tmpPromemberVO.memName }</p>
																	</div>
																</c:if>
															</c:forEach>
														</div>
													</div>
												</li>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
								
							</c:forEach>
						</c:if>
						<c:if test="${empty proMemberList }">
							<li><h4>프로젝트 팀원이 없습니다.</h4></li>
						</c:if>
					</ul>
				</div>
			</div>
			
			<%-- 프로젝트 공지사항 최근 2개만 보여줌 --%>
			<div class="dashboard-noticeList">
				<div class="dashwork-title">
					<span class="dashcard-title">공지사항</span>
				</div>
				<div class="dashcard-noticebox">
					<ul class="dashcard-noticelist">
						<li class="dashcard-noticechart"></li>
					</ul>
					<ul class="dashcard-noticeitemlist">
					
						<c:if test="${not empty projectNoticeList }">
							<c:forEach items="${projectNoticeList }" var="proNoticeVO">
								<li class="dashcard-noticeitem no-drag">
									<div class="dashnotice-title">
										<span>${proNoticeVO.boardTitle }</span>
										<i class="fas fa-circle"></i>
										<div class="noticeitem-writer">
<!-- 											작성자 프로필 이미지와 이름 -->
											<c:if test="${proNoticeVO.memberVO.memImg eq null}">
												<div class="avatar-sm">
													<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
														class="avatar-img rounded-circle">
												</div>
											</c:if>
											<c:if test="${proNoticeVO.memberVO.memImg ne null}">
												<div class="avatar-sm">
													<img src="${pageContext.request.contextPath }/assets/img/profile/${proNoticeVO.memberVO.memImg }" alt="..."
														class="avatar-img rounded-circle">
												</div>
											</c:if>
											<div class="notice-writername">${proNoticeVO.memberVO.memName }</div>
										</div>
									</div>
									<div class="noticeitem-content" data-boardno="${proNoticeVO.boardNo }" data-proid="${param.proId }">
										<div class="noticeitem-post">${proNoticeVO.boardContent }</div>
										<div class="wrote-date">${proNoticeVO.createDate }</div>
										<button class="dashnotice-navbtn" onclick="proNoticeDetailView($(this))">
											<span class="dashnotice-guide"> 자세히 보기 </span>
										</button>
									</div>
								</li>
							</c:forEach>
						</c:if>
						<c:if test="${empty projectNoticeList }">
							<li><h4>등록된 공지사항이 없습니다.</h4></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="set__statuschange">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">

			</div>
			<div class="modal-body">
				<div class="modal__header text-center"></div>
				<div class="text-center" id="messageView">

				</div>
				
				<br/>
				<div id="statusView" class="d-flex justify-content-center">
				</div>
				
				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#set__statuschange" id="cancelBtn">취소</button>
					<button type="button" class="form-confirm" id="requestBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<form id="progressForm" action="${pageContext.request.contextPath }/work/completeWorkList.do">
	<input type="hidden" name="proId" value="${projectVO.proId }"/>
</form>

<form id="projectCodeUpdateForm" action="${pageContext.request.contextPath }/project/codeUpdate.do" method="post">
	<input type="hidden" name="proId" value="${param.proId }">
	<input type="hidden" name="code">
</form>

<script type="text/javascript">
	$(function() {
		// 날짜 별 완료일감 현황
		let progressForm = $("#progressForm").ajaxForm({
			dataType: "json"
			, success: function(resp) {
				let completeWorkList = resp.completeWorkListInMonth;
				console.log(completeWorkList);
				
				let data = [];
				let labels = buildCalender(new Date());
				let max = 10;
				$(completeWorkList).each(function(idx, element) {
					let cnt = $(this)[0].completeWorkCnt;
					data.push(cnt);
					max = (max > cnt) ? max : cnt;
				});
				max = (max != 1 && max % 2 == 1) ? max + 1 : max; // 홀수면 y축 그리드가 깨짐
				renderChart(data, labels, max);
			}
			, error: function(xhr) {
				console.log(xhr.status);
			}
		}).submit();
		
		// 배경색 지정 위해 클래스 추가
		$('.main-panel').addClass('dashboard-panel')

		// 복수 구성원 프로필 hover시 이름 출력
		$('.toggle-person, .toggle-personlist').on('mouseover mouseleave',
				function() {
					$(this).siblings('.person-name').toggle();
				})

		// chart js에 사용
		// ex let today = new Date(2021,2,15) 2021년 2월 15일
		const ctx = document.getElementById("dashboard-calendar").getContext('2d');
		let today = new Date(); // 오늘 날짜
		let toyear = getformatYear(today);
		let tomonth = getformatMonth(today);

		$('.dashboard-date').text(toyear + "년 " + tomonth + "월 완료 작업 현황");

		function renderChart(data, labels, max) {
			let myChart = new Chart(ctx, {
				type : 'bar',
				data : {
					labels : labels, // 하단 라벨
					datasets : [ {
						label : '완료 작업 갯수',
						backgroundColor : "#1572e8", // 막대 배경색
						borderColor : "#1572e8", // 막대 테두리 생상
						data : data, // data 입력값
						xAxisId : "", // x축 ID
						yAxisId : "", // y축 ID
						borderWidth : 1, // 막대 테두리 너비
						hoverBackgroundColor : 'rgba(0, 0, 0, 0.5)', // 마우스 올릴때 그래프 색
						hoverBorderColor : 'rgba(0, 0, 0, 0.5)', // 마우스 올릴 때 테두리 컬러
					} ]
				},
				options : {
					scales:{
					    yAxes:[{
					        ticks:{
					            max: max
					        }
					    }]
					}
					, legend : {
						position : "top",
						align : "end"
					}
				}
			});
		}

		// 현재 기준으로 이전달
		function getbeforeMonth(date) {
			// 이전 달을 today에 저장. 달력에 today를 넣어준다.
			// today.getFullYear() 현재 년도 //today.getMonth() 월 //today.getDate 일
			// getMonth()는 현재 달을 받아 이전달을 출력하려면 -1 필요
			let beforeDay = new Date(date.getFullYear(), date.getMonth() - 1,
					date.getDate());
			return beforeDay;
		}

		//현재 기준으로 다음달
		function getnextMonth(date) {
			// 다음 달을 today에 값 저장하고 달력에 today를 넣어줌
			// today.getFullYear() : 현재 년도
			// getMonth() 현재 달에 다음달을 구하기 위해 +1
			let nextDay = new Date(date.getFullYear(), date.getMonth() + 1,
					date.getDate());
			return nextDay;
		}

		//현재 달의 일
		function buildCalender(date) {
			// 이번 달의 첫째날
			let firstDay = new Date(date.getFullYear(), date.getMonth(), 1);

			// 이번 달의 마지막 날
			let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);

			firstDay = getformatDay(firstDay);
			lastDay = getformatDay(lastDay);

			let day = [];
			let currentday = firstDay;

			for (let seq = 0; seq < lastDay; seq++) {
				day[seq] = (currentday + seq) + '';
			}

			return day;
		}

		// 날짜 포맷 YYYY MM DD
		function getformatDate(date) {
			let year = date.getFullYear(); // YYYY
			let month = (1 + date.getMonth()); // M
			month = month >= 10 ? month : '0' + month; // MM
			let day = date.getDate(); // D
			day = day >= 10 ? day : '0' + day; // DD
			return year + month + day;
		}

		// 날짜 포맷 DD
		function getformatDay(date) {
			let day = date.getDate(); // D
			// day = day >= 10 ? day : '0' + day; // DD
			return day;
		}

		// 날짜 포맷 MM
		function getformatMonth(date) {
			let month = (1 + date.getMonth()); // M
			// month = month >= 10 ? month : '0' + month; // MM
			return month;
		}

		// 날짜 포맷 YYYY
		function getformatYear(date) {
			let year = date.getFullYear() // YYYY
			return year;
		}

	})
	
	function proNoticeDetailView(input) {
		let dataDiv = $(input).parent();
		let boardNo = dataDiv.data("boardno");
		let proId = dataDiv.data("proid");
		location.href = $.getContextPath() + "/proNotice/proNoticeView.do?boardNo=" + boardNo + "&proId=" + proId;
	}

	function memberDetailView(memId) {
		console.log(memId);
	}

	// 총 일감 클릭 시 리스트 이동
	$("#workCntSpan").on("click", function(){
		location.href = $.getContextPath() + "/work/workList.do?proId=${param.proId}";
	});
	
	// 총 이슈 클릭 시 리스트 이동
	$("#issueCntSpan").on("click", function() {
		location.href = $.getContextPath() + "/issue/issueList.do?proId=${param.proId}";
	});
	
	let modal = $("#set__statuschange");
	$("div.dashboard-header button").on("click", function() {
		let status = $(this).data("status");
		let proName = $(this).siblings("div.project-name").text();
		
		let header = modal.find("div.modal__header");
		let headerText = $("<h4>");
		
		let messageView = modal.find("div#messageView");
		let message = $("<span>").addClass("errors");
		
		let clone = $(this).clone().prop("disabled", true);
		modal.find("div.modal-header").html(clone);
		switch(status) {
			case "progress":
				header.html(headerText.text("프로젝트를 정지요청 하시겠습니까?"));
				messageView.html(message.text("프로젝트가 정지되면 작업이 불가능합니다."));
				break;
			case "pause":
			case "complete":
				header.html(headerText.text("프로젝트 재진행 하시겠습니까?"));
				break;
				
			case "completeRequest":
				header.html(headerText.text("프로젝트 완료처리 하시겠습니까?"));
				break;
				
			default:
				console.log("invalid args");
				break;
		}
	});
	
	codeUpdateForm = $("#projectCodeUpdateForm");
	$("#requestBtn").on("click", function() {
		let memRole = "${realMember.memRole}";
		let currentAuthority = "${realMember.currentAuthority}";
		
		if(memRole != "ROLE_ADMIN" && currentAuthority != "ROLE_TEAM_MANAGER") {
			$("#cancelBtn").trigger("click")
			swal("접근권한 없음", "관리자 또는 프로젝트 매니저만 가능합니다.", "error");
			return false;
		}
		
		// 현재 프로젝트 상태를 나타냄
		let status = $("#set__statuschange").find("div.modal-header").children().data("status");
		let hidden = codeUpdateForm.find("input[name='code']");
		switch(status) {
		case "progress":
			// 정지 3
			hidden.val(3);
			break;
		case "pause":
		case "complete":
			hidden.val(2);
			break;
			
		case "completeRequest":
			hidden.val(4);
			break;
			
		default:
			console.log("invalid args");
			break;
		}
		if(hidden.val() && hidden.val().trim().length > 0) {
			codeUpdateForm.submit();
		}
		
	});
	
	
</script>