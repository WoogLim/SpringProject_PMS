<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-- modal()함수 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
 -->
<!-- modal / bootstrap -->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  -->
<!-- socket -->

<script	src="${pageContext.request.contextPath }/assets/js/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style>
/* .chatcontent {
	overflow: auto;
	height: 100%;
	position: relative;
}   */
.chat-containerK {
	/* overflow: hidden; */
	width: 100%;
	/* max-width : 200px; */
}

.chatcontent {
	height: 700px;
	width: 100%;
	/* width:300px; */
	overflow-y: scroll;
}

.chat-fix {
	position: fixed;
	bottom: 0;
	width: 100%;
}

#alertK {
	display: none;
}

#msgi {
	resize: none;
}

.myChat {
	background-color: #E0B1D0;
	display: inline-block;
	/* position: absolute;*/
	/* right: 0px; */
	/* float: right; */
	max-width: 200px;
	/* width : 100%; */
}

li {
	list-style-type: none;
}

.chatBox {
	display: inline-block;
}

.chatBox dateK {
	vertical-align: text-bottom;
}

.me {
	text-align: right;
	/* text-align:center; */
}

.otherChat {
	max-width: 200px;
}
</style>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
<div id="chat-containerK" class="border border-secondary">
	<div class="content chatcontent " data-room-no="chat-00001">
		<div id="list-guestbook" class="">
			<c:forEach items="${chatList}" var="chat">
				<!-- 내 채팅일 경우 -->
				<c:if test="${authMember.memId eq chat.msgWriter}">
					<li data-no="${chat.msgId}" class="me pr-2"><strong class="">${authMember.memId}</strong>
						<div class="me ">
							<strong style="display: inline;" class="align-self-end">${chat.createDate }</strong>
								<p class="myChat text-left p-2">${chat.msgContent }</p>
						</div>
					</li>
				</c:if>
				<!-- 다른사람의 채팅일 경우 -->
				<c:if test="${authMember.memId ne chat.msgWriter}">
					<li data-no="${chat.msgId}" class="pl-2"><strong>${chat.msgWriter}</strong>
						<div class="row ml-0">
							<p class="otherChat bg-light p-2">${chat.msgContent }</p>
							<strong class="align-self-center">${chat.createDate }</strong>
						</div>
					</li>
				</c:if>
			</c:forEach>
		</div>

	</div>
	<div class="chat-fixK">
		<div id="alertK" onclick="moveDown();" class="alert alert-success"
			role="alert">
			<strong></strong>
		</div>
		<div class="fix_btn row">
			<textarea name="msg" id="msgi" rows="2" class="form-control col-sm-8"></textarea>
			<button type="button" class="send col-sm-4 btn btn-secondary">보내기</button>
		</div>
	</div>

