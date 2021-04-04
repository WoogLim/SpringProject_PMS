<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자        수정내용
* ------------   ---------  -----------------
* 2021. 2. 19.     신광진      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	ul.customdashboard-card li.customcard-item:hover {
		cursor: pointer;
	} 
</style>

<div class="dashboard-header">
    <div class="project-name">
        관리자 대시보드
    </div>
</div>

<div class="customdash-container">
    
    <ul class="customdashboard-card">
        <li class="customcard-item custom-d-flex-2-4" data-type="work">
            <span class="customcard-header">
                총 일감
            </span>
            <span class="customcard-statistics">
                <span class="customstatistics-number" id="totalWorkCntSpan">
				<%-- 일감개수 자리 --%>
                </span>
            </span>
        </li>
        <li class="customcard-item custom-d-flex-2-4" data-type="completeWork">
            <span class="customcard-header">
                완료된 일감
            </span>
            <span class="customcard-statistics">
                <span class="customstatistics-number" id="completeWorkCntSpan">
				<%-- 완료작업 개수자리 --%>
                </span>
            </span>
        </li>
        <li class="customcard-item custom-d-flex-2-4" data-type="issue">
            <span class="customcard-header">
                총 이슈
            </span>
            <span class="customcard-statistics">
                <span class="customstatistics-number" id="totalIssueCntSpan">
				<%-- 이슈개수 자리 --%>
                </span>
            </span>
        </li>
        <li class="customcard-item custom-d-flex-2-4" data-type="project">
            <span class="customcard-header">
                프로젝트 개수
            </span>
            <span class="customcard-statistics">
                <span class="customstatistics-number" id="totalProjectCntSpan">
				<%-- 프로젝트 개수 자리 --%>
                </span>
            </span>
        </li>
        <li class="customcard-item custom-d-flex-2-4" data-type="inProgressProject">
            <span class="customcard-header">
                진행중인 프로젝트
            </span>
            <span class="customcard-statistics">
                <span class="customstatistics-number" id="inProgressProjectCntSpan">
				<%-- 진행중인 프로젝트 개수 자리 --%>
                </span>
            </span>
        </li>
    </ul>

    <ul class="customchart-statistics">
        <li class="customchart-item custom-d-flex-4">
            <div class="customchart-header">
                <span class="customchart-title">
                    일감 상태별 차트
                </span>
            </div>
            <div class="chart-container">
                <canvas id="workStatusChart"></canvas>
            </div>
        </li>
        <li class="customchart-item custom-d-flex-4">
            <div class="customchart-header">
                <span class="customchart-title">
                    이슈 상태별 차트
                </span>
            </div>
            <div class="chart-container">
                <canvas id="issueStatusChart"></canvas>
            </div>
        </li>
        <li class="customchart-item custom-d-flex-4">
            <div class="customchart-header">
                <span class="customchart-title">
                    프로젝트 상태별 차트
                </span>
            </div>
            <div class="chart-container">
                <canvas id="projectStatusChart"></canvas>
            </div>
        </li>
    </ul>

    <ul class="customlist-item">
        <li class="customcurrent-chart custom-d-flex-6">
            <div class="customchart-header">
                <span class="customchart-title">
                    구성원 권한별 차트
                </span>
                <div class="chart-container">
                    <canvas id="memberStatusChart"></canvas>
                </div>
            </div>
        </li>
        <li class="customcurrent-chart custom-d-flex-6">
            <div class="customchart-header">
                <span class="customchart-title">
                    프로젝트 역할별 차트
                </span>
                <div class="chart-container">
                    <canvas id="projectRoleStatusChart"></canvas>
                </div>
            </div>
        </li>
    </ul>
</div>


