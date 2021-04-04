<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 3. 4.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="scmregist-container">
     <div class="container-header">
         <h2 class="container-title">
             SCM
         </h2>
     </div>

     <div class="scmregist-form ">
         <div class="custom-header clearfix">
             <h1 class="customfilter-title float--left">
                 SCM 관리 도구 연동
             </h1>
             <div class="custom-filter float--right">
             <%-- SCM 등록관련해서 설명하고픈 얘기 적어주세요 밑에 div태그안에 --%>
                 <div class="custom-guide no-drag">
                      등록 이후에도 수정이 가능합니다.
                 </div>
             </div>
         </div>

         <form class="custom-form" action="">
             <ul class="customform-list">
                 <li class="customform-item">
                     <span class="customform-title required-form">
                         관리 도구 선택
                     </span>
                     <div class="svntool-selbox svn-selbox">
                     	 <%-- label이 버튼 형식으로 동작하게 CSS 잡아뒀습니다. 
                     	 label 클릭시 실질적으로 같은 형제 태그인 input태그가 선택됩니다. 
                     	 input은 radiobutton 타입임. name키 값으로 value불러오면 됩니다. 
                     	 data-scm 만 수정하지 마시고 다른 부분은 수정하셔도 됩니다. 
                     	 Git 선택시 리퍼지토시 등록 나오게 스크립트 잡아뒀습니다. --%>
                         <label for="svn-select" class="tool-selbtn">
                             <i class="fas fa-code-branch"></i>
                         </label>
                         <span class="tool-name no-drag">
                             SVN
                         </span>
                         <input type="radio" name="scmtool" value="1" id="svn-select" data-scm="svn" onchange="scmtoolSelect(this)">
                     </div>
                     <div class="svntool-selbox jgit-selbox">
                         <label for="jgit-select" class="tool-selbtn">
                             <i class="fab fa-github"></i>
                         </label>
                         <span class="tool-name no-drag">
                             Git
                         </span>
                         <input type="radio" name="scmtool" value="2" id="jgit-select" data-scm="git" onchange="scmtoolSelect(this)">
                     </div>
                 </li>

				 <%-- Git 선택시 리퍼지토리 설정 --%>
                 <li class="customform-item git-repositorypath">
                     <span class="customform-title required-form">
                         리퍼지토리 패스 경로
                     </span>
                     <input type="text" name="scmUrl" class="request-projectinput" placeholder="ex)passId/projecttitle">
                 </li>

				 <%-- 계정 ID --%>
                 <li class="customform-item">
                     <span class="customform-title required-form">
                         선택 도구 계정 ID
                     </span>
                     <input type="text" name="scmId" class="request-projectinput">
                 </li>

				 <%-- 계정 PW --%>
                 <li class="customform-item">
                     <span class="customform-title required-form">
                         선택 도구 계정 PW
                     </span>
                     <input type="password" name="scmPass" class="request-projectinput scm-pass">
                     <button type="button" class="scmpass-eyesbtn pass-hide">
                         <i class="far fa-eye-slash"></i>
                     </button>
                     <button type="button" class="scmpass-eyesbtn pass-show">
                         <i class="far fa-eye"></i>
                     </button>
                 </li>
             </ul>

             <div class="customrequestbtn-group">
                 <button type="submit" class="customrequest-submitbtn">
                     시작하기
                 </button>
             </div>
         </form>

     </div>
</div>

<script type="text/javascript">
$(function () {
    $('.loader-container').fadeOut();

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

})

function scmtoolSelect(input){
    if($('.tool-selbtn').hasClass('scm-selected')){
        $('.tool-selbtn').removeClass('scm-selected');
    }

    $(input).siblings('.tool-selbtn').addClass('scm-selected');
}
</script>
</body>
</html>