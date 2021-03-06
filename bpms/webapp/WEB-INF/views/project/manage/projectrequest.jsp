<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 2. 20.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<!-- 역할 넣는 곳 -->
<li class="selmember-rolelist selmember-list d-none">
	<button class="member-rolesetbtn" type="button" data-toggle="dropdown">
		회원 역할 지정
		<i class="fas fa-sort-down"></i>
	</button>
	<ul class="dropdown-menu memberrole-select">
		<c:if test="${not empty authorityList }">
			<c:forEach items="${authorityList }" var="authVO">
				<li data-authority="${authVO.authority }">
					<label for="${authVO.roleName }" class="member-ruleset" onclick="selectMemberRule(this)">${authVO.roleName }</label>
				</li>
			</c:forEach>
		</c:if>
<!-- 		<li> -->
<!-- 			<label for="PM" class="member-ruleset" onclick="selectMemberRule(this)">관리자</label> -->
<!-- 		</li> -->
<!-- 		<li> -->
<!-- 			<label for="UA" class="member-ruleset" onclick="selectMemberRule(this)">유저 인터페이스</label> -->
<!-- 		</li> -->
<!-- 		<li> -->
<!-- 			<label for="TA" class="member-ruleset" onclick="selectMemberRule(this)">테스트 개발자</label> -->
<!-- 		</li> -->
	</ul>
</li>

<!-- 마이페이지 화면 -->
<div class="main-panel">
	<div class="main-container">
		<div class="page-inner">
		
			<!-- 요청 폼 -->
			<form:form commandName="projectVO" method="post" id="requestForm"> 
				<div class="request-box">
					<div class="row request-container">
						<div class="col-md-12">
							<div class="card request-card">
								<section class="item-section">
									<div class="header__work clearfix">
										<div class="float--left d-flex no-drag">
											<h1>새 프로젝트 요청</h1>
										</div>
										<div class="history-filter float--right">
											<div class="history-guide no-drag">
												관리자의 승인시 프로젝트가 진행됩니다.
											</div>
										</div>
									</div>
									
									<div class="requesterror-box">
									
									</div>
	
									<div class="requestform-box">
										<ul class="request-content">
											<li class="project-introduce reqproject-name">
												<span for="" class="requestform-title required-form"> 프로젝트 이름</span>
												<input type="text" class="request-projectinput" id="proName" value="${projectVO.proName }">
											</li>
											<li class="project-introduce reqproject-content">
												<span for="" class="requestform-title required-form"> 프로젝트 내용</span>
												<input type="text" class="request-projectinput" id="proContent" value="${projectVO.proContent }">
											</li>
											<li class="project-respon">
												<div class="requestform-div req-rootproject">
													<span for="" class="requestform-title required-form">구성원</span>
													<div class="response-select">
														<button class="requestform-btn" type="button"
															data-toggle="dropdown" id="selectMemberBtn">
															<span class="project-rootproject">
																구성원 선택
															</span>
														</button>
														<ul class="dropdown-menu response-search"
															aria-labelledby="dropdownMenuButton" id="selectMemberBox">
															<li class="search-bar">
																<input type="text" class="search-respon" placeholder="이름을 검색하세요" id="searchMemberInput">
															</li>
														</ul>
														<ul class="selectuser-preview selectproject-mandate d-none">
														</ul>
													</div>
												</div>

												<div class="requestform-div req-rootproject">
													<div class="reqproject-header">
														<span for="" class="requestform-title title-root float--left">
															상위프로젝트
														</span>
													</div>
													<div class="response-select">
														<button class="requestform-btn" type="button"
															data-toggle="dropdown" id="parentProjectSearchBtn">
															<span class="project-rootproject">
																상위프로젝트 선택
															</span>
														</button>
														<ul class="dropdown-menu response-search"
															aria-labelledby="dropdownMenuButton" id="parentProjectBox">
															<li class="search-bar">
																<input type="text" class="search-respon" id="searchProjectInput">
															</li>
														</ul>
														
														<ul class="selectuser-preview" id="proParentPreView">
														</ul>
													</div>
												</div>
											</li>
	
											<li class="project-introduce memlist-choicerole">
												<span for="" class="requestform-title"> 구성원 역할지정</span>
												<div class="role-container">
													<ul class="memrole-choicelist">
														<li class="selmemlist-container">
	
															<ul class="selmember-title memtitle-box">
																<li class="selmember-titletext">
																	구성원 정보
																</li>
																<li class="selmember-titletext">
																	선택된 역할
																</li>
																<li class="selmember-titletext">
																	역할 선택
																</li>
															</ul>
	
															<ul class="selmemberlist-box">
				                                             	
															</ul>
														</li>
													</ul>
												</div>
											</li>
										</ul>
									</div>
									
									<div class="reqprojectbtn-group">
										<button class="projectrequest-submitbtn" type="button" id="projectInsertBtn">
											프로젝트 요청
										</button>
										<button class="projectrequest-cancelbtn" type="button" id="cancelBtn">
											취소
										</button>
									</div>
	
								</section>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</div>

