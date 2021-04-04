<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------    -------- -----------------
* 2021. 1. 28.	임건			최초작성
* 2021. 2. 10.	임건			메인 화면틀 작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="main-panel">
<div class="container">
	<div class="page-inner">
		<div class="project-box">
			<div class="row project-container">
				<div class="col-md-12">
					<div class="card project-card">
						<section class="item-section">
							<div class="header__work clearfix">
								<div class="float--left d-flex">
									<h1>프로젝트</h1>
								</div>
								<div class="project-filter float--right">
									<button class="btn-bpms" id="projectListBtn">
										<span>모든 프로젝트 조회</span>
									</button>
								</div>
							</div>
						</section>
						<div class="card-body">
							<ul class="project-title row">
								<li class="col-md-3">프로젝트명</li>
								<li class="col-md-4">내용</li>
								<li class="col-md-2">생성일</li>
								<li class="col-md-3">프로젝트 리더</li>
							</ul>
							
							<c:if test="${not empty projectList }">
								<c:forEach items="${projectList }" var="projectVO">
									<ul class="project-list row">
										<li class="col-md-3">${projectVO.proName }</li>
										<li class="col-md-4">${projectVO.proContent }</li>
										<li class="col-md-2">${projectVO.createDate }</li>
										<li class="col-md-3 project-authentication row">
											<div class="person-avatar col-6">
												<div class="avatar-sm">
													<c:set value="${projectVO.proMemberList[0].memImg }" var="memImg"/>
													<c:if test="${memImg eq null }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
															class="avatar-img rounded-circle">
													</c:if>
													<c:if test="${not (memImg eq null) }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/${memImg }" alt="..."
															class="avatar-img rounded-circle">
													</c:if>
												</div>
												<span class="project-leader">${projectVO.proMemberList[0].memName }</span>
											</div>
											<div class="project-btngroup col-6">
												<button class="project-detailviewbtn" onclick="projectDetailView('${projectVO.proId }')">
													<i class="fas fa-plus-circle"></i>
													<span>더보기</span>
												</button>
											</div>
										</li>
									</ul>	
								</c:forEach>
							</c:if>
							<c:if test="${empty projectList }">
								진행중인 프로젝트가 존재하지 않습니다.
							</c:if>
						</div>
					</div>
				</div>
			</div>

			<!-- 프로젝트 요청 내역 -->
			<div class="row request-container">
				<div class="col-md-12">
					<div class="card project-card">
						<section class="item-section">
							<div class="header__work clearfix">
								<div class="float--left d-flex">
									<h1>프로젝트 요청</h1>
								</div>
								<div class="project-filter float--right">
									<button class="btn-bpms" id="reqProjectListBtn">
										<span>모든 요청내역 조회</span>
									</button>
								</div>
							</div>
						</section>
						<div class="card-body">
							<ul class="request-title row">
								<li class="request-titlename">프로젝트 요청 
									<span class="request-totalnumber">${reqProjectList.size() }</span>
								</li>
							</ul>
							
							<ul class="request-items">
								<c:if test="${not empty reqProjectList }">
									<c:forEach items="${reqProjectList }" var="reqProjectVO">
										<li class="request-item row no-drag">
											<div class="request-icon col-3">
												<i class="fas fa-tasks"></i>
												<div class="request-protitle">
													<span class="request-proname">${reqProjectVO.proName }</span>
													<div class="request-manage">
														<span class="request-datetime">${reqProjectVO.createDate }</span>
														<span class="request-manager">${reqProjectVO.projectManager }</span>
													</div>
												</div>
											</div>
											<div class="request-procontent col-6">${reqProjectVO.proContent }</div>
											<div class="projectperson-group col-3">
												<div class="avatar-group">
													<c:if test="${not empty reqProjectVO.proMemberList }">
														<c:forEach items="${reqProjectVO.proMemberList }" var="proMemberVO" varStatus="status">
															<div class="avatar pro_member" data-memid="${proMemberVO.memId }" onclick="memberDetailView($(this))">
																<c:set value="${proMemberVO.memImg }" var="memProfile"/>
																<c:if test="${not (memProfile eq null) }">
																	<img src="${pageContext.request.contextPath }/assets/img/profile/${memProfile }" alt="..."
																		class="avatar-img rounded-circle border border-white toggle-person">
																</c:if>
																<c:if test="${memProfile eq null }">
																	<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
																		class="avatar-img rounded-circle border border-white toggle-person">
																</c:if>
																<p class="person-name">${proMemberVO.memName }</p>
															</div>
															<c:if test="${status.last }">
																<div class="avatar pro_member">
																	<span class="toggle-personlist avatar-title rounded-circle border border-white" 
																		onclick="reqProjectView($(this))" data-proid="${proMemberVO.proId }" >+</span>
																	<p class="person-name">자세히</p>
																</div>
															</c:if>
														</c:forEach>
													</c:if>
												</div>
											</div>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty reqProjectList }">
									요청된 프로젝트가 존재하지 않습니다.
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="row systeminfo-container">
				<!-- 공지사항 목록 -->
				<div class="col-md-6">
					<div class="card notice-card">
						<section class="item-section">
							<div class="header__work clearfix">
								<h1 class="float--left"> 공지사항</h1>

								<button class="btn-bpms float--right" id="serverNoticeListBtn">
									<span>더보기</span>
								</button>
							</div>
						</section>
						<div class="card-body" id="serverNoticeContainer">
							<c:if test="${not empty serverNoticeList }">
								<c:forEach items="${serverNoticeList }" var="boardVO">
									<div class="notice-item d-flex" data-boardno="${boardVO.boardNo }">
										<div class="avatar avatar-online">
											<span class="avatar-title rounded-circle border-white">A</span>
										</div>
										<div class="noticeitem-info">
											<div class="noticeitem-title">
												시스템 관리자
											</div>
											<div class="noticeitem-content">
												${boardVO.boardTitle }
											</div>
										</div>
										<div class="noticeitem-datatime">
											${boardVO.createDate }
										</div>
									</div>
									<div class="item-dashed"></div>
								</c:forEach>
							</c:if>
							<c:if test="${empty serverNoticeList }">
								서버 공지사항이 존재하지 않습니다.
							</c:if>
						</div>
					</div>
				</div>

				<!-- 사용자 목록 -->
				<div class="col-md-6">
					<div class="card player-card">
						<section class="item-section">
							<div class="header__work clearfix">
								<h1 class="float--left"> 사용자</h1>
								<button class="btn-bpms float--right" id="memberListBtn">
									<span>더보기</span>
								</button>
							</div>

						</section>

						<div class="card-body">
							<c:if test="${not empty memberList }">
								<c:forEach items="${memberList }" var="memberVO">
									<div class="member-item d-flex" data-memid="${memberVO.memId }" onclick="memberDetailView($(this))">
										<div class="avatar avatar-online member-avatar">
											<c:set value="${memberVO.memImg }" var="memberImg"/>
											<c:if test="${not (memberImg eq null) }">
												<img src="${pageContext.request.contextPath }/assets/img/profile/${memberImg }" alt="..."
													class="avatar-img rounded-circle border border-white toggle-person">
											</c:if>
											<c:if test="${memberImg eq null }">
												<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
													class="avatar-img rounded-circle border border-white toggle-person">
											</c:if>
										</div>
										<div class="member-info">
											<div class="member-title">${memberVO.memName }</div>
											<div class="member-memid">${memberVO.memId }</div>
										</div>
										<div class="member-createtime">
											${memberVO.createDate }
										</div>
									</div>
									<div class="item-dashed"></div>
								</c:forEach>
							</c:if>
							<c:if test="${empty memberList }">
								등록된 사용자가 존재하지 않습니다.
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 작업 히스토리 -->
		<div class="history-box">
			<div class="row history-container">
				<div class="col-md-12">
					<div class="card history-card">
						<section class="item-section">
							<div class="header__work clearfix">
								<div class="float--left d-flex">
									<h1>작업 히스토리</h1>
								</div>
								<div class="history-filter float--right">
									<div class="history-guide no-drag">-
										작업 히스토리 기본 설정일은 7일입니다.
									</div>
								</div>
							</div>
						</section>
						<div class="card-body" id="historyContainer">
							<div class="filter__card history-itemlist">
								<ul class="filter__role row history-role no-drag">
									<h2 class="filter-title">검색 필터</h2>

									<div class="filter-init">
										<button class="filter-initbtn" type="button" id="historyDateResetBtn">
											검색 필터 초기화
										</button>
										</div>

										<li class="project-rules col-12 row">

											<div class="history-searchfilter">

												<div class="selected-filter">
													<span class="selected-title">선택기간</span>
													<span class="selected-startdatetime"></span>
													<span class="selected-enddatetime"></span>
												</div>

												<div class="selected-datetime">
													<span class="start-alert">시작일</span>
													<input type="date" class="start-datetime" id="searchStartDate">
													
													<span class="end-alert">종료일</span>
													<input type="date" class="end-datetime" id="searchEndDate">
												</div>

											</div>

										</li>
									</ul>

									<ul class="history-items">
										<%-- 작업 히스토리 자리 --%>
									</ul>
									<div id="pagingArea">
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="historyForm" action="${pageContext.request.contextPath }/admin/history/historyList.do">
	<input type="hidden" name="searchStartDate">
	<input type="hidden" name="searchEndDate">
	<input type="hidden" name="currentPage">
