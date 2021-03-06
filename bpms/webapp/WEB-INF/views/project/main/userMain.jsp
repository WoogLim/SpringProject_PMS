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

<div class="main-panel">
	<div class="main-container">
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
										<button class="btn-bpms" id="projectRequestBtn">
											<span>새 프로젝트 요청</span>
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
											<li class="col-md-3 project-titlename" data-proId="">${projectVO.proName }</li>
											<li class="col-md-4">${projectVO.proContent }</li>
											<li class="col-md-2">${projectVO.createDate }</li>
											<li class="col-md-3 project-authentication row">
												<div class="person-avatar col-6">
													<div class="avatar-sm">
														<c:set value="${projectVO.proMemberList[0].memImg}" var="memImg"/>
														<c:if test="${memImg eq null }">
															<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
																class="avatar-img rounded-circle">
														</c:if>
														<c:if test="${not (memImg eq null) }">
															<img src="${pageContext.request.contextPath }/assets/img/profile/${memImg }" alt="..."
																class="avatar-img rounded-circle">
														</c:if>
														
													</div>
													<span class="project-leader">${projectVO.projectManager}</span>
												</div>
												<div class="project-btngroup col-6">
													<button class="project-detailviewbtn" onclick="projectDetailView('${projectVO.proId}')">
														<i class="fas fa-plus-circle"></i> <span>더보기</span>
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

				<div class="row systeminfo-container">
					<!-- 공지사항 목록 -->
					<div class="col-md-6">
						<div class="card notice-card">
							<section class="item-section">
								<div class="header__work clearfix">
									<h1 class="float--left">프로젝트 공지사항</h1>
								</div>

							</section>
							<div class="card-body">
								<c:if test="${not empty projectNoticeList }">
									<c:forEach items="${projectNoticeList }" var="boardVO">
										<div class="notice-item d-flex" onclick="proNoticeDetailView('${boardVO.boardList[0].proId}','${boardVO.boardList[0].boardNo}')">
											<div class="avatar avatar-online">
												<span class="avatar-title rounded-circle border-white">N
												</span>
											</div>
											<div class="noticeitem-info">
												<div class="noticeitem-title">
													<span class="noticefrom-project">${boardVO.proName }</span> <span
														class="notice-writer">${boardVO.boardList[0].boardWriter }</span>
												</div>
												<div class="noticeitem-content">${boardVO.boardList[0].boardTitle }</div>
											</div>
											<div class="noticeitem-datatime">${boardVO.boardList[0].createDate }</div>
										</div>
										<div class="item-dashed"></div>
									</c:forEach>
								</c:if>
								<c:if test="${empty projectNoticeList }">
									서버 공지사항이 존재하지 않습니다.
								</c:if>

							</div>
						</div>
					</div>
					<!-- 메모리스트 목록 -->
					<div class="col-md-6">
						<div class="card notice-card">
							<section class="item-section">
								<div class="header__work clearfix">
									<h1 class="float--left">내 메모</h1>

									<button class="btn-bpms float--right" type="button" onclick="myMemoList();">
										<span>더보기</span>
									</button>
								</div>

							</section>
							<div class="card-body">
								<c:if test="${not empty kanbanList }">
									<c:forEach items="${kanbanList }" var="kanbanVO">
										<div class="notice-item d-flex" onclick="myMemoList();">
											<div class="avatar avatar-online">
												<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png"
												alt="..." class="avatar-img rounded-circle">
											</div>
											<div class="noticeitem-info">
												<div class="noticeitem-title">${kanbanVO.kboardTitle }</div>
												<div class="noticeitem-content">${kanbanVO.stickerList[0].kstickerTitle }</div>
											</div>
											<div class="noticeitem-datatime">${kanbanVO.stickerList[0].createDate }</div>
										</div>
										<div class="item-dashed"></div>
									</c:forEach>
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
									<div class="float--left d-flex no-drag">
										<button class="mywork-history history-tab historytab-active" onclick="getWorkList()">
											<h1>내 작업 히스토리</h1>
										</button>
										<h1 class="histofy-separator">/</h1>
										<button class="myissue-history history-tab" onclick="getIssueList()">
											<h1>내 이슈 히스토리</h1>
										</button>
									</div>
									<div class="history-filter float--right">
										<div class="history-guide no-drag">히스토리 기본 설정일은 7일입니다.</div>
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

