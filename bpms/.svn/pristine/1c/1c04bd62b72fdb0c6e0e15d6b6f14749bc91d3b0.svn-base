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
	
</style>
<div class="container">
<ul class="justify-content-md-center">
	<li class="p-4">
		<div class="d-flex justify-content-between">
			<h1>WORK DETAIL</h1>
			<button id="cancleBtn" type="button" class="btn btn-outline-secondary">목록</button>
		</div>
	</li>
	<li class="p-4">
		<p>#${fn:trim(workVO.workId) }:작성자 ${workVO.boardWriter}. 마지막 업데이트 날짜 ${workVO.modifyDate }</p>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">제목</h3>
		<hr>
		<p class="p-2">${workVO.boardTitle }</p>
	</li>
	<li class="p-4">
		<h3 class="font-weight-bold">설명</h3>
		<hr>
		<p class="p-2">${workVO.boardContent }</p>
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
				<li class="p-4">${workVO.workDirector }</li>
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
				<li class="p-4">${workVO.startDate }</li>
				<li class="p-4">${workVO.endDate }</li>
				<li class="p-4">
					<div class="progress">
					  <div class="progress-bar progress-bar-striped active" role="progressbar"
					  	aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:${fn:trim(workVO.progress)}%">
					  	<span>${fn:trim(workVO.progress)}%</span>
					  </div>
					</div>
				</li>
				<li class="p-4">
					<c:forEach items="${wrCustomList }" var="wrCustom">
						<c:if test="${wrCustom.text eq workVO.workRank}">
							<span>
								<i class="${wrCustom.iconClass }" style="color: ${wrCustom.iconColor};"></i>
								<span style="color: ${wrCustom.textColor};">${workVO.workRank }</span>
							</span>
						</c:if>
					</c:forEach>
				</li>
				<li class="p-4">
					<c:forEach items="${wtCustomList }" var="wtCustom">
						<c:if test="${wtCustom.text eq workVO.workType}">
							<span>
								<i class="${wtCustom.iconClass }" style="color: ${wtCustom.iconColor};"></i>
								<span style="color: ${wtCustom.textColor};">${workVO.workType }</span>
							</span>
						</c:if>
					</c:forEach>
				</li>
				<li class="p-4">
					<c:forEach items="${wsCustomList }" var="wsCustom">
						<c:if test="${wsCustom.text eq workVO.workState}">
							<span>
								<i class="${wsCustom.iconClass }" style="color: ${wsCustom.iconColor};"></i>
								<span style="color: ${wsCustom.textColor};">${workVO.workState }</span>
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
		<c:if test="${not empty workVO.attatchList }">
			<c:forEach items="${workVO.attatchList }" var="attatch" varStatus="vs">
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
	<li class="p-4">
	</li>
	<li>
		<ul class="d-flex justify-content-end">
			<li class="p-4">
				<button id="modifyBtn" class="btn btn-outline-warning">수정</button>
				<button id="deleteBtn" type="button" class="btn btn-outline-danger">삭제</button>
			</li>
		</ul>		
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
				, "moveUrl": "/work/workUpdate.do?proId=${param.proId}&workId=${workVO.workId}"
			});
		});
		
		$("#deleteBtn").on("click", function() {
			$.getProStatus({
				"url": "/project/statusCheck.do?proId=${param.proId}"
				, "moveUrl": "/work/workDelete.do?proId=${param.proId}&workId=${workVO.workId}"
			});
			
		});
		
		$("#cancleBtn").on("click", function() {
			window.history.back();
		});
	});
</script>

