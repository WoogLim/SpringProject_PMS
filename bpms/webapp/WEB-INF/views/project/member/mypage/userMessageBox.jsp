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
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
<c:set value="${principal.realMember }" var="authMember"/>

<c:set value="${pagination.pagingVO.dataList }" var="dataList"/>
<c:set value="${pagination.pagingVO.searchDetail }" var="searchDetail"/> 
<div class="messagelist-container">
    <div class="messagelist-header">
        <h2 class="messgaeheader-title">
            메시지 수신함
        </h2>
        <span class="message-guide">
            <div class="confirm-guide"></div>
            <span>메시지 확인함</span>
            <div class="notconfirm-guide"></div>
            <span>확인하지 않음</span>
        </span>
    </div>

    <div class="messagelist-box">
        <div class="message-checkfilter no-drag">
            <div class="messagefilter-title">
                메시지 선택 필터
            </div>
			
			<%-- 선택이 아니라 보이기 인가? --%>
			<%-- 모든 메시지 선택 (스크립트 별도로 처리 안함) --%>
			<c:set value="${searchDetail.pushOpen }" var="pushOpen"/>
			
            <input type="radio" name="messagecheck" id="messageallcheck" value="" 
            	${(pushOpen eq null or pushOpen eq "") ? 'checked' : '' }>
            <label for="messageallcheck">모든 메시지</label>
			
			<%-- 확인하지 않은 메시지 선택 (스크립트 별도로 처리 안함) --%>
            <input type="radio" name="messagecheck" id="unconfirmedmessagecheck" value="N"
            	${pushOpen eq "N" ? 'checked' : '' }>
            <label for="unconfirmedmessagecheck">확인하지 않은 메시지</label>

			<%-- 확인한 메시지 선택 (스크립트 별도로 처리 안함) --%>
            <input type="radio" name="messagecheck" id="confirmedmessagecheck" value="Y"
            	${pushOpen eq "Y" ? 'checked' : '' }>
            <label for="confirmedmessagecheck">확인한 메시지</label>

            <div class="messagebtn-group">
                <button class="checkmessage-removebtn" id="deleteMsgBtn">
                    선택 메시지 삭제
                </button>
            </div>
        </div>
    </div>

    <div class="messageitemlist-box">
		<div class="messagebtn-group">
		    <button class="checkmessage-removebtn" id="selectAllBtn">
		        모두선택
		    </button>
		</div>
		<c:if test="${not empty dataList }">
			<c:forEach items="${dataList }" var="msgVO">
				<c:set value="${msgVO.memberVO }" var="memberVO"/>
				
				<%-- messageitem-box가 메시지 한 세트 --%>
		        <div class="messageitem-box">
		            <div class="messageitem-simple">
		                <div class="messageitem-check">
		                    <input type="checkbox">
		                </div>
		                <button type="button" class="messagesimple-info">
		                	<c:set value="${msgVO.pushOpen == 'Y' ? true : false }" var="isConfirmed"/>
							<c:set value="${isConfirmed ? 'messageitem-confirmed' : 'messageitem-unconfirmed' }" var="divClass"/>
		                    <div class="messagesimple-item ${divClass }" data-read="${isConfirmed }" data-pushno="${msgVO.pushNo }">
		                        <div class="message-sender">
		                            <div class="sender-profileimg">
		                                <div class="avatar-sm">
		                                	<c:if test="${empty memberVO.memImg }">
			                                    <img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" alt="..."
			                                        class="avatar-img rounded-circle">
		                                    </c:if>
		                                	<c:if test="${not empty memberVO.memImg }">
			                                    <img src="${pageContext.request.contextPath }/assets/img/profile/${memberVO.memImg }" alt="..."
			                                        class="avatar-img rounded-circle">
		                                    </c:if>
		                                </div>
		                            </div>
		                            <div class="sender-info">
		                                <span class="sender-id">${msgVO.pushSender }</span>
		                                <span class="send-date">${msgVO.createDate }</span>
		                            </div>
		                        </div>
		
		                        <div class="message-simplecontent">
		                            <span>${msgVO.pushContent }</span>
		                        </div>
		                    </div>
		                </button>
		            </div>
		            <%-- 해당 메시지 상세보기 --%>
		            <div class="messageitem-detail">
		                <div class="messageitem-header">
		                    <span class="messageitem-title">${msgVO.pushTitle }</span>
		                    <span class="messageitem-date">${msgVO.createDate }</span>
		                </div>
		                <%-- [상세보기] 메시지 내용 --%>
		                <div class="messageitem-content">
		                    ${msgVO.pushContent }
		                </div>
		                <%-- [상세보기] 상세보기 종료 버튼 --%>
		                <div class="messagebtn-group">
		                    <button class="message-confirmbtn">확인</button>
		                </div>
		            </div>
		        </div>
			
			</c:forEach>
		</c:if>
		
    </div>