<form id="memberSearchForm" action="${pageContext.request.contextPath }/member/noPagingMemberList.do">
	<input type="hidden" name="memAlive" value="Y">
	<input type="hidden" name="searchType" value="memName">
	<input type="hidden" name="searchWord" value="">
</form>

<form id="projectSearchForm" action="${pageContext.request.contextPath }/project/simpleProjectList.do">
	<input type="hidden" name="code" value="5">
	<input type="hidden" name="searchType" value="proName">
	<input type="hidden" name="searchWord" value="">
</form>

<form id="parentProjectMemberForm" action="${pageContext.request.contextPath }/project/projectMember.do">
	<input type="hidden" name="proId">
</form>

<form id="projectInsertForm" action="${pageContext.request.contextPath }/project/insertProject.do" method="post">
	<input type="hidden" name="proRequester" value="${authMember.memId }">	
</form>

<script type="text/javascript">
//////////////////////////
// errorbox 
$(".requesterror-box").hide();

$("#cancelBtn").on("click", function() {
	location.href = $.getContextPath() + "/user/main";
});

// 구성원선택
let memberSearchForm = $("#memberSearchForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		let dataList = resp.pagination.pagingVO.dataList;
		let liTags = makeMemberList(dataList);

		$("#selectMemberBox").children("li").not(".search-bar").remove();
		$("#selectMemberBox").append(liTags);
	}
	, error: function(xhr) {
		console.log(xhr.status);
	}
});

// 구성원 검색
$("#searchMemberInput").on("keyup", function() {
	memberSearchForm.find("input[name='searchWord']").val($(this).val());
	memberSearchForm.submit();
});

// 구성원 선택 버튼 클릭시 이벤트
$("#selectMemberBtn").on("click", function() {
	memberSearchForm.submit();
});

<%-- 비동기로 검색된 구성원 선택시 화면에 표시되지 않는 프리뷰에 추가됨 중복탐지를 위해 사용 --%>
$('#selectMemberBox').on('click', "li.search-member", function () {
	let previewContainer = $(this).parent().siblings('.selectuser-preview');
	let roleContainer = $('.selmemberlist-box');

	// 현재 클릭한 멤버
	let cloneSelect = $(this);
	let cloneSelectDom = this;

	// 현재 클릭한 멤버의 Id
	let selectMember = $(this).data('memid');
	console.log(selectMember);

	let drawTemplate = selectMemberTempalte(cloneSelect, selectMember);

	// 프리뷰에 있는 선택된 유저리스트
	let datalist = $(previewContainer).children('.selectuser-item')

	// 이미 선택된 멤버인지 검사
	let check = false;

	datalist.each(function () {
		let member = $(this).data('memid');
		if (selectMember == member) {
			swal("에러!", "이미 선택된 멤버입니다.", "error")
			check = true;
			return;
		}
	})

	// 선택된 멤버가 이미 있는 경우 종료
	if (check) {
		return;
	}

	let drawrolemember = memberroleTemplate(cloneSelectDom, selectMember);
	console.log(drawrolemember);

	previewContainer.append(drawTemplate);
	roleContainer.append(drawrolemember);
})

