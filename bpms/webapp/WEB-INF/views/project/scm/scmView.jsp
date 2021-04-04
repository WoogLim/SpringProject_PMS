<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 2. 24.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set value="${pagingVO.searchDetail.userStartDate }" var="startDate"/>
<c:set value="${pagingVO.searchDetail.userEndDate }" var="endDate"/>
<c:set value="${pagingVO.searchDetail.provider }" var="provider"/>
<div class="commithistory-container">
<div class="container-header">
    <h2 class="container-title">
        모든 커밋 내역
    </h2>

    <button id="chartBtn" class="commit-chart" type="button">
        <i class="far fa-chart-bar chart-bar"></i>
        커밋 통계
    </button>
</div>

 <div class="pipelinelist-box">
    <div class="pipe-checkfilter no-drag">
        <div class="pipefilter-title">
           	 커밋내역 선택 필터
        </div>

        <div class="selected-pipelinecontainer">
            <button class="pipelineuser-select" type="button" data-toggle="dropdown">
                <i class="fas fa-bezier-curve"></i>
                <%-- 이 label에는 밑에 라디오 버튼에서 선택한 label.text()값이 나타남 --%>
                <label for="" class="select-pipeline">모든 저자</label>
                <i class="fas fa-sort-down arrow-down"></i>
            </button>
            <ul class="pipeline-list dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li>
                    <input type="radio" name="userpipeline" class="pipeline-radio" onchange="logFilter();" value="">
                    <label for="" class="pipeline-label">모든 저자</label>
                </li>
                <!-- 여기서부터 구성원 목록 input의 아이디, label의 for는 갯수에 따라 스크립트로 정해짐-->
                	<%-- 밑에 li태그 하나가 구성원 한명 --%>
               	<c:forEach items="${providerList }" var="provider">
                    <li>
                        <%-- id는 스크립트로 정함 --%>
                        <input type="radio" name="userpipeline" class="pipeline-radio" onchange="logFilter();" value="${provider }">
                        <%-- for는 위 스크립트로 지정된 id로 되어있음 밑에 label에는 사용자 이름만 넣어줘영 --%>
                        <label for="" class="pipeline-label">${provider }</label>
                    </li>
               	</c:forEach>
                </ul>
            </div>
	
			<%-- 커밋내역 기간 선택 --%>
            <div class="selected-datetime">
                <span class="start-alert">
                    	시작일
                </span>
                <input type="date" class="start-datetime" onchange="logFilter();" value="${startDate }">
                <span class="end-alert">
                    	종료일
                </span>
                <input type="date" class="end-datetime" onchange="logFilter();" value="${endDate }">
            </div>
        </div>

		<div class="history-content">

	        <div class="history-tree">
	        	<div class="scmtree-container">
	        		<div class="scmtree-box">
	        			<h1>프로젝트 계층 구조</h1>
	           			<div id="scmtree">
	           			</div>
	        		</div>	        	
	        	</div>
	        </div>
	                                
	        <div class="commithistory-list">
	            <ul class="commithistory-title">
	                <li>개정번호/날짜</li>
	                <li>내용/작성자</li>
	            </ul>
		
				<%-- 밑에 ul태그 하나가 커밋내역 한세트 --%>
				<c:set value="${pagingVO.dataList }" var="logList"/>
				<c:forEach begin="${pagingVO.startRow }" end="${pagingVO.endRow }" var="i" step="1">
					<c:if test="${i le logList.size() }">
						<c:set value="${logList.get(i-1) }" var="log"/>
			            <ul class="commithistory-item">
			                <li class="commitmain-content">
			                	<%-- [1] revision 이름 --%>
			                    <div class="revision-box">
			                        ${log.revision }
			                    </div>
			                    <div class="content-box">
			                        <span class="content-icon">
			                            <i class="fas fa-signature"></i>
			                        </span>
			                        <%-- [2] 밑에 span 태그안에 커밋 내용 --%>
			                        <span>
			                        	${log.message }
			                        </span>
			                    </div>
			                </li>
			                <li class="commitsub-content">
			                	<%-- [5] 커밋 날짜 --%>
			                    <div class="commit-date">
			                        ${log.date }
			                    </div>
		                        <span class="commit-author">
		                        <i class="fas fa-user-circle"></i>
		                            <%-- [4] author 이름 --%>
		                            <span class="author-name">
		                                ${log.author}
		                            </span>
		                        </span>
			                </li>
			            </ul>
					</c:if>
				</c:forEach>
	        </div>
	    </div>
    </div>
