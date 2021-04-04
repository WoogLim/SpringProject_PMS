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

<c:set value="${workCustomInfoList }" var="customInfoList"/>
<c:set value="${pagination.pagingVO.dataList }" var="workList"/>
<c:set value="${pagination.pagingVO }" var="pagingVO"/>
<c:set value="${pagination.pagingVO.searchDetail }" var="searchDetail"/>
<c:set value="${pagination.pagingVO.sortVO }" var="sortVO"/>
<c:set value="${projectList }" var="proList"/>
<div class="panel-header">
		<span class="project-path"> 
			<a href="#">일감관리</a>
			<a href="#">등록된 일감</a>
		</span>

		<div class="setting__header">
			<h2>일감 리스트</h2>
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
					<select id="rankOptions" data-optioncode="WR">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'WR' }">
									<c:set value="${searchDetail.workRank eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
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
					<select id="typeOptions" data-optioncode="WT">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'WT' }">
									<c:set value="${searchDetail.workType eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
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
					<select id="statusOptions" data-optioncode="WS">
						<option value="">상관없음</option>
						<c:if test="${not empty customInfoList }">
							<c:forEach items="${customInfoList }" var="customInfoVO">
								<c:if test="${customInfoVO.groupCode eq 'WS' }">
									<c:set value="${searchDetail.workState eq customInfoVO.text ? 'selected' : ''}" var="selected"/>
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

			<!-- 프로젝트(PRO_ID) 구분 -->
			<div class="filter__condition col-2">
				<span class="condition__title">담당자 : </span>
				<div class="filter__member-status selectbox">
					<label></label>
					<select id="directorOptions" data-optioncode="DIRECTOR">
						<option value="">상관없음</option>
						<c:if test="${not empty workDirectorList }">
							<c:forEach items="${workDirectorList }" var="workVO">
								<c:set value="${searchDetail.workDirector eq workVO.workDirector ? 'selected' : ''}" var="selected"/>
								<option value="${workVO.workDirector }" ${selected }>${workVO.memName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>

			<div class="filter__condition col-2">
				<span class="condition__title">생성자 : </span>
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
	</div>
	<div class="card__row">
		<div class="table-memberlist">
			<table class="table work-table">
				<thead>
					<tr class="text-left">
						<th>일감 ID</th>
						<th>제목</th>
						<th>담당자</th>
						<th>진행률</th>
						<th>우선순위</th>
						<th>유형</th>
						<th>상태</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody id="workListBody" class="text-left">
					<c:if test="${not empty workList }">
						<c:forEach items="${workList }" var="workVO">
							<tr class="text-left">
								<td>
									<a href="${pageContext.request.contextPath }/work/workView.do?workId=${workVO.workId }">#${workVO.workId }</a>
								</td>
								<td>${workVO.boardTitle }</td>
								<td>${workVO.memName }</td>
								<td>
									<fmt:parseNumber value="${workVO.progress }" var="percent" type="number"/>	
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
								<td>
									<c:if test="${not empty customInfoList }">
										<c:set var="loopFlag" value="true"/>
										<c:forEach items="${customInfoList }" var="customInfoVO">
											<c:if test="${loopFlag }">
												<c:if test="${customInfoVO.text eq workVO.workRank }">
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
												<c:if test="${customInfoVO.text eq workVO.workType }">
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
												<c:if test="${customInfoVO.text eq workVO.workState }">
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
								<td>${workVO.createDate }</td>
							</tr>									
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<form id="workListForm">
	<%-- 날짜 정렬 --%>
	<input type="hidden" name="sortCondition" value="date">
	<input type="hidden" name="sortType" value="${sortVO.sortType }">

	<%-- 검색 조건 --%>
	<input type="hidden" name="workState" value="${searchDetail.workState }">
	<input type="hidden" name="workRank" value="${searchDetail.workRank }">	
	<input type="hidden" name="workType" value="${searchDetail.workType }">	
	<input type="hidden" name="proId" value="${searchDetail.proId }">
	<input type="hidden" name="boardWriter" value="${searchDetail.boardWriter }">
	<input type="hidden" name="workDirector" value="${searchDetail.workDirector }">
</form>

<script type="text/javascript">
	$(document).ready(function() {
		let workListForm = $("#workListForm");
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
	    
	    // 검색조건 이벤트 처리
	    $("div.filter__card").find("select").on("change", function() {
			let groupCode = $(this).data("optioncode");
			let val = $(this).val();
			switch(groupCode){
			case "WR":
				workListForm.find("input[name='workRank']").val(val);
				break;
			case "WT":
				workListForm.find("input[name='workType']").val(val);
				break;
			case "WS":
				workListForm.find("input[name='workState']").val(val);
				break;
			case "PROJECT":
				workListForm.find("input[name='proId']").val(val);
				workListForm.find("input[name='workDirector']").val("");
				workListForm.find("input[name='boardWriter']").val("");
				break;
			case "DATE":
				workListForm.find("input[name='sortType']").val(val);
				break;
			case "DIRECTOR":
				workListForm.find("input[name='workDirector']").val(val);
				break;
			case "WRITER":
				workListForm.find("input[name='boardWriter']").val(val);
				break;
			default:
				console.log("invalide args");
			}
			workListForm.submit();
	    });
	    
	    // 검색조건 초기화
	    $("#initSearchOptions").on("click", function() {
			let selects = $("div.filter__card").find("select");
			$(selects).each(function(idx, element) {
				$(this).val("");
			});
			
			let hiddens = workListForm.find("input");
			$(hiddens).each(function(idx, element){
				$(this).val("");
			});
			workListForm.submit();
	    });
	});
</script>
</body>
</html>