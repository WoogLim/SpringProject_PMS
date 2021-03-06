<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 1. 28.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="panel-header">
	<div class="page-inner">
		<span class="project-path"> 
			<a href="#">관리</a> 
			<a href="#">역할 및 권한</a>
		</span>

		<div class="setting__header">
			<h2>역할 및 권한</h2>
<!-- 			<div class="role__add"> -->
<!-- 				<button type="button" class="role__newrolebtn" id="roleInsertBtn"> -->
<!-- 					<i class="fas fa-plus-circle"></i> -->
<!-- 					새 역할 -->
<!-- 				</button> -->
<!-- 			</div> -->
		</div>

		<div class="role__card">
		
			<div class="card__row">
				<h4 style="color: #288CFF">구성원</h4>
				<c:if test="${not empty authorities }">
					<c:forEach items="${authorities }" var="roleVO">
						<c:if test="${fn:indexOf(roleVO.authority, 'TEAM') == -1 and fn:contains(roleVO.authority, 'ROLE') }">
							<ul class="role__item row">	
								<li class="role__rule col-4">
									<span class="set__role-name">${roleVO.description }<span style="color: #288CFF"> [${roleVO.roleName }]</span></span>
								</li>
								<li class="role__itembtn-box col-4" data-authority="${roleVO.authority }">
									<button class="role__itembtn" data-target="#set__roleRemove" onclick="updateFormView($(this))">
										<i class="fas fa-wrench"></i>
										수정
									</button>
									<button class="role__itembtn" data-toggle="modal" data-target="#set__roleRemove" onclick="setrole(this);">
										<i class="fas fa-trash"></i>
										제거
									</button>
								</li>
							</ul>
						</c:if>
					</c:forEach>
				</c:if>
			</div>

			<br/>
			
			<div class="card__row">
				<h4 style="color: #E16A93">프로젝트</h4>
				<c:if test="${not empty authorities }">
					<c:forEach items="${authorities }" var="roleVO">
						<c:if test="${fn:indexOf(roleVO.authority, 'TEAM') > -1 }">
							<ul class="role__item row">	
								<li class="role__rule col-4">
									<span class="set__role-name">${roleVO.description }<span style="color: #E16A93"> [${roleVO.roleName }]</span></span>
								</li>
								<li class="role__itembtn-box col-4" data-authority="${roleVO.authority }">
									<button class="role__itembtn" data-target="#set__roleRemove" onclick="updateFormView($(this))">
										<i class="fas fa-wrench"></i>
										수정
									</button>
									<button class="role__itembtn" data-toggle="modal" data-target="#set__roleRemove" onclick="setrole(this);">
										<i class="fas fa-trash"></i>
										제거
									</button>
								</li>
							</ul>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
			
			<br/>
					
			<div class="card__row">
				<h4 style="color: #D27328">시스템</h4>
				<c:if test="${not empty authorities }">
					<c:forEach items="${authorities }" var="roleVO">
						<c:if test="${fn:indexOf(roleVO.authority, 'AUTHENTICATED') > -1 }">
							<ul class="role__item row">	
								<li class="role__rule col-4">
									<span class="set__role-name">${roleVO.description }<span style="color: #D27328"> [${roleVO.roleName }]</span></span>
								</li>
								<li class="role__itembtn-box col-4" data-authority="${roleVO.authority }">
									<button class="role__itembtn" data-target="#set__roleRemove" onclick="updateFormView($(this))">
										<i class="fas fa-wrench"></i>
										수정
									</button>
									<button class="role__itembtn" data-toggle="modal" data-target="#set__roleRemove" onclick="setrole(this);">
										<i class="fas fa-trash"></i>
										제거
									</button>
								</li>
							</ul>
						</c:if>
					</c:forEach>
				</c:if>
			</div>

		</div>
	</div>
</div>

<!-- 삭제 모달 -->
<div class="modal fade" id="set__roleRemove">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">
			<form id="roleDeleteForm" action="${pageContext.request.contextPath }/admin/role/delete.do" method="post">
				<input type="hidden" name="authority" value="">
				<div class="modal__header">권한 삭제</div>

				<div class="setting__roleSet">
					<span class="copy__rolename">삭제할 권한 : </span>
					<div class="set__role"></div>
				</div>

				<div class="form-groupbtn">
					<button type="button" class="form-cancel" data-toggle="modal"
						data-target="#set__roleRemove" onclick="removeCancel()">취소</button>
					<button type="submit" class="form-confirm">제거</button>
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function setrole(input) {
		let setrole = $(input).parent().siblings('.role__rule').children().clone();
		let settingrole = ('.set__role');

		if ($(settingrole).children()) {
			$(settingrole).empty();
		}

		$(settingrole).append(setrole);
		let authority = $(input).parent().data("authority");
		console.log(authority);
		$("#roleDeleteForm").find("input[name='authority']").val(authority);
	}
	
	function updateFormView(input) {
		let authority = $(input).parent().data("authority");
		location.href = $.getContextPath() + "/admin/role/update.do?authority=" + authority;
	}
	
	function removeCancel() {
		$("#roleDeleteForm").find("input[name='authority']").val("");
	}
	
	$("#roleInsertBtn").on("click", function() {
		location.href = $.getContextPath() + "/admin/role/insert.do";
	});
	
</script>







