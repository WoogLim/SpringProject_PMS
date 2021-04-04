/**
 * @author 작성자명
 * @since 2021. 2. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일           수정자       수정내용
 * -----------     --------    ----------------------
 * 2021. 2. 8.      신광진       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 
function setrole(input) {
	let customTag = $(input).parent().siblings('.role__rule');
	let setrole = customTag.children().clone();
	
	let settingrole = ('.set__role');

	if ($(settingrole).children()) {
		$(settingrole).empty();
	}
	$(settingrole).append(setrole);

	let code = customTag.data("code");
	let customNo = customTag.data("no");
	let text = customTag.find("span.custom-text").text();
	$("#set__roleRemove").find("input[name='code']").val(code);
	$("#set__roleRemove").find("input[name='customNo']").val(customNo);
	$("#set__roleRemove").find("input[name='text']").val(text);
}

/*
수정일 : 2021-02-05
작성자 : 임건
설   명 : 유형 추가 모달
*/
let selecthistory;
let iconhistory = $('#setting-status .custom-iconbox i');
let customForm = $("#customForm");

// 모달 클릭시 초기화
$('.custom-initbtn').on('click',function(){
    let iconselect = $('#setting-status .common-iconlabel');

    if(iconselect.hasClass('selected-icon')){
        iconselect.removeClass('selected-icon');
    }
    $('#setting-status .custom-text').text('');
    
    if(iconhistory.attr('class')) {
        iconhistory.removeClass();
    }
    
    modalClear();
    hiddenClear();
    errorsClear();
})

// 버튼 클릭시 CSS 입혀줌
$('.common-iconlabel').on('click',function() {
    let current = $(this);
    if($(selecthistory).hasClass('selected-icon')) {
        selecthistory.removeClass('selected-icon');
    }
    current.addClass('selected-icon')
    selecthistory = current;
})

// 텍스트 입력시 감지
$('.common-text').on('propertychange change keyup paste input', function(){
    let currentval = $(this).val();
    $('#setting-status .custom-text').text(currentval);
    $("#setting-status span#textSpan").text("");
    // 텍스트 입력지워줘야함
    
    // 입력된 Text Hidden Tag Setting
    customForm.find("input[name='text']").val(currentval);
    customForm.find("input[name='codeName']").val(currentval);
})

$('.random-color').on('click',function(){
    let color = Math.random() * 0xffffff; // 0 ~ ffffff 무작위
    color = parseInt(color); // 정수로 변환
    color = color.toString(16) // 16진수 문자로 변환

    let randomcolor = "#"+color;
    let colorinput = $(this).siblings('#setting-status .common-colorinput');
    colorinput.val(randomcolor);
    
    iconcolor(this.nextSibling.nextSibling)
})

// 버튼 클릭시 아이콘 클래스 값 불러옴
function iconselect(icon){
    let iconVal = $(icon).val();
    if(iconhistory.attr('class')) {
        iconhistory.removeClass();
    }
    iconhistory.addClass(iconVal);
    
    $("#setting-status span#iconSpan").text("");
    customForm.find("input[name='iconClass']").val(iconVal);
}

// 색상 커스텀
function iconcolor(input){
    let inputcolor = $(input);

    if(input.dataset.selector == "icon"){
        inputcolor.siblings('.color-hex').text(inputcolor.val());
        $('#setting-status .custom-icon i').css("color",inputcolor.val());
    }
    if(input.dataset.selector == "text"){
        inputcolor.siblings('.color-hex').text(inputcolor.val());
        $('#setting-status .custom-text').css("color",inputcolor.val());
    }
    if(input.dataset.selector == "background"){
        inputcolor.siblings('.color-hex').text(inputcolor.val());
        $('#setting-status .custom-iconbox').css("background",inputcolor.val());
    }

	// 선택된 색상 hiddenTag Setting
    let hiddenTagName = inputcolor.attr("id");
    customForm.find("input[name = '" + hiddenTagName + "']").val(inputcolor.val());
}

// 모달 창 내부 추가버튼 클릭
$("#insertBtnInModal").on("click", function() {
	if(formValidationCheck()) {
		customForm.submit();
	}		
});

// 모달 창 내부 수정버튼 클릭
$("#modifyBtnInModal").on("click", function() {
	let type = $(this).parent().data("type");
	if(formValidationCheck()){
		if(type == "work") {
			customForm.attr("action", $.getContextPath() + "/admin/work/customInfoUpdate.do");
		} else if(type == "issue") {
			customForm.attr("action", $.getContextPath() + "/admin/issue/customInfoUpdate.do");
		} else {
			return false;
		}
		customForm.submit();
	}		
});