</form>
<script type="text/javascript">
	$(function(){
		let navhistory = $('.btn-active');
	
		$('.toggle-person, .toggle-personlist').on('mouseover mouseleave', function () {
			$(this).siblings('.person-name').toggle();
		})
	
		$('.history-navbtn').on('click',function(){
			historyForm.submit();
			
			if($(navhistory).hasClass('btn-active')){
				navhistory.removeClass('btn-active');
				navhistory.parent().removeClass('nav-active');
			}
		
			$(this).addClass('btn-active');
			$(this).parent().addClass('nav-active');
			$('.project-box').hide();
			$('.history-box').show();
	
			navhistory = $(this);
		})
	
		$('.project-navbtn').on('click',function(){
			if($(navhistory).hasClass('btn-active')){
				navhistory.removeClass('btn-active');
				navhistory.parent().removeClass('nav-active');
			}
	
			$(this).addClass('btn-active');
			$(this).parent().addClass('nav-active');
			$('.history-box').hide();
			$('.project-box').show();
	
			navhistory = $(this);
		})
		
		// 신광진
		let historyForm = $("#historyForm").ajaxForm({
			dataType: "json"
			, success: function(resp) {
				let vo = resp.historyVO;
				let searchStartDate = resp.historyVO.searchStartDate;
				let searchEndDate = resp.historyVO.searchEndDate;
				$("#historyContainer div.selected-datetime").find("input[id='searchStartDate']").val(searchStartDate);
				$("#historyContainer div.selected-datetime").find("input[id='searchEndDate']").val(searchEndDate);
				$("#historyContainer div.selected-filter").find("span.selected-startdatetime").text(searchStartDate);
				$("#historyContainer div.selected-filter").find("span.selected-enddatetime").text(searchEndDate);
				$("#historyForm").find("input[name='searchStartDate']").val(searchStartDate);
				$("#historyForm").find("input[name='searchEndDate']").val(searchEndDate);
				
				$("ul.history-items").children().remove();
				
				let dataList = resp.pagingVO.dataList;
				let liTags = [];
				$(dataList).each(function(idx, historyVO){
					let li = $("<li>").addClass("history-item row no-drag").data("uri", historyVO.historyUri)
																		   .data("proid", historyVO.proId);
					
					let iconDiv = $("<div>").addClass("history-status");
					iconDiv.append($("<i>").addClass("done fas fa-history"));
					
					let titleDiv = $("<div>").addClass("history-worktitle");
					let historyNameSpan = $("<span>").addClass("history-name").text(historyVO.historyTitle);
					let historyStateSpan = $("<span>").addClass("history-do").text(historyVO.historyState);
					let historyTypeSpan = $("<span>").addClass("history-type").text(historyVO.historyType);
					titleDiv.append(historyNameSpan, historyStateSpan, historyTypeSpan);
					
					let historyPathDiv = $("<div>").addClass("history-path");
					let historyIdSpan = $("<span>").addClass("history-code").text(historyVO.historyId);
					let historyManagerSpan = $("<span>").addClass("history-manager").text(historyVO.memName);
					let historyProjectIdSpan = $("<span>").addClass("history-projectid").text(historyVO.proName);
					historyPathDiv.append(historyIdSpan, historyManagerSpan, historyProjectIdSpan);
					
					let simpleInfoDiv = $("<div>").addClass("history-simpleinfo");
					simpleInfoDiv.append(titleDiv, historyPathDiv);

					let infoDiv = $("<div>").addClass("history-shortinfo col-md-4").data("memid", historyVO.historyWriter);
					infoDiv.append(iconDiv, simpleInfoDiv);
					
					let detailInfoDiv = $("<div>").addClass("history-detailinfo col-md-6");
					let detailSpan = $("<span>").addClass("history-content").text(historyVO.boardTypeName + " : " + historyVO.historyContent);
					detailInfoDiv.append(detailSpan);
					
					let avatarDiv = $("<div>").addClass("history-memberavatar col-md-2").data("memid", historyVO.memId);
					let imgDiv = $("<div>").addClass("avatar-sm");
					let memImg = $("<img>").attr("src", $.getContextPath() + "/assets/img/profile/defaultProfile.png")
										   .attr("alt", "....")
										   .addClass("avatar-img rounded-circle");
					if(historyVO.memImg && historyVO.memImg.trim().length) {
						memImg.attr("src", $.getContextPath() + "/assets/img/profile/" + historyVO.memImg);
					}
					avatarDiv.append(imgDiv.append(memImg));
					
					let dateSpan = $("<span>").addClass("history-projectid").text(historyVO.historyDate);

					li.append(infoDiv, detailInfoDiv, avatarDiv, dateSpan);
					liTags.push(li);
				});
				$("ul.history-items").append(liTags);
				$("#pagingArea").html(resp.pagingVO.pagingHTML);
			}
			, error: function(xhr){
				console.log(xhr.status);
			}
		});
		
		// 페이징
		$("#pagingArea").on("click", "a", function(event){
			event.preventDefault();
			let currentPage = $(this).data("page");
			historyForm.find("input[name='currentPage']").val(currentPage);
			historyForm.submit();
		});

		// 히스토리 상세보기
		$("ul.history-items").on("click", "li.history-item", function(){
			let uri = $(this).data("uri");
			let proId = $(this).data("proid");
			location.href = $.getContextPath() + uri + "&proId=" + proId;
		});
		
		// 서버 공지사항 더보기
		$("#serverNoticeListBtn").on("click", function() {
			location.href = $.getContextPath() + "/serverNotice/serverNoticeList.do?mng=Y";
		});
		
		// 프로젝트 리스트 더보기
		$("#projectListBtn").on("click", function(){
			location.href = $.getContextPath() + "/admin/project/projectList.do?groupCode=P";
		});
		
		// 요청된 프로젝트 더보기
		$("#reqProjectListBtn").on("click", function() {
			location.href = $.getContextPath() + "/admin/project/requestProjectList.do";
		});
		
		// 사용자 더보기
		$("#memberListBtn").on("click", function() {
			location.href = $.getContextPath() + "/admin/member/memberList.do";
		});
		
		// 서버공지 자세히 보기
		$("#serverNoticeContainer div.notice-item").on("click", function() {
			let boardNo = $(this).data("boardno");
			location.href = $.getContextPath() + "/serverNotice/serverNoticeView.do?boardNo=" + boardNo + "?mng=Y";
		});
		
		// 히스토리 날짜 선택		
		$("#historyContainer div.selected-datetime :input").on("change", function() {
			let id = $(this).attr("id");
			let val = $(this).val();
			let startDate = historyForm.find("input[name='searchStartDate']");
			let endDate = historyForm.find("input[name='searchEndDate']");
			
			if(id == "searchStartDate") {
				startDate.val(val);
			} else if(id == "searchEndDate") {
				endDate.val(val);
			}
			
			if((startDate.val() != null && startDate.val().trim().length > 0)
					&& (endDate.val() != null && endDate.val().trim().length > 0)) {
				historyForm.submit();
			}
		});
		
		// 히스토리 검색조건 초기화
		$("#historyDateResetBtn").on("click", function() {
			let inputs = $("#historyContainer div.selected-datetime :input");
			$(inputs).each(function(idx, element){
				$(this).val("");
			});
			
			let hiddens = historyForm.find("input[name]");
			$(hiddens).each(function(idx, element){
				$(this).val("");
			});
			historyForm.submit();
		});
	})
	
	// 회원정보 상세보기 페이지로 이동
	function memberDetailView(input) {
		location.href = $.getContextPath() + "/admin/member/memberDetail.do?memId=" + input.data("memid");
	}
	
	// 요청된 프로젝트 보기
	function reqProjectView(input) {
		// 자세히보기가 Modal로 구현되어 있어서 애매함.
		// 일단 List조회 페이지로 이동시킴
		$("#reqProjectListBtn").trigger("click");
	}
	
	// 프로젝트 상세조회
	function projectDetailView(proId) {
		location.href = $.getContextPath() + "/project/main?proId=" + proId;
	}
	
	// 관리페이지 이동
	function goAdminPage() {
		location.href = $.getContextPath() + "/admin/dashBoard";
	}
	
	// 일반회원용 페이지로 전환
	function goUserMainPage() {
		location.href= $.getContextPath() + "/user/main";	
	}
	
</script>