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
	
	.search-btn{
		width: 30px;
		height: 30px;
		margin-right: 20px;
		border-radius: 50%;
	}
	
	.search-box{
		height: 30px;
		border-radius: 20px;
	}
	
</style>
<div class="d-flex justify-content-between">
	<h1>ISSUE LIST</h1>
	<button id="createIssueBtn" type="button" class="btn btn-outline-primary">이슈 발행</button>
</div>
<form:form id="issueFilter" commandName="issueVO" modelAttribute="issueVO" method="post">
<table class="table table-hover issue-table">
	<thead>
		<tr>
			<th class="table-left">
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
				이슈 ID
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton id="issueid-asc" path="sort" value="ASC" onchange="filterSubmit();" />
					<label for="issueid-asc">오름차순</label>
					<form:radiobutton id="issueid-desc" path="sort" value="DESC" onchange="filterSubmit();" />
					<label for="issueid-desc">내림차순</label>
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
					<form:radiobutton path="issueRank" label="우선순위" onchange="filterSubmit();"/>
					<form:radiobuttons path="issueRank" items="${irCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />
				</div>
			</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
					유형
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="issueType" label="유형" onchange="filterSubmit();"/>
					<form:radiobuttons path="issueType" items="${itCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />
				</div>
			</th>
			<th>
				<button class="dropdown-toggle css-dropbtn1" type="button" data-toggle="dropdown">
					상태
				</button>
				<div class="dropdown-menu issue-filterbtn" aria-labelledby="dropdownMenuButton">
					<form:radiobutton path="issueState" label="상태" onchange="filterSubmit();"/>
					<form:radiobuttons path="issueState" items="${isCustomList }" itemValue="text" itemLabel="text" onchange="filterSubmit();" />						
				</div>
			</th>
			<th>담당자</th>
			<th>진행률(%)</th>
		</tr>
	</thead>
	<tbody id="issueList">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8" id="pagingArea">
				${issueFilter.pagingHTML }
			</td>
		</tr>
	</tfoot>
</table>
<input type="hidden" name="page">
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/projectStatus.js"></script>
<script type="text/javascript">

	const filterForm = $("#issueFilter");
	
	// 이슈 상세 화면 이동
	$("#issueList").on("click", "tr", function(){
		let issueId = $($(this).find("td")[0]).text().replace("#","");
		location.href = "${cPath }/issue/issueView.do?proId=${param.proId}&issueId="+issueId;
	});
	
	// 이슈 생성 화면 이동 
	let createIssueBtn = $("#createIssueBtn").on("click", function() {
		$.getProStatus({
			"url": "/project/statusCheck.do?proId=${param.proId}"
			, "moveUrl": "/issue/issueInsert.do?proId=${param.proId}"
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
	
	// 이슈 조회 비동기 처리
	let filter = $("#issueFilter").ajaxForm({
		dataType : "json"
		, success : function(data){
			let trTags = [];
			let issueList = data.pagingVO.dataList;
			let pagination = data.pagingVO.pagingHTML;
			// 이슈 조회 리스트 : 아이디, 제목, 우선순위, 유형, 상태, 담당자, 진행률
			if(issueList.length > 0){
				for(let issue of issueList) {
					trTags.push(
						$("<tr>").append(
							$("<td>").text("#"+issue.boardNo).addClass("table-left")
							,$("<td>").text(issue.proName)
							,$("<td>").text(issue.boardTitle)
							// 이슈 우선 순위 커스텀
							,issueCustomRank(issue.issueRank, data.irCustomList)
							// 이슈 유형 커스텀
							,issueCustomType(issue.issueType, data.itCustomList)
							// 이슈 상태 커스텀
							,issueCustomStatus(issue.issueState, data.isCustomList)
							,$("<td>").text(issue.issueDirector)
							// 이슈 진행도 프로그레스 바
							,issueProgressbar(issue.progress)
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
			$("#issueList").html(trTags);
		}
	}).submit();
	
	// 이슈 프로그레스바 (부트스트랩 >> UA 임건 디자인 예정)
	function issueProgressbar(progressVal) {
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
	
	// 이슈 순위 커스텀
	function issueCustomRank(rankVal, customList) {
		let issueRankTag = $("<td>").append("<span>");
		let rankSpanTag = $(issueRankTag).children('span');
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
		return issueRankTag;
	}
	
	// 이슈 유형 커스텀
	function issueCustomType(typeVal, customList) {
		let issueTypeTag = $("<td>").append("<span>");
		let typeSpanTag = $(issueTypeTag).children('span');
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
		return issueTypeTag;
	}

	// 이슈 상태 커스텀
	function issueCustomStatus(statusVal, customList) {
		let issueStatusTag = $("<td>").append("<span>");
		let statusSpanTag = $(issueStatusTag).children('span');
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
		return issueStatusTag;
	}
	
	function filterSubmit() {
		filterForm.submit();
	}
</script>



