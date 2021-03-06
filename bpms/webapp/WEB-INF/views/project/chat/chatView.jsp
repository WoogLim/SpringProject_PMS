<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<div class="quick-sidebar chatactive-item">
    <a href="#" class="close-quick-sidebar">
        <i class="flaticon-cross"></i>
    </a>
    <div class="quick-sidebar-wrapper">
        <ul class="nav nav-tabs nav-line nav-color-secondary" role="tablist">
            <li class="nav-item"> 
            	<a class="nav-link active show" data-toggle="tab" href="#messages" role="tab"
                    aria-selected="true">프로젝트 채팅 메신저</a> </li>
        </ul>
        <div class="tab-content mt-3 ">
            <div class="tab-chat tab-pane fade show active" id="messages" role="tabpanel">
                <div class="messages-contact">
                    <div class="quick-wrapper">
                        <div class="quick-scroll scrollbar-outer">
                            <div class="chatroom-container">
                            </div>
							
                            <ul class="row chatroom-list here">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<li class="user-chat chat-me d-none">
    <div class="charuser-info">
        <span class="chatuser-name">
        </span>
        <span class="chatuser-date">
        </span>
    </div>
    <div class="chatuser-contents">
        <span class="contents-text"></span>
    </div>
</li>

<li class="user-chat chat-others d-none">
    <div class="charuser-info">
        <span class="chatuser-name">
        </span>
        <span class="chatuser-date">
        </span>
    </div>
    <div class="chatuser-contents">
        <span class="contents-text"></span>
    </div>
</li>
</security:authorize>
<script>
var inputMemId = "${authMember.memId}";

var toShowRoomList = {memId : inputMemId};
	
let retire = $(".retire");

let here = $(".chatroom-list");

function limgunlovessunyeopLee(input){
	var msg = $(input).parent().siblings('.chat-inputmessage').children('.chat-message').val();
	insertChat();
	$(".chat-message").val("");
// 	console.log(msg);
	socket.send(msg);
	
}

function insertChat() {
	var writer = "${authMember.memName}";
	
	var sendData = {
			msgWriter : writer,
			chatRoomId : localStorage.getItem("chatRoomId"),
			msgContent : $(".chat-message").val(),
			proId : localStorage.getItem("proId")
		}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/chat/chatInsert.do",
		type : "POST",
		data : JSON.stringify(sendData),
		dataType : "json",
		contentType : "application/json",
		success : function(result) {
			console.log("채팅 insert 성공");
		},
		error : function(xhr, status, err) {
			console.log("처리실패!");
			console.log(xhr);
			console.log(status);
			console.log(err);
		}
	});
}
	let socket;

function initSocket(url) {
	socket = new SockJS(url);
	
	var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var hour = date.getHours();
    var minutes = date.getMinutes()
    console.log(year + month + day);
    
	socket.onmessage = function(evt) {
	 	
		var beforeSplit = evt.data;
		var afterSplit = beforeSplit.toString().split(":");	
		console.log(afterSplit);
		if('${authMember.memName}'!= afterSplit[0]){
			$(".atThis").append(/* evt.data + "<br/>"); */
				$("<li>").addClass("user-chat chat-others").append(
					$("<div>").addClass("charuser-info").append(
						$("<span>").addClass("chatuser-name").text(afterSplit[0])
						,$("<span>").addClass("chatuser-date").text(year+"-"+month+"-"+day+" "+hour+":"+minutes)
					)
					,$("<div>").addClass("chatuser-contents").append(
						$("<span>").addClass("contents-text").text(afterSplit[1])		
					)
				)	
			)
		}else{
			$(".atThis").append(/* evt.data + "<br/>"); */
				$("<li>").addClass("user-chat chat-me").append(
					$("<div>").addClass("charuser-info").append(
						$("<span>").addClass("chatuser-name").text(afterSplit[0])
						,$("<span>").addClass("chatuser-date").text(year+"-"+month+"-"+day+" "+hour+":"+minutes)
					)
					,$("<div>").addClass("chatuser-contents").append(
						$("<span>").addClass("contents-text").text(afterSplit[1])		
					)
				)	
			)
		}
		$(".chat-content").scrollTop($(".chat-content")[0].scrollHeight);
	};
	
	socket.onclose = function(evt) {
// 		$(".atThis").append("연결 종료");	
		
	}
	
// 	$("#sendBtn").stop().on("click", function() {
// 		var msg = $(".chat-message").val();
// 		insertChat();
// 		$(".chat-message").val("");
// 		socket.send(msg);
// 		console.log("한번");
// 	});
	
	 // 메시지 입력하고 엔터를 누른 경우
   
}

