<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
	
	textarea{
		border: 0px;
		background-color: white; 
	}
	
	.profile{
		max-height: 50px;
		max-width: 50px;
	}
	
	.reply-content{
		border: none;
		border-bottom: solid 1px gray;
	}
	
	.reply-writer{
		font-weight: bolder;
		font-size: 15px;	
	}
	
	.reply-date{
		color: gray;
		font-size: 10px;
	}
	
	.reply-menu{
		color: gray;
	}
	
	.reply-menu:hover{
		color: #6799FF;
	}
</style>
<div class="container">
<ul class="justify-content-md-center">
	<li class="p-4">
		<div class="d-flex justify-content-between">
			<h1>ISSUE DETAIL</h1>
			<button id="cancleBtn" type="button" class="btn btn-outline-secondary">목록</button>
		</div>
	</li>
	<li class="p-4">
		<p>#${fn:trim(issueVO.issueId) }:작성자 ${workVO.boardWriter}. 마지막 업데이트 날짜 ${issueVO.modifyDate }</p>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">제목</h3>
		<hr>
		<p class="p-2">${issueVO.boardTitle }</p>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">설명</h3>
		<hr>
		<p class="p-2">${issueVO.boardContent }</p>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">사용자</h3>
		<hr>
		<div class="row">
			<ul class="col font-weight-bold">
				<li class="p-4">담당자</li>
				<li class="p-4">담당</li>
			</ul>
			<ul class="col font-weight-bold">
				<li class="p-4">${issueVO.issueDirector }</li>
				<li class="p-4">DA</li>
			</ul>
		</div>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">세부 정보</h3>
		<hr>
		<div class="row">
			<ul class="col font-weight-bold">
				<li class="p-4">시작 날짜</li>
				<li class="p-4">완료 기한</li>
				<li class="p-4">진행률(%)</li>
				<li class="p-4">우선 순위</li>
				<li class="p-4">이슈 유형</li>
				<li class="p-4">이슈 상태</li>
			</ul>
			<ul class="col font-weight-bold">
				<li class="p-4">${issueVO.startDate }</li>
				<li class="p-4">${issueVO.endDate }</li>
				<li class="p-4">
					<div class="progress">
					  <div class="progress-bar progress-bar-striped active" role="progressbar"
					  	aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:${fn:trim(issueVO.progress)}%">
					  	<span>${fn:trim(issueVO.progress)}%</span>
					  </div>
					</div>
				</li>
				<li class="p-4">
					<c:forEach items="${irCustomList }" var="irCustom">
						<c:if test="${irCustom.text eq issueVO.issueRank}">
							<span>
								<i class="${irCustom.iconClass }" style="color: ${irCustom.iconColor};"></i>
								<span style="color: ${irCustom.textColor};">${issueVO.issueRank }</span>
							</span>
						</c:if>
					</c:forEach>
				</li>
				<li class="p-4">
					<c:forEach items="${itCustomList }" var="itCustom">
						<c:if test="${itCustom.text eq issueVO.issueType}">
							<span>
								<i class="${itCustom.iconClass }" style="color: ${itCustom.iconColor};"></i>
								<span style="color: ${itCustom.textColor};">${issueVO.issueType }</span>
							</span>
						</c:if>
					</c:forEach>
				</li>
				<li class="p-4">
					<c:forEach items="${isCustomList }" var="isCustom">
						<c:if test="${isCustom.text eq issueVO.issueState}">
							<span>
								<i class="${isCustom.iconClass }" style="color: ${isCustom.iconColor};"></i>
								<span style="color: ${isCustom.textColor};">${issueVO.issueState }</span>
							</span>
						</c:if>
					</c:forEach>
				</li>
			</ul>
		</div>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">첨부 파일</h3>
		<hr>
		<c:if test="${not empty issueVO.attatchList }">
			<c:forEach items="${issueVO.attatchList }" var="attatch" varStatus="vs">
				<c:url value="/board/download.do" var="downloadURL">
					<c:param name="attNo" value="${attatch.attNo }" />
				</c:url>
				<a href="${downloadURL }">
					<span title="다운로드:${attatch.attDowncount}">${attatch.attOriginname }</span>
					${not vs.last?"|":"" }
				</a>
			</c:forEach>		
		</c:if>
	</li>
	<li>
		<ul class="d-flex justify-content-end">
			<li class="p-4">
				<button id="modifyBtn" class="btn btn-outline-warning">수정</button>
				<button id="deleteBtn" type="button" class="btn btn-outline-danger">삭제</button>
				<button id="cancleBtn" type="button" class="btn btn-outline-secondary">취소</button>
			</li>
		</ul>		
	</li>
	<li class="p-4">
	</li>
</ul>
</div>
<div style="height: 100px;"></div>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/projectStatus.js"></script>
<script type="text/javascript">
	$(function() {
		
		$("#modifyBtn").on("click", function() {
			$.getProStatus({
				"url": "/project/statusCheck.do?proId=${param.proId}"
				, "moveUrl": "/issue/issueUpdate.do?proId=${param.proId}&issueId=${issueVO.issueId}"
			});
		});
		
		$("#deleteBtn").on("click", function() {
			$.getProStatus({
				"url": "/project/statusCheck.do?proId=${param.proId}"
				, "moveUrl": "/issue/issueDelete.do?proId=${param.proId}&issueId=${issueVO.issueId}"
			});
		});
		
		$("#cancleBtn").on("click", function() {
			window.history.back();
		});
		
		$(".reply-create").on("click", function() {
			
		});

		$(".reply-update").on("click", function() {
			
		});
		
		$(".reply-delete").on("click", function() {
			// closest : 맞는 조건의 상위 요소 중 가장 가까운 요소를 select
			let repno = $(this).closest("ul").data("repno");
			console.log($(this).closest("ul"));
			console.log(repno);
		});
	});
</script>

