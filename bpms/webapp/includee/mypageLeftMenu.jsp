<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<div class="sidebar sidebar-style-2">
    <div class="sidebar-wrapper scrollbar scrollbar-inner">
        <div class="sidebar-content">
            <div class="user">
                <div class="avatar-sm float-left mr-2">
                	<c:if test="${authMember.memImg eq null }">
	                    <img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..." class="avatar-img rounded-circle">
                	</c:if>
                	<c:if test="${not (authMember.memImg eq null) }">
	                    <img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" alt="..." class="avatar-img rounded-circle">
                	</c:if>
                </div>
                <div class="info">
                    <a data-toggle="collapse" href="#collapseExample" aria-expanded="true">
                        <span>
                           	${authMember.memId}
                            <span class="user-level">User Architecture</span>
                        </span>
                    </a>
                    <div class="clearfix"></div>
                </div>
            </div>
            <ul class="nav nav-primary">
                
            	<li class="nav-item mypage-nav nav-myprofile">
                    <a href="${pageContext.request.contextPath }/member/mypage">
                        <i class="fas fa-layer-group"></i>
                        <p>마이 프로필</p>
                    </a>
                </li>
                <li class="nav-item mypage-nav nav-mymessage">
                    <a href="${pageContext.request.contextPath }/member/mymessage">
                        <i class="fas fa-signal"></i>
                        <p>메시지함</p>
                    </a>
                </li>
                <li class="nav-item mypage-nav nav-sticker">
                    <a href="${pageContext.request.contextPath }/kanban/kanbanView.do">
                        <i class="fas fa-calendar-alt"></i>
                        <p>스티커 메모</p>
                    </a>
                </li>
                <li class="nav-item mypage-nav nav-mysecurity">
                    <a href="${pageContext.request.contextPath }/member/mySetting">
                        <i class="fab fa-wikipedia-w"></i>
                        <p>개인정보 설정</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- End Sidebar -->