<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<div class="panel-header">
	<div class="page-inner">
		<span class="project-path">
			<a href="#">요청관리</a>
			<a href="#">요청된 프로젝트</a>
		</span>

		<div class="issue-header clearfix">
			<div class="float--left">
				<h1 class="fw-mediumbold">요청된 프로젝트</h1>
			</div>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th>프로젝트 ID</th>
					<th>프로젝트 이름</th>
					<th>책임자</th>
					<th>구성원</th>
					<th>상태</th>
					<th>요청날짜</th>
				</tr>
			</thead>
			<tbody id="listBody">
<!-- 				<tr> -->
<!-- 					<td> -->
<!-- 						<div class="avatar avatar-sm"> -->
<%-- 							<img src="${pageContext.request.contextPath }/assets/img/profile2.jpg" --%>
<!-- 								alt="..." class="avatar-img rounded-circle"> -->
<!-- 						</div>  -->
<!-- 						<span>John</span> -->
<!-- 					</td> -->
<!-- 					<td><a href="#myModal" data-toggle="modal">BPMS프로젝트 사업 생성 -->
<!-- 							요청</a></td> -->
<!-- 					<td>신광진 외 2명</td> -->
<!-- 				</tr> -->
				
				<!-- 위에는 dummy 데이터입니다. -->
				<!-- ProjectVO안에 List<ProjectMemberVO> -->
				
				<c:if test="${not empty reqList }">
					<c:forEach items="${reqList }" var="reqProjectVO" varStatus="status">
						<tr>
							<td>
								${reqProjectVO.proId }
							</td>
							<td>
								<!-- 프로젝트 이름 -->
								<a href="#myModal" data-toggle="modal" id="reqViewTag"
									data-title="${reqProjectVO.proName }"
									data-content="${reqProjectVO.proContent }"
									data-manager="${reqProjectVO.projectManager }"
									data-id="${reqProjectVO.proId }"
									data-requester="${reqProjectVO.proRequester }"
								>
									${reqProjectVO.proName }
								</a>
							</td>
							<td>
								<!-- 책임자 -->
								<c:if test="${not empty reqProjectVO.proMemberList }">
									<c:set value="true" var="loopFlag"/>
									<c:forEach items="${reqProjectVO.proMemberList }" var="proMemberVO">
										<c:if test="${loopFlag }">
											<c:if test="${proMemberVO.memId eq reqProjectVO.projectManager }">
												<div class="avatar pro_member" data-memid="${proMemberVO.memId }" onclick="memberDetailView($(this))" style="cursor: pointer;">
													<c:set value="${proMemberVO.memImg }" var="memProfile"/>
													<c:if test="${not (memProfile eq null) }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/${memProfile }" alt="..."
															class="avatar-img rounded-circle border border-white toggle-person">
													</c:if>
													<c:if test="${memProfile eq null }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
															class="avatar-img rounded-circle border border-white toggle-person">
													</c:if>
													<p class="person-name">${proMemberVO.memName }</p>
												</div>
												${proMemberVO.memName }
												<c:set var="loopFlag" value="false"/>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
							</td>
							<td>
								<!-- 구성원 -->
								<c:if test="${not empty reqProjectVO.proMemberList }">
									<div class="avatar-group" style="cursor: pointer;">
										<c:forEach items="${reqProjectVO.proMemberList }" var="proMemberVO">
											<c:if test="${not (proMemberVO.memId eq reqProjectVO.projectManager) }">
												<div class="avatar pro_member" data-memid="${proMemberVO.memId }" onclick="memberDetailView($(this))">
													<c:set value="${proMemberVO.memImg }" var="memProfile"/>
													<c:if test="${not (memProfile eq null) }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/${memProfile }" alt="..."
															class="avatar-img rounded-circle border border-white toggle-person">
													</c:if>
													<c:if test="${memProfile eq null }">
														<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
															class="avatar-img rounded-circle border border-white toggle-person">
													</c:if>
													<p class="person-name">${proMemberVO.memName }</p>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
							</td>
							<td>대기</td>
							<td>${reqProjectVO.createDate }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty reqList }">
					<tr class="text-center">
						<th colspan="6">요청된 프로젝트가 없습니다.</th>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h3>프로젝트 생성 요청</h3>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<input type="hidden" id="proRequseter">
				<div class="form-group">
					<h4>프로젝트 식별자</h4>
					<input type="text" id="proId" class="form-control" readonly>
				</div>
				<div class="form-group">
					<h4>제목</h4>
					<input type="text" id="title" class="form-control" readonly>
				</div>
				<div class="form-group">
					<h4>내용</h4>
					<textarea rows="10" class="form-control" id="content" readonly></textarea>
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="container d-flex flex-row-reverse">
					<input type="button" id="acceptBtn" class="btn btn-primary" value="수락">
					&nbsp;
					<input type="button" id="rejectBtn" class="btn btn-danger" value="거절">
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Reject Modal -->
<div class="modal fade" id="rejectModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4>프로젝트 생성 요청 거절</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<input type="hidden" name="proRequester">			
				<div class="form-group">
					<h4>프로젝트 식별자</h4>
					<input type="text" id="proId" class="form-control" readonly>
				</div>
				<div class="form-group">
					<h4>메시지 수신자</h4>
					<input type="text" id="pushReceiver" class="form-control" readonly>
				</div>
				<div class="form-group">
					<h4>거절사유</h4>
					<textarea rows="10" class="form-control" id="pushContent"></textarea>
					<span id="pushContentSpan"></span>
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="container d-flex flex-row-reverse">
					<input type="button" id="sendBtn" class="btn btn-primary" value="전송">
					&nbsp;
					<input type="button" class="btn btn-danger" onclick="closeRejectModal()" value="취소">
				</div>
			</div>
		</div>
	</div>
</div>


<form method="post" id="projectForm" action="${pageContext.request.contextPath}/admin/project/accept.do">
	<input type="hidden" name="proId">
	<input type="hidden" name="code" value="2">
	<input type="hidden" name="pushSender" value="${authMember.memId }">
</form>

<form method="post" id="pushMsgForm" action="${pageContext.request.contextPath }/pushMsg/rejectMsgInsert.do">
	<input type="hidden" name="pushSender" value="${authMember.memId }">
	<input type="hidden" name="pushContent">
	<input type="hidden" name="pushReceiver">
	<input type="hidden" name="proId">
</form>



<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/project/requestProjectView.js"></script>