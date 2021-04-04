<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<div class="main-header" data-background-color="purple">
	<div class="nav-top">
		<div class="container d-flex flex-row">
			<!-- Logo Header -->
			<div class="logo-header" data-background-color="blue">

				<a href="${pageContext.request.contextPath }/admin/main" class="logo">
					<img src="${pageContext.request.contextPath }/assets/img/bpms_logo.svg" alt="navbar brand" class="navbar-rand">
				</a>
			</div>
			<!-- End Logo Header -->

			<!-- Navbar Header -->
			<nav class="navbar navbar-header navbar-expand-lg" data-background-color="blue2">

				<div class="container-fluid">
					<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">

						<li class="nav-item dropdown hidden-caret">
							<a class="nav-link dropdown-toggle" href="#" id="notifDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
							<a class="nav-link quick-sidebar-toggler chatToggle" href="#" id="messageDropdown"
								role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-comment"></i>
							</a>
						</li>

						<!-- 내 정보 -->
						<li class="nav-item dropdown hidden-caret">
							<a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#"
								aria-expanded="false">
								<div class="avatar-sm">
									<c:if test="${authMember.memImg eq null }">
										<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
											class="avatar-img rounded-circle">
									</c:if>
									<c:if test="${not (authMember.memImg eq null) }">
										<img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" alt="..."
											class="avatar-img rounded-circle">
									</c:if>
								</div>
							</a>
							<ul class="dropdown-menu dropdown-user animated fadeIn">
								<div class="dropdown-user-scroll scrollbar-outer">
									<li>
										<div class="user-box">
											<div class="avatar-lg">
												<c:if test="${authMember.memImg eq null }">
													<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
														class="avatar-img rounded-circle">
												</c:if>
												<c:if test="${not (authMember.memImg eq null) }">
													<img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" alt="..."
														class="avatar-img rounded-circle">
												</c:if>
											</div>
											<div class="u-text">
												<h4>${authMember.memName } [${authMember.memId }]</h4>
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
			<!-- End Navbar -->
		</div>
	</div>
	<div class="nav-bottom">
		<div class="container">
			<h3 class="title-menu d-flex d-lg-none">
				Menu
				<div class="close-menu"> <i class="flaticon-cross"></i></div>
			</h3>
			<ul class="nav page-navigation page-navigation-info bg-white main-navitems">
				<ul class="nav-container">
					<li class="nav-item main-navigation nav-active">
						<button class="project-navbtn main-navbtn btn-active">
							<i class="fas fa-tasks"></i>
							프로젝트
						</button>
					</li>
					<li class="nav-item main-navigation">
						<button class="history-navbtn main-navbtn">
							<i class="far fa-newspaper"></i>
							작업 히스토리
						</button>
					</li>
					<li class="nav-item main-navigation">
						<button class="manage-navbtn main-navbtn" onclick="goAdminPage()">
							<i class="far fa-sun"></i>
							관리페이지
						</button>
					</li>
					<li class="nav-item main-navigation">
						<button class="manage-navbtn main-navbtn" onclick="goUserMainPage()">
							<i class="fas fa-exchange-alt"></i>
							일반회원용 메인페이지
						</button>
					</li>
				</ul>
				<li class="logon-member">
					<span class="loginmem-name no-drag">${authMember.memName } [${authMember.memId }]</span>
					<span>님 어서오세요</span>
					<button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/login/logout.do'">
						로그아웃
					</button>
				</li>
			</ul>
		</div>
	</div>
</div>