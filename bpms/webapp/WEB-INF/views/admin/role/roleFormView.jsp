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
			<a href="#">새 역할</a>
		</span>

		<div class="setting__header">
			<h2>새 역할</h2>
		</div>

		<div class="addrole__card">

			<ul class="new__role-status row">
				<li class="new__role-info col-2">이름</li>
				<li class="col-10"><input class="role__input form-control"
					type="text"></li>
			</ul>
			
			<c:set value="${selectedAuthority }" var="selectedAuthority"/>
			<ul class="new__role-status row">
				<li class="new__role-info col-2">다른 권한 복사</li>
				<li class="col-10">
					<div class="role__input selectbox">
						<label for="ex_building">
							<c:if test="${not empty selectedAuthority }">
								${selectedAuthority.description }[${selectedAuthority.roleName }]
							</c:if>
							<c:if test="${empty selectedAuthority }">
								선택안함
							</c:if>
						</label>
						<select id="building">
							<option value="">선택안함</option>
							<c:forEach items="${authorities }" var="roleVO">
								<c:if test="${not (roleVO.authority eq 'IS_AUTHENTICATED_ANONYMOUSLY') }">
									<option value="${roleVO.authority }" ${roleVO.authority eq selectedAuthority.authority ? "selected":"" }>${roleVO.description}[${roleVO.roleName }]</option>
								</c:if>
							</c:forEach>
						</select>
					</div>

				</li>
			</ul>

		</div>

		<%-- 권한 Form Start --%>
		<div class="setting__header">
			<h2>권한</h2>
		</div>
		
		<form id="roleForm" action="${pageContext.request.contextPath }/admin/role/insert.do" method="post">
			<div class="addrole__card">

			<c:forEach items="${resourceList }" var="resource" varStatus="vs">
				<c:if test="${resource.level le 2 }">
					<c:if test="${vs.count ge 2 }"></div></div><br/></c:if>
					<div class="row m-3 new__role-list">
						<h2 class="new__role-title">${resource.description }</h2>
						<div class="new__role-allcheck">
                        	<button class="role-allcheck" onclick="allcheck($(this));" type="button">모두 선택</button>
                        	<button class="role-uncheck"  onclick="uncheck($(this));" type="button">모두 취소</button>
						</div>
						<div class="row col-12 project-rules">
				</c:if>
				<div class="col-3">
					<input type="checkbox" class="form-check-input" name="resourceId" id="${resource.resourceId }" value="${resource.resourceId }"
						${not empty selectedAuthority and fn:contains(resource.authorities, selectedAuthority.authority) ? "checked" : "" }>
					<label for="${resource.resourceId }" class="role-checkname" title="${resource.resourcePattern }" data-bs-toggle="tooltip" data-bs-placement="top">${resource.description }</label>
				</div>
				<c:if test="${ vs.last }"></div></c:if>
			</c:forEach>
			
			</div>
			<div class="new__create-role text-right">
				<button type="button" style="background-color:#FF6A89" id="backBtn">뒤로가기</button>
				<button type="button">생성하기</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {

		let selectTarget = $('.selectbox select');

		selectTarget.focus(function() {
			$('.selectbox').addClass('selectbox__active');
		})

		selectTarget.focusout(function() {
			$('.selectbox').removeClass('selectbox__active');
		})

		selectTarget.change(function() {
			var select_name = $(this).children('option:selected').text();
			$(this).siblings('label').text(select_name);

			location.href = $.getContextPath() + "/admin/role/insert.do?authority=" + $(this).val();
		});
		
		$("#backBtn").on("click", function(){
			location.href = $.getContextPath() + "/admin/role/roleListView.do";
		});
		
		
	});

	$(function() {
		<c:if test="${not empty selectedAuthority.authority}">
		$.ajax({
			url: $.getContextPath() + "/admin/role/roleAuthority.do"
			, dataType:"json"
			, data: {"authority": "${param.authority}"}
			, success:function(resp){
				console.log(resp);
				let resourceList = resp.resourceList;
				$(resourceList).each(function(idx, res){
					console.log(res);
					$("#"+res.resourceId).prop({
						disabled:true
						,checked:true
					});
				});
			}
			, error:function(resp){
				console.log(resp);
			}
		})		
		</c:if>
	});

	function allcheck(input) {
		$(input).parent().siblings('li').find('.form-check-input').prop(
				'checked', true);
	}

	function uncheck(input) {
		$(input).parent().siblings('li').find('.form-check-input').prop(
				'checked', false);
	}
</script>







