<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Best Project Management System</title>
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
<link rel="icon" href="${pageContext.request.contextPath }/assets/img/icon.ico" type="image/x-icon" />

<!-- Fonts and icons -->
<script src="${pageContext.request.contextPath }/assets/js/plugin/webfont/webfont.min.js"></script>
<script>
	WebFont.load({
		google: {
			"families": ["Lato:300,400,700,900"]
		},
		custom: {
			"families": ["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands",
				"simple-line-icons"
			],
			urls: ['../assets/css/fonts.min.css']
		},
		active: function () {
			sessionStorage.fonts = true;
		}
	});
</script>


<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>

<!-- NotyMessage -->
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/module/notifyMessage.js"></script>

<!-- CSS Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/atlantis2.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/custom.css">

<script type="text/javascript">
	$.getContextPath = function() {
		return "${pageContext.request.contextPath}";
	}
</script>