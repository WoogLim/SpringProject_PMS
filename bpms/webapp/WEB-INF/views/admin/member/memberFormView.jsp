<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자        수정내용
* ------------   ---------  -----------------
* 2021. 1. 31.     신광진      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path"> 
			<a href="#">관리</a>
			<a href="#">등록된 구성원</a>
			<a href="#">구성원 등록</a>
		</span>
		<div class="setting__header">
			<h2>구성원 추가</h2>
		</div>
		<hr>
		
		<form:form commandName="memberVO" id="memberForm" method="post" action="${pageContext.request.contextPath }/admin/member/memberInsert.do">
			<div class="container">
				<div class="row form-group">
					<label for="memId">로그인 아이디</label>
					<div class="input-group">
						<input type="text" id="memId" name="memId" class="form-control" pattern="^[a-z0-9]{5,15}$" 
								value="${memberVO.memId }" placeholder="영어소문자와 숫자만 사용된 5~15자리" required>
						<input type="button" id="idDupCheckBtn" class="btn btn-primary" value="아이디 중복확인">
						<input type="hidden" id="checkedMemId">
					</div>
					<form:errors path="memId" element="span" cssClass="errors"/>
					<br/>
					<span id="duplicationSpan" class="errors"></span>
				</div>
				
				<div class="row form-group">
					<label for="memPass">비밀번호</label>
					<input type="text" name="memPass" id="memPass" class="form-control" pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$" 
						value="${memberVO.memPass }" placeholder="영어 소문자와 대문자, 숫자를 포함한 5~12자리" required>
					<form:errors path="memPass" element="span" cssClass="errors"/>
				</div>
				
				<div class="row form-group">
					<label for="memName">이름</label>
					<input type="text" name="memName" id="memName" class="form-control" 
						value="${memberVO.memName }" placeholder="이름" required>
					<form:errors path="memName" element="span" cssClass="errors"/>
				</div>
				
				<div class="row form-group">
					<label for="memMail">이메일</label>
					<input type="email" name="memMail" id="memMail" class="form-control" 
						placeholder="Email@domain.com" value="${memberVO.memMail }" required>
					<form:errors path="memMail" element="span" cssClass="errors"/>
				</div>
				
				<div class="row form-group">
					<label for="memHp">핸드폰 번호</label>
					<input type="tel" name="memHp" id="memHp" class="form-control" value="${memberVO.memHp }"
						placeholder="01x-xxxx-xxxx"	pattern="^\d{3}-\d{3,4}-\d{4}$"	required>
					<form:errors path="memHp" element="span" cssClass="errors"/>
				</div>
				
				<div class="row">
					<input type="submit" id="insertBtn" class="btn btn-primary" value="추가">
					&nbsp;
					<input type="reset" class="btn btn-danger" value="초기화">
				</div>
			</div>		
		</form:form>
		
		<form action="${pageContext.request.contextPath }/admin/member/duplicationCheck.do" method="get" id="idCheckForm">
			<input type="hidden" name="memId">
		</form>
	</div>
</div>
<script type="text/javascript">
	let memberForm = $("#memberForm");
	
	// 회원등록 Form
	memberForm.on("submit", function() {
		let memIdTag = memberForm.find("input[name='memId']");
		let checkedMemIdTag = memberForm.find("input[id='checkedMemId']");
		if($(memId).val() != $(checkedMemId).val()) {
			$("#duplicationSpan").text("중복체크를 완료해주세요");
			memIdTag.focus();
			return false;
		}
	});

	// 아이디 중복체크 Form 
	let idCheckForm = $("#idCheckForm").ajaxForm({
		dataType: "json"
		, success: function(resp) {
			if(resp=="PKDUPLICATED") {
				$("#duplicationSpan").text("중복된 아이디입니다.");
			} else if(resp=="OK") {
				$("#duplicationSpan").text("");
				let checkedMemId = memberForm.find("input[name='memId']").val();
				memberForm.find("input[id='checkedMemId']").val(checkedMemId);
			}
		}
		, error: function(xhr) {
			console.log(xhr.status);
		}
	});
	
	// 아이디 중복체크 버튼
	$("#idDupCheckBtn").on("click", function() {
		let memId = memberForm.find("input[name='memId']").val();
		if(memId == null || memId.trim().length == 0) {
			$("#duplicationSpan").text("아이디를 입력해주세요");
			return false;
		}
		
		let pattern = $("#memberForm").find("input[name='memId']").attr("pattern");
		let regExp = new RegExp(pattern);
		if(!regExp.test(memId)) {
			$("#duplicationSpan").text("영어소문자와 숫자만 입력가능합니다(5~15글자)");
			return false;	
		}
		
		idCheckForm.find("input[name='memId']").val(memId);
		idCheckForm.submit();
	});
</script>
