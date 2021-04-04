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
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />

<div class="mysetting-container">
    <div class="mysetting-header">
        <h2 class="mysetting-title">
            프로필 및 계정 정보
        </h2>
    </div>

    <div class="mysetting-section">
        <h2 class="mysection-title">
            프로필 이미지 변경
        </h2>
    </div>

    <div class="myprofileinfo-container">
        <div class="profileimg-card">
            <div class="image-preview">
                <div class="image-upload">
					<c:if test="${authMember.memImg eq null }">
	                    <img src="${pageContext.request.contextPath }/assets/img/profile/defaultProfile.png" class="image-upload-box" alt="..." class="avatar-img rounded-circle">
                	</c:if>
                	<c:if test="${not (authMember.memImg eq null) }">
	                    <img src="${pageContext.request.contextPath }/assets/img/profile/${authMember.memImg }" class="image-upload-box" alt="..." class="avatar-img rounded-circle">
                	</c:if>
					<form action="" autocomplete="off" class="imageupdate-form">
                    	<input type="file" name="memImg" class="file-upload-input" onchange="updateImage(this);">
                    </form>
                </div>
                <span class="profileuser-name">
                    	${memberVO.memName }
                </span>
            </div>
            
            <div class="userprofile-info">
                <span class="userprofile-email"><i class="fas fa-envelope"></i>${memberVO.memMail }</span>
            </div>
        </div>
    </div>
    
    <div class="mysetting-section">
        <h2 class="mysection-title">
            비밀번호 변경
        </h2>
    </div>

    <div class="myprofileinfo-container">
        <div class="passchange-card">
            <form action="" class="passcard-inner">
                <span class="passinput-checker">현재 비밀번호</span>
                <input type="password" class="currentpass-input" id="mem-currentPass">
                <span class="passchange-error" id="currentpass-error" data-msgtype=""></span>

                <span class="passinput-checker passinput-change">새 비밀번호</span>
                <input type="text" class="changepass-input" id="mem-newPass">
                <span class="passchange-error" id="newpass-error" data-msgtype=""></span>

                <button type="button" class="passchange-submit">변경 내용 저장</button>
            </form>
        </div>
    </div>

</div>    