</div>
<ui:pagination paginationInfo="${pagination }" type="bsNumber" jsFunction="pagingFunction"/>

<form id="messageForm">
	<input type="hidden" name="pushOpen" value="${searchDetail.pushOpen }">
	<input type="hidden" name="currentPage" value="${pagingVO.currentPage }">
</form>

<form id="messageDeleteForm" action="${pageContext.request.contextPath }/pushMsg/delete.do">
	<input type="hidden" name="memId" value="${authMember.memId }">
</form>

<script type="text/javascript">   
let messageForm = $("#messageForm");
let messageDeleteForm = $("#messageDeleteForm");

// 페이징 처리
function pagingFunction(event) {
	event.preventDefault();
	let target = event.target;
	let page = target.dataset.page;
	messageForm.find("input[name='currentPage']").val(page);
	messageForm.submit();
	return false;
}

// hiddenTag 생성
function hiddenTagTemplate(options) {
	return $("<input>").attr("type", "hidden").attr("name", options.name).val(options.val);
}

$(function() {
	$('.page-inner').addClass('my-inner');
    
	<%-- 129 ~ 141 네비게이션바 유지 스크립트
	tabhistory 선택했던 네비게이션 탭
	before 이전에 선택되어있던 네비게이션 탭
	--%>

    <%-- 메시지 상세보기 --%>
    $('.messagesimple-info').click(function(){
		let dataDiv = $(this).children("div.messagesimple-item");
		let confirmed = dataDiv.data("read");
		if(!confirmed) {
			// pushMessage확인상태 변경
			let pushNo = dataDiv.data("pushno");
			let data = {"pushNo": pushNo, "pushOpen": "Y"}
			$.ajax({
				url: $.getContextPath() + "/pushMsg/update.do"
				, dataType: "json"
				, data: data
			}).done(function(resp){
				let count = resp.count;
				if(resp.message.text == "OK") {
					dataDiv.removeClass("messageitem-unconfirmed");
					dataDiv.addClass("messageitem-confirmed");
					dataDiv.data("read", true);
					
					if(count > 0){
						console.log("ok");
						$("span.notification").text(count);
					} else {
						$("span.notification").remove();
					}
				}
			}).fail(function(xhr){
				console.log(xhr.status);
			});
		}

		// 상세보기 Animation
    	$(this).parent().siblings('.messageitem-detail').stop().animate({
            height: 'toggle'
        }, 100);
    })
	
    <%-- 메시지 확인 버튼 --%>
    $('.message-confirmbtn').click(function(){
        $(this).parent().parent().hide()
    })
    
    <%-- 필터링 라디오 버튼 --%>
    $("div.message-checkfilter").on("click", "input:radio", function() {
    	let pushOpen = $(this).val();
    	messageForm.find("input[name='pushOpen']").val(pushOpen);
    	messageForm.find("input[name='currentPage']").val(1);
    	messageForm.submit();
    })
    
    let selectFlag = false;
    $("#selectAllBtn").on("click", function() {
    	let messageDiv = $("div.messageitem-box");
    	if(selectFlag) {
	    	messageDiv.find("input:checkbox").prop("checked", false);
	    	selectFlag = false;
    	} else {
    		messageDiv.find("input:checkbox").prop("checked", true);
    		selectFlag = true;
    	}
    });
    
    // 선택 메시지 삭제
    $("#deleteMsgBtn").on("click", function() {
    	let messageList = $("div.messageitemlist-box");
		let chkBoxs = messageList.find("input:checked");

		if(chkBoxs.length > 0) {
			let hiddens = [];
			chkBoxs.each(function(idx, element){
				let dataDiv = $(this).parent().siblings("button.messagesimple-info").children("div.messagesimple-item");
				let pushNo = dataDiv.data("pushno");
				let name = "pushMsgList[" + idx + "].pushNo";
				let hiddenTag = hiddenTagTemplate({"name": name, "val":pushNo});
				hiddens.push(hiddenTag);
			});
			let pushOpen = $("div.message-checkfilter").find("input:checked").val();
			let searchDetail = hiddenTagTemplate({"name": "pushOpen", "val": pushOpen});
			hiddens.push(searchDetail);
			
			messageDeleteForm.append(hiddens);
			messageDeleteForm.submit();
		}
    });
})


</script>

















