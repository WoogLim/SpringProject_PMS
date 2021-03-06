<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자     수정내용
* ----------    -------- -----------------
* 2021. 1. 28.	 임건		최초작성
* 2021. 2. 04.   신광진		Controller연동 및 데이터처리
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<c:set value="${pagination.pagingVO }" var="pagingVO"/>
<c:set value="${pagingVO.searchDetail }" var="searchDatail"/>
<c:set value="${pagingVO.sortVO }" var="sortVO"/>
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path"> 
			<a href="#">관리</a>
			<a href="#">등록된 구성원</a>
		</span>

		<div class="setting__header">
			<h2>사용자</h2>
			<div class="role__add">
				<button type="button" class="member__addbtn" id="memberInsertBtn">
					<i class="fas fa-plus-circle"></i>구성원 추가
				</button>
			</div>
		</div>
		
		<div class="filter__card">
			<ul class="filter__role row">
				<h2 class="filter-title">검색 조건</h2>

				<div class="filter-init">
					<button class="" type="button" id="initSearchOptions">검색 필터 초기화</button>
				</div>

				<li class="project-rules col-12 row">

					<!-- 계정상태 구분 -->
					<div class="filter__condition col-2">
						<span class="condition__title">계정상태 : </span>
						<div class="filter__member-status selectbox">
							<label></label>
							<select id="statusOptions">
								<option value="" ${empty searchDetail.memAlive ? "selected" : "" }>모두</option>
								<option value="Y" ${not empty searchDetail.memAlive and searchDetail.memAlive eq "Y" ? "selected" : "" }>사용중</option>
								<option value="N" ${not empty searchDetail.memAlive and searchDetail.memAlive eq "N" ? "selected" : "" }>잠금</option>
							</select>
						</div>
					</div>

					<!-- 관리자 구분 -->
					<div class="filter__condition col-2">
						<span class="condition__title">회원구분 : </span>
						<div class="filter__member-status selectbox">
							<label></label>
							<select id="adminRoleOptions">
								<option value="" ${empty searchDetail.adminRole ? "selected" : "" }>모두</option>
								<option value="Y" ${not empty searchDetail.adminRole and searchDetail.adminRole eq "N" ? "selected" : "" }>관리자</option>
								<option value="N" ${not empty searchDetail.adminRole and searchDetail.adminRole eq "Y" ? "selected" : "" }>일반구성원</option>
							</select>
						</div>
					</div>

					<!-- 등록일 구분 -->
					<div class="filter__condition col-2">
						<span class="condition__title">등록일 : </span>
						<div class="filter__member-status selectbox">
							<label></label>
							<select id="dateOptions">
								<option value="" ${empty sortVO ? "selected" : "" }>상관없음</option>
								<option value="DESC" ${not empty sortVO and sortVO.sortType eq "DESC" ? "selected" : "" }>최근순</option>
								<option value="ASC" ${not empty sortVO and sortVO.sortType eq "ASC" ? "selected" : "" }>과거순</option>
							</select>
						</div>
					</div>
					
					<div class="status__guide col-4">
						<span> 
							<span class='auth__admin'>
								<i class='fas fa-user-cog'></i>
							</span>
							<span>: 관리자</span>
						</span>
						<span> 
							<span class='auth__member'>
								<i class="fas fa-user"></i>
							</span>
							<span>: 일반 구성원</span>
						</span>
						<span> 
							<span class='auth__lock'>
								<i class="fas fa-user-lock"></i>
							</span>
							<span>: 잠금 계정</span>
						</span>
					</div>
				</li>
			</ul>
		</div>
		<div class="memberlist__card">
			<div class="clearfix search__form">
