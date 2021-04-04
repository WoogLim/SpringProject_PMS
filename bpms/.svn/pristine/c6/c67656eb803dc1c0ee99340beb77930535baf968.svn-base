<%--
* [[ê°ì ì´ë ¥(Modification Information)]]
* ìì ì¼                 ìì ì      	ìì ë´ì©
* ----------  -------- -----------------
* 2021. 2. 25.	ìê±´		ìµì´ìì±
* Copyright (c) 2021 by DDIT All right reserved
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>${errorMsgVO.statusCode }</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<link rel="icon" href="${pageContext.request.contextPath }/assets/img/icon.ico" type="image/x-icon"/>
	
	<!-- Fonts and icons -->
	<script src="${pageContext.request.contextPath }/assets/js/plugin/webfont/webfont.min.js"></script>
    <link rel="stylesheet" href="../assets/css/font.css">
    <link rel="stylesheet" href="../assets/css/custom.css">
	<script>
		WebFont.load({
			google: {"families":["Lato:300,400,700,900"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands", "simple-line-icons"], urls: ['../assets/css/fonts.min.css']},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	</script>

	<!-- CSS Files -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/atlantis.css">
</head>
<body class="page-not-found">
	<div class="wrapper not-found">
		<h1 class="animated fadeIn">${errorMsgVO.statusCode } ERROR</h1>
		<div class="desc animated fadeIn errorpage-message"><span>${errorMsgVO.errorMsg }</span></div>
		<a href="/bpms" class="btn btn-outline-secondary btn-back-home mt-4 animated fadeInUp error-gohomebtn">
			<i class="flaticon-home"></i>
			급할 수록 돌아 가세요
		</a>
	</div>
</body>
</html>