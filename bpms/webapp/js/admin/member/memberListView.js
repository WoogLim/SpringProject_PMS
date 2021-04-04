/**
 * @author 작성자명
 * @since 2021. 2. 2.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자       수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 02.     신광진       최초작성
 * 2021. 2. 04.     신광진       Script작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 

const lockModal = $("#set__statuschange");
const unlockModal = $("#set__unlockmodal");
const removeModal = $("#set__roleRemove");
const initPasswordModal = $("#initPasswordModal");
const memberListBody = $("#memberListBody");
const pagingArea = $("#pagingArea");

//=============== Paging ============================
pagingArea.on("click", "a", function(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	let hiddenTag = memberListForm.find("input[name='page']");
	hiddenTag.val(page);
	memberListForm.submit();
	return false;
});
	
//=============== Form ============================
// 계정 잠금, 잠금해제 처리 Form
let lockStatusForm = $("#lockStatusForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		console.log(resp);
		if(resp.result == "OK") {
			showResultMessage(resp.message);
			memberListForm.submit();
		} else {
			showResultMessage(resp.message);
		}
	}
	, error: function(xhr) {
		console.log(xhr.status);
	}
});

// 계정 삭제처리 Form
let removeForm = $("#removeForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		console.log(resp);
		if(resp.result == "OK") {
			showResultMessage(resp.message);
			memberListForm.submit();
		} else {
			showResultMessage(resp.message);
		}
	}
	, error: function(xhr) {
		console.log(xhr.status);
	}
});

// 비밀번호 초기화 Form
let initPasswordForm = $("#initPasswordForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		console.log(resp);
		showResultMessage(resp.message);
	}
});

// 회원 리스트 조회 Form
let memberListForm = $("#memberListForm").ajaxForm({
	dataType: "json"
	, success: function(resp) {
		console.log(resp);
		let dataList = resp.pagination.pagingVO.dataList;
		let pagingHTML = resp.pagination.pagingVO.pagingHTML;
		let trTags = [];
		
		let memberTag = '<span class="auth__member"><i class="fas fa-user"></i></span>';
		let adminTag = '<span class="auth__admin"><i class="fas fa-user-cog"></i></span>';
		let lockMemberTag = '<span class="auth__lock"><i class="fas fa-user-lock"></i></span>';
		let unlockBtn = '<button type="button" class="member__setbtn set__member-unlock" onclick="unlockmember($(this))"'
						+ ' data-toggle="modal" data-target="#set__unlockmodal"> 잠금 해제 </button>'
		
		let lockBtn = '<button type="button" class="member__setbtn set__member-lock" onclick="lockmember($(this))"'
					  + ' data-toggle="modal" data-target="#set__statuschange"> 잠금 설정 </button>';

		let removeBtn = '<button type="button" class="member__setbtn set__member-remove" onclick="removemember($(this))"'
    					+ ' data-toggle="modal" data-target="#set__roleRemove"> 계정 삭제 </button>';
    	let initPasswordBtn = '<button type="button" class="member__setbtn" onclick="initPassword($(this))"'
							+ 'data-toggle="modal" data-target="#initPasswordModal"> 비밀번호 초기화 </button>';
		$(dataList).each(function(idx, memberVO) {
			
			let td_memId = $("<td>").html($("<a>").attr("href", $.getContextPath() + "/admin/member/memberDetail.do?memId=" + memberVO.memId).text(memberVO.memId));
			let td_memName = $("<td>").text(memberVO.memName);
			let td_memMail = $("<td>").text(memberVO.memMail);
			let td_adminRole = $("<td>");
			if(memberVO.adminRole == "Y" && memberVO.memAlive == "Y") {
				td_adminRole.html(adminTag);
			}
			else if(memberVO.adminRole != "Y" && memberVO.memAlive == "Y") {
				td_adminRole.html(memberTag);
			}
			else if(memberVO.memAlive == "N") {
				td_adminRole.html(lockMemberTag);
			}
		
			let td_createDate = $("<td>").text(memberVO.createDate);
			
			let flexDiv = $("<div>").data("id", memberVO.memId).data("name", memberVO.memName).addClass("d-flex");
			let td_settings = (memberVO.memAlive == "N") ? $("<td>").append(flexDiv.append(unlockBtn, removeBtn, initPasswordBtn))
														 : $("<td>").append(flexDiv.append(lockBtn, removeBtn, initPasswordBtn));
			let trTag = $("<tr>").append(
				td_memId
				, td_memName
				, td_memMail
				, td_adminRole
				, td_createDate
				, td_settings
			);
			trTags.push(trTag
					
			);
		});
		memberListBody.html(trTags);
		pagingArea.html(pagingHTML);
	}
	, error: function(xhr) {
		console.log(xhr.status);
	}
});

// 결과메시지 출력
function showResultMessage(param) {
	showMessage({
		"text": param.text
		, "align": param.align
		, "from": param.from
		, "timeout": param.timeout
		, "type": param.type
	})
}

//=============== 검색조건 =============================
$(".filter__card").find(":input[id]").on("change", function() {
	let selected = $(this).val();
	let tagId = $(this).attr("id");
	
	switch(tagId) {
		case "statusOptions" :
			memberListForm.find("input[name='memAlive']").val(selected);
			break;
			
		case "adminRoleOptions" :
			memberListForm.find("input[name='adminRole']").val(selected);
			break;
		
		case "dateOptions" :
			memberListForm.find("input[name='sortType']").val(selected);
			break;
			
		default:
			console.log("Unknown SelectBox");
			return false;
	}
	memberListForm.submit();
});

$(".memberlist__card").find("input[id='searchWord']").on("keyup", function() {
	let searchWord = $(this).val();
	memberListForm.find("input[name='searchWord']").val(searchWord);
	memberListForm.submit();
});

//=============== MODAL =============================	
// 잠금설정 클릭 이벤트
function lockmember(input) {
	setDataInModal({
		"modal": lockModal
		, "memId": getMemId(input)
		, "memName": getMemName(input)
	});
}

// 잠금해제 클릭 이벤트
function unlockmember(input) {
	setDataInModal({
		"modal": unlockModal
		, "memId": getMemId(input)
		, "memName": getMemName(input)
	});
}

// 계정삭제 클릭 이벤트
function removemember(input) {
	setDataInModal({
		"modal": removeModal
		, "memId": getMemId(input)
		, "memName": getMemName(input)
	});
}

// 비밀번호 초기화 클릭 이벤트
function initPassword(input){
	setDataInModal({
		"modal": initPasswordModal
		, "memId": getMemId(input)
		, "memName": getMemName(input)
	});
	initPasswordModal.find("div.set__mail").text(getMemMail(input));
}

// 회원아이디 (테이블 버튼만 사용가능, 모달내부 버튼 X)
function getMemId(element) {
	return $(element).parent("div.d-flex").data("id");
}

// 회원이름 (테이블 버튼만 사용가능, 모달내부 버튼 X)
function getMemName(element) {
	return $(element).parent("div.d-flex").data("name");
}

function getMemMail(element){
	return $(element).parent("div.d-flex").data("mail");
}

// Modal내부에 데이터 셋팅
function setDataInModal(options) {
	let modal = options.modal;
	let memId = options.memId;
	let memName = options.memName;
	let memIdDiv = modal.find("div.set__role");
	let memNameDiv = modal.find("div.set__name");
	
	memIdDiv.text(memId);
	memNameDiv.text(memName);
}

//=============== MODAL 내부 BUTTON ============================
// 잠금해제 확인버튼 이벤트 
$("#unlockBtn").on("click", function() {
	let memId = getMemIdByModal(unlockModal);
	lockStatusForm.find("input[name='memId']").val(memId);
	lockStatusForm.find("input[name='memAlive']").val("Y");
	lockStatusForm.submit();
	btnClickTrigger($("#unlockCancelBtn"));
});

// 잠금 확인버튼 이벤트
$("#lockBtn").on("click", function() {
	let memId = getMemIdByModal(lockModal);
	lockStatusForm.find("input[name='memId']").val(memId);
	lockStatusForm.find("input[name='memAlive']").val("N");
	lockStatusForm.submit();
	btnClickTrigger($("#lockCancelBtn"));
});

// 삭제 확인버튼 이벤트
$("#removeBtn").on("click", function() {
	let memId = getMemIdByModal(removeModal);
	removeForm.find("input[name='memId']").val(memId);
	removeForm.submit();
	btnClickTrigger($("#removeCancelBtn"));
});

// Button Click Tigger
function btnClickTrigger(button) {
	button.trigger("click");
}

// 모달창 내부에 세팅된 회원 아이디 가져옴
function getMemIdByModal(modal) {
	return modal.find("div.set__role").text().trim();
}

//=============== 페이지이동 ============================
// 구성원 추가
$("#memberInsertBtn").on("click", function() {
	location.href = $.getContextPath() + "/admin/member/memberInsert.do"
});


//=============== 비밀번호 초기화 ==================
$("#initPasswordBtnInModal").on("click", function() {
	let memId = $(this).parent().siblings("div.setting__roleSet").first().children("div.set__role").text();
	initPasswordForm.find("input[name='memId']").val(memId.trim());
	initPasswordForm.submit();
	$(this).prev().trigger("click");
});

//=============== SELECT(임건) ============================
$(document).ready(function() {
    var selectTarget = $('.selectbox select');

    selectTarget.each(function(){
    	let select_name = $(this).children('option:selected').text();
    	$(this).siblings('label').text(select_name)
    })
    
    selectTarget.change(function(){ 
        var select_name = $(this).children('option:selected').text(); 
        
        /* 형제 요소인 label에 표시 */
        $(this).siblings('label').text(select_name); 
    }); 
});

// 검색조건 초기화
$("#initSearchOptions").on("click", function() {
	let selects = $("div.filter__card").find("select").not("[name='sortCondition']").not("[name='searchType']");
	$(selects).each(function(idx, element) {
		$(this).val("");
	});
	
	let hiddens = memberListForm.find("input");
	$(hiddens).each(function(idx, element){
		$(this).val("");
	});
	memberListForm.submit();
	
	let card = $("li.project-rules").find("select");
	
	$(card).each(function(idx, element){
		let defaultValue = $($(this).find("option")[0]).text();
		$(this).siblings("label").text(defaultValue);
	});
	
});
























