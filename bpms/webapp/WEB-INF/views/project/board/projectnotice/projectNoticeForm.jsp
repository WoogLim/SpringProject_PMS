<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
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
<form:form commandName="notice" id="noticeForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="boardNo" id="boardNo" value="${pronotice.boardNo }" />
<input type="hidden" name="boardShow" 	value="Y" />
<input type="hidden" name="code" value="1">
<input type="hidden" name="boardWriter" value="${authMember.memId }">
<div class="page-inner">
	<span class="project-path">
		<a href="">프로젝트</a>
		<a href="">공지사항</a>
	</span>

	<div class="issue-header clearfix">
		<div class="float-left">
			<h1 class="fw-mediumbold"> 공지사항 등록</h1>
		</div>
	</div>
<table class="table">
	<tr>
		<th class="">제목</th>
		<td>
			<input type="text" class="input-box" name="boardTitle" value="${pronotice.boardTitle}" />
		</td>
	</tr>
	<tr style="height: 400px;">
		<th class="">내용</th>
		<td>
			<textarea class="input-box" name="boardContent">${pronotice.boardContent }</textarea>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td id="fileArea">
			<div>
				<c:if test="${not empty pronotice.attatchList }">
					<c:forEach items="${pronotice.attatchList }" var="attatch" varStatus="vs">
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
			<div class="input-group">
				<input type="file" class="form-control" name="boardFiles" />
				<span class="btn btn-primary plusBtn">+</span>
			</div>
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

	$("#fileArea").on("click", ".plusBtn", function(){
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		let fileTag = newDiv.find("input[type='file']");
		fileTag.val("");
		clickDiv.after(newDiv);		
	});
	
	let noticeForm =$("#noticeForm");
	$(".delAtt").on("click", function(){
		let attNo = $(this).data("att-no");
		console.log(attNo);
		noticeForm.append(
			$("<input>").attr({
				"type":"hidden"
				, "name":"delAttNos"
			}).val(attNo)
		);
		$(this).parent("span:first").hide();
	});
</script>
</body>
</html>