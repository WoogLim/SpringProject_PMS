<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
	ul,li{
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
	
	.error{
		color: red;
	}
	
	.mini-searchbar{
		position: absolute;
		width: 50%;
		max-height: 100px;
		overflow: auto;
		background-color: white;
		border-radius: 10px;
	}
	
	.mini-searchbar::-webkit-scrollbar{
		width: 3px;
	}
	
	.mini-searchbar::-webkit-scrollbar-thumb {
		background-color: #dcdcdc;
		border-radius: 10px;
	}
	
	.mini-searchbar::-webkit-scrollbar-track {
		background-color: white;
		border-radius: 10px;
	}
	
	#searchListArea {
		cursor: pointer;
	}
</style>

<form:form id="issueForm" commandName="issueVO" modelAttribute="issueVO" method="post" enctype="multipart/form-data">
<div class="container">
	<ul class="justify-content-md-center">
		<li class="p-4">
			<h1>ISSUE</h1>
		</li>
		<li class="form-group pr-4">
			<div class="d-flex justify-content-end">
		        <form:checkbox path="boardShow" class="form-check-input"  id="autoSizingCheck" value="Y" />
		        <label class="form-check-label pl-2" for="autoSizingCheck">비공개 여부</label>
			</div>
		</li>
		<li class="form-group p-4">
			<h3 class="font-weight-bold">* 제목</h3>
			<hr>
			<form:input path="boardTitle" type="text" class="form-control"/>
			<form:errors path="boardTitle" element="span" cssClass="error"/>
		</li>
		<li class="form-group p-4">
			<h3 class="font-weight-bold">내용</h3>
			<hr>
			<form:textarea path="boardContent" cols="" rows="" class="form-control" />
		</li>
		<li class="form-group p-4">
			<h3 class="font-weight-bold">사용자</h3>
			<hr>
			<ul class="row">
				<li class="col">
					<label>* 프로젝트</label>
					<!-- 로그인 끝나고 수정 --> 
					<form:select id="projectSelBox" path="proId" class="custom-select" onchange="DetailSelectBoxesInit();">
						<option value="">프로젝트</option>
						<form:options items="${projectList }" itemValue="proId" itemLabel="proName" />
					</form:select>
					<form:errors path="proId" element="span" cssClass="error"/>
				</li>
				<li class="pl-4 pr-4"/>
				<!-- 공백 채우기.. -->
				<li class="col"/>
				<li class="w-100"/>
				<li class="col pt-4">
					<label>* 담당자</label>
					<!-- 로그인 끝나고 수정 -->
					<form:select id="directorSelBox" path="issueDirector" class="custom-select">
						<option value="">프로젝트를 선택해주세요</option>
						<form:options items="${projectMember }" itemValue="memId" itemLabel="memName"/>
					</form:select>
					<form:errors path="issueDirector" element="span" cssClass="error"/>
				</li>
				<li class="pl-4 pr-4"/>
				<li class="col pt-4">
					<label for="inlineFormCustomSelect">연결 일감</label>
					<form:input autocomplete="off" id="workSearch" path="workSearch" type="text" cssClass="form-control" placeholder="연결 할 일감..." value="${issueVO.workId }"/>		
					<form:hidden id="workId" path="workId"/>
					<form:errors path="workId" element="span" cssClass="error"/>
					<ul id="searchListArea" class="mini-searchbar shadow-sm">
					</ul>		
				</li>
			</ul>
		</li>
		<li class="form-group p-4">
			<h3 class="font-weight-bold">세부 정보</h3>
			<hr>
			<ul class="row">
				<li class="col">
					<label>* 우선 순위</label>
					<form:select path="issueRank" cssClass="custom-select">
						<option value="">우선 순위</option>
						<form:options items="${irCustomList }" itemValue="text" itemLabel="text" />
					</form:select>
					<form:errors path="issueRank" element="span" cssClass="error"/>
				</li>
				<li class="pl-4 pr-4"/>
				<li class="col">
					<label>* 이슈 유형</label>
					<form:select path="issueType" cssClass="custom-select">
						<option value="">이슈 유형</option>
						<form:options items="${itCustomList }" itemValue="text" itemLabel="text" />
					</form:select>
					<form:errors path="issueType" element="span" cssClass="error"/>
				</li>
				<li class="w-100"/>
				<li class="col pt-4">
					<label>* 이슈 상태</label>
					<form:select path="issueState" cssClass="custom-select">
						<option value="">이슈 상태</option>
						<form:options items="${isCustomList }" itemValue="text" itemLabel="text"/>
					</form:select>
					<form:errors path="issueState" element="span" cssClass="error"/>
				</li>
				<li class="pl-4 pr-4"/>
				<li class="col pt-4">
					<label>진척도</label>
					<form:select path="progress" class="custom-select">
						<form:option value="0" label="0%"/>
						<form:option value="10" label="10%"/>
						<form:option value="20" label="20%"/>
						<form:option value="30" label="30%"/>
						<form:option value="40" label="40%"/>
						<form:option value="50" label="50%"/>
						<form:option value="60" label="60%"/>
						<form:option value="70" label="70%"/>
						<form:option value="80" label="80%"/>
						<form:option value="90" label="90%"/>
						<form:option value="100" label="100%"/>
					</form:select>
				</li>
			</ul>
		</li>
		<li class="form-group p-4">
			<h3 class="font-weight-bold">날짜</h3>
			<hr>
			<ul class="row">
				<li class="col">
					<label>시작 날짜</label>
					<form:input path="startDate" type="date" class="form-control"/>
					<form:errors path="startDate" element="span" cssClass="error"/>
				</li>
				<li class="pl-4 pr-4"/>
				<li class="col">
					<label>완료 기한</label>
					<form:input path="endDate" type="date" class="form-control"/>
					<form:errors path="endDate" element="span" cssClass="error"/>
				</li>
			</ul>
		</li>
		<li class="p-4">
			<h3 class="font-weight-bold">첨부 파일</h3>
			<hr>
			<div id="fileArea">
				<c:if test="${not empty issueVO.attatchList }">
					<c:forEach items="${issueVO.attatchList }" var="attatch" varStatus="vs">
						<span title="download" class="attatchSpan">
							<span class="delAtt" data-att-no="${attatch.attNo }">
								<i class="fas fa-times">
									${attatch.attOriginname } &nbsp; ${not vs.last?"|":"" }
								</i>
							</span>
						</span>
					</c:forEach>		
				</c:if>
			</div>
			<form:input path="boardFiles" type="file" class="form-control" multiple="multiple"/>
		</li>
		<li>
			<ul class="d-flex justify-content-end p-2">
				<li class="p-2">
					<button id="insertBtn" class="btn btn-outline-success">작성</button>
				</li>
				<li class="p-2">
					<button id="cancleBtn" type="button" class="btn btn-outline-danger">취소</button>
				</li>
			</ul>
		</li>
	</ul>
