<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------------------------------------
* 2021. 2. 13.	임건			최초작성
* 2021. 2. 15.	이선엽		코딩
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="wiki-container row">
	<%-- 위키 게시글 카드 --%>
	<c:set var="wikiList" value="${pagingVO.dataList }" />
	<c:if test="${not empty wikiList }">
		<c:forEach items="${wikiList }" var="wiki">
			<div class="wiki-item col-lg-3 col-md-4 col-sm-6 no-drag listBody">
				<div class="wiki-card">
					<div class="wiki-header">
						<div class="wiki-icon">
							<i class="fas fa-info"></i>
							<div class="dot-solid"></div>
							<div class="dot-solid"></div>
						</div>
						<%-- 위키 게시글 제목 --%>
						<div class="wiki-title">
							<h3>${wiki.boardTitle }</h3>
							<input type="hidden" value="${wiki.boardNo }" />
							<br>
							<hr style="border-bottom-width: 2px">
							<br>
						</div>
					</div>
					<%-- 위키 게시글 내용 최대 높이 지나가면 안보임--%>
					<div class="wiki-content">
						<!-- 자바스크립트를 다루는 사람은 많지만 자바스크립트를 명확히 알고 -->
						<!-- 사용하는 사름은 그리 많지 않다. 엔진에 대해 이해력이 필요하다. -->
<%-- 						${wiki.boardContent } --%>
					</div>

					<%-- 위키 게시글 작성일--%>
					<div class="wiki-datetime">
						${wiki.createDate }
						<%-- 위키 게시글 최근 수정일--%>
						<c:if test="${not empty wiki.modifyDate }">
							<span class="update-datetime"> 최근 수정 : ${wiki.modifyDate }</span>
						</c:if>
					</div>

					<div class="wiki-writer">
						<div class="writer-info">
							<%-- 위키 게시글 작성자 프로필이미지 따로 기능 구현은 아직 안했으므로 이름만 넣읍시다--%>
							<div class="avatar-sm">
								<img src="../assets/img/flaticon/poyo.png" alt="..."
									class="avatar-img rounded-circle">
							</div>
							<%-- 위키 게시글 작성자 이름 data-writer에는 작성자 id 넣어 사용하면 될듯합니다. --%>
							<div class="writer-name" data-writer="">&nbsp;&nbsp;${wiki.boardWriter }</div>
						</div>

<!-- 						<div class="wiki-btngroup"> -->
<%-- 							<c:url value="/wiki/wikiUpdate.do" var="updateURL"> --%>
<%-- 								<c:param name="what" value="${wiki.boardNo }" /> --%>
<%-- 							</c:url> --%>
<!-- 							<button class="wiki-modify" type="button" -->
<%-- 								onclick="location.href='${updateURL}'">수정</button> --%>
<!-- 							<button class="wiki-remove" type="button" data-toggle="modal" -->
<!-- 								data-target="#remove-wiki">삭제</button> -->
<!-- 						</div> -->
					</div>
				</div>
			</div>
<!-- 			<form id="deleteForm" method="post" -->
<%-- 				action="${cPath }/wiki/wikiDelete.do"> --%>
<%-- 				<input type="hidden" name="boardNo" value="${wiki.boardNo }" /> --%>
<!-- 			</form> -->
			<!-- 위키 삭제 모달 -->
<!-- 			<div class="modal fade customModal" id="remove-wiki"> -->
<!-- 				<div class="modal-dialog modal-md"> -->
<!-- 					<div class="modal-content"> -->
<!-- 						<div class="modal-body"> -->

<!-- 							<div class="modal__header">해당 위키를 삭제하시겠습니까?</div> -->

<!-- 							<div class="form-groupbtn"> -->
<!-- 								<button type="button" class="form-cancel" data-toggle="modal" -->
<!-- 									data-target="#remove-wiki">취소</button> -->
<!-- 								<button type="button" class="form-confirm" id="removeBtn">삭제</button> -->
<!-- 							</div> -->

<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</c:forEach>
	</c:if>
</div>

<div class="wiki-write">
	<button class="wiki-btn wiki-writebtn"
		id="createWikiBtn">
		<i class="fas fa-pencil-alt"></i> <span class="wiki-guide">위키 작성</span>
	</button>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/projectStatus.js"></script>
<script>

	$("#createWikiBtn").on("click", function() {
		$.getProStatus({
			"url": "/project/statusCheck.do?proId=${param.proId}"
			, "moveUrl": "/wiki/wikiInsert.do?proId=${param.proId }"
		});
	});
// 	let wikiTitle = $(".wiki-title");
// 	let wikiContent = $(".wiki-content");
	let listBody = $(".listBody");
	
	let wikiView = $("#wikiView");
	
	listBody.on("click", function(){
		let boardNo = $(this).find("input[type='hidden']").val();
		location.href = "${cPath}/wiki/wikiView.do?proId=${param.proId}&boardNo="+boardNo;
	});
	
// 	wikiContent.on("click", function(){
// 		let boardNo = $(this).prev().find("input[type='hidden']").val();
// 		location.href = "${cPath}/wiki/wikiView.do?what="+boardNo;
// 	});

	let deleteForm = $('#deleteForm');
<%-- 위키 버튼 마우스 오버시 나타나는 문자 --%>
	$(function() {
		$('.main-panel').addClass('wiki-box')

		$('.wiki-writebtn i').on('mouseover mouseleave', function() {
			$('.wiki-guide').toggle();
		})

		$('.wiki-writebtn').on('click', function() {

		})

		$('#removeBtn').on('click', function() {
			deleteForm.submit();
		})
	})
</script>