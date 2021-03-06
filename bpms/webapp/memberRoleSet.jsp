<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 1. 28.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="panel-header">
		<div class="page-inner">
			<span class="project-path"> <a href="#">관리</a> <a href="#">역할
					및 권한</a> <a href="#">새 역할</a>
			</span>

			<div class="setting__header">
				<h2>새 역할</h2>
			</div>

			<div class="addrole__card">

				<ul class="new__role-status row">
					<li class="new__role-info col-2">이름</li>
					<li class="col-10"><input class="role__input form-control"
						type="text"></li>
				</ul>

				<ul class="new__role-status row">
					<li class="new__role-info col-2">다른 권한 복사</li>
					<li class="col-10">
						<div class="role__input selectbox">
							<label for="ex_building">복사할 권한 선택</label>
							<%-- 필요한 속성은 쓰시는데에 맞게 수정해주시면 됩니다! --%>
							<select id="building" onchange="">
								<option>선택안함</option>
								<option>PL</option>
								<option>AA</option>
								<option>UA</option>
							</select>
						</div>

					</li>
				</ul>

			</div>

			<div class="setting__header">
				<h2>권한</h2>
			</div>

			<div class="addrole__card">

				<%--    
                  new__role-list 가 권한안에 있는 모듈별 권한 박스.
                                다른 모듈 권한 추가하려면 바로 밑에있는 <ul></ul> 복붙해서 추가해주시면 됩니다.--%>
				<ul class="new__role-list row">
					<!-- 모듈( 프로젝트, 형상관리, 일감 생성 등 ) 타이틀 -->
					<h2 class="new__role-title">프로젝트</h2>

					<div class="new__role-allcheck">
						<%-- 모두 선택시 모듈내 권한 전체 체크 --%>
						<button class="role-allcheck" onclick="allcheck($(this));"
							type="button">모두 선택</button>
						<%-- 모두 취소시 모듈내 권한 전체 취소 --%>
						<button class="role-uncheck" onclick="uncheck($(this));"
							type="button">모두 취소</button>
					</div>
					<li class="project-rules col-12 row">
						<%-- id 값이랑 name 값은 비워뒀습니다. value값도 쓰실때에 맞게 바꾸시면 됩니다. --%>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option1" aria-label="...">
							<%-- 모듈권 권한 제목 --%>
							<label class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option2" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option3" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option4" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option5" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option6" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
					</li>
				</ul>

				<ul class="new__role-list row">
					<h2 class="new__role-title">댓글</h2>

					<div class="new__role-allcheck">
						<button class="role-allcheck" onclick="allcheck($(this));"
							type="button">모두 선택</button>
						<button class="role-uncheck" onclick="uncheck($(this));"
							type="button">모두 취소</button>
					</div>

					<li class="project-rules col-12 row">

						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option1" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option1" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option1" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
						<div class="form-check col-3">
							<input class="form-check-input position-static" type="checkbox"
								id="" value="option1" aria-label="..."> <label
								class="role-checkname" for=""> 프로젝트 생성 </label>
						</div>
					</li>
				</ul>

				<div class="new__create-role">
					<button type="button">만들기</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {

			let selectTarget = $('.selectbox select');

			selectTarget.focus(function() {
				$('.selectbox').addClass('selectbox__active');
			})

			selectTarget.focusout(function() {
				$('.selectbox').removeClass('selectbox__active');
			})

			selectTarget.change(function() {

				var select_name = $(this).children('option:selected').text();
				$(this).siblings('label').text(select_name);

			});
		});

		function allcheck(input) {
			$(input).parent().siblings('li').find('.form-check-input').prop(
					'checked', true);
		}

		function uncheck(input) {
			$(input).parent().siblings('li').find('.form-check-input').prop(
					'checked', false);
		}
	</script>
</body>
</html>







