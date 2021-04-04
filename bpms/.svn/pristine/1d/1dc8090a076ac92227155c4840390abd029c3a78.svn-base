<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
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
</head>
<body>
<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>
<div class="panel-header">
	<div class="page-inner">
		<div class="issue-header clearfix">
			<div class="float-left">
				<h1 class="fw-mediumbold">프로젝트 공지사항</h1>
			</div>
			<div>
				<c:if test="${(authMember.currentAuthority eq 'ROLE_TEAM_MANAGER') or (authMember.memRole eq 'ROLE_ADMIN') }">
	   				<button type="button" class="btn float-right d-flex" id="insertBtn" onclick="location.href='insertForm.do?proId=${param.proId}'">
						<i class="fas fa-plus-circle"></i>등록
					</button>
				</c:if>
			</div>
		</div>		
		<br>
		<div class="float-right d-flex">
			<div class="input-group" id="inputUI">
				<select class="form-control" name="searchType">
           			<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
           			<option value="content" ${'content' eq param.searchType?"selected":"" }>내용</option>
           		</select>
               	<input type="text" class="form-control" id="search" name="searchWord" value="${pagingVO.searchVO.searchWord }" placeholder="search">
			</div>
		</div>
		<br><br><br><br>
		<table class="table" style="border-top: 2px solid black">
		<thead>
			<tr>
				<th style="text-align: center"><h3>번호</h3></th>
				<th style="text-align: center"><h3>제목</h3></th>
				<th style="text-align: center"><h3>작성자</h3></th>
				<th style="text-align: center;"><h3>작성일</h3></th>
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
<form id="noticeView" method="post" action="">
	<input type="hidden" name="boardNo">
</form>

<script type="text/javascript">
	let listBody = $("#listBody");
	
	let noticeView = $("#noticeView");
	
	listBody.on("click", "tr", function(){
		let boardNo = $(this).find("[type='hidden']").eq(0).text();
		if(boardNo && boardNo.trim().length > 0) {
			noticeView.attr("action", "${cPath}/proNotice/proNoticeView.do?boardNo="+boardNo+"&proId=${param.proId}")
			noticeView.find("input[type='hidden']").val(boardNo);
			noticeView.submit();
		}
	});

	let pagingArea = $("#pagingArea").on("click", "a" ,function(event){
		event.preventDefault();
		let page = $(this).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		searchForm.find("[name='page']").val("");
		return false;
	});
	
	let searchForm = $("#searchForm").ajaxForm({
		dataType:"json",
		success:function(paging){
			let noticeList = paging.pagingVO.dataList;
			let pagingHTML = paging.pagingVO.pagingHTML;
			let trTags = [];
			if(noticeList.length > 0){
				$(noticeList).each(function(idx, pronotice){
					trTags.push(
		  				$("<tr>").append(
		  					$("<input type='hidden'>").text(pronotice.boardNo)
		  					, $("<td style='text-align: center'>").text(pronotice.rnum)
		  					, $("<td style='text-align: center'>").text(pronotice.boardTitle)
		  					, $("<td style='text-align: center'>").text(pronotice.boardWriter)		
		  					, $("<td style='text-align: center'>").text(pronotice.createDate)
		  				).data("pronotice", pronotice)
		  			);					
				});
			}
			else{
				trTags.push(
			  		$("<tr>").html(
			  			$("<td colspan='5'>").addClass("text-center").text("검색 결과 없음.")
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
</body>
</html>