</div>
<form:hidden path="boardNo" value="${issueVO.boardNo }"/>
<form:hidden path="boardWriter" value="${issueVO.boardWriter }"/>
</form:form>
<div style="height: 100px;"></div>

<script type="text/javascript">

	const issueForm = $("#issueForm");

	function DetailSelectBoxesInit() {
		$.ajax({
			url : "${cPath}/issue/issueFormDetailInit.do"
			,method : "post"
			,data : $("#issueForm").serialize()
			,dataType : "json"
			,success:function(data){
				let options = [];
				let memberList = data.projectMember;
				let disabled = true;
				if(memberList != null) {
					if(memberList.length > 0){
						for (let member of memberList) {
							options.push($("<option>").val(member.memId).text(member.memName))
						}
						disabled = false;
					}
				}else {
					options.push($("<option>").text("프로젝트를 선택해주세요"));
				} 
				$("#directorSelBox").attr("disabled", disabled);
 				$("#directorSelBox").html(options);
			} 
		});
	}
	
	// 상위 일감 검색 스크립트
	let timeout = null;
	$("#workSearch").keyup(function(event){
		clearTimeout(timeout);
		timeout = setTimeout(function(){
			let searchWord = $("#workSearch").val();
			let blank = true;
			if(searchWord != null){
				if(searchWord.trim().length > 0){
					parentSearch();
					$("#workId").val(searchWord.trim());
					blank = false;
				}
			}
			// 입력 값이 아무 것도 없을 때
			if(blank){
				$("#searchListArea").empty();
				$("#workId").val("");
			}
		},500)
	});
	
// 	$("#workSearch").focusout(function() {
// 		$("#searchListArea").empty();
// 	});
	
	// 상위 일감 검색 결과 비동기 조회
	function parentSearch(){
		$.ajax({
			url : "${cPath}/issue/issueToWorkSearch.do"
			,method : "post"
			,data : $("#issueForm").serialize()
			,dataType : "json"
			,success:function(data){
				let workList = data.workList;
				let listTags = [];				
				if(workList != null){
					if(workList.length > 0){
						for (let work of workList) {
							listTags.push(
								$("<li>").data("workid", work.workId).text("#" + work.workId + " : " + work.boardTitle).addClass("marker")
							);
						}
					}
				}
				$("#searchListArea").append(listTags);
			}
		});
	} 
	
	$("#searchListArea").on("click", "li.marker", function() {
		let workId = $(this).data("workid");
		let text = $(this).text();

		$(this).parent().siblings("input#workSearch").val(text);
		$(this).parent().siblings("input#workId").val(workId);
		
		$("#searchListArea").empty();		
	});
	
	$(function (){	
		// 폼 로딩시 프로젝트가 선택되어 있지 않다면 담당자 선택은 disabled
		let proVal = $("#projectSelBox").val();
		if(proVal == null || !(proVal.length > 0)) {
			$("#directorSelBox").attr("disabled", true);
		}
		
		$("#cancleBtn").on("click", function(){
			window.history.back();
		});
		
		// 첨부 파일 수정 스크립트
		$(".delAtt").on("click", function(){
			let attNo = $(this).data("att-no");
			$("#issueForm").append(
				$("<input>").attr({
					"type":"hidden"
					, "name":"delAttNos"
				}).val(attNo)
			);
			$(this).parent("span:first").hide();
		});
		

	});
</script>