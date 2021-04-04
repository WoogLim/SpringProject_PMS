<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>
<nav class="navbar navbar-header navbar-expand-lg" data-background-color="blue2">
	<div class="container-fluid">
		<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
		
			<li class="nav-item">
				<c:if test="${not empty authMember.projectList }">
					<div class="projectsearch-nav">
						<c:set value="true" var="loopFlag"/>
						<c:forEach items="${authMember.projectList }" var="proVO">
							<c:if test="${loopFlag }">
								<c:if test="${proVO.proId eq param.proId }">
				                    <button class="projectnav-select" data-toggle="dropdown" type="button">
				                        <div class="projectselected-item">
				                            <div class="projectitem-icon">
				                                <i class="fas fa-tasks"></i>
				                            </div>
				                            <div class="projectitem-info">
				                                <span class="projectitem-name">${proVO.proName }</span>
				                                <span class="projectitem-proid">${proVO.proId }</span>    
				                            </div>
				                            <div class="projectitemend-icon">
				                                <i class="fas fa-sort-down"></i>
				                            </div>
				                        </div>
				                    </button>
									<c:set value="false" var="loopFlag"/>
								</c:if>
							</c:if>
						</c:forEach>
						
	                    <ul class="dropdown-menu project-searchbar" aria-labelledby="dropdownMenuButton">
	                        <li class="search-bar">
	                            <input type="text" class="search-projectlist">
	                        </li>
							<c:forEach items="${authMember.projectList }" var="proVO">
								<c:if test="${not (proVO.proId eq param.proId) }">
			                        <li class="search-projectitem" data-proid="${proVO.proId }">
			                            <div class="projectselected-item">
			                                <div class="projectitem-icon">
			                                    <i class="fas fa-tasks"></i>
			                                </div>
			                                <div class="projectitem-info">
			                                    <span class="projectitem-name">${proVO.proName }</span>
			                                    <span class="projectitem-proid">${proVO.proId }</span>    
			                                </div>
			                            </div>
			                        </li>
								</c:if>
							</c:forEach>
	                    </ul>
	                </div>
				</c:if>
            </li>
			
			<c:if test="${authMember.memRole eq 'ROLE_ADMIN' }">
				<li class="nav-item dropdown hidden-caret">
	                <a class="nav-link" href="${pageContext.request.contextPath }/admin/dashBoard" aria-expanded="false">
	                    <i class="far fa-sun"></i>
	                </a>
	            </li>
            </c:if>
            
			<li class="nav-item dropdown hidden-caret"><a
				class="nav-link dropdown-toggle push-alrambtn" href="#" id="notifDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
				<i class="fa fa-bell"></i>
				<c:if test="${authMember.unConfirmedPushMsgCount gt 0 }">
					<span class="notification">${authMember.unConfirmedPushMsgCount }</span>
				</c:if>
			</a>
				<ul class="dropdown-menu notif-box animated fadeIn" aria-labelledby="notifDropdown">

					<!-- 푸쉬 알람 드롭다운 -->
					<li>
						<div class="dropdown-title"> 
							<c:if test="${authMember.unConfirmedPushMsgCount gt 0 }">
								<span class="notify__alram">${authMember.unConfirmedPushMsgCount }</span> 건의 알림이 있습니다.
							</c:if>
							<c:if test="${authMember.unConfirmedPushMsgCount le 0 }">
								새로운 메시지가 없습니다.
							</c:if>
						</div>
					</li>
					<li>
						<div class="notif-scroll scrollbar-outer">
							<div class="notif-center">
								<c:if test="${not empty authMember.pushMsgList }">
									<c:forEach items="${authMember.pushMsgList }" var="pushMsgVO">
										<a href="${pageContext.request.contextPath }/member/mymessage">
											<div class="notif-icon notif-primary"> 
												<i class="fas fa-envelope"></i>
											</div>
											<div class="notif-content">
												<span class="block">
													${pushMsgVO.pushTitle }
												</span>
												<span class="time">발신자: ${pushMsgVO.memberVO.memName }</span>
											</div>
										</a>
									</c:forEach>
								</c:if>
							</div>
						</div>
					</li>
					<li>
						<a class="see-all" href="${pageContext.request.contextPath }/member/mymessage">
							모든 메시지 보기
							<i class="fa fa-angle-right"></i> 
						</a>
					</li>
				</ul>
			</li>

			<!-- 메신저 -->
			<li class="nav-item">
			<a class="nav-link quick-sidebar-toggler"
				href="#" id="messageDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
				<i class="fas fa-comment"></i>
			</a>
			</li>

			<!-- 내 정보 -->
			<li class="nav-item dropdown hidden-caret">
			<a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#" aria-expanded="false">
				<div class="avatar-sm">
					<c:if test="${authMember.memImg eq null }">
						<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..." class="avatar-img rounded-circle">
					</c:if>
					<c:if test="${not (authMember.memImg eq null) }">
						<img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" alt="..." class="avatar-img rounded-circle">
					</c:if>
				</div>
			</a>
				<ul class="dropdown-menu dropdown-user animated fadeIn">
					<div class="dropdown-user-scroll scrollbar-outer">
						<li>
							<div class="user-box">
								<div class="avatar-lg">
									<c:if test="${authMember.memImg eq null }">
										<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..." class="avatar-img rounded-circle">
									</c:if>
									<c:if test="${not (authMember.memImg eq null) }">
										<img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" alt="..." class="avatar-img rounded-circle">
									</c:if>
								</div>
								<div class="u-text">
									<h4>${authMember.memId } [${authMember.memName }]</h4>
									<p class="text-muted">${authMember.memMail }</p>
								</div>
							</div>
						</li>
						<li>
							<div class="dropdown-divider"></div> 
							<a class="dropdown-item" href="${pageContext.request.contextPath }/member/mypage">마이페이지</a>
							<div class="dropdown-divider"></div> 
							<a class="dropdown-item" href="${pageContext.request.contextPath}/login/logout.do">Logout</a>
						</li>
					</div>
				</ul>
			</li>
		</ul>
	</div>
