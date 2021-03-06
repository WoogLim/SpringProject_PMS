<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%--
* [[개정이력(Modification Information)]]
* 수정일                          수정자        수정내용
* ----------------------------------------
* 2021. 2. 5.      이선엽       최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<style>
 	.workReportForm{ 
         border: 1px solid black; 
         text-align: center;
         font-weight: bold; 
         font-size:14px; 
         height:35px; 
     } 

     .classify, .remark{ 
         border-collapse: collapse; 
         width : 15% 
     } 
  
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
 	} */
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
 	
 	.border-none{
 		border: none !important;
 	}
</style>	  
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
	<div class="panel-header">
		<div class="page-inner">
			<div class="issue-header clearfix">
				<div class="float-left">
					<h1 class="fw-mediumbold" style="padding-left: 10px">
						${boardVO.boardTitle}</h1>
				</div>
				<button type="button" class="btn float-right d-flex" id="listBtn" onclick="location.href='${cPath }/workReport/workReportList.do?proId=${param.proId }'">
					<i class="fas fa-list"></i>목록
				</button>
			</div>
			<br><br>
			<hr style="border-bottom: 2px solid black;">
			<div class="issue-body clearfix">
				<div class="float-left">
					<h3 class="fw-mediumbold" style="padding-left: 30px;">${boardVO.boardWriter}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${boardVO.createDate }</h3>
				</div>
				<br><br>
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
				</div>
				<br><br>
				<hr>
				<div class="float">
					<!-- <h4 style="padding-left: 30px"> -->${boardVO.boardContent }<!-- </h4> -->
				</div>
			</div>
			<br><br><br>
			<div class="issue-footer clearfix">
				<div class="float-right">
					<c:url value="/workReport/workReportUpdate.do" var="updateURL">
						<c:param name="boardNo" value="${boardVO.boardNo }" />
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
		</div>
	</div>
	<br>
	<li class="p-4">
		<h3 style="padding-left: 30px;">댓글</h3>
		<hr style="border: 1px solid black">
		<form method="post" class="form-inline" id="replyInsertForm"
			action="${pageContext.request.contextPath }/reply/replyInsert.do">
			<input type="hidden" name="replyNo" /> <input type="hidden"
				name="boardNo" value="${boardVO.boardNo }" />
			<table class="col-md-10" style="border-color: white;">
				<tr class="border-none">
					<td style="float:left" class="border-none">
						<input type="text" class="form-control mb-2"
						name="replyWriter" value="${authMember.memName }" readonly
						maxlength="10" />
					</td>
				</tr>
				<tr class="border-none">
					<td class="border-none" colspan="2">
						<div class="input-group">
							<textarea class="form-control mb-2 mr-2" rows="2"
								placeholder="내용 200자 이내" maxlength="100" name="replyContent"></textarea>
						</div>
					</td>
					<td colspan="3" class="border-none">
						<input type="submit" value="전송" class="btn btn-primary" />
					</td>
				</tr>
			</table>
		</form>
		<div id="listBody">
		</div>
</security:authorize>
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
 <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyModalLabel">댓글 수정</h5>
      </div>
      <security:authorize access="isAuthenticated()">
		<security:authentication property="principal" var="principal" />
		<c:set var="authMember" value="${principal.realMember }" />
      <form id="replyUpdateForm" action="${pageContext.request.contextPath }/reply/replyUpdate.do" method="post">
      	<input type="hidden" name="replyNo" required/>
      	<input type="hidden" name="boardNo"  required value="${boardVO.boardNo }"/>
	      <div class="modal-body">
	      	<table class="table form-inline">
	      		<tr>
	      			<td>
	      				<input type="text" required name="replyWriter" class="form-control" placeholder="작성자" value="${authMember.memName }" readonly/>
	      			</td>
	      		</tr>
	      		<tr>
	      			<td colspan="2">
						<div class="input-group">
							<textarea class="form-control mb-2 mr-2" rows="2" placeholder="내용 200자 이내"maxlength="200" name="replyContent"></textarea>
						</div>
					</td>
	      		</tr>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-success">등록</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      </form>
      </security:authorize>
    </div>
  </div>