//////////////////////////
// 상위 프로젝트
let projectSearchForm = $("#projectSearchForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		let dataList = resp.dataList;
		let liTags = makeProjectList(dataList);

		$("#parentProjectBox").children("li").not(".search-bar").remove();
		$("#parentProjectBox").append(liTags);
	}
	, error: function(xhr) {
		console.log(xhr.status);
	}
});

$("#parentProjectSearchBtn").on("click", function() {
	projectSearchForm.submit();
});

$("#searchProjectInput").on("keyup", function() {
	projectSearchForm.find("input[name='searchWord']").val($(this).val());
	projectSearchForm.submit();
});

<%-- 비동기로 검색된 프로젝트 선택시 프리뷰로 보여줌 --%>
$('#parentProjectBox').on('click', 'li.search-pro', function () {
	let previewContainer = $(this).parent().siblings('.selectuser-preview');
	let projectHeader = $('.reqproject-header');

	if (previewContainer.children('.selectpro-item').length > 0) {
		swal("에러!", "프로젝트가 이미 선택되었습니다.", "error")
	} else {
		let cloneSelect = $(this);
		let selectProject = $(this).data('proid');
		$("#parentProjectMemberForm").find("input[name='proId']").val(selectProject);
		
		let drawTemplate = selectProjectTempalte(cloneSelect, selectProject);
		let drawMandatebtn = selectMembermandate();
		console.log(projectHeader);

		previewContainer.append(drawTemplate);
		projectHeader.append(drawMandatebtn);
	}
})

//////////////////////////
// 프로젝트 생성 요청
let projectInsertForm = $("#projectInsertForm");
$("#projectInsertBtn").on("click", function(){
	let root = $("div.requestform-box");
	let hiddenTags = [];
	
	let proName = root.find("input#proName").val();
	let proContent = root.find("input#proContent").val();
	
	let hiddenProName = hiddenTagTemplate({"name": "proName", "val": proName});
	let hiddenProContent = hiddenTagTemplate({"name": "proContent", "val": proContent});
	hiddenTags.push(hiddenProName, hiddenProContent);
	
	let selectedMemberList = $("ul.selmemberlist-box").find("div.selmember-box");
	let proMemcount = 0;
	$(selectedMemberList).each(function(idx, element) {
		proMemcount++;

		let memId = $(this).data("memid");
		let memImg = $(this).data("memimg");
		let authority = $(this).data("authority");
		
		if(authority == 'ROLE_TEAM_MANAGER') {
			let hiddenProManager = hiddenTagTemplate({"name": "projectManager", "val": memId});
			hiddenTags.push(hiddenProManager);
		}
		
		let hiddenMemId = hiddenTagTemplate({"name": "proMemberList[" + idx + "].memId", "val": memId});
		let hiddenMemImg = hiddenTagTemplate({"name": "proMemberList[" + idx + "].memImg", "val": memImg});
		let hiddenAuthority = hiddenTagTemplate({"name": "proMemberList[" + idx + "].authority", "val": authority});
		hiddenTags.push(hiddenMemId, hiddenMemImg, hiddenAuthority);
// 		console.log(memId + ", " + memImg + ", " + authority);
	});
	let hiddenProMemcount = hiddenTagTemplate({"name": "proMemcount", "val": proMemcount});
	hiddenTags.push(hiddenProMemcount);
	
	projectInsertForm.children("input").not("[name='proRequester']").remove();
	projectInsertForm.append(hiddenTags);
	
	let proParent = $("ul#proParentPreView").find("span.responproject-id").text();
	if(!isEmpty(proParent)) {
		let hiddenProParent = hiddenTagTemplate({"name": "proParent", "val": proParent});
		hiddenTags.push(hiddenProParent);
	}
	
	projectInsertForm.append(hiddenTags);
	if(validationCheck(projectInsertForm)) {
		$(".requesterror-box").html("");
		$(".requesterror-box").children().remove();
		$(".requesterror-box").hide();
		projectInsertForm.submit();
	}
	
});

function hiddenTagTemplate(options) {
	return $("<input>").attr("type", "hidden").attr("name", options.name).val(options.val);
}

function errorMsgTemplate(text) {
	return $("<span>").addClass("errors").text(text);
}