$("#messageDropdown").on("click", function(){
	$.ajax({
		url : "${pageContext.request.contextPath}/chat/chatList.do",
		type : "GET",
		data : toShowRoomList,
		dataType : "json",
		contentType : "application/json",
		success : function(resp) {
			let pushTag = [];
// 			console.log(resp.chatRoomList);
			let chatRoomList = resp.chatRoomList;
			if(chatRoomList.length > 0){
				retire.hide();
				$(chatRoomList).each(function(idx, chatRoom){
					pushTag.push(
		  				$("<li>").addClass("chatroom-item col-md-12").append(
		  					$("<button>").addClass("chatroom-card").append(
			  					$("<div>").addClass("chatroomlist-container").append(
			  						$("<div>").addClass("chatroom-header").append(
			  							$("<span>").addClass("chat-icon").append(
				  							$("<i>").addClass("fas fa-users")
				  							,$("<span>").addClass("dot-icon")
											,$("<span>").addClass("icon-name").text("TALK")		  									
			  							)
			  							,$("<span>").addClass("chatproject-title").text(chatRoom.chatTitle)
			  						)
			  						,$("<div>").addClass("chatproject-content").append(
		  								$("<span>").addClass("lately-chat").text()
		  								,$("<span style='margin-right : 10px'>").addClass("latelychat-date").append(
	  										$("<i>").addClass("fas fa-eye").text(chatRoom.memCount))
		  								,$("<input type='hidden'>").text(chatRoom.chatRoomId)
		  								,$("<input type='hidden'>").text(chatRoom.proId)
			  						)
			  					)
		  					)
		  				)
	  				  );
				});
			}else{
				retire.hide();
			}
			here.html(pushTag);

		},
		error : function(xhr, status, err) {
			console.log("처리실패!");
			console.log(xhr);
			console.log(status);
			console.log(err);
		}
	});
})

    $(document).ready(function(){
        $('.chat-list').children().remove()
		var memId = "${authMember.memId}";			//사용자 아이디를 파라미터로 받는다
		
    	$(".here").on("click", "button", function(){
    		let templateChat = chatTemplate();
    		
    		$(".here").hide();
    		$('.chatroom-container').prepend($(templateChat));
    		$('.chatroom-container').show();
    		let inputMemId = "${authMember.memId}";
    		let chooseRoom = $(this).find("[type='hidden']").eq(0).text();
    		localStorage.setItem("chatRoomId", chooseRoom);
    		let whichProj = $(this).find("[type='hidden']").eq(1).text();
    		localStorage.setItem("proId", whichProj);
    		
    		var toEnterRoom = {
   				memId : inputMemId,
   				chatRoomId : chooseRoom,
   				proId : whichProj
    		}
    		
    		$.ajax({
    			url : "${pageContext.request.contextPath}/chat/chatView.do",
    			type : "GET",
    			data : toEnterRoom,
    			dataType : "json",
    			contentType : "application/json",
    			success : function(resp) {
    				var atThis = $(".atThis");
    				liTag = []
    				let chatList = resp.chatList.messageList;
    				if(chatList.length > 0){
    					$(chatList).each(function(idx, chat){
    						if('${authMember.memId}'!=chat.msgWriter){
    							liTag.push(
    								$("<li>").addClass("user-chat chat-others").append(
    									$("<div>").addClass("charuser-info").append(
    										$("<span>").addClass("chatuser-name").text(chat.msgWriter)
    										,$("<span>").addClass("chatuser-date").text(chat.createDate)
    									)
    									,$("<div>").addClass("chatuser-contents").append(
    										$("<span>").addClass("contents-text").text(chat.msgContent)		
    									)
    								)		
    							)
    						}else{
    							liTag.push(
       								$("<li>").addClass("user-chat chat-me").append(
       									$("<div>").addClass("charuser-info").append(
       										$("<span>").addClass("chatuser-name").text(chat.msgWriter)
       										,$("<span>").addClass("chatuser-date").text(chat.createDate)
       									)
       									,$("<div>").addClass("chatuser-contents").append(
       										$("<span>").addClass("contents-text").text(chat.msgContent)		
       									)
       								)		
       							)
    						}
    						atThis.html(liTag)
    					});
    				}
    				initSocket("${cPath}/ws/chat?memId=" + memId 
    		   				+ "&proId=" 
    		   				+ localStorage.getItem("proId") 
    		   				+ "&chatRoomId=" 
    		   				+ localStorage.getItem("chatRoomId") );
    				$(".chat-content").scrollTop($(".chat-content")[0].scrollHeight);
    				
//     				$(".chat-message").keyup(function(event){
// 						if(event.keyCode === 13){
// 							alert("enter");
// 							insertChat();
// 							initSocket();
// 						}
//     				})
    			},		
    			error : function(xhr, status, err) {
    				console.log("처리실패!");
    				console.log(xhr);
    			}
    		});
    	})
    		
    	/* function moveDown() {
			$(".chat-content").scrollTop($(".chat-content")[0].scrollHeight);
		} */
    	
//         $('.chat-btn').click(function(){
//             console.log('눌림');
//         })

//         $('.chatroom-exit').click(function(){
//             $('.chatroom-container').hide();
//             $('.chatroom-list').show();
//             $('.chatroom-container').children().remove();
//         })
    })
    
    function chatTemplate(){
		let chatcontainer = $('<div class="chatnote-list"> <div class="chat-header"> <span></span> <button type="button" class="chatroom-exit" onclick="hideChat();"> <i class="fas fa-times"></i> </button> </div> <div class="chat-content"> <ul class="chat-list atThis"> </ul> </div> <div class="chat-input"> <form class="chatinput-container" action=""> <div class="chat-inputmessage"> <input type="text" class="chat-message"></input> </div> <div class="chat-submit"> <button class="chat-submitbtn" type="button" id="sendBtn" onclick="limgunlovessunyeopLee(this)">전송</button> </div> </form> </div> </div>');
	
		return chatcontainer
	}
	
	function hideChat(){
        $('.chatroom-container').hide();
        $('.chatroom-list').show();
        $('.chatroom-container').children().remove();
        console.log("연결 끊김")
        socket.close();
	}
</script>