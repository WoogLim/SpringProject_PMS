<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<style type="text/css">
	input::placeholder{
	    color: #D8D8D8;
	}
	table {
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	}
	th, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	}
	a{
	    color: black;
	}
	.title{
	    width: 600px;
	}
	.writeday{
		width: 300px;
	}
	#divTop{
		margin-bottom: 40px;
	}
	#insertBtn {
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
	    padding-right : 30px;
	}
	
	#downExcelJxls {
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
	}

 	#insertBtn i { 
     margin-right: 15px; 
     font-size: 26px; 
 	} 
 	
 	#downExcelJxls i { 
     margin-right: 15px; 
     font-size: 26px; 
 	} 

	#insertBtn:hover {
	    background: #3232FF;
	    color: #ffffff;
	    transition: .3ms;
	    box-shadow: 0 0 4px 4px rgba(111, 111, 111, 0.07);
	}
	
	#downExcelJxls:hover {
	    background: #47C83E;
	    color: #ffffff;
	    transition: .3ms;
	    box-shadow: 0 0 4px 4px rgba(111, 111, 111, 0.07);
	}
	
	#listBody {
		cursor: pointer;
	}
</style>
<body>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<div class="panel-header">
	<div class="page-inner">
		<div class="issue-header clearfix">
			<div class="float-left">
				<h1 class="fw-mediumbold"> ?????? ????????????</h1>
			</div>
			<div>
				<a id="downExcelJxls" class="btn float-right d-flex" style="margin-left : 15px;" href="#" data-page='${pagingVO.currentPage }'>
					<i class="fas fa-file-download"></i> ????????? ??????
				</a>
	   			<c:if test="${authMember.memRole eq 'ROLE_ADMIN'}">
	   				<button type="button" class="btn float-right d-flex" id="insertBtn">
						<i class="fas fa-plus-circle"></i>??????
					</button>
				</c:if>
			</div>
		</div>		
		<br>
		<div class="float-right d-flex">
			<div class="input-group" id="inputUI">
				<select class="form-control" name="searchType">
           			<option value="title" ${'title' eq param.searchType?"selected":"" }>??????</option>
           			<option value="content" ${'content' eq param.searchType?"selected":"" }>??????</option>
           		</select>
               	<input type="text" class="form-control" id="search" name="searchWord" value="${pagingVO.searchVO.searchWord }" placeholder="search">
			</div>
		</div>
		<br><br><br><br>
		<table class="table" style="border-top: 2px solid black">
		<thead>
			<tr>
				<th style="text-align: center"><h3>??????</h3></th>
				<th style="text-align: center"><h3>??????</h3></th>
				<th style="text-align: center"><h3>?????????</h3></th>
				<th style="text-align: center;"><h3>?????????</h3></th>
			</tr>
		</thead>
			<tbody id="listBody">
			</tbody>
		</table>
		<div id="pagingArea"></div>
		<form id = "searchForm">
			<input type="hidden" name="page" >
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }">
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }">
			<input type="hidden" name="sortCondition" value="${pagingVO.sortVO.sortCondition }">
			<input type="hidden" name="sortType" value="${pagingVO.sortVO.sortType }">
		</form>
	</div>
</div>
<form id="noticeView" method="post">
	<input type="hidden" name="boardNo">
</form>
</security:authorize>
<script type="text/javascript">
	let listBody = $("#listBody");
	
	let noticeView = $("#noticeView");
	
	$("#insertBtn").on("click", function() {
		location.href = $.getContextPath() + "/serverNotice/serverNoticeInsert.do?proId=${param.proId}&mng=${param.mng}";
	})
	
	$("#downExcelJxls").on("click", function(){
		let id = $(this).prop("id");
		let page = $(this).data("page");
// 		console.log("downExcel : " + page);
		let requestURL ="${cPath}/serverNotice/downloadExcel.do?page="+page+"&jxls=true";
		$(this).attr("href", requestURL);
		return true;
	})
	
	listBody.on("click", "tr", function(){
		let boardNo = $(this).find("[type='hidden']").eq(0).text();
		let action = "${cPath}/serverNotice/serverNoticeView.do?boardNo="+boardNo+"&proId=${param.proId}";
		
		let mng = "${param.mng}";
		if(mng && mng == "Y") {
			action += "&mng=Y";
		}
		noticeView.attr("action", action);
		noticeView.find("input[name='boardNo']").val(boardNo);
		noticeView.submit();
	});

	let pagingArea = $("#pagingArea").on("click", "a" ,function(event){
		event.preventDefault();
		let page = $(this).data("page");
		console.log("pagingArea : " + page);
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		searchForm.find("[name='page']").val("");
		$('#downExcelJxls').data("page",page);
		return false;
	});
	
	let searchForm = $("#searchForm").ajaxForm({
		dataType:"json",
		success:function(resp){
			console.log(resp);
			console.log(resp.pagingVO);
			console.log(resp.pagingVO.dataList);
			let serverNoticeList = resp.pagingVO.dataList;
			let pagingHTML = resp.pagingVO.pagingHTML;
			let trTags = [];
			if(serverNoticeList.length > 0){
				$(serverNoticeList).each(function(idx, serverNotice){
					trTags.push(
		  				$("<tr>").append(
		  					$("<input type='hidden'>").text(serverNotice.boardNo)
		  					, $("<td style='text-align: center'>").text(serverNotice.rnum)
		  					, $("<td style='text-align: center'>").text(serverNotice.boardTitle)
		  					, $("<td style='text-align: center'>").text(serverNotice.boardWriter)		
		  					, $("<td style='text-align: center'>").text(serverNotice.createDate)	
		  				).data("serverNotice", serverNotice)
		  			);					
				});
			}
			else{
				trTags.push(
			  		$("<tr>").html(
			  			$("<td colspan='5'>").addClass("text-center").text("?????? ?????? ??????.")
			  		)	
				);
			}
		  	listBody.html(trTags);
		  	pagingArea.html(pagingHTML);
		}
	}).submit();
	
	$("#search").keyup(function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
</script>