// 유효성 체크
function validationCheck(form) {
	let valid = true;
	let errorMsgBox = [];
	
	// 프로젝트 이름
	let proName = form.find("input[name='proName']").val();
	if(isEmpty(proName)) {
		errorMsgBox.push(errorMsgTemplate("프로젝트 이름은 필수 입력입니다."));
		valid = false;
	}
	
	// 팀원 역할
	let hiddens = $(form).find("input[name]");
	let managerCount = 0;
	$(hiddens).each(function(idx, element){
		let name = $(this).attr("name");
		console.log(name);
		if(name.indexOf("authority") > -1) {
			if(isEmpty($(this).val())){
				errorMsgBox.push(errorMsgTemplate("모든 팀원은 역할을 설정해야합니다."));
				valid = false;
			}
			if(!isEmpty($(this).val()) && $(this).val() == "ROLE_TEAM_MANAGER") {
				managerCount++;
			}
		}
		
		if(managerCount > 1) {
			errorMsgBox.push(errorMsgTemplate("TEAM_MANAGER는 한 명이어야 합니다."));
			valid = false;
		}
		
		return valid // break
	});
	
	if(!valid){
		showError(errorMsgBox);
	}
	return valid;
}

// 빈 값 체크
function isEmpty(value) {
	let ret = false;
	if(!value || value.trim().length < 1) {
		ret = true;
	}
	return ret;
}

// 에러메시지 보여주기
function showError(errorMsgBox) {
	let errorDisplayBox = $(".requesterror-box");
	errorDisplayBox.html("");
	$(errorMsgBox).each(function(idx, element){
		errorDisplayBox.append($(this));
	});
	$(".requesterror-box").show();	
}

///////////////////////////
// Function ///////////////

// 구성원 검색결과 리스트 생성
function makeMemberList(dataList) {
	let liTags = [];
	$(dataList).each(function(idx, element){
		let li = $("<li>").addClass("search-user search-member");
		let imgDiv = $("<div>").addClass("avatar-sm");
		let infoDiv = $("<div>").addClass("responuser-info");
		li.append(imgDiv, infoDiv);
	
		let img = $("<img>").attr("src", $.getContextPath() + "/assets/img/profile/defaultProfile.png")
							.attr("alt", "...")
							.addClass("avatar-img rounded-circle");
		if($(this)[0].memImg != null) {
			img.attr("src", $.getContextPath() + "/assets/img/profile/" + $(this)[0].memImg);
		}
		imgDiv.append(img);
	
		let nameSpan = $("<span>").addClass("responuser-name").text($(this)[0].memName);
		let idSpan = $("<span>").addClass("responuser-id").text($(this)[0].memId);
		infoDiv.append(nameSpan, idSpan);
	
		li.data("memid", $(this)[0].memId);
		liTags.push(li);
	});
	return liTags;
}

// 상위프로젝트 리스트 생성
function makeProjectList(dataList) {
	let liTags = [];
	let icon = $("<i>").addClass("fas fa-tasks");
	$(dataList).each(function(idx, element){
		let li = $("<li>").addClass("search-pro").data("proid", $(this)[0].proId);
		let div = $("<div>").addClass("responproject-info");
		li.append(div);

		let proNameSpan = $("<span>").addClass("responproject-title").text($(this)[0].proName);
		let proIdSpan = $("<span>").addClass("responproject-id").text($(this)[0].proId);
		div.append(proNameSpan, proIdSpan);
		
		liTags.push(li);
	});
	return liTags;
}

<%-- 담당자 프리뷰 생성 템플릿 함수 --%>
function selectManagerTempalte(manager, selectmanager) {
	let drawTemplate = $(
		'<li class="selectuser-item" data-memid=""> <div class="avatar-sm"> </div>  <div class="responuser-info"> </div> <div class="selectuser-btngroup"> <button class="responuser-removebtn" type="button" onclick="selectUserCancel(this);"> 취소 </button> </div> </li>'
	);

	let profileImgTag = manager.children('.avatar-sm').children().clone();
	let userNmaeTag = manager.children('.responuser-info').children('.responuser-name').clone();
	let userIdTag = manager.children('.responuser-info').children('.responuser-id').clone();

	drawTemplate.data('memid', selectmanager);
	drawTemplate.children('.avatar-sm').append(profileImgTag);
	drawTemplate.children('.responuser-info').append(userNmaeTag);
	drawTemplate.children('.responuser-info').append(userIdTag);

	return drawTemplate;
}

