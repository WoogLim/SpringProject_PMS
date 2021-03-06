<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
<%--
* [[개정이력(Modification Information)]]
* 수정일                          수정자        수정내용
* ----------------------------------------
* 2021. 2. 5.      이선엽       최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
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
	
	.workReportForm tr, th, td{
        border: 1px solid black;
        text-align: center;
        font-weight: bold;
        font-size:14px;
        height:35px;
    }

    .classify-form, .remark-form{
        border-collapse: collapse;
        width : 15%
    }
	
</style>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<div class="issue-header clearfix">
	<div class="float-left">
		<c:choose>
			<c:when test="${empty wiki.boardNo }">
	  			<h1 class="fw-mediumbold"> 일일 업무 보고 등록</h1>
			</c:when>
			<c:otherwise>
				<h1 class="fw-mediumbold"> 일일 업무 보고 수정</h1>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<form:form commandName="board" id="boardForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="boardNo" value="${boardVO.boardNo }" required />
	<input type="hidden" name="boardWriter" value="${authMember.memName} " />
	<input type="hidden" name="boardShow" 	value="Y" />
	<input type="hidden" name="code" value="12" />
	<table class="table table-bordered">
		<tr>
			<th class="text-center">제목</th>
			<td class="pb-1">
				<input type="text" class="form-control"
				required name="boardTitle" value="${boardVO.boardTitle}" />
				<form:errors path="boardTitle" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<th class="text-center">첨부파일</th>
			<td class="pb-1" id="fileArea">
				<div>
					<c:if test="${not empty boardVO.attatchList }">
						<c:forEach items="${boardVO.attatchList }" var="attatch" varStatus="vs">
							<span title="다운로드:${attatch.attDowncount }" class="attatchSpan">
								<img src="${cPath }/images/delete.png" class="delAtt" data-att-no="${attatch.attNo }"/>
								${attatch.attOriginname } &nbsp; ${not vs.last?"|":"" }
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
		<tr style="height: 100%;">
			<th class="">내용</th>
			<td>
				<textarea name="boardContent" style="height:1500px">
					<c:choose>
						<c:when test="${empty boardVO.boardNo }">
							${form.wrForm }
						</c:when>
						<c:otherwise>
							${boardVO.boardContent }
						</c:otherwise>
					</c:choose>
				</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center pt-2">
				<input type="submit" class="btn btn-primary ml-5" value="등록" />
				<input type="button" class="btn btn-danger" value="취소" onclick="history.go(-1)" />
			</td>
		</tr>
	</table>
</form:form>
</security:authorize>
<script type="text/javascript">
	CKEDITOR.replace("boardContent", {
		 filebrowserImageUploadUrl: '${cPath }/board/imageUpload.do?command=QuickUpload&type=Images',
		 height:1000	 
	});
	
	$(document).ready(function(){
		$('<table>').attr('text-align', 'center');
	})
	
	$("#fileArea").on("click", ".plusBtn", function(){
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		let fileTag = newDiv.find("input[type='file']");
		fileTag.val("");
		clickDiv.after(newDiv);		
	});
	
	let boardForm =$("#boardForm");
	$(".delAtt").on("click", function(){
		let att_no = $(this).data("attNo");
		boardForm.append(
			$("<input>").attr({
				"type":"hidden"
				, "name":"delAttNos"
			}).val(att_no)
		);
		$(this).parent("span:first").hide();
	});
	
	boardForm.validate({
		onsubmit:true,
		onfocusout:function(element, event){
			return this.element(element);
		},
		errorPlacement: function(error, element) {
			error.appendTo( $(element).parents("td:first") );
	  	}
	});
	
</script>