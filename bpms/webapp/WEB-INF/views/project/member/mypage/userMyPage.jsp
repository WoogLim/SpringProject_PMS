<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 2. 22.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="mypage__container">
    <div class="myheader__container">
        <div class="mask"></div>
    </div>

    <div class="profile__card row">

        <div class="profile__image col-10">
			<c:if test="${memberVO.memImg eq null }">
				<img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt=""> 
			</c:if>
			<c:if test="${not (memberVO.memImg eq null) }">
				<img src="${pageContext.request.contextPath }/assets/img/profile/${memberVO.memImg }" alt=""> 
			</c:if>
            <span class="name__profile">${memberVO.memName }</span>
        </div>

    </div>
</div>
<div class="profile__container row">

    <div class="profile__info col-10">

        <div class="user__info">

            <div class="info__card">

                <div class="list__title">
                    <h2>정보</h2>
                    <a href="${pageContext.request.contextPath }/member/mySetting">정보 수정</a>
                </div>
                <div class="info__list">
                    <p class="info__email">
                        <i class="far fa-envelope"></i>
                        ${memberVO.memMail }
                    </p>
                </div>

                <div class="list__title">
                    <h2>마이보드</h2>
                    <a href="${pageContext.request.contextPath }/kanban/kanbanView.do">더보기</a>
                </div>
                
                <div class="kanban__list">
	                <c:if test="${not empty mystickerList }">
	                	<c:forEach items="${mystickerList }" var="stickerVO">
		                    <p class="kanban__history">
		                        <i class="fas fa-pen-square"></i>
		                        	${stickerVO.kstickerTitle }
		                    </p>
	                	</c:forEach>
	                </c:if>
	                <c:if test="${empty mystickerList }">
	                    <p class="kanban__history">
	                        <i class="fas fa-pen-square"></i>
	                        	작성한 메모가 없습니다.
	                    </p>
	                </c:if>
                </div>
            </div>
        </div>

        <div class="user__works">

            <div class="user__work">
                <h2>작업이력</h2>
                <p>다른 사람에게는 본인에게 액세스가 허용된 것만 봅니다</p>
            </div>

            <div class="nav__type">
                <p class="work__nav">내 작업</p>
                <p class="nav__hr">/</p>
                <p class="issue__nav">내 이슈</p>
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

<script type="text/javascript">   
$(document).ready(function(){
    
	$('.page-inner').addClass('my-inner');
	$('.nav-myprofile').addClass('mynav-active');
    
    let worklist = $(".work__card");
    let issuelist = $('.issue__card');
    $(".work__nav").addClass('nav__active');

    $('.issue__nav').click(function(){
        $(worklist).hide();
        $(".work__nav").removeClass('nav__active');
        $(issuelist).show();
        $(this).addClass('nav__active');
    })

    $(".work__nav").click(function(){
        $(issuelist).hide();
        $(".issue__nav").removeClass('nav__active');
        $(worklist).show();
        $(this).addClass('nav__active');
    })
    
    let workList = $(".work__card");
	let issueList = $('.issue__card');
	let projectList = $(".project__card");
	
	$(".work__nav").addClass('nav__active');

	$('.issue__nav').click(function() {
		$(workList).hide();
		$(".work__nav").removeClass('nav__active');
		$(issueList).show();
		$(this).addClass('nav__active');
	})

	$(".work__nav").click(function() {
		$(issueList).hide();
		$(".issue__nav").removeClass('nav__active');
		$(workList).show();
		$(this).addClass('nav__active');
	})
	
	workList.on("click", "div.work__history", function(){
		let workId = $(this).data("workid");
		location.href = $.getContextPath() + "/work/workView.do?workId=" + workId;
	});
	
	issueList.on("click", "div.issue__history", function() {
		let issueId = $(this).data("issueid");
		location.href = $.getContextPath() + "/issue/issueView.do?issueId=" + issueId;
	});
	
	projectList.on("click", "div.project__info", function() {
		let proId = $(this).data("proid");
		location.href = $.getContextPath() + "/project/main?proId=" + proId;
	});
})

</script>