</div>
<div class="modal fade" id="replyChildModal" tabindex="-1" aria-labelledby="replyChildModalLabel" aria-hidden="true">
 <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyChildModalLabel">대댓글</h5>
      </div>
      <security:authorize access="isAuthenticated()">
		<security:authentication property="principal" var="principal" />
		<c:set var="authMember" value="${principal.realMember }" />
      <form action="${pageContext.request.contextPath }/reply/replyInsert.do" method="post">
      	<input type="hidden" name="replyParent" required/>
      	<input type="hidden" name="boardNo"  required value="${boardVO.boardNo }"/>
	      <div class="modal-body">
	      	<table class="table form-inline">
	      		<tr>
	      			<td>
	      				<input type="text" required name="replyWriter" class="form-control" value="${authMember.memName }" readonly/>
	      			</td>
	      		</tr>
	      		<tr>
	      			<td colspan="2">
						<div class="input-group">
							<textarea id="inputContent"class="form-control mb-2 mr-2" rows="2" placeholder="내용 200자 이내" maxlength="200" name="replyContent">
							</textarea>
						</div>
					</td>
	      		</tr>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-success">등록</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      </form>
      </security:authorize>
    </div>
  </div>
</div>

<form id="deleteForm" method="post" action="${cPath }/workReport/workReportDelete.do?proId=${param.proId}">
	<input type="hidden" name="boardNo" value="${boardVO.boardNo }" />
</form>
<form id="searchForm" action="${pageContext.request.contextPath }/reply/replyList.do" method="get">
	<input type="hidden" name="boardNo" value="${boardVO.boardNo }" />
	<input type="hidden" name="page" />
</form>
<form id="replyDeleteForm" action="${pageContext.request.contextPath }/reply/replyDelete.do" method="post">
	<input type="hidden" name="replyNo"/>
   	<input type="hidden" name="boardNo"  required value="${boardVO.boardNo }"/>
</form>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfobject/2.2.4/pdfobject.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfobject/2.2.4/pdfobject.min.js"></script>
<script>
	let deleteForm = $("#deleteForm");
	let inputContent = $("#inputContent");
	
	let listBody = $("#listBody");
	
	function commonSuccess(resp){
		if(resp.result == "OK"){
			replyInsertForm.get(0).reset();
			inputContent.text("");
			replyModal.modal("hide");
			replyChildModal.modal("hide");
			searchForm.submit();
		}else if(resp.message){
			alert(resp.message);
		}
	}
	
	// 대댓글
	function childReply(event){
		let replyNo = $(this).parents(".liParent").find("[type='hidden']").val();
		console.log(replyNo);
		replyChildForm.get(0).replyParent.value = replyNo;
		replyChildModal.modal("show");
	}
	// 수정
	function updateReply(event){
		let replyNo = $(this).parents(".liParent").find("[type='hidden']").val();
		replyModal.modal("show");
		console.log("uR"+replyNo);
		$('#replyUpdateForm').find("[name='replyNo']").val(replyNo);
	}
	// 삭제
	function deleteReply(event){
		let replyNo = $(this).parents(".liParent").find("[type='hidden']").val();
		console.log(replyNo);
		$('#replyDeleteForm').find("[name='replyNo']").val(replyNo);
		$('#replyDeleteForm').submit();
	}
	
	let replyList = $("#listBody").on("click", ".reply-create", childReply)
	 							  .on("click", ".reply-update", updateReply)
							      .on("click", ".reply-delete", deleteReply)
							      .find("#listBody");
	
	let replyModal = $("#replyModal").on("hidden.bs.modal", function(){
		$(this).find("form").get(0).reset();
	});
	
	let replyChildModal = $("#replyChildModal").on("hidden.bs.modal", function(){
		$(this).find("form").get(0).reset();
	});
	
	let options ={
		dataType : "json",
		success :commonSuccess
	}
	
	let replyInsertForm = $("#replyInsertForm").ajaxForm(options);
	let replyUpdateForm = replyModal.find("form").ajaxForm(options);
	let replyChildForm = replyChildModal.find("form").ajaxForm(options);
	let replyDeleteForm = $("#replyDeleteForm").ajaxForm(options);
//========================================================	
	