<%-- 구성원 프리뷰 생성 템플릿 함수 --%>
function selectMemberTempalte(member, selectmember) {
	let drawTemplate = document.createElement('li');
	let avatar = document.createElement('div');
	let responuser = document.createElement('div');

	drawTemplate.setAttribute('class', 'selectuser-item')
	drawTemplate.dataset.memid = selectmember;

	avatar.setAttribute('class', 'avatar-sm');
	responuser.setAttribute('class', 'responuser-info');

	let profileImgTag = member.children('.avatar-sm').children().clone();
	let userNmaeTag = member.children('.responuser-info').children('.responuser-name').clone();
	let userIdTag = member.children('.responuser-info').children('.responuser-id').clone();

	$(drawTemplate).children('.avatar-sm').append(profileImgTag);
	$(drawTemplate).children('.responuser-info').append(userNmaeTag);
	$(drawTemplate).children('.responuser-info').append(userIdTag);
	console.log(drawTemplate)

	return drawTemplate;
}

<%-- 상위 프로젝트 프리뷰 생성 템플릿 함수 --%>
function selectProjectTempalte(project, selectproject) {
	let drawTemplate = $(
		'<li class="selectpro-item" data-proid=""> <i class="fas fa-tasks"></i> <div class="responproject-info"> </div> <div class="selectuser-btngroup"> <button class="responpro-removebtn" type="button" onclick="selectProjectCancel(this);"> 취소 </button>  </div> </li>'
	);
	let projectTitle = project.children('.responproject-info').children('.responproject-title').clone();
	let projectId = project.children('.responproject-info').children('.responproject-id').clone();

	drawTemplate.data('proid', selectproject);
	drawTemplate.children('.responproject-info').append(projectTitle);
	drawTemplate.children('.responproject-info').append(projectId);

	return drawTemplate;
}

<%-- 상위 프로젝트 구성원 위임 버튼 생성 템플릿 함수 --%>
function selectMembermandate() {
	let drawTemplate = $(
		'<button type="button" class="float--right mandate-select"> <input type="checkbox" name="mandate" id="mandate-member" onchange="selectMandate(this);"> <label for="mandate-member">구성원 위임</label> </button>'
	);
	return drawTemplate;
}

<%-- 담당자 취소 버튼 클릭시 선택된 담당자 삭제 함수 --%>
function selectUserCancel(input) {
	let cancelUser = $(input).parents('.selectuser-item').data('memid');
	$(input).parents('.selectuser-item').remove();
	$('.selmemberlist-box').children('.selmember-box[data-memid=' + cancelUser + ']').remove();
}

<%-- 프로젝트 취소 버튼 클릭시 선택된 프로젝트 삭제 함수 --%>
function selectProjectCancel(input) {
	console.log(input);
	$("#parentProjectMemberForm").find("input[name='proId']").val("");
	$(input).parents('.selectpro-item').remove();
	$('.selectproject-mandate').children('.selectmandate-item').remove();
	$('.reqproject-header').children('.mandate-select').remove();
	$('.selmemberlist-box').children('.mandatemem-box').remove();
}

<%-- 역할지정 탭에서 구성원 삭제 버튼 클릭시 선택된 구성원 삭제 함수, 화면에 보이지 않는 구성원 프리뷰에서도 삭제 --%>
function selectMemberCancel(input) {
	console.log('눌림');
	let cancelUser = $(input).parent().parent().parent().parent().data('memid');
	$('.selectproject-mandate').children('.selectuser-item[data-memid=' + cancelUser + ']').remove();
	let deleteTarget = $(input).parents('.selmember-box');
	deleteTarget.remove();
	console.log(cancelUser);
	// $(input).parents('.selectuser-item').remove();
}