<!-- 				<div class="role__add float--left"> -->
<!-- 					<button type="button" class="member__addbtn" id="pdfDownloadBtn"> -->
<!-- 						PDF 출력 -->
<!-- 					</button> -->
<!-- 					<button type="button" class="member__addbtn" id="excelDownloadBtn"> -->
<!-- 						Excel 출력 -->
<!-- 					</button> -->
<!-- 				</div> -->
				<div class="float--right">
					<div class="bpms-searchgroup">
				    	<input class="bpms-search" placeholder="이름 검색" id="searchWord">
				    	<i class="fas fa-search"></i>
				    </div>
				</div>
			</div>
			<div class="card__row">
				<div class="table-memberlist">
					<table class="table issue-table">
						<thead>
							<tr class="text-left">
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
								<th>상태 및 회원 구분</th>
								<th>등록일</th>
								<th>계정설정</th>
							</tr>
						</thead>
						<tbody id="memberListBody" class="text-left">
							<c:if test="${not empty pagingVO.dataList }">
								<c:forEach items="${pagingVO.dataList }" var="memberVO">
									<tr>
										<td>
											<a href="${pageContext.request.contextPath }/admin/member/memberDetail.do?memId=${memberVO.memId}">${memberVO.memId }</a>
										</td>
										<td>${memberVO.memName }</td>
										<td>${memberVO.memMail }</td>
										<td>
											<c:if test="${memberVO.adminRole eq 'Y' and memberVO.memAlive eq 'Y' }">
												<span class='auth__admin'>
													<i class='fas fa-user-cog'></i>
												</span>
											</c:if>
											<c:if test="${memberVO.adminRole eq 'N' and memberVO.memAlive eq 'Y' }">
												<span class='auth__member'>
													<i class="fas fa-user"></i>
												</span>
											</c:if>
											<c:if test="${memberVO.memAlive eq 'N' }">
												<span class='auth__lock'>
													<i class="fas fa-user-lock"></i>
												</span>
											</c:if>
										</td>
										<td>${memberVO.createDate }</td>
										<td>
											<div class="d-flex" data-id="${memberVO.memId }" data-name="${memberVO.memName }" data-mail="${memberVO.memMail }">
												<c:if test="${memberVO.memAlive eq 'N' }">
			                                    	<button type="button" class="member__setbtn set__member-unlock" onclick="unlockmember($(this))" 
			                                    		data-toggle="modal" data-target="#set__unlockmodal"> 잠금 해제 </button>
			                                    	<button type="button" class="member__setbtn set__member-remove" onclick="removemember($(this))" 
			                                    		data-toggle="modal" data-target="#set__roleRemove"> 계정 삭제 </button>
												</c:if>
												<c:if test="${memberVO.memAlive eq 'Y' }">
				                                    <button type="button" class="member__setbtn set__member-lock" onclick="lockmember($(this))" 
				                                    	data-toggle="modal" data-target="#set__statuschange"> 잠금 설정 </button>
				                                    <button type="button" class="member__setbtn set__member-remove" onclick="removemember($(this))" 
				                                    	data-toggle="modal" data-target="#set__roleRemove"> 계정 삭제 </button>
												</c:if>
													<button type="button" class="member__setbtn" onclick="initPassword($(this))"
														data-toggle="modal" data-target="#initPasswordModal"> 비밀번호 초기화 </button>													
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<div id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form id="memberListForm">
	<%-- 날짜 정렬 --%>
	<input type="hidden" name="sortCondition" value="date">
	<input type="hidden" name="sortType">
	
	<%-- 검색 조건 --%>
	<input type="hidden" name="memId">
	<input type="hidden" name="adminRole">
	<input type="hidden" name="memAlive">
	<input type="hidden" name="page">
	<input type="hidden" name="searchType" value="memName">
	<input type="hidden" name="searchWord">
</form>

<form id="lockStatusForm" action="${pageContext.request.contextPath }/admin/member/changeLockStatus.do" method="post">
	<input type="hidden" name="memId">
	<input type="hidden" name="memAlive">
</form>

<form id="removeForm" action="${pageContext.request.contextPath }/admin/member/deleteMember.do" method="post">
	<input type="hidden" name="memId">
</form>

<form id="initPasswordForm" action="${pageContext.request.contextPath }/admin/member/initPassword.do" method="post">
	<input type="hidden" name="memId">
</form>

<!-- 잠금 모달 -->
<div class="modal fade" id="set__statuschange">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">
				<div class="modal__header">계정 잠금</div>
				<span class="errors">계정잠금 시 해당 계정의 모든 권한이 제한됩니다.</span>
				
				<div class="setting__roleSet">
					<span class="copy__rolename">잠금할 계정 : </span>
					<div class="set__role" id="lockTargetId"></div>
				</div>
				<div class="setting__roleSet">
					<span class="copy__rolename">사용자 이름 : </span>
					<div class="set__name"></div>
				</div>
				
				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#set__statuschange" id="lockCancelBtn">취소</button>
					<button type="button" class="form-confirm" id="lockBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 잠금 해제 모달 -->
<div class="modal fade" id="set__unlockmodal">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">

				<div class="modal__header">계정 잠금 해제</div>

				<div class="setting__roleSet">
					<span class="copy__rolename">잠금 해제할 계정 : </span>
					<div class="set__role"></div>
				</div>
				<div class="setting__roleSet">
					<span class="copy__rolename">사용자 이름 : </span>
					<div class="set__name"></div>
				</div>

				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#set__unlockmodal" id="unlockCancelBtn">취소</button>
					<button type="button" class="form-confirm" id="unlockBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 삭제 모달 -->
<div class="modal fade" id="set__roleRemove">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">

				<div class="modal__header">계정 삭제</div>
				<span class="errors">계정삭제 시 해당 계정정보는 모두 삭제됩니다.</span>
				
				<div class="setting__roleSet">
					<span class="copy__rolename">삭제할 계정 : </span>
					<div class="set__role"></div>
				</div>
				<div class="setting__roleSet">
					<span class="copy__rolename">사용자 이름 : </span>
					<div class="set__name"></div>
				</div>

				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#set__roleRemove" id="removeCancelBtn">취소</button>
					<button type="button" class="form-confirm" id="removeBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 비밀번호 초기화 모달 -->
<div class="modal fade" id="initPasswordModal">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">

				<div class="modal__header">비밀번호 초기화</div>
				<span class="errors">해당 사용자의 이메일로 초기화된 비밀번호가 전송됩니다.</span>
				
				<div class="setting__roleSet">
					<span class="copy__rolename">비밀번호 초기화 계정 : </span>
					<div class="set__role"></div>
				</div>
				<div class="setting__roleSet">
					<span class="copy__rolename">사용자 이름 : </span>
					<div class="set__name"></div>
				</div>
				<div class="setting__roleSet">
					<span class="copy__rolename">수신 이메일 : </span>
					<div class="set__mail"></div>
				</div>

				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#initPasswordModal" id="initPasswordCancelBtn">취소</button>
					<button type="button" class="form-confirm" id="initPasswordBtnInModal">초기화</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- end Content -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/member/memberListView.js"></script>

