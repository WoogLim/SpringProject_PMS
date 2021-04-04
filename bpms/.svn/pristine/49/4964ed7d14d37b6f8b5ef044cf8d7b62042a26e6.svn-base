<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	body {
	font-family: sans-serif;
	background: #ccc;
	}
</style>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>
</head>
<body>
<c:set var="wrCustomList" value="${wrCustomList }"/>
<c:set var="wtCustomList" value="${wtCustomList }"/>
<c:set var="wsCustomList" value="${wsCustomList }"/>
<c:set var="scheduleList" value="${scheduleVO.scheduleList }" />
<c:set var="ganttVO" value="${ganttVO }" />
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path">
			<a href="">프로젝트</a>
			<a href="">PMS 프로그램 개발</a>
		</span>
   
		<div class="issue-header clearfix">
			<div class="float-left">
				<h1 class="fw-mediumbold"> 간트차트</h1>
			</div>
		</div>
		
		<div class="gantt-checkfilter no-drag" id="ganttCheck">
           <div class="pipefilter-title">
               	파이브라인 선택 필터
           </div>

           <div class="ganttfilter-item">
				<span class="ganttfilter-title">
					우선순위
				</span>
				<div class="selected-pipelinecontainer">
					<c:choose>
						<c:when test="${not empty ganttVO.workRank }">
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">${ganttVO.workRank }</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:when>
						<c:otherwise>
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">모두 조회</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:otherwise>
					</c:choose>
                   
					<ul class="pipeline-list dropdown-menu" aria-labelledby="dropdownMenuButton">
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WR" value=""
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">모두 조회</label>
                       </li>
                       <c:if test="${not empty wrCustomList }">
							<c:forEach items="${wrCustomList }" var="wrCustomList">
							<li>
								<input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WR" value="${wrCustomList.text }"
									onchange="selectfilter(this);">
								<label for="" class="pipeline-label">${wrCustomList.text }</label>
							</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>

			<div class="ganttfilter-item">
				<span class="ganttfilter-title">
					유형
				</span>
				<div class="selected-pipelinecontainer">
					<c:choose>
						<c:when test="${not empty ganttVO.workType }">
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">${ganttVO.workType }</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:when>
						<c:otherwise>
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">모두 조회</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:otherwise>
					</c:choose>
                   
					<ul class="pipeline-list dropdown-menu" aria-labelledby="dropdownMenuButton">
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WT" value=""
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">모두 조회</label>
                       </li>
                       <c:if test="${not empty wtCustomList }">
							<c:forEach items="${wtCustomList }" var="wtCustomList">
							<li>
								<input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WT" value="${wtCustomList.text }"
									onchange="selectfilter(this);">
								<label for="" class="pipeline-label">${wtCustomList.text }</label>
							</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>

           <div class="ganttfilter-item">
				<span class="ganttfilter-title">
					상태
				</span>
				<div class="selected-pipelinecontainer">
					<c:choose>
						<c:when test="${not empty ganttVO.workState }">
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">${ganttVO.workState }</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:when>
						<c:otherwise>
							<button class="pipelineuser-select" type="button" data-toggle="dropdown">
								<i class="fas fa-chart-line"></i>
								<label for="" class="select-pipeline">모두 조회</label>
								<i class="fas fa-sort-down arrow-down"></i>
							</button>
						</c:otherwise>
					</c:choose>
                   
					<ul class="pipeline-list dropdown-menu" aria-labelledby="dropdownMenuButton">
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WS" value=""
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">모두 조회</label>
                       </li>
                       <c:if test="${not empty wsCustomList }">
							<c:forEach items="${wsCustomList }" var="wsCustomList">
							<li>
								<input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="WS" value="${wsCustomList.text }"
									onchange="selectfilter(this);">
								<label for="" class="pipeline-label">${wsCustomList.text }</label>
							</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
			
			<div class="ganttfilter-item">
				<span class="ganttfilter-title">
					날짜
				</span>
				<div class="selected-pipelinecontainer">
					<button class="pipelineuser-select" type="button" data-toggle="dropdown">
						 <i class="fas fa-clock"></i>
						<label for="" class="select-pipeline">Default</label>
						<i class="fas fa-sort-down arrow-down"></i>
					</button>
                   
					<ul class="pipeline-list dropdown-menu" aria-labelledby="dropdownMenuButton">
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="DO" value="Month"
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">Month</label>
                       </li>
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="DO" value="Week"
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">Week</label>
                       </li>
                       <li>
                           <input type="radio" name="userpipeline" class="pipeline-radio" data-optioncode="DO" value="Day"
                               onchange="selectfilter(this);">
                           <label for="" class="pipeline-label">Day</label>
                       </li>
					</ul>
				</div>
			</div>
			
			<div class="ganttfilter-item" style="flex:1; justify-content:flex-end">
				<button class="pipelineuser-select" type="button" id="pdfDownload" data-toggle="dropdown" onclick="fnSaveAsPdf();" style="background-color: #F5A9BC;">PDF DownLoad
				</button>
			</div>
		</div>	
		
		
		<div class="ganttTotal" id="ganttTotal">
			<c:if test="${not empty scheduleList }">
				<div class="ganttTable">
						<div class="divHead"></div>
					<c:forEach items="${scheduleList}" var="ganttTable">
						<div class="divBody"><span id="spanType">${ganttTable.workType}</span>&nbsp&nbsp<span id="spanTitle">${ganttTable.boardTitle}</span></div>
					</c:forEach>
				</div>
				<div class="gantt">
					<div class="gantt-target"></div>
				</div>
			</c:if>
		</div>
		<c:if test="${empty scheduleList }">
			<div id="noResult">해당하는 검색결과가 없습니다.</div>
		</c:if>
	</div>
