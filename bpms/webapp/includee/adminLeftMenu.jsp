<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
                    <a aria-expanded="true">
                        <span>
                            ADMIN
                            <span class="user-level">${authMember.memId } [${authMember.memName }]</span>
                        </span>
                    </a>
                </div>
            </div>
            <ul class="nav nav-primary">
                <li class="nav-item active">
                    <a href="${pageContext.request.contextPath }/admin/dashBoard">
                        <i class="fas fa-layer-group"></i>
                        <p>대시보드</p>
                    </a>
                </li>

                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">공지 관리</h4>
                </li>                
                <li class="nav-item nav-noticesetting">
                    <a href="${pageContext.request.contextPath }/serverNotice/serverNoticeList.do?mng=Y">
                        <i class="fas fa-bullhorn"></i>
                        <p>공지관리</p>
                    </a>
                </li>
                
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">프로젝트 관리</h4>
                </li>
                <li class="nav-item nav-regitstedproject">
                    <a href="${pageContext.request.contextPath }/admin/project/projectList.do?groupCode=P">
                        <i class="fas fa-barcode"></i>
                        <p>등록된 프로젝트</p>
                    </a>
                </li>
                <li class="nav-item nav-requestproject">
                    <a href="${pageContext.request.contextPath }/admin/project/requestProjectList.do">
                        <i class="fas fa-paper-plane"></i>
                        <p>요청된 프로젝트</p>
                    </a>
                </li>
                
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">구성원 관리</h4>
                </li>
                <li class="nav-item nav-registedmember">
                    <a href="${pageContext.request.contextPath }/admin/member/memberList.do">
                        <i class="fas fa-users"></i>
                        <p>등록된 구성원</p>
                    </a>
                </li>
                <li class="nav-item nav-roleandrule">
                    <a href="${pageContext.request.contextPath }/admin/role/roleListView.do">
                        <i class="fas fa-gem"></i>
                        <p>역할 및 권한</p>
                    </a>
                </li>
                
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">일감 관리</h4>
                </li>
                <li class="nav-item nav-registedwork">
                    <a href="${pageContext.request.contextPath }/admin/work/workList.do">
                        <i class="fas fa-paperclip"></i>
                        <p>등록된 일감</p>
                    </a>
                </li>
                <li class="nav-item nav-worktype">
                    <a href="${pageContext.request.contextPath }/admin/work/customInfoList.do?groupCode=WT">
                        <i class="fas fa-tags"></i>
                        <p>일감 유형</p>
                    </a>
                </li>
                <li class="nav-item nav-workstatus">
                    <a href="${pageContext.request.contextPath }/admin/work/customInfoList.do?groupCode=WS">
                        <i class="fas fa-sign"></i>
                        <p>일감 상태</p>
                    </a>
                </li>
                <li class="nav-item nav-workrank">
                    <a href="${pageContext.request.contextPath }/admin/work/customInfoList.do?groupCode=WR">
                        <i class="fas fa-sitemap"></i>
                        <p>일감 우선순위</p>
                    </a>
                </li>
                
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                        <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">이슈 관리</h4>
                </li>
                <li class="nav-item nav-registedissue">
                    <a href="${pageContext.request.contextPath }/admin/issue/issueList.do">
                        <i class="fab fa-hotjar"></i>
                        <p>등록된 모든 이슈</p>
                    </a>
                </li>
                <li class="nav-item nav-issuetype">
                    <a href="${pageContext.request.contextPath }/admin/issue/customInfoList.do?groupCode=IT">
                        <i class="fas fa-tags"></i>
                        <p>이슈 유형</p>
                    </a>
                </li>
                <li class="nav-item nav-issuestatus">
                    <a href="${pageContext.request.contextPath }/admin/issue/customInfoList.do?groupCode=IS">
                        <i class="fas fa-sign"></i>
                        <p>이슈 상태</p>
                    </a>
                </li>
                <li class="nav-item nav-issuerank">
                    <a href="${pageContext.request.contextPath }/admin/issue/customInfoList.do?groupCode=IR">
                        <i class="fas fa-sitemap"></i>
                        <p>이슈 우선순위</p>
                    </a>
                </li>
                
            </ul>
        </div>
    </div>
</div>
<!-- End Sidebar -->