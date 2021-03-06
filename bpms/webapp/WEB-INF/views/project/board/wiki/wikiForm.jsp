<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.input-box {
		display: block;
		width: 100%;
		height: 95%;
		padding: 0.375rem 0.75rem;
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
		color: #212529;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid #ced4da;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		border-radius: 0.25rem;
		transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}
</style>
</head>
<body>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<form:form modelAttribute="wiki" id="wikiForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="boardNo" id="boardNo" value="${wiki.boardNo }" />
	<input type="hidden" class="form-control" name="boardWriter" value="${authMember.memName} " />
	<input type="hidden" name="boardShow" 	value="Y" />
	<div class="page-inner">
		<div class="issue-header clearfix">
			<div class="float-left">
				<c:choose>
					<c:when test="${empty wiki.boardNo }">
			  			<h1 class="fw-mediumbold"> 위키 등록</h1>
					</c:when>
					<c:otherwise>
						<h1 class="fw-mediumbold"> 위키 수정</h1>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<br>
	<table class="table">
		<tr>
			<th class="">제목</th>
			<td>
				<input type="text" class="input-box" name="boardTitle" value="${wiki.boardTitle}" />
			</td>
		</tr>
		<tr style="height: 400px;">
			<th class="">내용</th>
			<td>
				<textarea class="input-box" name="boardContent">${wiki.boardContent }</textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2" class="text-center pt-2">
				<input type="submit" class="btn btn-primary ml-5" value="저장" />
				<input type="button" class="btn btn-danger" value="취소" onclick="history.go(-1)" />
			</th>
		</tr>
	</table>
	</div>
</form:form>
</security:authorize>
<script type="text/javascript">
	CKEDITOR.replace("boardContent", {
		 filebrowserImageUploadUrl: '${cPath }/board/imageUpload.do?command=QuickUpload&type=Images'
	});
</script>
</body>
</html>