</div>

<form id="workListForm">
	<%-- 검색 조건 --%>
	<input type="hidden" name="workState" value="${ganttVO.workState }">
	<input type="hidden" name="workRank" value="${ganttVO.workRank }">	
	<input type="hidden" name="workType" value="${ganttVO.workType }">
	<input type="hidden" name="proId" value="${param.proId }">
</form>
<script type="text/javascript">
	$.fn.hasScrollBar = function() {
	    return (this.prop("scrollWidth") == 0 && this.prop("clientWidth") == 0) || (this.prop("scrollWidth") > this.prop("clientWidth"));
	};
	
	function wheel(name){
		$(name).on('mousewheel',function(e){
		    var hasScroll = $(this).hasScrollBar();
		    if(!hasScroll){
		    }else{
		        e.preventDefault(); 
		        var wheelDelta = e.originalEvent.wheelDelta;
		        if(wheelDelta > 0){
		            $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
		        }else{
		            $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
		        }
		    }
		});
	}
	
	$(function(){
	    wheel('.gantt-container');
	    /* 390 ~ 398 검색필터의 radio의 id, label의 for를 지정해줌*/
	    let slectpipeline = $('.pipeline-list li');
        let count = 0;

        slectpipeline.each(function () {
            count++;

            $(this).children('.pipeline-radio').attr('id', 'pipeuser' + count);
            $(this).children('.pipeline-label').attr('for', 'pipeuser' + count);
        })
	    
	});
	
	/* 403 ~ 406 검색필터 선택시 라벨에 보여줌 */
	function selectfilter(input) {
        let userselect = $(input).siblings('.pipeline-label').text();
        $(input).parent().parent().siblings('.pipelineuser-select').children('.select-pipeline').text(userselect);
    }
	
	let workListForm = $("#workListForm");
    let selectTarget = $('.selectbox select');

    selectTarget.each(function(){
    	let select_name = $(this).children('option:selected').text();
    	$(this).siblings('label').text(select_name)
    })
    
    selectTarget.change(function(){ 
        let select_name = $(this).children('option:selected').text(); 
        
        /* 형제 요소인 label에 표시 */
        $(this).siblings('label').text(select_name); 
    }); 
    
    // 검색조건 이벤트 처리
    $("div.gantt-checkfilter").find("input").on("change", function() {
		let groupCode = $(this).data("optioncode");
		let val = $(this).val();
		switch(groupCode){
		case "WR":
			workListForm.find("input[name='workRank']").val(val);
			break;
		case "WT":
			workListForm.find("input[name='workType']").val(val);
			break;
		case "WS":
			workListForm.find("input[name='workState']").val(val);
			break;
		case "DIRECTOR":
			workListForm.find("input[name='workDirector']").val(val);
			break;
		case "DO":
			gantt_chart.change_view_mode(val);
			console.log(val);
			return;
		default:
			console.log("invalide args");
		}
		workListForm.submit();
    });

	let arr = new Array();
	<c:forEach items="${scheduleList}" var="gantt">
		arr.push({start: "${gantt.startDate }",
				  end: "${gantt.endDate }",
				  name: "${gantt.boardTitle }",
				  id: "${gantt.workId }",
				  progress: "${gantt.progress }",
				  dependencies: "${gantt.workParent }"});
	</c:forEach>
	
	let gantt_chart = new Gantt(".gantt-target", arr, {
		view_mode: 'Month',
		language: 'ko'
	});
	
	function fnSaveAsPdf() {
		html2canvas(document.getElementById("ganttTotal"),{scale: 2}).then(function(canvas) {
		  var imgData = canvas.toDataURL('image/png');
		  var imgWidth = 210;
		  var pageHeight = imgWidth * 1.414;
		  var imgHeight = canvas.height * imgWidth / canvas.width;	
		
		  var doc = new jsPDF({
		    'orientation': 'p',
		    'unit': 'mm',
		    'format': 'a4'
		  }); 
		
		  doc.addImage(imgData, 'PNG', 0, 0, imgWidth, imgHeight);
		  doc.save('gantt.pdf');
		});
	}
</script>
</body>
</html>