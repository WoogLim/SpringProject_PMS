<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div class="profile__container row">

		<div class="profile__info col-10">

			<div class="user__info">

                <div class="info__card">
					<form:form commandName="memberVO" action="${pageContext.request.contextPath }/admin/member/memberUpdate.do" method="post" id="memberUpdateForm">
	                    <div class="list__title">
	                        <h2>회원 정보</h2>
	                        <button class="memberinfo-setting" id="memberUpdateBtn" type="submit">
	                            <span>
	                                회원 정보 저장
	                            </span>
	                        </button>
	                    </div>
	                    <ul class="memberinfo-list">
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">아이디</span>
	                            <span class="memberinfo-content">
	                                <input type="text" class="memberinfo-input" name="memId" value="${memberVO.memId }" required readonly>
	                            </span>
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">이름</span>
	                            <span class="memberinfo-content">
	                                <input type="text" class="memberinfo-input" name="memName" value="${memberVO.memName }"
	                                	required pattern="^([가-힣A-Za-z]){2,20}$">
	                            </span>
	                        </li>
	                        <li>
	                        	<form:errors cssClass="errors" path="memName" element="span"></form:errors>
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">이메일</span>
	                            <span class="memberinfo-content">
	                                <input type="email" class="memberinfo-input" name="memMail" value="${memberVO.memMail }">
	                            </span>
	                        </li>
	                        <li>
		                        <form:errors cssClass="errors" path="memMail" element="span"></form:errors>
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">전화전호</span>
	                            <span class="memberinfo-content">
	                                <input type="text" class="memberinfo-input" name="memHp" value="${memberVO.memHp }"
	                                	required pattern="^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$">
	                            </span>
	                        </li>
	                        <li>
								<form:errors cssClass="errors" path="memHp" element="span"></form:errors>	                        
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">등록일</span>
	                            <span class="memberinfo-content">
	                                <input type="date" class="memberinfo-input" name="createDate" value="${memberVO.createDate }" readonly>
	                            </span>
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">관리자</span>
	                            <span class="memberinfo-status">
	                                <input type="checkbox" class="memberstatus-setting empower-admin" 
	                                	name="checkbox-adminRole" ${memberVO.adminRole eq 'Y' ? 'checked' : '' }>
	                                <form:hidden path="adminRole"/>
	                                <span class="no-drag memberstatus-info status-admin">현재 관리자 상태</span>
	                            </span>
	                        </li>
	                        <li class="memberinfo-item">
	                            <span class="memberinfo-title">활성</span>
	                            <span class="memberinfo-status">
	                                <input type="checkbox" class="memberstatus-setting empower-active"
	                                	name="checkbox-memAlive" ${memberVO.memAlive eq 'Y' ? 'checked' : '' }>
	                                <form:hidden path="memAlive"/>
	                                <span class="no-drag memberstatus-info status-active">현재 활성 상태</span>
	                            </span>
	                        </li>
						</ul>
                    </form:form>
                </div>
            </div>

			<div class="user__works">

				<div class="user__work">
					<h2>작업이력</h2>
					<p>다른 사람에게는 본인에게 액세스가 허용된 것만 봅니다</p>
				</div>

				<div class="nav__type">
					<p class="work__nav">담당 작업</p>
					<p class="nav__hr">/</p>
					<p class="issue__nav">담당 이슈</p>
				</div>

				<div class="work__card">
				
					<c:if test="${not empty workList }">
						<c:forEach items="${workList }" var="workVO">
							<div class="work__history" data-workid="${workVO.workId }">
								<c:if test="${not empty workCustomInfoList }">
									<c:set value="true" var="workFlag"/>
									<c:forEach items="${workCustomInfoList }" var="workCustomInfoVO">
										<c:if test="${workFlag }">
											<c:if test="${workCustomInfoVO.text eq workVO.workType }">
												<c:set value="false" var="workFlag"/>
												<div class="work__type">
													<span class="custom-iconbox" style="background-color: ${workCustomInfoVO.backgroundColor}">
														<span class="custom-icon" style="color: ${workCustomInfoVO.iconColor}">
															<i class="${workCustomInfoVO.iconClass }"></i>
														</span>
														<span class="custom-text" style="color: ${workCustomInfoVO.textColor}">${workCustomInfoVO.text }</span>
													</span>
												</div>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
								<div class="work__info">
									<div class="work__header">
										<span class="work__code">#${workVO.workId }</span>
										<span class="work__summerize">${workVO.boardTitle }</span>
										<span class="work__summerize">[프로젝트: ${workVO.proId }]</span>
									</div>
									<div class="work__news">
										<span>등록시간: ${workVO.createDate }</span>
									</div>
								</div>
							</div>
						</c:forEach>
						<button type="button" class="more__info" onclick="workMoreView('${memberVO.memId}')">더 보기</button>
					</c:if>
					<c:if test="${empty workList }">
						<p>일감 생성내역이 없습니다.</p>
					</c:if>
					
				</div>

				<div class="issue__card">
				
					<c:if test="${not empty issueList }">
						<c:forEach items="${issueList }" var="issueVO">
							<div class="issue__history" data-issueid="${issueVO.issueId }">
								<c:if test="${not empty issueCustomInfoList }">
									<c:set value="true" var="issueFlag"/>
									<c:forEach items="${issueCustomInfoList }" var="issueCustomInfoVO">
										<c:if test="${issueFlag }">
											<c:if test="${issueCustomInfoVO.text eq issueVO.issueType }">
												<c:set value="false" var="issueFlag"/>
												<div class="work__type">
													<span class="custom-iconbox" style="background-color: ${issueCustomInfoVO.backgroundColor}">
														<span class="custom-icon" style="color: ${issueCustomInfoVO.iconColor}">
															<i class="${issueCustomInfoVO.iconClass }"></i>
														</span>
														<span class="custom-text" style="color: ${issueCustomInfoVO.textColor}">${issueCustomInfoVO.text }</span>
													</span>
												</div>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
								<div class="issue__info">
									<div class="issue__header">
										<span class="issue__code">#${issueVO.issueId }</span>
										<span class="issue__summerize">${issueVO.boardTitle }</span>
										<span class="issue__summerize">[프로젝트: ${issueVO.proId }]</span>
									</div>
									<div class="issue__news">
										<span>등록시간: ${issueVO.createDate }</span>
									</div>
								</div>
							</div>
						</c:forEach>
						<button type="button" class="more__info" onclick="issueMoreView('${memberVO.memId}')">더 보기</button>
					</c:if>
					<c:if test="${empty issueList }">
						<p>이슈 발행내역이 없습니다.</p>
					</c:if>
					
				</div>

				<div class="user__project">
					<h2>소속 프로젝트</h2>
				</div>

				<div class="project__card">
					<c:if test="${not empty projectList }">
						<c:forEach items="${projectList }" var="projectVO">
							<div class="project__info" data-proid="${projectVO.proId }">
								<div class="project__type generel__porject">
									<i class="fas fa-stream"></i>
								</div>
								<div class="project__detail">
									<div class="project__id">#${projectVO.proId }</div>
									<div class="project__header">${projectVO.proName }</div>
									<div class="project__header">[담당자: ${projectVO.projectManager }]</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty projectList }">
						<div>
							<p>소속 프로젝트가 없습니다.</p>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="mypage__verifiModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-body">

					<div class="modal__header">비밀번호 확인</div>
					<form action="">
						<div class="form-group form-floating-label">
							<input id="passwordsignin" name="passwordsignin" type="password"
								class="form-control input-border-bottom" required> <label
								for="passwordsignin" class="placeholder">패스워드</label>
							<div class="show-password">
								<i class="icon-eye"></i>
							</div>
						</div>

						<div class="form-group form-floating-label">
							<input id="confirmpassword" name="confirmpassword"
								type="password" class="form-control input-border-bottom"
								required> <label for="confirmpassword"
								class="placeholder">패스워드 확인</label>
							<div class="show-password">
								<i class="icon-eye"></i>
							</div>
						</div>

						<div class="form-groupbtn">
							<button type="button" class="form-cancel">취소</button>
							<button type="button" class="form-confirm">확인</button>
						</div>

					</form>

				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">

</script>







