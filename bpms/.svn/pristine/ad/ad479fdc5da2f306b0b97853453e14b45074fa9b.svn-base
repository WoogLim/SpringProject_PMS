<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------    -------- -----------------
* 2021. 2. 13.	임건			최초작성
* 2021. 2. 15.	이선엽		코딩
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<div class="wiki-container">
	<div class="wiki-postbox row">
		<div class="wiki-content col-lg-8 col-md-12 col-sm-12">
			<div class="wikipost-header">
				<%-- 위키 게시글 제목 --%>
				<div class="wikepost-title">
					<h1>${boardVO.boardTitle }</h1>
				</div>
				<div class="wikipost-writer">
					<span class="wikiwriter-name" data-writer="">${boardVO.boardWriter }</span>
					<span class="wiki-wrotedate">최초 작성 : ${boardVO.createDate }</span>
					<c:if test="${not empty boardVO.modifyDate }">
						<span class="wiki-wrotedate">최종 수정 : ${boardVO.modifyDate}</span>
					</c:if>
				</div>
				<div class="wikipost-writer">
					<%-- 위키 게시글 작성자 및 작성일  data-writer 에 작성자 이름 넣어 사용 --%>
<%-- 					<span class="wikiwriter-name" data-writer="">${boardVO.boardWriter }</span> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${empty boardVO.modifyDate }"> --%>
<%-- 							<span class="wiki-wrotedate">${boardVO.createDate }</span> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<span class="wiki-wrotedate">${boardVO.modifyDate }</span> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
				</div>
			</div>
			<div class="wikipost-maincontent">
				<%-- 위키 게시글 내용 들어갈 곳 밑에 h1, img태그는 예시이므로 삭제 후 사용하세요! --%>
				<h1>${boardVO.boardContent }</h1>
<!-- 				<img src="../assets/img/bg-404.jpeg" alt=""> -->
			</div>
		</div>

		<div class="wiki-subcontent col-lg-4 col-md-12 col-sm-12">
			<c:choose>
				<c:when test="${empty boardVO.modifyDate }">
					<div class="wrote-history">
						<ul class="wrote-historylist">
							<li class="wrote-historyitem">
								<div class="writer-avatar">
									<div class="avatar-sm">
										<img src="../assets/img/flaticon/poyo.png" alt="..."
											class="avatar-img rounded-circle">
									</div>
								</div>
								<div class="post-history">
									<div class="postwriter-info">
										<%-- 작성자 이름 --%>
										<span class="post-writername"> ${boardVO.boardWriter } </span>
										<%-- 작성 유형 --%>
										<span class="post-type">
		                          			최초 작성본
										</span>
									</div>
									<%-- 작성 기간 --%>
									<div class="post-wrotedate">
		                       			최초 작성 시간 : ${boardVO.createDate }
									</div>
								</div>
							</li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="wrote-history">
						<ul class="wrote-historylist">
							<li class="wrote-historyitem">
								<div class="writer-avatar">
									<div class="avatar-sm">
										<img src="../assets/img/flaticon/poyo.png" alt="..."
											class="avatar-img rounded-circle">
									</div>
								</div>
								<div class="post-history">
									<div class="postwriter-info">
										<span class="post-writername"> 최초 작성본 </span>
									</div>
									<%-- 작성 기간 --%>
									<div class="post-wrotedate">
		                       			${boardVO.createDate }
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="wrote-history">
						<ul class="wrote-historylist">
							<li class="wrote-historyitem">
								<div class="writer-avatar">
									<div class="avatar-sm">
										<img src="../assets/img/flaticon/poyo.png" alt="..."
											class="avatar-img rounded-circle">
									</div>
								</div>
								<div class="post-history">
									<div class="postwriter-info">
										<span class="post-writername"> 수정본</span>
									</div>
									<%-- 작성 기간 --%>
									<div class="post-wrotedate">
		                       			최종 수정 시간 : ${boardVO.modifyDate }
									</div>
								</div>
							</li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="wiki-write" data-boardno="${boardVO.boardNo }">
			<c:url value="/wiki/wikiUpdate.do" var="updateURL">
				<c:param name="proId" value="${param.proId }" />
				<c:param name="boardNo" value="${boardVO.boardNo }" />
			</c:url>
			<button class="wiki-btn wiki-modifybtn" id="updateBtn">
				<i class="fas fa-pencil-alt"></i> 
				<span class="wiki-guide">위키 수정</span>
			</button>

			<button class="wiki-btn wiki-removebtn" data-toggle="modal"
				data-target="#remove-wiki">
				<i class="fas fa-times"></i> 
				<span class="wiki-guide">위키 삭제</span>
			</button>
		</div>
	</div>

</div>

<form id="deleteForm" method="post" action="${cPath}/wiki/wikiDelete.do?proId=${param.proId}">
	<input type="hidden" name="boardNo" value="${boardVO.boardNo }" />
</form>
</security:authorize>
<!-- 위키 삭제 모달 -->
<div class="modal fade customModal" id="remove-wiki">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">

				<div class="modal__header">해당 위키를 삭제하시겠습니까?</div>

				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#remove-wiki" id="removeCancelBtn">취소</button>
					<button type="button" class="form-confirm" id="removeBtn">삭제</button>
				</div>

			</div>
		</div>
	</div>
</div>

<!-- End Custom template -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/projectStatus.js"></script>
<script>
	$(function() {
		$('.main-panel').addClass('wiki-box')

		$('.wiki-btn i').on('mouseover mouseleave', function() {
			$(this).siblings('span').toggle();
		})
		
		$('#removeBtn').on('click', function() {
			$.ajax({
				url: $.getContextPath() + "/project/statusCheck.do?proId=${param.proId}"
				, dataType: "json"
			}).done(function(resp){
				let status = resp.status;
				let message = resp.message;
				
				if(message){
					showMessage({
						"text": message.text
						, "align": message.align
						, "from": message.from
						, "timeout": message.timeout
						, "type": message.type
					})
				} else {
					if(status == "PAUSE") {
						swal("접근 불가", "프로젝트가 정지상태이기 때문에 접근 불가능합니다.", "error");
					} else if(status == "COMPLETE") {
						swal("접근 불가", "프로젝트가 완료상태이기 때문에 접근 불가능합니다.", "error");
					} else if(status == "WAIT") {
						swal("접근 불가", "프로젝트가 아직 승인되지 않았습니다.", "error");
					} else if(status == "PROGRESS") {
						$("#deleteForm").submit();
					}
					$("#removeCancelBtn").trigger("click");
				}
			}).fail(function(xhr){
				console.log(status);
			});
		})
		
		
		$("#updateBtn").on("click", function() {
			let boardNo = $(this).parent().data("boardno");
			if(boardNo){
				$.getProStatus({
					"url": "/project/statusCheck.do?proId=${param.proId}"
					, "moveUrl": "/wiki/wikiUpdate.do?proId=${param.proId}&boardNo=" + boardNo
				});
			}
		});
	})
</script>