//====================덧글 페이징=======================
	let pagingArea = $("#pagingArea");
	let pagingA = pagingArea.on('click', "a" ,function(){
		let page = $(this).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		searchForm.find("[name='page']").val(1);
		return false;
	});
	
	let searchForm = $("#searchForm").ajaxForm({
		dataType : "json",
		success : function(resp) {
			listBody.empty();
			pagingArea.empty();
			let replyList = resp.dataList;
			let ulTags = [];
			if(replyList){
				$(replyList).each(function(idx, reply){
					let ul = $("<ul class='pt-5 d-flex bd-highlight'>");
					if("${authMember.memName}" === reply.replyWriter){
						if(reply.replyParent == null){
							ul.append(
			 						$("<li>").addClass('pl-4 bd-highlight').attr('style', 'width : 15%').append(
									  $("<a>").addClass("reply-writer").text(reply.replyWriter)
			 						  , $("<span>").addClass("reply-date").text("작성 날짜 : " + reply.createDate )
			 						  , $("<p>").text(reply.replyContent)
			 						),
			 						 $("<li>").addClass("bd-highlight liParent").append(
		 								$("<input type='hidden'>").attr('value', reply.replyNo)
		 							  ,	$("<i>").addClass("fas fa-ellipsis-v reply-menu").attr("id","dropdownMenuButton").attr("data-toggle","dropdown")
									  , $("<div>").addClass("dropdown-menu").attr("aria-labelledby", "dropdownMenuButton").append(
										  $("<a>").addClass("dropdown-item reply-create").append(
										  	$("<i>").addClass("fas fa-pen").text("답글 달기")	  
										  )	  
										, $("<a>").addClass("dropdown-item reply-update").append(
										  	$("<i>").addClass("fas fa-edit").text("수정")	  
										  )
										, $("<a>").addClass("dropdown-item reply-delete").append(
											$("<i>").addClass("fas fa-trash-alt").text("삭제")	  
									  	  )
									  )
		 	 						)							  
		 					).data("reply", reply);
						}else{
							//댓글의 작성자이며, 상위 댓글이 있는 경우
							ul.attr('style', 'padding-left : 30px')
							ul.append(
		 						$("<li>").addClass('pl-4 bd-highlight').attr('style', 'width : 15%').append(
	 								
								  $("<a>").addClass("reply-writer").text(reply.replyWriter)
		 						  , $("<span>").addClass("reply-date").text("작성 날짜 : " + reply.createDate )
		 						  , $("<p>").text(reply.replyContent)
		 						  
		 						),
		 						 $("<li>").addClass("bd-highlight liParent").append(
	 								$("<input type='hidden'>").attr('value', reply.replyNo)
	 							  ,	$("<i>").addClass("fas fa-ellipsis-v reply-menu").attr("id","dropdownMenuButton").attr("data-toggle","dropdown")
								  , $("<div>").addClass("dropdown-menu").attr("aria-labelledby", "dropdownMenuButton").append(
									  $("<a>").addClass("dropdown-item reply-update").append(
									    	$("<i>").addClass("fas fa-edit").text("수정")	  
									  )
									  , $("<a>").addClass("dropdown-item reply-delete").append(
										    $("<i>").addClass("fas fa-trash-alt").text("삭제")	  
								  	  )
								  )
	 	 						)							  
		 					).data("reply", reply);
						}
 					
				}else{
					if(reply.replyParent == null){
						ul.append(
		 						$("<li>").addClass('pl-4 bd-highlight').attr('style', 'width : 15%').append(
								  $("<a>").addClass("reply-writer").text(reply.replyWriter)
		 						  , $("<span>").addClass("reply-date").text("작성 날짜 : " + reply.createDate )
		 						  , $("<p>").text(reply.replyContent)
		 						),
		 						 $("<li>").addClass("bd-highlight liParent").append(
	 								$("<input type='hidden'>").attr('value', reply.replyNo)
	 							  ,	$("<i>").addClass("fas fa-ellipsis-v reply-menu").attr("id","dropdownMenuButton").attr("data-toggle","dropdown")
								  , $("<div>").addClass("dropdown-menu").attr("aria-labelledby", "dropdownMenuButton").append(
									  $("<a>").addClass("dropdown-item reply-create").append(
									  	$("<i>").addClass("fas fa-pen").text("답글 달기")	  
									  )	  
								  )
	 	 						)							  
	 					).data("reply", reply);
					}else{
						ul.attr('style', 'padding-left : 30px')
						ul.append(
	 						$("<li>").addClass('pl-4 bd-highlight').attr('style', 'width : 15%').append(
 								
							  $("<a>").addClass("reply-writer").text(reply.replyWriter)
	 						  , $("<span>").addClass("reply-date").text("작성 날짜 : " + reply.createDate )
	 						  , $("<p>").text(reply.replyContent)
	 						)
	 					).data("reply", reply);
					}
				}
					ulTags.push(ul);
				});
				listBody.html(ulTags);
			if(replyList.length>0)
				pagingArea.html(resp.pagingHTML);
			
		}},
		error : function(errResp) {
			console.log(errResp);
		}
	}).submit();
</script>