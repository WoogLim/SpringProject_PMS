<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>BPMS</title>
<tiles:insertAttribute name="preScript" />
</head>
<body class="home-background">
	<div class="loader-container">
<%--         <img src="${pageContext.request.contextPath }/assets/img/screenloader.svg" alt=""> --%>
    </div>
	<div class="wrapper horizontal-layout-2">
			<tiles:insertAttribute name="topMenu" />
			<tiles:insertAttribute name="contents" />
			<tiles:insertAttribute name="message" />
		</div>
		<tiles:insertAttribute name="endScript" />
	<c:if test="${not empty message }">
		<script type="text/javascript">
			showMessage({
				"text" : "${message.text}",
				"align" : "${message.align}",
				"from" : "${message.from}",
				"timeout" : "${message.timeout}",
				"type" : "${message.type}"
			})
		</script>
	</c:if>
</body>
</html>