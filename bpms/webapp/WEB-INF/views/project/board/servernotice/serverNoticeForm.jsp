<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
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
<form:form modelAttribute="boardVO" id="boardForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="boardNo" id="boardNo" value="${boardVO.boardNo }" />
<input type="hidden" name="boardWriter" id="boardWriter" value="${authMember.memName }" />
<input type="hidden" name="boardShow" id="boardShow" value="Y" />
<%-- <input type="hidden" name="groupCode" value="${pronotice.groupCode }" /> --%>
<%-- <input type="hidden" name="proId" value="${pronotice.proId }" /> --%>
<div class="page-inner">
<table class="table">
	<tr>
		<th class="">제목</th>
		<td>
			<input type="text" class="input-box" name="boardTitle" value="${boardVO.boardTitle}" />
		</td>
	</tr>
	<tr style="height: 400px;">
		<th class="">내용</th>
		<td>
			<textarea class="input-box" name="boardContent">${boardVO.boardContent }</textarea>
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
	<tr>
		<th colspan="2" class="text-center pt-2">
			<input type="button" class="btn btn-primary ml-5" id="submitBtn" value="저장" />
			<input type="button" class="btn btn-danger" id="cancelBtn" value="취소"/>
		</th>
	</tr>
</table>
</div>
</form:form>
</security:authorize>
<script type="text/javascript">
	let boardForm =$("#boardForm");
	
	CKEDITOR.replace("boardContent", {
		 filebrowserImageUploadUrl: '${cPath }/board/imageUpload.do?command=QuickUpload&type=Images'
	});
	
	$("#submitBtn").on("click", function() {
		let mng = "${param.mng}";
		if(mng) {
			let hidden = $("<input>").attr("type", "hidden").attr("name", mng).val(mng);
			boardForm.append(hidden);
		}
		boardForm.submit();
	});
	
	$("#cancelBtn").on("click", function() {
		let boardNo = "${param.boardNo}";
		console.log(boardNo);
		if(boardNo && boardNo.length > 0) {
			location.href = $.getContextPath() + "/serverNotice/serverNoticeView.do?boardNo=${param.boardNo}&proId=${param.proId}&mng=${param.mng}";
		} else {
			history.go(-1);
		}
	});
	
// 	boardForm.validate({
//  		onsubmit:true,
//  		onfocusout:function(element, event){
//  			return this.element(element);
//  		},
//  		errorPlacement: function(error, element) {
//  			error.appendTo( $(element).parents("td:first") );
//  	  	}
//  	});
	
	$("#fileArea").on("click", ".plusBtn", function(){
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		let fileTag = newDiv.find("input[type='file']");
		fileTag.val("");
		clickDiv.after(newDiv);		
	});
	
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
	
</script>