</security:authorize>
<script type="text/javascript">   
$(function(){
    
	$('.page-inner').addClass('my-inner');
    
	<%-- 129 ~ 141 네비게이션바 유지 스크립트
	tabhistory 선택했던 네비게이션 탭
	before 이전에 선택되어있던 네비게이션 탭
	--%>
	
    String.prototype.IsNullOrEmpty = function () {
    var arg = arguments[0] === undefined ? this.toString() : arguments[0];
    	if (arg === undefined || arg === null || arg === "") { return true; }
	    else { 
	        if (typeof (arg) != "string") { throw "Property or Arguments was not 'String' Types"; }
	        return false; 
	    }
	};
    
    $('.passchange-submit').click(function(){
    	
    	let currentPass = $('#mem-currentPass').val();
    	let newPass = $('#mem-newPass').val();
        let currentPassMessage = document.getElementById('currentpass-error');
        let newPassMessage = document.getElementById('newpass-error');
        let setCheck;
    	
    	if(currentPass.IsNullOrEmpty()){
			currentPassMessage.dataset.msgtype = 'error';
			$(currentPassMessage).show().text("현재 비밀번호를 입력해주세요.");
			setCheck = false;
			return;
    	}else{
    		$.ajax({
    			url: '${pageContext.request.contextPath }/member/passCheck',
    			type: "POST",
    			async:false,
    			data: {"pwd" : currentPass},
    			dataType: "text",
    			success: function(result){
    				if(result.trim() == "OK"){
    					currentPassMessage.dataset.msgtype = 'success';
    					$(currentPassMessage).show().text("본인 확인에 성공했습니다.");
    					setCheck = true;
    				}else{
    					currentPassMessage.dataset.msgtype = 'error';
    					$(currentPassMessage).show().text("본인 확인에 실패했습니다.");
    					swal("에러!", "본인 확인에 실패했습니다.", "error")
    					setCheck = false;
    				}
    			},
    			error:function(msg){
    				console.log(msg);
    			}
    		})
    	}
    	
    	if(!setCheck){
    		return;
    	}
    	
    	if(newPass.IsNullOrEmpty()){
    		newPassMessage.dataset.msgtype = 'error';
    		$(newPassMessage).show().text("새 비밀번호를 입력해주세요.");
			swal("에러!", "새 비밀번호를 입력해주세요.", "error")
			setCheck = false;
			return;
    	}else{
    		if(ValidationPass(newPass.trim())){
    		$.ajax({
    			url: '${pageContext.request.contextPath }/member/setPassCheck',
    			type: "POST",
    			async:false,
    			data: {"newPwd": newPass},
    			dataType: "text",
    			success: function(result){
    				if(result.trim() != "OK"){
    					newPassMessage.dataset.msgtype = 'error';
    					$(newPassMessage).show().text("비밀번호를 다시 입력해주세요.");
    					swal("에러!", "현재 비밀번호와 다른 비밀번호를 입력해주세요.", "error")
    					setCheck = false;
    				}else{
    					setCheck = true;
    				}
    			},
    			error:function(msg){
    				console.log(msg);
    			}
    		})
    		}else{
        		newPassMessage.dataset.msgtype = 'error';
        		$(newPassMessage).show().text("특수문자 포함 영문 5~12글자 이내 입력");
				swal("에러!", "비밀번호 형식이 맞지않습니다.", "error")
				setCheck = false;
    		}
    	}
    	
    	if(!setCheck){
    		return;
    	}
    	
    	if(!currentPass.IsNullOrEmpty() && !newPass.IsNullOrEmpty() && ValidationPass(newPass.trim()) && currentPass.trim() != newPass.trim() && setCheck){
    		$.ajax({
    			url: '${pageContext.request.contextPath }/member/updatePass',
    			type: "POST",
    			aysnc: false,
    			data: {"memPass": newPass},
    			dataType: "text",
    			success: function(result){
    				if(result.trim() == "OK"){
    					$(newPassMessage).hide();
    					swal({
    						icon: "success",
				    	    title: "비밀번호 변경 완료",
				    	    text: "다시 로그인이 필요합니다.",
				    	    type: "success"
				    	}).then(function() {
				    		location.href = '${pageContext.request.contextPath}/login/logout.do';
				    	});
    				}else{
    					swal("오류!", "서버 오류가 발생했습니다. 잠시만 기다려주세요.", "error")
    				}
    			},
    			error:function(msg){
    				console.log(msg);
    			}
    		})
    	}
    })
})

function updateImage(input){
	let file = input.files[0];
	
	let RegExp = /(.*?)\/(jpg|jpeg|png|bmp)$/;
	
	if(!file.type.match(RegExp)){
		swal("에러!", "이미지 파일이 아닙니다.", "error")
		return;
	}
	
    updatememberform(file);
    
}

function updatememberform(file){
	console.log(file);
	
	let memform = new FormData();
	memform.append("memImg", file);
    
    $.ajax({
    	url: '${pageContext.request.contextPath}/member/updateImg',
    	type: "POST",
    	async: false,
        processData: false,
        contentType: false,
    	data: memform,
    	dataType:"text",
    	success: function(result){
			if(result.trim() == "OK"){
				swal({
					icon: "success",
		    	    title: "프로필 이미지 변경 완료",
		    	    type: "success"
		    	}).then(function() {
		    		location.reload();
		    	});
			}else{
				swal("오류!", "서버 오류가 발생했습니다. 다시 시도해주세요.", "error")
			}
    	},
    	error:function(msg){
    		console.log(msg);
    		console.log("에러");
    	}
    })
}
</script>