<%-- 구성원 위임 버튼 클릭시 실행되는 함수 --%>
function selectMandate(input) {
	let check = $(input).prop('checked')
	let previewContainer = $('.selectproject-mandate');
	let rolememberConatainer = $('.selmemberlist-box');
	console.log(input);
	// 체크되어 있을 때
	
	let selectedMemberList = [];
	let selmemberlist = $("ul.selmemberlist-box").children("div.selmember-box");
	$(selmemberlist).each(function(idx, element) {
		selectedMemberList.push($(this));
	});
	if (check) {
		$.ajax({
			url: $("#parentProjectMemberForm").attr("action")
			, data: {
				"proId": $("#parentProjectMemberForm").find("input[name='proId']").val()
			}
			, dataType: "json"
		}).done(function(resp){
			let memberList = resp.proMemberList;
			$(memberList).each(function(idx, element){
				let memId = $(this)[0].memId;
				let memName = $(this)[0].memName;
				let memImg = $(this)[0].memImg;
				
				let duplicationFlag = false;
				$(selectedMemberList).each(function(idx, element){
					duplicationFlag = memId == $(this).data("memid") ? true : false;
				});

				if(!duplicationFlag){
					if(memImg == "" || memImg == null) {
						memImg = $.getContextPath() + "/assets/img/profile/defaultProfile.png";
					}
					
					let template = mandateMemberTempalte(memId, memImg, memName);
					let roletemplate = mandatememroleTemplate(memId, memImg, memName);
	
					previewContainer.append(template);
					rolememberConatainer.append(roletemplate);
				}
			});
		}).fail(function(xhr){
			console.log(xhr.status);
		});
	} else {
		<%-- 체크 해제시 프리뷰, 역할지정 프리뷰에서 삭제 --%>
		previewContainer.children('.selectmandate-item').remove();
		rolememberConatainer.children('.mandatemem-box').remove();
	}
}

<%-- 구성원 위임 체크박스 선택시 구성원 프리뷰에 추가 --%>
function mandateMemberTempalte(member, memberimg, memname) {
	let drawTemplate = $(
		'<li class="selectuser-item selectmandate-item" data-memid=""> <div class="avatar-sm"> <img src="" alt="..." class="avatar-img rounded-circle"> </div> <div class="responuser-info"> <span class="responuser-name"> </span> <span class="responuser-id"> </span> </div> <div class="selectuser-btngroup"> <button class="responuser-removebtn" type="button" onclick="selectUserCancel(this);"> 취소 </button> </div> </li>'
	);

	drawTemplate.data('memid', member);
	drawTemplate.children('.avatar-sm').children('img').attr('src', memberimg);
	drawTemplate.children('.responuser-info').children('.responuser-name').text(memname);
	drawTemplate.children('.responuser-info').children('.responuser-id').text(member);

	return drawTemplate;
}

function viewRoleModal() {
	$('.custommodal-container').fadeIn(100);
	$('.custompopup-title').text("dd");

	$('.custombtn-cancel').click(function () {
		$('.custommodal-container').fadeOut(100);
	})
}

<%-- 구성원 위임 체크박스 선택시 구성원 역할지정 프리뷰에 추가 --%>
function memberroleTemplate(member, selectmember) {
	let drawTemplate = document.createElement('div')
	let userinfoBoxTag = document.createElement('li')
	let userImg = document.createElement('div')
	let userinfoTag = document.createElement('div')
	let userroleTag = document.createElement('li')
	let userrolelistTag = document.createElement('li');
	
	drawTemplate.setAttribute('class', 'selmember-box');
	drawTemplate.dataset.memid = selectmember;
	
	userinfoBoxTag.setAttribute('class', 'selmember-info');
	userImg.setAttribute('class', 'avatar-sm');
	userinfoTag.setAttribute('class', 'responuser-info');
	userroleTag.setAttribute('class', 'selmember-role');
	userroleTag.innerText = "역할을 선택해주세요"
	
	userrolelistTag.setAttribute('class', 'selmember-rolelist');

	userinfoBoxTag.append(userImg);
	userinfoBoxTag.append(userinfoTag);
	
	drawTemplate.append(userinfoBoxTag);
	drawTemplate.append(userroleTag);
	drawTemplate.append(userrolelistTag);
	
	let cancelbtn = $(
		'<div class="selectuser-btngroup seluserdeletebtn"> <button class="responuser-removebtn" type="button" onclick="selectMemberCancel(this);"> 삭제 </button> </div>'
		)
		let profileImgTag = $(member).children('.avatar-sm').children().clone();
		let selectMember = $(member).children('.responuser-info').children().clone();
		
	let rolelist = $('.selmember-list').children().clone()
	rolelist.removeClass('d-none');
	
	// drawTemplate.data('memid', selectmember);
	$(drawTemplate).children('.selmember-info').children('.avatar-sm').append(profileImgTag);
	$(drawTemplate).children('.selmember-info').children('.responuser-info').append(selectMember);
	$(drawTemplate).children('.selmember-info').children('.responuser-info').append(cancelbtn);
	$(drawTemplate).children('.selmember-rolelist').append(rolelist);

	return drawTemplate;
}