<form id="historyForm" action="${pageContext.request.contextPath }/history/historyList.do">
	<input type="hidden" name="searchStartDate">
	<input type="hidden" name="searchEndDate">
	<input type="hidden" name="page">
	<input type="hidden" name="filterList">
</form>

<script type="text/javascript">
	$(function() {
		
		let navhistory = $('.userbtn-active');
		let historytab = $('.historytab-active');

		$('.history-navbtn').on('click', function() {
			if ($(navhistory).hasClass('userbtn-active')) {
				navhistory.removeClass('userbtn-active');
				navhistory.parent().removeClass('usernav-active');
			}

			$(this).addClass('userbtn-active');
			$(this).parent().addClass('usernav-active');
			$('.project-box').hide();
			$('.history-box').show();

			navhistory = $(this);
			
			historyForm.submit();
		})

	$('.project-navbtn').on('click', function() {
			if ($(navhistory).hasClass('userbtn-active')) {
				navhistory.removeClass('userbtn-active');
				navhistory.parent().removeClass('usernav-active');
			}

			$(this).addClass('userbtn-active');
			$(this).parent().addClass('usernav-active');
			$('.history-box').hide();
			$('.project-box').show();

			navhistory = $(this);
		})

		$('.myissue-history').on('click', function() {
			if ($(historytab).hasClass('historytab-active')) {
				historytab.removeClass('historytab-active');
				historytab.parent().removeClass('historytab-active');
			}

			$(this).addClass('historytab-active');
			$('.mywork-historylist').hide();
			$('.myissue-historylist').show();

			historytab = $(this);
		})

		$('.mywork-history').on('click', function() {
			if ($(historytab).hasClass('historytab-active')) {
				historytab.removeClass('historytab-active');
				historytab.parent().removeClass('historytab-active');
			}

			$(this).addClass('historytab-active');
			$('.myissue-historylist').hide();
			$('.mywork-historylist').show();

			historytab = $(this);
		})
		
		$("#projectRequestBtn").on("click", function() {
			location.href = $.getContextPath() + "/project/insertProject.do";
		});
	})
	
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
			console.log(dataList);
			let liTags = [];
			$(dataList).each(function(idx, historyVO){
				let li = $("<li>").addClass("history-item no-drag").data("uri", historyVO.historyUri)
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

				let infoDiv = $("<div>").addClass("history-shortinfo").data("memid", historyVO.historyWriter);
				infoDiv.append(iconDiv, simpleInfoDiv);
				
				let detailInfoDiv = $("<div>").addClass("history-detailinfo");
				let detailSpan = $("<span>").addClass("history-content").text(historyVO.boardTypeName + " : " + historyVO.historyContent);
				detailInfoDiv.append(detailSpan);
				
				let avatarDiv = $("<div>").addClass("history-memberavatar").data("memid", historyVO.memId);
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
	
	// 페이징
	$("#pagingArea").on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data("page");
		historyForm.find("input[name='page']").val(page);
		historyForm.submit();
	});

	// 히스토리 상세보기
	$("ul.history-items").on("click", "li.history-item", function(){
		let uri = $(this).data("uri");
		let proId = $(this).data("proid");
		location.href = $.getContextPath() + uri + "&proId=" + proId;
	});

	// 이슈 히스토리
	function getIssueList() {
		historyForm.find("input[name='filterList']").val("issue");
		historyForm.find("input[name='page']").val(1);
		historyForm.submit();
	}
	
	// 일감 히스토리
	function getWorkList() {
		historyForm.find("input[name='filterList']").val("");
		historyForm.find("input[name='page']").val(1);
		historyForm.submit();	
	}	
	
	
	function projectDetailView(proId) {
		location.href = $.getContextPath() + "/project/main?proId=" + proId;
	}
	
	function proNoticeDetailView(proId, boardNo) {
 		location.href = $.getContextPath() + "/proNotice/proNoticeView.do?boardNo="+boardNo+"&proId="+proId;
	}
	
	function proNoticeListView() {
		location.href = $.getContextPath() + "/serverNotice/serverNoticeList.do";
	}
	
	function myMemoList(){
		location.href = $.getContextPath() + "/kanban/kanbanView.do";
	}
	
	function goAdminMainPage() {
		location.href = $.getContextPath() + "/admin/main";
	}
	
</script>