</div>
</security:authorize>
<script>
	var client;
	//채팅 저장
	function insertChat() {
		$.ajax({
			url : "${pageContext.request.contextPath}/chat/insertChat.do",
			type : "POST",
			data : {
				msgWriter : "${authMember.memId}",
				chatRoomId : "chat-00001",
				msgContent : $("#msgi").val()
			},
			dataType : "json",
			success : function(result) {
				console.log("접속 종료 시 채팅 insert 성공");
			},
			error : function(xhr, status, err) {
				console.log("처리실패!");
				console.log(xhr);
				console.log(status);
				console.log(err);
			}
		});
	}
	//생성된 메시지로 가기//맨 아래로 가기
	function moveDown() {
		$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
		$('#alertK').css('display', 'none');
	}
	$(document).ready(function() {
		//시작할때 스크롤 내리기
		$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
		
		var isEnd = false;
		var isScrolled = false;
		var fetchList = function() {
			if (isEnd == true) {
				return;
			}

			// 채팅 리스트를 가져올 때 시작 번호
			// renderList 함수에서 html 코드의 <li> 태그에 data-no 속성으로
			// data- 속성의 값을 가져오기 위해 data() 함수 사용
			var endNo = $("#list-guestbook li").first().data("no");
			console.log("endNo : " + endNo);
			$.ajax({
				url : "${pageContext.request.contextPath}/chat/chatList.do?endNo="+ endNo + "&roomNo=chat-00001",
				type : "GET",
				dataType : "json",
				success : function(result) {
					// 컨트롤러에서 가져온 방명록 리스트는 result.data에 담김
					var length = result.size;
					if (length < 10) {
						isEnd = true;
					}
					$.each(result, function(index, vo) {
						var html = renderList(vo, 0);
						$("#list-guestbook").prepend(html);
					})
					var position = $('[data-no=' + endNo + ']').prev().offset();//위치값
					console.log(position);
					document.querySelector('.chatcontent').scrollTo({
						top : position.top,
						behavior : 'auto'
					});
					isScrolled = false;
				},
				error : function(xhr, status, err) {
					console.log("처리실패!");
					console.log(xhr);
					console.log(status);
					console.log(err);
				}
			});
		}

		var renderList = function(vo, endNo) {
			alert("ㅎㅇ");
			var html = "";
			if (endNo == 0){endNo = vo.msgId};

			if (vo.msgWriter == "${authMember.memId}") {
				var	content = "<p class='myChat text-left p-2'>" + vo.msgContent + "</p>";

				html = "<li class='me pr-2' data-no='"+ endNo +"'>"
						+ "<strong>"
						+ vo.msgWriter
						+ "</strong>"
						+ "<div class='me'>"
						+ "<strong style='display : inline;' class='align-self-end'>"
						+ vo.createDate
						+ "</strong>"
						+ content
						+ "</div>" + "</li>";
			}
			//남이 보낸 채팅일 경우
			else {
				var content = "<p class='otherChat bg-light p-2'>"+ vo.msgContent + "</p>";
			}
				html = "<li class='pl-2' data-no='"+ vo.msgId +"'>"
						+ "<strong>"
						+ vo.msgWriter
						+ "</strong>"
						+ "	<div class='row ml-0'>"
						+ content
						+ "<strong class='align-self-center'>"
						+ vo.createDate
						+ "</strong>"
						+ "</div>"
						+ "</li>";
			return html;

		}
		
		//무한 스크롤
		$(".chatcontent").scroll(function() {
			var $window = $(this);
			var scrollTop = $window.scrollTop();
			var windowHeight = $window.height();
			var documentHeight = $(document).height();

			if (scrollTop < 1 && isScrolled == false) {
				isScrolled = true;
				fetchList();
			}
		})
	});
		////////////////////socket
		//새로운 메시지 알림
// 		function newAlerts(content, endNo) {
// 			$('#alertK').css('display', 'block');
// 			$('#alertK').html(
// 					"<strong>" + content.memberId
// 							+ "</strong>님이 메시지를 보냈습니다.");
// 		}

		$(function() {
			var chatBox = $('.box');
			var messageInput = $('textarea[name="msg"]');
			var roomNo = "chat-00001";
			var sock = new SockJS("${pageContext.request.contextPath}/endpoint");
			var client = Stomp.over(sock);
			function sendmsg() {
				var message = messageInput.val();
				if (message == "") {
					return false;
				}
				//insertChat();
				client.send('/app/hello/' + roomNo,	{} ,JSON.stringify({
								msgContent : message, 
								msgWriter : "${authMember.memId}",
								chatRoomId : roomNo
							}));
				messageInput.val('');
			}
			client.connect({}, function() {
				client.subscribe('/subscribe/chat/' + roomNo,
					function(chat) {
						//받은 데이터
						alert("뭐시발");
						var content = JSON.parse(chat.body);
						$("#list-guestbook").append(content);
						console.log("ㅎㅎ");
						var endNo = content.msgId;
						/*var endNo = $("#list-guestbook li").last().data("no");
						if(isNaN(endNo))
							endNo = 1;
						else
							endNo = endNo+1;
						 */
						var html = renderList(content, endNo);
						$("#list-guestbook").append(html);
// 						newAlerts(content, endNo);
					});
			});
			// 1. send 버튼 클릭 시 함수 -> 성공
			$('.send').click(function() {
// 				console.log("send 버튼 클릭");
				sendmsg();
			});

			//채팅창 떠날시에
			function disconnect() {
				if (client != null) {
					client.disconnect();
					console.log("disconnect 함수")
				}
			}
			window.onbeforeunload = function(e) {
				alert("떠날떄");
				insertChat();
				disconnect();
			}

			function closeConnection() {
				alert("closeConnection");
				sock.close();
			}

// 			function viewList() {
// 				alert('viewList');
// 				var url = "/chat/chatList?page=" + page
// 						+ "&perPageNum=" + perPageNum;
// 				location.replace(url);
// 			}

		});

	//여기 위에까지가 방 입장하자마자
</script>