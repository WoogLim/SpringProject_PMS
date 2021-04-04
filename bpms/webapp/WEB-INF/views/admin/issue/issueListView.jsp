<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:set value="${issueCustomInfoList }" var="customInfoList"/>
<c:set value="${pagination.pagingVO.dataList }" var="issueList"/>
<c:set value="${pagination.pagingVO }" var="pagingVO"/>
<c:set value="${pagination.pagingVO.searchDetail }" var="searchDetail"/>
<c:set value="${pagination.pagingVO.sortVO }" var="sortVO"/>
<c:set value="${projectList }" var="proList"/>
<div class="panel-header">
		<span class="project-path"> 
			<a href="#">이슈관리</a>
			<a href="#">등록된 모든이슈</a>
		</span>

		<div class="setting__header">
			<h2>이슈 리스트</h2>
		</div>
</div>		
<div class="filter__card">
	<ul class="filter__role row">
		<h2 class="filter-title">검색 조건</h2>

		<div class="filter-init">
			<button id="initSearchOptions" type="button">검색 필터 초기화</button>
		</div>
		<li class="project-rules col-12 row">
			<!-- 우선순위(RANK) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">우선순위 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="rankOptions" data-optioncode="IR">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'IR' }">
									<c:set value="${searchDetail.issueRank eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
									<option value="${customInfoVO.text }" ${selected }>${customInfoVO.text }</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>

			<!-- 유형(TYPE) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">유형 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="typeOptions" data-optioncode="IT">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'IT' }">
									<c:set value="${searchDetail.issueType eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
									<option value="${customInfoVO.text }" ${selected }>${customInfoVO.text }</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			
			<!-- 상태(STATE) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">상태 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="statusOptions" data-optioncode="IS">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'IS' }">
									<c:set value="${searchDetail.issueState eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
									<option value="${customInfoVO.text }" ${selected }>${customInfoVO.text }</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>

			<!-- 발행일(START_DATE) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">발행일 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="dateOptions" data-optioncode="DATE">
						<option value="">상관없음</option>
						<option value="DESC" ${'DESC' eq sortVO.sortType ? "selected" : "" }>최근순</option>
						<option value="ASC" ${'ASC' eq sortVO.sortType ? "selected" : "" }>과거순</option>
					</select>
				</div>
			</div>
		</li>
		
		<li class="project-rules project-rules2 col-12 row">

			<!-- 프로젝트(PRO_ID) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">프로젝트 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="projectOptions" data-optioncode="PROJECT">
						<option value="">상관없음</option>
						<c:if test="${not empty proList }">
							<c:forEach items="${proList }" var="projectVO">
								<c:set value="${searchDetail.proId eq projectVO.proId ? 'selected' : ''}" var="selected"/>
								<option value="${projectVO.proId }" ${selected }>${projectVO.proName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>

			<!-- 담당자(ISSUE_DIRECTOR) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">담당자 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="directorOptions" data-optioncode="DIRECTOR">
						<option value="">상관없음</option>
						<c:if test="${not empty issueDirectorList }">
							<c:forEach items="${issueDirectorList }" var="issueVO">
								<c:set value="${searchDetail.issueDirector eq issueVO.issueDirector ? 'selected' : ''}" var="selected"/>
								<option value="${issueVO.issueDirector }" ${selected }>${issueVO.memName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			
			<!-- 발행인(BOARD_WRITER) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">발행인 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="writerOptions" data-optioncode="WRITER">
						<option value="">상관없음</option>
						<c:if test="${not empty boardWriterList }">
							<c:forEach items="${boardWriterList }" var="boardVO">
								<c:set value="${searchDetail.boardWriter eq boardVO.boardWriter ? 'selected' : ''}" var="selected"/>
								<option value="${boardVO.boardWriter }" ${selected }>${boardVO.memName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</li>
	</ul>
</div>
<div class="memberlist__card">
	<div class="clearfix search__form">
		<div class="role__add float--left">
			<button type="button" class="member__addbtn" id="pdfDownloadBtn">
				PDF 출력
			</button>
			<button type="button" class="member__addbtn" id="excelDownloadBtn">
				Excel 출력
			</button>
		</div>
	</div>
	<div class="card__row">
		<div class="table-memberlist">
			<table class="table issue-table">
				<thead>
					<tr class="text-left">
						<th>이슈 ID</th>
						<th>제목</th>
						<th>담당자</th>
						<th>진행률</th>
						<th>우선순위</th>
						<th>유형</th>
						<th>상태</th>
						<th>발행일</th>
					</tr>
				</thead>
				<tbody id="issueListBody" class="text-center">
					<c:if test="${not empty issueList }">
						<c:forEach items="${issueList }" var="issueVO">
							<tr class="text-left">
								<td>
									<a href="${pageContext.request.contextPath }/issue/issueView.do?issueId=${issueVO.issueId }">#${issueVO.issueId }</a>
								</td>
								<td>${issueVO.boardTitle }</td>
								<td>${issueVO.memName }</td>
								<td>
									<fmt:parseNumber value="${issueVO.progress }" var="percent" type="number"/>	
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
										data-original-title="진행률 : ${percent eq null ? 0 : percent } %"
										data-original-title="60%">${percent }%</div>
									</div>
								</td>
								<td>
									<c:if test="${not empty customInfoList }">
										<c:set var="loopFlag" value="true"/>
										<c:forEach items="${customInfoList }" var="customInfoVO">
											<c:if test="${loopFlag }">
												<c:if test="${customInfoVO.text eq issueVO.issueRank }">
													<c:set var="loopFlag" value="false"/>
													<span class="custom-iconbox" style="background-color: ${customInfoVO.backgroundColor}">
														<span class="custom-icon" style="color: ${customInfoVO.iconColor}">
															<i class="${customInfoVO.iconClass }"></i>
														</span>
														<span class="custom-text" style="color: ${customInfoVO.textColor}">${customInfoVO.text }</span>
													</span>
												</c:if>
											</c:if>
										</c:forEach>
									</c:if>
								</td>
								<td>
									<c:if test="${not empty customInfoList }">
										<c:set var="loopFlag" value="true"/>
										<c:forEach items="${customInfoList }" var="customInfoVO">
											<c:if test="${loopFlag }">
												<c:if test="${customInfoVO.text eq issueVO.issueType }">
													<c:set var="loopFlag" value="false"/>
													<span class="custom-iconbox" style="background-color: ${customInfoVO.backgroundColor}">
														<span class="custom-icon" style="color: ${customInfoVO.iconColor}">
															<i class="${customInfoVO.iconClass }"></i>
														</span>
														<span class="custom-text" style="color: ${customInfoVO.textColor}">${customInfoVO.text }</span>
													</span>
												</c:if>
											</c:if>
										</c:forEach>
									</c:if>
								</td>
								<td>
									<c:if test="${not empty customInfoList }">
										<c:set var="loopFlag" value="true"/>
										<c:forEach items="${customInfoList }" var="customInfoVO">
											<c:if test="${loopFlag }">
												<c:if test="${customInfoVO.text eq issueVO.issueState }">
													<c:set var="loopFlag" value="false"/>
													<span class="custom-iconbox" style="background-color: ${customInfoVO.backgroundColor}">
														<span class="custom-icon" style="color: ${customInfoVO.iconColor}">
															<i class="${customInfoVO.iconClass }"></i>
														</span>
														<span class="custom-text" style="color: ${customInfoVO.textColor}">${customInfoVO.text }</span>
													</span>
												</c:if>
											</c:if>
										</c:forEach>
									</c:if>
								</td>
								<td>${issueVO.createDate }</td>
							</tr>									
						</c:forEach>
					</c:if>
					<c:if test="${empty issueList }">
						<tr class="">
							<td colspan="8">
								<p>발행된 이슈가 없습니다.</p>
							</td>
						<tr>
					</c:if>
				</tbody>
			</table>
			<div id="pagingArea">
				${pagingVO.pagingHTML }
				<%-- paginationHTML Area --%>
			</div>
		</div>
	</div>
</div>

<form id="issueListForm">
	<%-- 날짜 정렬 --%>
	<input type="hidden" name="sortCondition" value="date">
	<input type="hidden" name="sortType" value="${sortVO.sortType }">

	<%-- 페이징 --%>	
	<input type="hidden" name="currentPage" value="${pagingVO.currentPage }">

	<%-- 검색 조건 --%>
	<input type="hidden" name="issueState" value="${searchDetail.issueState }">
	<input type="hidden" name="issueRank" value="${searchDetail.issueRank }">
	<input type="hidden" name="issueType" value="${searchDetail.issueType }">
	<input type="hidden" name="issueDirector" value="${searchDetail.issueDirector }"> 
	<input type="hidden" name="boardWriter" value="${searchDetail.boardWriter }">
	<input type="hidden" name="proId" value="${searchDetail.proId }"> 
</form>

<script type="text/javascript">
	$(document).ready(function() {
		let issueListForm = $("#issueListForm");
	    let selectTarget = $('.selectbox select');

	    selectTarget.each(function(){
	    	let select_name = $(this).children('option:selected').text();
	    	$(this).siblings('label').text(select_name)
	    })
	    
	    selectTarget.change(function(){ 
	        let select_name = $(this).children('option:selected').text(); 
	        
	        /* 형제 요소인 label에 표시 */
	        $(this).siblings('label').text(select_name); 
	    }); 

	    // paging처리
	    $("#pagingArea").on("click", "a", function(event) {
			event.preventDefault();
			let currentPage = $(this).data("page");
			issueListForm.find("input[name='currentPage']").val(currentPage);
			issueListForm.submit();
			return false;
		});
	    
	    // 검색조건 이벤트 처리
	    $("div.filter__card").find("select").on("change", function() {
			let optionCode = $(this).data("optioncode");
			let val = $(this).val();
			switch(optionCode){
			case "IR":
				issueListForm.find("input[name='issueRank']").val(val);
				break;
			case "IT":
				issueListForm.find("input[name='issueType']").val(val);
				break;
			case "IS":
				issueListForm.find("input[name='issueState']").val(val);
				break;
			case "PROJECT":
				issueListForm.find("input[name='proId']").val(val);
				issueListForm.find("input[name='issueDirector']").val("");
				issueListForm.find("input[name='boardWriter']").val("");
				break;
			case "DATE":
				issueListForm.find("input[name='sortType']").val(val);
				break;
			case "DIRECTOR":
				console.log(val);
				issueListForm.find("input[name='issueDirector']").val(val);
				break;
			case "WRITER":
				issueListForm.find("input[name='boardWriter']").val(val);
				break;
			default:
				console.log("invalide args");
			}
			issueListForm.submit();
	    });
	    
	    // 검색조건 초기화
	    $("#initSearchOptions").on("click", function() {
			let selects = $("div.filter__card").find("select");
			$(selects).each(function(idx, element) {
				$(this).val("");
			});
			
			let hiddens = issueListForm.find("input");
			$(hiddens).each(function(idx, element){
				$(this).val("");
			});
			
			issueListForm.submit();
	    });
	});
</script>
</body>
</html>