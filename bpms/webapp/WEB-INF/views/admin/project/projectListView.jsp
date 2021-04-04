<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set value="${pagination.pagingVO.dataList }" var="dataList"/>
<c:set value="${pagination.pagingVO.searchDetail }" var="searchDetail"/>
<c:set value="${pagination.pagingVO.sortVO }" var="sortVO"/>
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path"> 
			<a href="#">프로젝트 관리</a>
			<a href="#">등록된 프로젝트 목록</a>
		</span>

		<div class="setting__header">
			<h2>프로젝트 목록</h2>
		</div>
		
		<div class="filter__card">
			<ul class="filter__role row">
				<h2 class="filter-title">검색 조건</h2>

				<div class="filter-init">
					<button class="" onclick="" type="button" id="initSearchOptions">검색 필터 초기화</button>
				</div>

				<li class="project-rules col-12 row">

					<!-- 프로젝트 상태(CODE) 구분 -->
					<div class="filter__condition col-2">
						<span class="condition__title">상태 : </span>
						<div class="filter__member-status selectbox">
							<label></label>
							<select id="statusOptions" data-optioncode="CODE">
								<option value="">상관없음</option>
								<c:if test="${not empty codeList }">
									<c:forEach items="${codeList }" var="codeVO">
										<c:if test="${not (codeVO.code eq 1) }">
											<c:set value="${searchDetail.code eq codeVO.code ? 'selected' : '' }" var="selected"/>
											<option value="${codeVO.code }" ${selected }>${codeVO.codeName }</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select>
						</div>
					</div>

					<!-- 등록일(DATE) 구분 -->
					<div class="filter__condition col-2">
						<span class="condition__title">등록일 : </span>
						<div class="filter__member-status selectbox">
							<label></label>
							<select id="dateOptions" data-optioncode="DATE">
								<option value="" ${empty sortVO ? "selected" : "" }>상관없음</option>
								<option value="DESC" ${not empty sortVO and sortVO.sortType eq "DESC" ? "selected" : "" }>최근순</option>
								<option value="ASC" ${not empty sortVO and sortVO.sortType eq "ASC" ? "selected" : "" }>과거순</option>
							</select>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="memberlist__card">
			<div class="card__row">
				<div class="table-memberlist">
					<table class="table issue-table">
						<thead>
							<tr class="text-left">
								<th>프로젝트 ID</th>
								<th>프로젝트 이름</th>
								<th>상태</th>
								<th>등록된 일감</th>
								<th>발행된 이슈</th>
								<th>진행률</th>
								<th>생성일</th>
								<th>종료일</th>
							</tr>
						</thead>
						<tbody id="projectListBody" class="text-left">
							<c:if test="${not empty dataList }">
								<c:forEach items="${dataList }" var="projectVO">
									<tr>
										<td>
											<a href="${pageContext.request.contextPath }/project/main?proId=${projectVO.proId }">#${projectVO.proId }</a>
										</td>
										<td>${projectVO.proName }</td>
										<td>${projectVO.codeName }</td>
										<td>${projectVO.workCnt }개</td>
										<td>${projectVO.issueCnt }개</td>
										<td>
											<c:set value="${projectVO.progress }" var="percent"/>
											<div class="progress">
												<c:set var="className" value="bg-success"/>
												<c:if test="${percent eq null or percent lt 40 }">
													<c:set var="className" value="bg-danger"/>
												</c:if>
												<c:if test="${percent ge 40 and percent lt 80 }">
													<c:set var="className" value="bg-warning"/>
												</c:if>
												<div class="progress-bar progress-bar-striped ${className }" 
													role="progressbar" 
													style="width: ${percent}%"
													aria-valuenow="40" 
													aria-valuemin="0" 
													aria-valuemax="100" 
													data-toggle="tooltip" 
													data-placement="top" 
													data-original-title="진행률 : ${percent eq null ? 0 : percent } %">
													${percent }%
													</div>
											</div>
										</td>
										<td>${projectVO.createDate }</td>
										<td>${projectVO.endDate }</td>
									</tr>		
								</c:forEach>
							</c:if>
							<c:if test="${empty dataList }">
								<tr class="text-center">
									<th colspan="8">검색결과가 없습니다.</th>
								</tr>
							</c:if>				
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<form id="projectListForm">
	<%-- 날짜 정렬 --%>
	<input type="hidden" name="sortCondition" value="date">
	<input type="hidden" name="sortType" value="${sortVO.sortType }">

	<%-- 검색 조건 --%>
	<input type="hidden" name="code" value="${searchDetail.code }">
	<input type="hidden" name="groupCode" value="P">
</form>

<script type="text/javascript">
	$(document).ready(function() {
	    var selectTarget = $('.selectbox select');
		let projectListForm = $("#projectListForm");
	    
	    selectTarget.each(function(){
	    	let select_name = $(this).children('option:selected').text();
	    	$(this).siblings('label').text(select_name)
	    })
	    
	    selectTarget.change(function(){ 
	        var select_name = $(this).children('option:selected').text(); 
	        
	        /* 형제 요소인 label에 표시 */
	        $(this).siblings('label').text(select_name); 
	    }); 
	    
	    // 검색조건 이벤트 처리
	    $("div.filter__card").find("select").on("change", function() {
			let groupCode = $(this).data("optioncode");
			let val = $(this).val();
			switch(groupCode){
			case "CODE":
				projectListForm.find("input[name='code']").val(val);
				break;
			case "DATE":
				projectListForm.find("input[name='sortType']").val(val);
				break;
			default:
				console.log("invalide args");
			}
			projectListForm.submit();
	    });
	    
	    // 검색조건 초기화
	    $("#initSearchOptions").on("click", function() {
			let selects = $("div.filter__card").find("select");
			$(selects).each(function(idx, element) {
				$(this).val("");
			});
			
			let hiddens = projectListForm.find("input");
			$(hiddens).each(function(idx, element){
				$(this).val("");
			});
			
			projectListForm.submit();
	    });
	});
</script>







