<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style>
	#listBtn, #updateBtn, #removeBtn {
		all: unset;
	    width: auto;
	    padding: 5px 10px;
	    border-radius: 25px;
	    display: inline-flex;
	    justify-content: center;
	    align-items: center;
	    box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.07);
	    font-weight: 500;
	    cursor: pointer;
	    box-sizing: border-box;
	    margin-bottom: 5px;
	    margin-right: 15px;
	}

 	#listBtn i { 
     margin-right: 15px; 
     font-size: 26px; 
 	} 
 	
 	#updateBtn i { 
     margin-right: 15px; 
     font-size: 26px; 
 	} 
 	
 	#removeBtn i { 
     margin-right: 15px; 
     font-size: 26px; 
 	} 

	#listBtn:hover {
	    background: #3232FF;
	    color: #ffffff;
	    transition: .3ms;
	    box-shadow: 0 0 4px 4px rgba(111, 111, 111, 0.07);
	}
	#updateBtn:hover {
	    background: #FFA343;
	    color: #ffffff;
	    transition: .3ms;
	    box-shadow: 0 0 4px 4px rgba(111, 111, 111, 0.07);
	}
	#removeBtn:hover {
	    background: red;
	    color: #ffffff;
	    transition: .3ms;
	    box-shadow: 0 0 4px 4px rgba(111, 111, 111, 0.07);
	}
</style>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
	<div class="panel-header">
		<div class="page-inner">
			<br>
			<div class="issue-header clearfix">
				<div class="float-left">
					<h1 class="fw-mediumbold" style="padding-left: 10px">
						${pronotice.boardTitle}</h1>
				</div>
				<button type="button" class="btn float-right d-flex" id="listBtn" onclick="location.href='${cPath }/proNotice/proNoticeList.do?proId=${param.proId }'">
					<i class="fas fa-list"></i>목록
				</button>
			</div>
			<br>
			<hr style="border-bottom: 2px solid black;">
			<div class="issue-body clearfix">
				<div class="float-left">
					<h3 class="fw-mediumbold" style="padding-left: 30px;">${pronotice.boardWriter}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${pronotice.createDate }</h3>
				</div>
				<br>
				<hr style="border-bottom: 1px solid black;">
				<div class="float-left" style="display : flex">
					<br>
					<c:if test="${not empty pronotice.attatchList }">
						<c:forEach items="${pronotice.attatchList }" var="attatch"
							varStatus="vs">
							<c:url value="/board/download.do" var="downloadURL">
								<c:param name="attNo" value="${attatch.attNo }" />
							</c:url>
							<a href="${downloadURL }">
								<h4 style="padding-left: 30px; color: black">
									<i class="fas fa-file" style="margin-right: 12px"></i>${attatch.attOriginname }
								</h4>
							</a>
						</c:forEach>
					</c:if>
					<c:if test="${empty pronotice.attatchList }">
						<h4 style="padding-left: 30px">첨부파일이 존재하지 않습니다.</h4>
					</c:if>
					<br><br>
				</div>
				<br>
				<hr>
				<div class="float-left">
					<h3 style="padding-left: 30px">${pronotice.boardContent }</h3>
				</div>
			</div>
			<br>
			<hr>
			<c:if test="${(authMember.currentAuthority eq 'ROLE_TEAM_MANAGER') or (authMember.memRole eq 'ROLE_ADMIN') }">
				<div class="issue-footer clearfix">
					<div class="float-right">
						<c:url value="/serverNotice/serverNoticeUpdate.do" var="updateURL">
							<c:param name="boardNo" value="${pronotice.boardNo }" />
							<c:param name="proId" value="${param.proId }" />
						</c:url>
						<a class="btn" id="updateBtn" href="${updateURL }">
							<i class="fas fa-eraser"></i>수정
						</a>
						<button type="button" id="removeBtn">
							<i class="fas fa-trash-alt"></i>삭제
						</button>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</security:authorize>
<form id="updateForm" method="get" action="${cPath }/proNotice/updateNotice.do">
	<input type="hidden" name="boardNo" value="${pronotice.boardNo }">
	<input type="hidden" name="proId" value="${param.proId }">
</form>
<form id="deleteForm" method="post" action="${cPath}/proNotice/deleteNotice.do">
	<input type="hidden" name="boardNo" value="${pronotice.boardNo }">
	<input type="hidden" name="proId" value="${param.proId }">
</form>
<script>
	let updateForm = $("#updateForm");
	let updateBtn = $("#updateBtn").on("click", function(){
		updateForm.submit();
	});
	let deleteForm = $("#deleteForm");
	let deleteBtn = $("#removeBtn").on("click", function(){
		deleteForm.submit();
	});
</script>