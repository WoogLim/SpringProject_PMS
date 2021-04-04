<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
	ul,li{
		list-style: none;
		margin-top: 0px;
		margin-bottom: 0px;
		margin-left: 0px;
		margin-right: 0px;
		padding-top: 0px;
		padding-left: 0px;
		padding-right: 0px;
		padding-bottom: 0px;
		margin: 0px;
		padding: 0px;
	}
	
	hr {
		margin-top: 0px;
		padding-top: 0px;
	}
	
	table {
		text-align: center;
		cursor: pointer;
	}
	
	.table-left {
		text-align: left;
	}
</style>
<div class="d-flex justify-content-between">
	<h1>TASK LIST</h1>
	<button id="createWorkBtn" type="button" class="btn btn-outline-primary">일감 생성</button>
</div>
<form:form id="workFilter" commandName="workVO" modelAttribute="workVO"  method="post">
<table class="table table-hover issue-table">
	<thead>
		<tr>
			<th class="table-left">
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
				일감 ID
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton id="workid-asc" path="sort" value="ASC" onchange="filterSubmit();" />
					<label for="workid-asc">오름차순</label>
					<form:radiobutton id="workid-desc" path="sort" value="DESC" onchange="filterSubmit();" />
					<label for="workid-desc">내림차순</label>
				</div>
			</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
				프로젝트
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="filterProject" label="프로젝트" onchange="filterSubmit();"/>
					<form:radiobuttons path="filterProject" items="${projectList }" itemValue="proId" itemLabel="proName" onchange="filterSubmit();"/>
				</div>
			</th>
			<th>제목</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
				우선순위
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="workRank" label="우선순위" onchange="filterSubmit();"/>
					<form:radiobuttons path="workRank" items="${wrCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />
				</div>
			</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
					유형
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="workType" label="유형" onchange="filterSubmit();"/>
					<form:radiobuttons path="workType" items="${wtCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />
				</div>
			</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
					상태
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="workState" label="상태" onchange="filterSubmit();"/>
					<form:radiobuttons path="workState" items="${wsCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />						
				</div>
			</th>
			<th>담당자</th>
			<th>진행률(%)</th>
		</tr>
	</thead>
	<tbody id="workList">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8" id="pagingArea">
				${issueFilter.pagingHTML }
			</td>
		</tr>
	</tfoot>
