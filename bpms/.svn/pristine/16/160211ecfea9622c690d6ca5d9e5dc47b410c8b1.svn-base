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
</head>
<body class="login">
   <!-- left Side -->
   <div class="wrapper wrapper-login wrapper-login-full p-0">
      <div class="login-aside w-50 d-flex flex-column align-items-center justify-content-center text-center bg-secondary-gradient">
         <h1 class="title fw-bold text-white mb-3">BPMS</h1>
         <p class="subtitle text-white op-7">Best Project Manager System...</p>
      </div>
     <div class="login-aside w-50 d-flex align-items-center justify-content-center bg-white">
         <div class="container container-login container-transparent animated fadeIn">
         <!-- sign up UI -->
       <form:form modelAttribute="memberVO" id="signUpForm" action="${pageContext.request.contextPath }/login/signUp.do">
       	 <input type="hidden" name="memAlive" value="Y"/>
       	 <input type="hidden" name="memDelete" value="N"/>
       	 <input type="hidden" name="adminRole" value="Y"/>
         <div class="container container-signup container-transparent animated fadeIn">
            <h3 class="text-center">회원가입</h3>
            <div class="login-form">
               <div class="form-group">
                  <label for="id" class="placeholder"><b>아이디</b></label>
                  <input id="fullname" name="memId" type="text" class="form-control input-border-bottom" 
                  pattern="^[a-zA-Z0-9]{5,15}$" required />
                  <form:errors path="memId" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="password" class="placeholder"><b>비밀번호</b></label>
                  <input id="passwordsignin" name="memPass" type="password" pattern="^([^가-힣]).{4,12}$"
                     class="form-control input-border-bottom" required>
                  <div class="show-password">
                        <i class="icon-eye"></i>
                  </div>
                  <form:errors path="memPass" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="name" class="placeholder"><b>이름</b></label>
                  <input id="inputName" name="memName" type="text"
                     class="form-control input-border-bottom" pattern="^([가-힣A-Za-z]){2,20}$" required> 
                  <form:errors path="memName" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="email" class="placeholder"><b>이메일</b></label>
                  <input id="memMail" name="memMail" type="email"   class="form-control input-border-bottom"
                     pattern="^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$" required>
                  <form:errors path="memMail" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="tel" class="placeholder"><b>휴대폰</b></label>
                  <input id="memTel" name="memHp" type="text"   class="form-control input-border-bottom"
                     pattern="^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$" required>
                  <form:errors path="memHp" element="span" cssClass="error" />
               </div>
<!--                <div class="row form-sub m-0"> -->
<!--                   <div class="custom-control custom-checkbox"> -->
<!--                      <input type="checkbox" class="custom-control-input" name="agree" id="agree"> -->
<!--                      <label class="custom-control-label" for="agree">I Agree the terms and conditions.</label> -->
<!--                   </div> -->
<!--                </div> -->
               <div class="row form-action">
                  <a href="${cPath }/login/loginForm.do" id="show-signin" class="btn btn-danger mr-3">Cancel</a>
                  <input type="submit" class="btn btn-success ml-5" id="submitBtn" value="회원가입" />
               </div>
            </div>
         </div>
      </form:form>
      </div>   
         </div>
         </div>
   
   <!-- jQuery -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
   <script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
   
   <!-- jquery-validation-1.19.2 -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
   
   <!-- 템플릿에 있던 기본 플러그인 -->
   <script src="${pageContext.request.contextPath }/assets/js/core/bootstrap.min.js"></script>
   
   <!-- Nofity.js -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/module/notifyMessage.js"></script>
</body>
<script type="text/javascript">
   // 로그인 클릭 이벤트
   $("#loginBtn").on("click", function(){
      $("#loginForm").submit();
   });
   
   // 로그아웃 클릭 이벤트
   $("#logoutBtn").on("click", function() {
      window.location.href = "${pageContext.request.contextPath }/login/logout.do";
   })
   
   // bpms 페이지 이동
   $("#bpmsBtn").on("click", function() {
      window.location.href = "${pageContext.request.contextPath }";
   });
   
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