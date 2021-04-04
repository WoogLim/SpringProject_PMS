<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<!-- CSS Files -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/atlantis.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/font.css">
    <script src="${pageContext.request.contextPath }/assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
        WebFont.load({
            google: {
                "families": ["Lato:300,400,700,900"]
            },
            custom: {
                "families": ["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons"
                ],
                urls: ['../assets/css/fonts.min.css']
            },
            active: function () {
                sessionStorage.fonts = true;
            }
        });
    </script>
</head>
<body class="login">
	<!-- left Side -->
	<div class="wrapper wrapper-login wrapper-login-full p-0">
		<div class="login-aside w-50 d-flex flex-column align-items-center justify-content-center text-center bg-secondary-gradient bpmslogin">
            <img src="${pageContext.request.contextPath }/assets/img/index/Website Design.svg" alt="">
		</div>
	<!-- login UI -->
		<div class="login-aside w-50 d-flex align-items-center justify-content-center bg-white">
			
			<security:authorize access="isAnonymous()">
			<div class="container container-login container-transparent animated fadeIn">
				<h3 class="text-center">BPMS 로그인</h3>
				<div class="login-form">
				
					<!-- loginForm -->
					<form id="loginForm" action="${pageContext.request.contextPath }/login/loginProcess.do" method="post">
						<div class="form-group">
							<label for="username" class="placeholder"><b>아이디</b></label>
							<!-- required pattern="^(?=.*[0-9]+)(?=.*[a-z]+).{5,13}$" -->
							<input type="text" class="form-control" name="memId" value="${cookie.idCookie.value }">
						</div>
						<div class="form-group">
							<label for="password" class="placeholder"><b>비밀번호</b></label>
							<div class="position-relative bpms-pass">
								<!-- required pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,13}$" -->
								<input id="password" name="memPass" type="password" class="form-control scm-pass">
	                            <button type="button" class="scmpass-eyesbtn pass-hide">
	                                <i class="far fa-eye-slash"></i>
	                            </button>
	                            <button type="button" class="scmpass-eyesbtn pass-show">
	                                <i class="far fa-eye"></i>
	                            </button>
							</div>
						<div class="form-group form-action-d-flex mb-3">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="rememberme" name="rememberme" ${not empty cookie.idCookie ? "checked" : "" }>
								<label class="custom-control-label m-0" for="rememberme">로그인 저장</label>
							</div>
							<span id="loginBtn" class="btn btn-secondary fw-bold">로그인</span>
						</div>
						</div>
					</form>
					<!-- login Form -->
					<div class="login-account">
						<span class="msg">회원이 아니신가요?</span>
						<a href="${pageContext.request.contextPath }/login/signUp.do" >회원가입</a>
					</div>
				</div>
			</div>
			</security:authorize>
			<security:authorize access="isAuthenticated()">
				<security:authentication property="principal" var="principal"/>
				<c:set var="authMember" value="${principal.realMember }" />
				<ul class="row">
					<li class="col">
						<h1>${authMember.memName }님!</h1>
						<h2>BPMS에 오신걸 환영합니다!!!</h2>
						<span id="logoutBtn" class="btn btn-secondary fw-bold">LOG OUT</span>
					</li>
					<li class="col">
						<span id="bpmsBtn" class="btn btn-secondary fw-bold" onclick="goMainPage('${authMember.adminRole}')">START</span>
					</li>
				</ul>
			</security:authorize>
		</div>
	</div>
	
	<!-- jQuery -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
	
	<!-- jquery-validation-1.19.2 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
	
	<!-- 템플릿에 있던 기본 플러그인 -->
	<script src="${pageContext.request.contextPath }/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/core/popper.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/core/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/atlantis.min.js"></script>
	
	<!-- Nofity.js -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/notifyMessage.js"></script>
</body>
<script type="text/javascript">
	
	$('.pass-show').click(function(){
	    $(this).hide();
	    $(this).siblings('.scm-pass').attr("type","text")
	    $('.pass-hide').show();
	})
	
	$('.pass-hide').click(function(){
	    $(this).hide();
	    $(this).siblings('.scm-pass').attr("type","password")
	    $('.pass-show').show();
	})

	console.log(${admin});
	console.log(${user});

	// 로그인 클릭 이벤트
	$("#loginBtn").on("click", function(){
		$("#loginForm").submit();
	});
	
	// 로그아웃 클릭 이벤트
	$("#logoutBtn").on("click", function() {
		window.location.href = "${pageContext.request.contextPath }/login/logout.do";
	})
	
	// bpms 페이지 이동
// 	$("#bpmsBtn").on("click", function() {
// 		window.location.href = "${pageContext.request.contextPath }";
// 	});
	
	// 수정: 2021. 02. 12 신광진
	// 일반회원과 관리자 MainPage를 다르게 하기위해 수정했습니다.
	function goMainPage(adminRole) {
		console.log(adminRole);
		console.log(typeof adminRole);
		if(adminRole == 'N' || adminRole == null || adminRole == "") {
			window.location.href = "${pageContext.request.contextPath}/user/main";
		} else if(adminRole == 'Y') {
			window.location.href = "${pageContext.request.contextPath}/admin/main";
		}
	}
	
	$(function(){
      const validateOptions = {
            onsubmit:true
            ,onfocusout:function(element, event){
               return this.element(element);
            }
            ,errorPlacement: function(error, element) {
               error.appendTo( $(element).parents("div:first") );
              }
            
      }
      
      validateOptions.rules={
         memId : {
            remote : '${pageContext.request.contextPath}/signUp/idCheck.do'
         }
      }
      validateOptions.messages={
         memId : {
            required : 'ID는 필수입력 사항입니다. 숫자, 영문자를 이용하여 5~15글자 이내로 입력해야 합니다.'
            ,remote : '이미 존재하는 아이디입니다.'
         },
         
         memPass : {
            required : '비밀번호는 필수입력 사항입니다. 특수문자를 포함한 영어만 입력할 수 있으며 5~12글자 이내로 입력해야 합니다.'
         },
         
         memName : {
            required : '이름은 필수입력 사항입니다. 특수문자를 제외한 한글과 영어 모두 입력할 수 있으며 2~20글자 이내로 입력해야 합니다.'            
         },
         
         memMail : {
            required : '이메일은 필수입력 사항입니다. abc@defg.hij 형식으로 입력해야 합니다.'
         },
         
         memHp : {
            required : '휴대폰 번호는 필수입력 사항입니다. 01X-XXX(X)-XXXX 형식으로 입력해야 합니다.'
         }
         
      }
      
      let validator = $("#signUpForm").validate(validateOptions);
   });
</script>
</html>
