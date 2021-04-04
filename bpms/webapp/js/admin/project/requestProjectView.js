/**
 * @author 신광진
 * @since 2021. 1. 30.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일             수정자        수정내용
 * ------------     --------    ----------------------
 * 2021. 1. 30.      신광진         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 
const myModal = $("#myModal");
const rejectModal = $("#rejectModal");
let projectForm = $("#projectForm");
let pushMsgForm = $("#pushMsgForm");

// listBody
$("#listBody").on("click", "a#reqViewTag", function() {
	let title = $(this).data("title");	
	let content = $(this).data("content");
	let id = $(this).data("id");
	let requester = $(this).data("requester");
	
	let proTitle = myModal.find(":input[id='title']");
	let proContent = myModal.find(":input[id='content']");
	let proRequester = myModal.find("input[id='proRequseter']");
	let proId = myModal.find("input[id='proId']");
	
	proRequester.val(requester);
	proTitle.val(title);
	proContent.val(content);
	proId.val(id);
});

// myModal close trigger
function closeMyModal() {
	myModal.find("button.close").trigger("click");
}

// rejectModal close trigger
function closeRejectModal() {
	$("#pushContentSpan").text("");
	$("#pushContent").val("");
	rejectModal.find("button.close").trigger("click");
}

// reject Button in myModal
$("#rejectBtn").on("click", function() {
	closeMyModal();
	
	let proId = myModal.find("input[id='proId']").val();
	let pushReceiver = myModal.find("input[id='proRequseter']").val();
	
	rejectModal.find("input[id='pushReceiver']").val(pushReceiver);
	rejectModal.find("input[id='proId']").val(proId);
	$(rejectModal).modal();
});

// accept Button in myModal
$("#acceptBtn").on("click", function() {
	closeMyModal();
	let proId = myModal.find("input[id='proId']").val();
	projectForm.find("input[name='proId']").val(proId);
	projectForm.submit();
});

// send Button in rejectModal
$("#sendBtn").on("click", function(){
	let pushContent = $("#pushContent").val();
	if(pushContent != null && pushContent.trim().length > 0) {
		let inputs = rejectModal.find(":input[id]");
		$(inputs).each(function(idx, element){
			let name = $(this).attr("id");
			let val = $(this).val();
			let hiddenTag = pushMsgForm.find("input[name='" + name + "']");
			hiddenTag.val(val);
//			console.log(hiddenTag.attr("name") + " : " + hiddenTag.val());
		});
		pushMsgForm.submit();
	} else {
		$("#pushContentSpan").text("거절사유를 입력해야 합니다.").css("color", "red");
	}
});

// projectMember mouse Event
$('.toggle-person, .toggle-personlist').on('mouseover mouseleave', function () {
	$(this).siblings('.person-name').toggle();
})

function memberDetailView(input) {
	location.href = $.getContextPath() + "/admin/member/memberDetail.do?memId=" + input.data("memid");
}