</div>
<div id="pagingArea">
	${pagingVO.pagingHTML }
	<form:form id="logForm" modelAttribute="scmVO" commandName="scmVO">
		<input type="hidden" name="page">
		<form:input type="hidden" path="userStartDate" />
		<form:input type="hidden" path="userEndDate" />
		<form:input type="hidden" path="provider" />
	</form:form>
</div>

<script type="text/javascript">
	$(function(){
	    // 월별 및 저자별 커밋 통계 페이지 이동
		$("#chartBtn").on("click", function() {
			window.location.href = "${cPath}/scm/scmChart.do";
		});
		
	    let slectpipeline = $('.pipeline-list li');
	    let count = 0;
	
	    slectpipeline.each(function(){
	        count++;
	        $(this).children('.pipeline-radio').attr('id', 'pipeuser'+count);
	        $(this).children('.pipeline-label').attr('for', 'pipeuser'+count);
	    });
	    
	    // 로그 기록 필터
	    const logForm = $("#logForm");
	    
	 	// 페이징 처리
		let pagingArea = $("#pagingArea").on("click", "a" ,function(event){
			event.preventDefault();
			let page = $(this).data("page");
			logForm.find("[name='page']").val(page);
			logForm.submit();
			logForm.find("[name='page']").val("");
			return false;
		});
	 	
		const NODEURL = "${cPath }/scm/svnFancyTree.do";
		
		$("#scmtree").fancytree({
			extensions : ["filter"],
			source : {
				url : NODEURL
				,cache : false
			},
			lazyLoad : function(event, data) {
				var node = data.node;
				data.result = {
					url : NODEURL
					, data : {
						path : node.key
						,pathName : node.title
					}
					,cache : false
				}
			},
			activate: function(event, data) {
				$("#echoActive").text(data.node.title);
			},
			filter : {
				autoApply : true, // Re-apply last filter if lazy data is loaded
				autoExpand : false, // Expand all branches that contain matches while filtered
				counter : true, // Show a badge with number of matching child nodes near parent icons
				fuzzy : false, // Match single characters in order, e.g. 'fb' will match 'FooBar'
				hideExpandedCounter : true, // Hide counter badge if parent is expanded
				hideExpanders : false, // Hide expanders if all child nodes are hidden by filter
				highlight : true, // Highlight matches by wrapping inside <mark> tags
				leavesOnly : false, // Match end nodes only
				nodata : true, // Display a 'no data' status node if result is empty
				mode : "dimm" // Grayout unmatched nodes (pass "hide" to remove unmatched node instead)
			}
		});
	});
	
	// 필터 변경 시 서브밋
	function logFilter(){
		let startDate = $(".start-datetime").val();
		$("#logForm").find("[name='userStartDate']").val(startDate);
		console.log(startDate);
		let endDate = $(".end-datetime").val();
		$("#logForm").find("[name='userEndDate']").val(endDate);
		console.log(endDate);
		let provider = $("[name='userpipeline']:checked").val();
		console.log(provider);
		$("#logForm").find("[name='provider']").val(provider);
		$("#logForm").submit();
	} 
	
	document.addEventListener('scroll', function() {
		 let scrollHeight = document.documentElement.scrollTop;
		 
		 if(scrollHeight >= 145){
			 $('.scmtree-box').css("top",scrollHeight - 115)
		 }else{
			 $('.scmtree-box').css("top","20px")
		 }
	});
</script>
</body>
</html>