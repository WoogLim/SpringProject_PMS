<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.modal {
        text-align: center;
	}
	 
	@media screen and (min-width: 768px) { 
	        .modal:before {
	                display: inline-block;
	                vertical-align: middle;
	                content: " ";
	                height: 100%;
	        }
	}
	 
	.modal-dialog {
	        display: inline-block;
	        text-align: left;
	        vertical-align: middle;
	}
	
	th, td{
		width: 800px;
		height: 50px;
		text-align: center;
		border-bottom: solid 1px;
		border-color: black;
	}
	
	.trHead{
		text-align: left;
	}
</style>
</head>
<body>
<table>
	<tr>
		<th>일감</th>
		<td class="trHead" colspan="3">${ganttVO.boardTitle }</td>
	</tr>
	<tr>
		<th>담당자</th>
		<td class="trHead" colspan="3">${ganttVO.workDirector }</td>
	</tr>
	<tr >
		<th>순위</th>
		<td>${ganttVO.workRank }</td>
		<th>유형</th>
		<td>${ganttVO.workType }</td>
	</tr>
	<tr>
		<th>상태</th>
		<td>${ganttVO.workState }</td>
		<th>진행률</th>
		<td>${ganttVO.progress }%</td>
	</tr>
	<tr>
		<th>시작일</th>
		<td>${ganttVO.startDate }</td>
		<th>마감일</th>
		<td>${ganttVO.endDate }</td>
	</tr>
</table>
</body>
</html>