<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------    -------- -----------------
* 2021. 2. 1.	임건			최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!-- 작업 히스토리 -->
<div class="panel-header">
	<div class="page-headerinner">
		<div class="setting__header">
			<h2>프로젝트 히스토리</h2>
		</div>
	</div>
</div>
<c:set value="${pagingVO.searchDetail.searchStartDate }" var="searchStartDate"/>
<c:set value="${pagingVO.searchDetail.searchEndDate }" var="searchEndDate"/>
<c:set value="${pagingVO.searchDetail.filterList }" var="filterList"/>
<div class="history-box show-block">
	<div class="row history-container">
		<div class="col-md-12">
			<div class="card history-card">
				<section class="item-section">
					<div class="header__work clearfix">
						<div class="float--left d-flex no-drag">
							<button class="my-history history-tab ${empty filterList ? 'historytab-active' : '' }">
								<h1>TASK</h1>
							</button>
							<h1 class="histofy-separator">/</h1>
							<button class="my-history history-tab ${'issue' eq filterList ? 'historytab-active' : '' }" data-filter="issue">
								<h1>ISSUE</h1>
							</button>
						</div>
						<div class="history-filter float--right">
							<div class="history-guide no-drag">히스토리 기본 설정일은 7일입니다.</div>
						</div>
					</div>
				</section>
				<div class="card-body">
					<div class="filter__card mywork-historylist">
						<ul class="filter__role row history-role no-drag">
							<li>
								<h2 class="filter-title">검색 필터</h2>
								<div class="filter-init">
									<button class="filter-initbtn" onclick="" type="button">검색 필터 초기화</button>
								</div>
							</li>
							<li class="project-rules col-12 row">
								<div class="history-searchfilter">
									<div class="selected-filter">
										<span class="selected-title">선택기간</span> 
										<span class="selected-startdatetime">${searchStartDate }</span> 
										<span class="selected-enddatetime">${searchEndDate }</span>
									</div>

									<div class="selected-datetime">
										<span class="start-alert"> 시작일 </span> 
										<input id="searchStartDate" type="date" class="start-datetime" name="searchStartDate" value="${searchStartDate }" onchange="search();"> 
										<span class="end-alert"> 종료일 </span>
										<input id="searchEndDate" type="date" class="end-datetime" name="searchEndDate" value="${searchEndDate }" onchange="search();">
									</div>
								</div>
							</li>
						</ul>
						<!-- 여기가.. 작업 내역 리스트인건가... -->
						<ul id="historyListArea" class="history-items">
							<c:forEach items="${pagingVO.dataList }" var="history">
								<li class="history-item row no-drag" data-uri="${history.historyUri }">
									<div class="history-shortinfo col-md-4">
										<div class="history-status">
											<i class="fas fa-history" style="font-size: 20px; color:#808080;"></i>
										</div>
										<div class="history-simpleinfo">
											<div class="history-worktitle">
												<span class="history-name">${history.historyTitle }</span>
												<c:if test="${not empty history.historyState }">
													<span class="history-do">${history.historyState }</span> 
												</c:if> 
												<c:if test="${not empty history.historyType }">
													<span class="history-type">${history.historyType }</span>
												</c:if>
											</div>
											<div class="history-path">
												<span class="history-code">${history.historyId }</span> 
												<span class="history-manager" data-memid="">${history.memName }</span> 
												<span class="history-projectid">${history.proName }</span>
											</div>
										</div>
									</div>
									
									<div class="history-detailinfo col-md-6">
										<span class="history-content">${history.boardTypeName} : ${history.historyContent }</span>
									</div>
									
									<div class="history-memberavatar col-md-2">
										<div class="avatar-sm">
											<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..." class="avatar-img rounded-circle">
										</div>
									</div>
									<span class="history-projectid">${history.historyDate }</span>
								</li>
							</c:forEach>
						</ul>
					</div>
					
					<div id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form:form id="historyForm" modelAttribute="historyVO" method="get">
	<input type="hidden" name="page"/>
	<form:hidden path="proId"/>
	<form:hidden path="searchStartDate"/>
	<form:hidden path="searchEndDate"/>
	<form:hidden path="filterList"/>
</form:form>
<script>
	$(".my-history").on("click", function(){
		let filterVal = $(this).data("filter");
		$("#historyForm").find(":hidden[name='filterList']").val(filterVal);
		$("#historyForm").submit();
		historytab = $(this);
	});
	
	$("#historyListArea").on("click", "li", function() {
		let detailViewUri = $(this).data("uri");
		if(detailViewUri != null){
			if(detailViewUri.length > 0){
				console.log(detailViewUri);
				window.location.href = "${cPath}"+detailViewUri+"&proId=${param.proId}";
			}
		}
	});

	$("#pagingArea").on("click", "a", function(){
		let page = $(this).data("page");
		$("#historyForm").find(":hidden[name='page']").val(page);
		$("#historyForm").submit();
	});
	
	function search() {
		let startDate = $("#searchStartDate").val(); 
		let endDate = $("#searchEndDate").val();
		$("#historyForm").find(":hidden[name='searchStartDate']").val(startDate);
		$("#historyForm").find(":hidden[name='searchEndDate']").val(endDate);
		$("#historyForm").submit();
	}
</script>