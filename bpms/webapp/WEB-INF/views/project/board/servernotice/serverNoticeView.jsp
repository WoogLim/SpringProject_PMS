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
						${boardVO.boardTitle}</h1>
				</div>
				<button type="button" class="btn float-right d-flex" id="listBtn">
					<i class="fas fa-list"></i>목록
				</button>
			</div>
			<br>
			<hr style="border-bottom: 2px solid black;">
			<div class="issue-body clearfix">
				<div class="float-left">
					<h3 class="fw-mediumbold" style="padding-left: 30px;">${boardVO.boardWriter}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${boardVO.createDate }</h3>
				</div>
				<br>
				<hr style="border-bottom: 1px solid black;">
				<div class="float-left" style="display : flex">
					<br>
					<c:if test="${not empty boardVO.attatchList }">
						<c:forEach items="${boardVO.attatchList }" var="attatch"
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
					<c:if test="${empty boardVO.attatchList }">
						<h4 style="padding-left: 30px">첨부파일이 존재하지 않습니다.</h4>
					</c:if>
					<br><br>
				</div>
				<br>
				<hr>
				<div class="float-left">
					<h3 style="padding-left: 30px">${boardVO.boardContent }</h3>
				</div>
			</div>
			<br>
			<hr>
			<c:if test = "${authMember.memRole eq 'ROLE_ADMIN' }">
				<div class="issue-footer clearfix">
					<div class="float-right" data-boardno="${boardVO.boardNo }">
<%-- 						<c:url value="/serverNotice/serverNoticeUpdate.do" var="updateURL"> --%>
<%-- 							<c:param name="boardNo" value="${boardVO.boardNo }" /> --%>
<%-- 							<c:param name="proId" value="${param.proId }" /> --%>
<%-- 						</c:url> --%>
						<a class="btn" id="updateBtn">
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
	<form id="deleteForm" method="post" action="${cPath }/serverNotice/serverNoticeDelete.do?proId=${param.proId}">
		<input type="hidden" name="boardNo" value="${boardVO.boardNo }" />
	</form>
</security:authorize>
<script>
	let deleteForm = $("#deleteForm");
	let removeBtn = $("#removeBtn").on("click", function(){
		let mng = "${param.mng}";
		let hidden = $("<input>").attr("type", "hidden")
								 .attr("name", "mng")
								 .val(mng);
		deleteForm.append(hidden);
		deleteForm.submit();
	});
	
	$("#listBtn").on("click", function() {
		let url = "${cPath }/serverNotice/serverNoticeList.do?proId=${param.proId }&mng=${param.mng}";
		location.href = url;
	});
	
	$("#updateBtn").on("click", function() {
		let boardNo = $(this).parent().data("boardno");
		let url = "${cPath }/serverNotice/serverNoticeUpdate.do?proId=${param.proId}&mng=${param.mng}&boardNo=" + boardNo;
		location.href = url;
	});
	
</script>