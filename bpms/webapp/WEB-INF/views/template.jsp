<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Test</title>
<tiles:insertAttribute name="preScript"/>
</head>
<body>
	<div class="loader-container">
<%--         <img src="${pageContext.request.contextPath }/assets/img/screenloader.svg" alt=""> --%>
    </div>
	<div class="wrapper">
		<div class="main-header">
		<tiles:insertAttribute name="logo" />
		<tiles:insertAttribute name="topMenu" />
		<tiles:insertAttribute name="message" />
		</div>
		<tiles:insertAttribute name="leftMenu" />
		
	<div class="main-panel">
        <div class="container">
        	<div class="page-inner">
				<tiles:insertAttribute name="contents"/>
			</div>
		</div>
	</div>
</div>
		<tiles:insertAttribute name="endScript"/>
		<tiles:insertAttribute name="navScript"/>
<c:if test="${not empty message }">
	<script type="text/javascript">
		showMessage({
			"text": "${message.text}"
			, "align": "${message.align}"
			, "from": "${message.from}"
			, "timeout": "${message.timeout}"
			, "type": "${message.type}"
		})
	</script>
</c:if>
</body>
</html>