<%-- 구성원 검색으로 선택한 구성원을 역할지정 프리뷰에 추가 --%>
function mandatememroleTemplate(member, memberimg, memname) {
	let drawTemplate = document.createElement('div');
	let userinfoBoxTag = document.createElement('li');
	let userImg = document.createElement('div');
	let userinfoTag = document.createElement('div');
	let userroleTag = document.createElement('li');
	let userrolelistTag = document.createElement('li');

	let imgTag = document.createElement('img');
	let userNTag = document.createElement('span');
	let userITag = document.createElement('span');

	drawTemplate.setAttribute('class', 'selmember-box mandatemem-box');
	drawTemplate.dataset.memid = member;

	imgTag.setAttribute('class', 'avatar-img rounded-circle');
	userNTag.setAttribute('class', 'responuser-name');
	userITag.setAttribute('class', 'responuser-id');

	userinfoBoxTag.setAttribute('class', 'selmember-info');
	userImg.setAttribute('class', 'avatar-sm');
	userinfoTag.setAttribute('class', 'responuser-info');
	userroleTag.setAttribute('class', 'selmember-role');
	userroleTag.innerText = "역할을 선택해주세요"

	userrolelistTag.setAttribute('class', 'selmember-rolelist');

	userImg.append(imgTag);

	userinfoTag.append(userNTag);
	userinfoTag.append(userITag);

	userinfoBoxTag.append(userImg);
	userinfoBoxTag.append(userinfoTag);

	drawTemplate.append(userinfoBoxTag);
	drawTemplate.append(userroleTag);
	drawTemplate.append(userrolelistTag);

	let cancelbtn = $(
		'<div class="selectuser-btngroup seluserdeletebtn"> <button class="responuser-removebtn" type="button" onclick="selectMemberCancel(this);"> 삭제 </button> </div>'
		)
	let rolelist = $('.selmember-list').children().clone()
	rolelist.removeClass('d-none');

	// drawTemplate.data('memid', selectmember);
	$(drawTemplate).children('.selmember-info').children('.avatar-sm').children('img').attr('src', memberimg);
	$(drawTemplate).children('.selmember-info').children('.responuser-info').children('.responuser-name').text(
		memname);
	$(drawTemplate).children('.selmember-info').children('.responuser-info').children('.responuser-id').text(member);
	$(drawTemplate).children('.selmember-info').children('.responuser-info').append(cancelbtn);
	$(drawTemplate).children('.selmember-rolelist').append(rolelist);

	return drawTemplate;
}

<%-- 역할지정시 선택한 역할명을 보여줌 --%>
function selectMemberRule(input){
	let rolename = $(input).text();
	let authority = $(input).parent().data("authority");
	$(input).parent().parent().parent().siblings('.selmember-role').text(rolename);
	$(input).parent().parent().parent().parent().data("authority", authority);
	
	let memImg = $(input).parent().parent().parent().siblings("li.selmember-info").find("img").attr("src")
	memImg = memImg.substring(memImg.lastIndexOf("/") + 1);
	$(input).parent().parent().parent().parent().data("memimg", memImg);
}
</script>






