// 아이콘, 텍스트 입력 확인
function formValidationCheck() {
	let submitFlag = true;
	let hiddenTags = customForm.find("input[type='hidden']");
	$(hiddenTags).each(function(idx, element) {
		let name = $(this).attr("name");
		let val = $(this).val();
		if(name == "text" && (val == null || val.trim().length < 1)) {
			$("#textSpan").text("이름은 필수입력입니다");
			submitFlag = false;
		} 
		
		if(name == "iconClass" && (val == null || val.trim().length < 1)) {
			$("#iconSpan").text("아이콘 선택은 필수입니다");
			submitFlag = false;
		}
	});
	return submitFlag;
}

// 수정버튼 클릭 이벤트
$("div.card__row").on("click", "button#modifyBtn", function() {
	errorsClear();
	$("#setting-status #insertBtnInModal").hide();
	$("#setting-status #modifyBtnInModal").show();
	
	let ul = $(this).closest("ul");
	let li = ul.find("li.role__rule");
	let modal = $("#setting-status");
	
	modal.find("input[name='customNo']").val(li.data("no"));
	modal.find("input[name='code']").val(li.data("code"));
	
	let backgroundColorStyle = li.find("span.custom-iconbox").attr("style");
	let backgroundColor = backgroundColorStyle.substring(backgroundColorStyle.indexOf("#"));
	modal.find("input[id='backgroundColor']").val(backgroundColor);
	modal.find("input[name='backgroundColor']").val(backgroundColor);
	modal.find("div.icon-preview span.custom-iconbox").css("background-color", backgroundColor);
	
	let iconColorStyle = li.find("span.custom-icon").attr("style");
	let iconColor = iconColorStyle.substring(iconColorStyle.indexOf("#"));
	modal.find("input[id='iconColor']").val(iconColor);
	modal.find("input[name='iconColor']").val(iconColor);
	modal.find("div.icon-preview span.custom-icon i").css("color", iconColor);

	let iconClass = li.find("span.custom-icon i").attr("class");
	modal.find("input[name='iconClass']").val(iconClass);
	let iconRadios = modal.find("input[type=radio]");
	$(iconRadios).each(function(idx, element) {
		if($(this).val() == iconClass) {
			$(this).trigger("click");
			$(this).prev("label").trigger("click");
			iconhistory.addClass(iconClass);
		}
	});
	
	let textSpan = li.find("span.custom-text");
	let text = textSpan.text();
	let textColorStyle = textSpan.attr("style");
	let textColor = textColorStyle.substring(textColorStyle.indexOf("#"));
	modal.find("input[name='text']").val(text);
	modal.find("input[name='codeName']").val(text);
	modal.find("input[name='textColor']").val(textColor);
	modal.find("div.icon-preview span.custom-text").text(text);
	modal.find("div.icon-preview span.custom-text").css("color", textColor);
	modal.find("input.common-text").val(text);
	modal.find("input#textColor").val(textColor);
});

// 모달 창 내부 취소버튼 클릭
$("#cancelBtnInModal").on("click", function() {
	let modal = $("#setting-status");
	let hiddens = modal.find("input[type='hidden']");
	$(hiddens).each(function(idx, element){
		let name = $(this).attr("name");
		if(name != "groupCode" && name != "groupName") {
			$(this).val("");
		}
	});
});

// 모달 창 내부 삭제버튼 클릭
$("#removeBtnInModal").on("click", function() {
	let inputs = $("#set__roleRemove").find("input[type='hidden']");
	$(inputs).each(function(idx, element){
		let value = $(this).val();
		if(value == null || value.trim().length < 1) {
			return false;
		}
	});
	$("#removeForm").submit();
});

// customForm안에 Hidden태그 값 초기화
function hiddenClear() {
    let hiddens = customForm.find("input[type='hidden']");
    hiddens.each(function(idx, element){
    	let name = $(this).attr("name");
    	if(name != "groupCode" && name != "groupName") {
    		$(this).val("");
    	}
    });
}

// modal클릭 시 내부 데이터 초기화
function modalClear() {
    $('#setting-status .color-hex').text('');
    $('#setting-status .common-colorinput').val('#ffffff');
    $('#setting-status .common-text').val('');
    $('#setting-status .custom-icon i').css("color","#000000");
    $('#setting-status .custom-text').css("color","#000000");
    $('#setting-status .custom-iconbox').css("background","#ffffff");
    $("#setting-status #modifyBtnInModal").hide();
    $("#setting-status #insertBtnInModal").show();
}

// Modal내부에 error메시지 초기화
function errorsClear() {
	let errors = $("#setting-status span.errors");
	errors.each(function(idx, element){
		$(this).text("");
	});
}