</nav>

<form id="myProjectSearchForm" action="${pageContext.request.contextPath }/project/myProjectList.do">
	<input type="hidden" name="searchWord" value="">
</form>

<script type="text/javascript">
	$("ul.project-searchbar").on("click", "li.search-projectitem", function(){
		let proId = $(this).data("proid");
		location.href = $.getContextPath() + "/project/main?proId=" + proId;
	});
	
	let myProjectSearchForm = $("#myProjectSearchForm").ajaxForm({
		dataType: "json"
		, success: function(resp){
			
			let root = $("ul.project-searchbar");
			let childrens = root.find("li").not(".search-bar");
			if(childrens) {
				childrens.remove();
			}
			
			let dataList = resp.dataList;
			if(dataList.length < 1) {
				return false;
			}
			
			let liTags = [];
			$(dataList).each(function(idx, proVO){
				if(proVO.proId == '${param.proId}') return true;
				let li = $("<li>").addClass("search-projectitem").data("proid", proVO.proId);
				let parentDiv = $("<div>").addClass("projectselected-item");
				
				let iconDiv = $("<div>").addClass("projectitem-icon");
				let icon = $("<i>").addClass("fas fa-tasks");
				iconDiv.append(icon);
				
				let infoDiv = $("<div>").addClass("projectitem-info");
				let proNameSpan = $("<span>").addClass("projectitem-name").text(proVO.proName);
				let proIdSpan = $("<span>").addClass("projectitem-proid").text(proVO.proId);
				infoDiv.append(proNameSpan, proIdSpan);
				
				li.append(parentDiv.append(iconDiv, infoDiv));
				liTags.push(li);
			});
			root.append(liTags);
		}
		, error: function(xhr) {
			console.log(xhr.status);
		}
	});
	
	$("ul.project-searchbar").on("keyup", "input.search-projectlist", function(){
		let searchWord = $(this).val();
		myProjectSearchForm.find("input[name='searchWord']").val(searchWord);
		myProjectSearchForm.submit();
	});
	
	
	
</script>

