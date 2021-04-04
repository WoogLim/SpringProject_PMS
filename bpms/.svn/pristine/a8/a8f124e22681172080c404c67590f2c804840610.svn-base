<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<nav class="navbar navbar-header navbar-expand-lg" data-background-color="purple">
	<div class="container-fluid">
		<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">

			<li class="nav-item dropdown hidden-caret"><a
				class="nav-link dropdown-toggle" href="#" id="notifDropdown"
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