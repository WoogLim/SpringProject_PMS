/**
 * @author 작성자명
 * @since 2021. 3. 6.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자       수정내용
 * -----------     --------    ----------------------
 * 2021. 3. 6.      신광진       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 

$.getProStatus = function(options){
	$.ajax({
		url: $.getContextPath() + options.url
		, dataType: "json"
	}).done(function(resp){
		let status = resp.status;
		let message = resp.message;
		
		if(message){
			showMessage({
				"text": message.text
				, "align": message.align
				, "from": message.from
				, "timeout": message.timeout
				, "type": message.type
			})
		} else {
			if(status == "PAUSE") {
				swal("접근 불가", "프로젝트가 정지상태이기 때문에 접근 불가능합니다.", "error");
			} else if(status == "COMPLETE") {
				swal("접근 불가", "프로젝트가 완료상태이기 때문에 접근 불가능합니다.", "error");
			} else if(status == "WAIT") {
				swal("접근 불가", "프로젝트가 아직 승인되지 않았습니다.", "error");
			} else if(status == "PROGRESS") {
				location.href = $.getContextPath() + options.moveUrl;
			} 
		}
	}).fail(function(xhr){
		console.log(status);
	});
	
	return this;
}