</table>
<input type="hidden" name="page"/>
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/projectStatus.js"></script>
<script type="text/javascript">

	const filterForm = $("#workFilter");
	
	// 일감 상세 화면 이동
	$("#workList").on("click", "tr", function(){
		let workId = $($(this).find("td")[0]).text().replace("#","");
		location.href = "${cPath }/work/workView.do?proId=${param.proId}&workId="+workId;
	});
	
	// 일감 생성 화면 이동 
	let createWorkBtn = $("#createWorkBtn").on("click", function() {
		$.getProStatus({
			"url": "/project/statusCheck.do?proId=${param.proId}"
			, "moveUrl": "/work/workInsert.do?proId=${param.proId}"
		});
	});	
	
	// 페이징 처리
	let pagingArea = $("#pagingArea").on("click", "a" ,function(event){
		event.preventDefault();
		let page = $(this).data("page");
		filterForm.find("[name='page']").val(page);
		filterForm.submit();
		filterForm.find("[name='page']").val("");
		return false;
	});
	
	// 일감 조회 비동기 처리
	let filter = $("#workFilter").ajaxForm({
		dataType : "json"
		, success : function(data){
			let trTags = [];
			let workList = data.pagingVO.dataList;
			let pagination = data.pagingVO.pagingHTML;
			// 이슈 조회 리스트 : 아이디, 제목, 우선순위, 유형, 상태, 담당자, 진행률
			if(workList.length > 0){
				for(let work of workList) {
					trTags.push(
						$("<tr>").append(
							$("<td>").text("#"+work.boardNo).addClass("table-left")
							,$("<td>").text(work.proName)
							,$("<td>").text(work.boardTitle)
							// 이슈 우선 순위 커스텀
							,workCustomRank(work.workRank, data.wrCustomList)
							// 이슈 유형 커스텀
							,workCustomType(work.workType, data.wtCustomList)
							// 이슈 상태 커스텀
							,workCustomStatus(work.workState, data.wsCustomList)
							,$("<td>").text(work.workDirector)
							// 이슈 진행도 프로그레스 바
							,workProgressbar(work.progress)
						)
					);			
				}
			}else {
				trTags.push(
					$("<tr>").append(
						$("<td>").text("조회된 결과가 없습니다...")
					)
				);
			}
			$("#pagingArea").html(pagination);
			$("#workList").html(trTags);
		}
	}).submit();
	
	// 일감 프로그레스바 (부트스트랩 >> UA 임건 디자인 예정)
	function workProgressbar(progressVal) {
		// 진행도는 null able 입니다.
		progressVal = (progressVal != null) ? progressVal.trim() : 0;
		// 진행률에 따라 프로그레스바 색깔이 다릅니다.
		let bgColor = "bg-danger";
		switch(Math.floor(progressVal/40)){
		case 1:
			bgColor = "bg-warning";
			break;
		case 2:
			bgColor = "bg-success";
			break;
		default:
			bgColor = "bg-danger";
			break;
		}
		
		let progressTag = $("<td>").append($("<span>").addClass("progress"));
		let progressSpanTag = $(progressTag).children('span');
		let progress = $("<span>").addClass("progress-bar progress-bar-striped active " + bgColor)
						   		  .attr({
							   			"role" : "progressbar"
									   ,"aria-valuenow" : "40"
									   ,"aria-valuemin" : "0"
									   ,"aria-valuemax" : "100"
								  })
								  .css("width", progressVal+"%")
						   		  .text(progressVal+"%");
		$(progressSpanTag).append(progress);
		return progressTag;
	}
	
	// 일감 순위 커스텀
	function workCustomRank(rankVal, customList) {
		let workRankTag = $("<td>").append("<span>");
		let rankSpanTag = $(workRankTag).children('span');
		rankVal = rankVal.trim();
		for (let custom of customList) {
			let customText = custom.text.trim();
			if(customText == rankVal){
				let icon = $("<span>").append($("<i>").addClass(custom.iconClass).css("color", custom.iconColor));
				let text = $("<span>").text(" "+rankVal).css("color", custom.textColor);
				rankSpanTag.append(icon,text).css("background-color", custom.backgroundColor);
				break;
			}	
		}
		return workRankTag;
	}
	
	// 일감 유형 커스텀
	function workCustomType(typeVal, customList) {
		let workTypeTag = $("<td>").append("<span>");
		let typeSpanTag = $(workTypeTag).children('span');
		typeVal = typeVal.trim();
		for (let custom of customList) {
			let customText = custom.text.trim();
			if(customText == typeVal){
				let icon = $("<span>").append($("<i>").addClass(custom.iconClass).css("color", custom.iconColor));
				let text = $("<span>").text(" "+typeVal).css("color", custom.textColor);
				typeSpanTag.append(icon,text).css("background-color", custom.backgroundColor);
				break;
			}
		}
		return workTypeTag;
	}

	// 일감 상태 커스텀
	function workCustomStatus(statusVal, customList) {
		let workStatusTag = $("<td>").append("<span>");
		let statusSpanTag = $(workStatusTag).children('span');
		statusVal = statusVal.trim();
		for (let custom of customList) {
			let customText = custom.text.trim();
			if(customText == statusVal){
				let icon = $("<span>").append($("<i>").addClass(custom.iconClass).css("color", custom.iconColor));
				let text = $("<span>").text(" "+statusVal).css("color", custom.textColor);
				statusSpanTag.append(icon,text).css("background-color", custom.backgroundColor);
				break;
			}	
		}
		return workStatusTag;
	}
	
	function filterSubmit() {
		filterForm.submit();
	}
</script>