<script>

	$(function(){
		const workStatusChart = document.getElementById("workStatusChart").getContext('2d');
		const issueStatusChart =  document.getElementById("issueStatusChart").getContext('2d');
		const projectStatusChart =  document.getElementById("projectStatusChart").getContext('2d');
		const memberStatusChart =  document.getElementById("memberStatusChart").getContext('2d');
		const projectRoleStatusChart =  document.getElementById("projectRoleStatusChart").getContext('2d');
		let colorSequnce = 0;
		// 컬러 색상 30가지
		let colors = ["#ff7a7a", "#7abaff", "#ffef7a", "#ffaf7a", "#ce7aff", "#ff7a9d", "#6932ff", "#32ff87", "#03e9bf", "#f8ffba",
		             "#ffc5c5", "#576ebd", "#bdae57", "#f89f63", "#f532ff", "#fd5381", "#400bff", "#13ba6c", "#138dba", "#b7ba13",
		             "#fc2525", "#2647b5", "#e1fa04", "#fa6604", "#fa04a8", "#b82b89", "#4200dc", "#b1f7d6", "#036d94", "#6a490d"]
		
// 		renderChart(colors);
	

		$.ajax({
			url: $.getContextPath() + "/admin/dashBoard"
			, dataType: "json"
			, success: function(resp){
				console.log(resp);
				workStateChartDataSet(resp.workStateList);
				issueStateChartDataSet(resp.issueStateList);
				projectStateChartDataSet(resp.projectStateList);
				memberStateChartDataSet(resp.descriptionList);
				projectMemberRoleChartDataSet(resp.roleNameList);
			}
			, error: function(xhr) {
				console.log(xhr.status);
			}
				
		});	
		
		function workStateChartDataSet(dataList) {
			let labels = [];
			let data = [];
			let backgroundColor = [];
			let completeWorkCnt = 0;
			let totalWorkCnt = 0;
			$(dataList).each(function(idx, element){
				labels.push(element.workState);
				data.push(element.workCntPerState);
				backgroundColor.push(colors[idx]);
				
				totalWorkCnt += element.workCntPerState;
				if(element.workState == '완료') {
					completeWorkCnt = element.workCntPerState;
				}
			});
			
			$("#totalWorkCntSpan").text(totalWorkCnt);
			$("#completeWorkCntSpan").text(completeWorkCnt);
			
			workStateChartRender({
				"labels": labels
				, "data": data
				, "backgroundColor": backgroundColor
			});
		}
		
		function issueStateChartDataSet(dataList) {
			let labels = [];
			let data = [];
			let backgroundColor = [];
			let totalIssueCnt = 0;
			$(dataList).each(function(idx, element){
				labels.push(element.issueState);
				data.push(element.issueCntPerState);
				backgroundColor.push(colors[idx]);
				
				totalIssueCnt += element.issueCntPerState;
			});
			
			$("#totalIssueCntSpan").text(totalIssueCnt);
			issueStateChartRender({
				"labels": labels
				, "data": data
				, "backgroundColor": backgroundColor
			});
		}
		
		function projectStateChartDataSet(dataList) {
			let labels = [];
			let data = [];
			let backgroundColor = [];
			let totalProjectCnt = 0;
			let inProgressProjectCnt = 0;
			$(dataList).each(function(idx, element){
				labels.push(element.codeName);
				data.push(element.proCnt);
				backgroundColor.push(colors[idx]);
				
				totalProjectCnt += element.proCnt;
				if(element.codeName == '진행') {
					console.log(element.codeName + ": " + element.proCnt);
					inProgressProjectCnt = element.proCnt;
				}
			});
			
			$("#totalProjectCntSpan").text(totalProjectCnt);
			$("#inProgressProjectCntSpan").text(inProgressProjectCnt);
			projectStateChartRender({
				"labels": labels
				, "data": data
				, "backgroundColor": backgroundColor
			});
		}
		
		function memberStateChartDataSet(dataList) {
			let labels = [];
			let data = [];
			let backgroundColor = [];
			$(dataList).each(function(idx, element){
				labels.push(element.description);
				data.push(element.authCnt);
				backgroundColor.push(colors[idx]);
			});
			
			memberStateChartRender({
				"labels": labels
				, "data": data
				, "backgroundColor": backgroundColor
			});
		}
		
		function projectMemberRoleChartDataSet(dataList) {
			let labels = [];
			let data = [];
			let backgroundColor = [];
			$(dataList).each(function(idx, element){
				labels.push(element.roleName);
				data.push(element.authCnt);
				backgroundColor.push(colors[idx]);
			});
			
			projectMemberRoleChartRender({
				"labels": labels
				, "data": data
				, "backgroundColor": backgroundColor
			});
		}
		
		// 상태 별 일감 차트
		function workStateChartRender(options) {
			new Chart(workStatusChart, {
				type: 'doughnut',
			    data: {
			        labels: options.labels
			        , datasets: [{
			        	label: '일감 상태 별 분류'
			        	, data: options.data
				        , backgroundColor: options.backgroundColor
			        	, hoverOffset: 4
			        }]
			    }
			});
		}
		
		// 상태 별 이슈 차트
		function issueStateChartRender(options){
			new Chart(issueStatusChart, {
			    type: 'doughnut',
			    data: {
			        labels: options.labels
			        , datasets: [{
				        label: '이슈 상태 별 분류'
				        , data: options.data
				        , backgroundColor: options.backgroundColor
				        , hoverOffset: 4
			        }]
			    }
			});
		}
		
		function projectStateChartRender(options) {
			new Chart(projectStatusChart, {
			    type: 'bar',
			    data: {
			        labels: options.labels
			        , datasets: [{
				        data: options.data
				        , backgroundColor: options.backgroundColor
				        , borderWidth : 2 // 막대 테두리 너비
				        , hoverOffset: 4
			        }]
			    },
			    options: {
			        legend: {
			            display: false
			        },
			        responsive: false,
			        scales: {
			            yAxes: [{
			                ticks: {
			                    min: 0
			                }
			            }]
			        }
			    }
			});
		}
		
		function memberStateChartRender(options){ 
			new Chart(memberStatusChart, {
			    type: 'horizontalBar',
			    data: {
			        labels: options.labels
			        , datasets: [{
				        data: options.data
				        , backgroundColor: options.backgroundColor
				        , borderWidth : 2 // 막대 테두리 너비
		            	, hoverOffset: 4
			        }]
			    },
			    options: {
			        legend: {
			            display: false
			        },
			        responsive: false,
			        scales: {
			            xAxes: [{
			                ticks: {
			                    min: 0
			                }
			            }]
			        }
			    }
			});
		}
		
		function projectMemberRoleChartRender(options) {
			new Chart(projectRoleStatusChart, {
			    type: 'bar',
			    data: {
			        labels: options.labels
			        , datasets: [{
				        data: options.data
				        , backgroundColor: options.backgroundColor
				        , borderWidth : 2 // 막대 테두리 너비
		            	, hoverOffset: 4
					}]
				},
			    options: {
			        legend: {
			            display: false
			        },
			        responsive: false,
			        scales: {
			            yAxes: [{
			                ticks: {
			                    min: 0
			                }
			            }]
			        }
			    }
			});
		}
  })

	$("ul.customdashboard-card").on("click", "li.customcard-item", function() {
		let type = $(this).data("type");
		let uri = null;
		switch(type){
			case "work":
				uri = "/admin/work/workList.do"
				break;
			case "completeWork":
				uri = "/admin/work/workList.do?workState=완료";
				break;
				 
			case "issue":
				uri = "/admin/issue/issueList.do";
				break;
				
			case "project":
				uri = "/admin/project/projectList.do?groupCode=P";
				break;
				 
			case "inProgressProject":
				uri ="/admin/project/projectList.do?code=2&groupCode=P";
				break;
				 
			default:
				console.log("invalid agrs");
				break;
		 }
		
		if(uri) {
			location.href = $.getContextPath() + uri;
		}
	});
  
	
	
  
	function getColor() {
		let color = Math.random() * 100;  // 0~ffffff 사이의 랜덤 색 만들기 결과는 10진수 실수
		color = parseInt(color); // 실수를 정수로 형변환
		color = color.toString(16); // 정수를 16진수 문자로 
		let colorCode = "#" + color; // 색상 코드로 변경
	
		return colorCode;
  	}
	
	
	
	

</script>