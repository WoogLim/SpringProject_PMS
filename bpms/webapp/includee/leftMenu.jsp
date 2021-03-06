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
                         	${authMember.memName }
                        	<span class="user-level">${authMember.currentAuthority }</span>
                        </span>
                    </a>
                    <div class="clearfix"></div>
                </div>
            </div>
            <ul class="nav nav-primary">
                
            	<li class="nav-item active">
                    <a href="${pageContext.request.contextPath }/project/main?proId=${param.proId }">
                        <i class="fas fa-layer-group"></i>
                        <p>프로젝트 대시보드</p>
                    </a>
                </li>
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">프로젝트 공지</h4>
                </li>
                <li class="nav-item navpro-servernotice">
                    <a href="${pageContext.request.contextPath }/serverNotice/serverNoticeList.do?proId=${param.proId }">
                        <i class="fas fa-flag-checkered"></i>
                        <p>시스템 공지사항</p>
                    </a>
                </li>
                <li class="nav-item navpro-pronotice">
                    <a href="${pageContext.request.contextPath }/proNotice/proNoticeList.do?proId=${param.proId }">
                        <i class="far fa-flag"></i>
                        <p>프로젝트 공지사항</p>
                    </a>
                </li>
                
<!--                 <li class="nav-section"> -->
<!--                     <span class="sidebar-mini-icon"> -->
<!--                         <i class="fa fa-ellipsis-h"></i> -->
<!--                     </span> -->
<!--                     <h4 class="text-section">프로젝트 설정</h4> -->
<!--                 </li> -->
<!--                 <li class="nav-item navpro-prosetting"> -->
<!--                     <a href="#"> -->
<!--                         <i class="fas fa-cog"></i> -->
<!--                         <p>프로젝트 설정</p> -->
<!--                     </a> -->
<!--                 </li> -->
<!--                 <li class="nav-item navpro-memsetting"> -->
<%--                     <a href="${pageContext.request.contextPath }/project/memberConfig.do?proId=${param.proId}"> --%>
<!--                         <i class="fas fa-users-cog"></i> -->
<!--                         <p>구성원 설정</p> -->
<!--                     </a> -->
<!--                 </li> -->
                
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">프로젝트 업무</h4>
                </li>
                <li class="nav-item navpro-gantt">
                    <a href="${pageContext.request.contextPath }/gantt/ganttList.do?proId=${param.proId }">
                        <i class="fas fa-signal"></i>
                        <p>간트 차트</p>
                    </a>
                </li>
                <li class="nav-item navpro-calendar">
                    <a href="${pageContext.request.contextPath }/schedule/calendarList.do?proId=${param.proId }">
                        <i class="fas fa-calendar-alt"></i>
                        <p>캘린더</p>
                    </a>
                </li>
                <li class="nav-item navpro-scm">
                   <a href="${pageContext.request.contextPath }/scm/scmView.do?proId=${param.proId}">
                        <i class="fas fa-code-branch"></i>
                        <p>SCM</p>
                    </a>
                </li>
                <li class="nav-item navpro-wiki">
                    <a href="${pageContext.request.contextPath }/wiki/wikiList.do?proId=${param.proId }">
                        <i class="fab fa-wikipedia-w"></i>
                        <p>위키</p>
                    </a>
                </li>
                <li class="nav-item navpro-report">
                    <a href="${pageContext.request.contextPath }/workReport/workReportList.do?proId=${param.proId }">
                        <i class="fas fa-clipboard"></i>
                        <p>업무 보고</p>
                    </a>
                </li>
                <li class="nav-item navpro-history">
                    <a href="${cPath}/history/historyList.do?proId=${param.proId }">
                        <i class="fas fa-folder-open"></i>
                        <p>작업 이력</p>
                    </a>
                </li>
                <li class="nav-item navpro-workreport">
                    <a href="${cPath}/work/workList.do?proId=${param.proId }">
                        <i class="fas fa-paperclip"></i>
                        <p>일감 관리</p>
                    </a>
                </li>
                <li class="nav-item navpro-issuereport">
                    <a href="${cPath}/issue/issueList.do?proId=${param.proId }">
                        <i class="fab fa-hotjar"></i>
                        <p>이슈 관리</p>
                    </a>
                </li>
                <li class="nav-item navpro-storage">
                    <a href="${cPath}/storage/storageView.do?proId=${param.proId }">
                        <i class="fas fa-database"></i>
                        <p>파일 저장소</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- End Sidebar -->