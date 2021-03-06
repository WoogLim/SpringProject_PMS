<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 2. 24.	임건		최초작성
* Copyright (c) 2021 by DDIT All right reserved
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="commithistory-container">
    <div class="container-header">
        <h2 class="container-title">
            커밋내역 차트
        </h2>
        <button class="svnactive-status no-drag">
            <img src="${pageContext.request.contextPath }/assets/img/dashboard/project-Active.svg" alt="">
            <span>SVN 연동중</span>
        </button>
    </div>

    <div class="chart-container">
        <div class="authorchart-container">
            <div class="charttype-verticalbar">
                <div class="chart-card">
                    <div class="scmchart-title">
                        <span>
                            저자별 커밋내역
                        </span>
                        <%-- 저자별 커밋내역 기간별 선택 --%>
                        <div class="selected-datetime">
                            <span class="start-alert">
                                시작일
                            </span>
                            <input type="date" class="start-datetime" onchange="logFilter();" value="${scmVO.userStartDate }">
                            <span class="end-alert">
                                종료일
                            </span>
                            <input type="date" class="end-datetime" onchange="logFilter();" value="${scmVO.userEndDate }">
                        </div>
                    </div>
                    <canvas id="authorcommitbar-chart"></canvas>
                </div>
            </div>

            <div class="charttype-bar">
                <div class="chart-card">
                        <div class="scmchart-title">
                            <span>
                                월별 총 커밋내역
                            </span>
                            <%-- 년도 선택 화면에 표시된 년도가 input태그 value에 적용됨 --%>
                            <div class="year-select">
                                <span class="select-title">
                                    선택 년도
                                </span>
                                <button class="previous-year" type="button">
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <input type="text" value="" class="commit-year">
                                <label for="" class="commitview-year"></label>
                                <button class="next-year" type="button">
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    <canvas id="authorcommitdonut-chart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<form:form id="logForm" modelAttribute="scmVO">
	<form:hidden path="userStartDate"/>
	<form:hidden path="userEndDate"/>
	<form:hidden path="year"/>
</form:form>
<script>
$(function(){
	
    //ex let today = new Date(2021,2,15) 2021년 2월 15일
    let today = new Date(); // 오늘 날짜
    let toyear = getformatYear(today);

    $('.commitview-year').text(toyear)
    $('.commit-year').val(toyear)
    
    <%-- 버튼 선택시 현재년도의 이전 년도 --%>
    $('.previous-year').click(function(){
        let currentyear =  $('.commitview-year').text();
        let previousyear = parseInt(currentyear)-1;
        $('.commitview-year').text(previousyear)
        $('.commit-year').val(previousyear)
    	$("#logForm").find("[name='year']").val(previousyear);
        logFilter();
    })
    
    <%-- 버튼 선택시 현재년도의 이후 년도 --%>
    $('.next-year').click(function(){
        let currentyear =  $('.commitview-year').text();
        let nextyear = parseInt(currentyear)+1;
        $('.commitview-year').text(nextyear)
        $('.commit-year').val(nextyear)
        $("#logForm").find("[name='year']").val(nextyear);
        logFilter();
    })

    const authorchartveritcalbar = document.getElementById("authorcommitbar-chart").getContext('2d');
    const authorchartbar =  document.getElementById("authorcommitdonut-chart").getContext('2d');
    // 그래프에 넣을 data
    let authorcommitdata = [];
    let authornames = [];
	<c:forEach items="${providerChartMap }" var="provider">
		authornames.push("${provider.key}");
		authorcommitdata.push(${provider.value});
    </c:forEach>

	let commitmonth = [];
    let commitcount = [];
	<c:forEach items="${monthChartMap }" var="monthChart">
		commitmonth.push("${monthChart.key}월");
		commitcount.push(${monthChart.value});
    </c:forEach>

    <%-- 저자별 커밋 내역  authorNames: 저자별 이름 commitCount: 저자별 커밋갯수--%>
    let authordata = {
        'commitCount' : authorcommitdata,
        'authorNames' : authornames
    };
    
    <%-- 월별 총 커밋  commitmonth: 월 commitcount: 월별 커밋갯수--%>
    let commitcountdata = {
        'commitMonth' : commitmonth,
        'commitCount' : commitcount
    };

    renderChart(authordata, commitcountdata);

    function renderChart(authordata, commitcountdata) {
        let charttypeVerticalBar = new Chart(authorchartveritcalbar, {
            type: 'horizontalBar',
            data: {
                labels: authordata.authorNames, // 하단 라벨

                datasets: [{
                    label: '커밋 갯수',
			        backgroundColor: "#5643ff", // 막대 배경색
			        borderColor: "#5643ff", // 막대 테두리 생상
                    data: authordata.commitCount, // data 입력값
                    xAxisId: "", // x축 ID
                    yAxisId: "", // y축 ID
                    borderWidth: 1, // 막대 테두리 너비
                    hoverBackgroundColor: 'rgba(0, 0, 0, 0.5)', // 마우스 올릴때 그래프 색
                    hoverBorderColor: 'rgba(0, 0, 0, 0.5)', // 마우스 올릴 때 테두리 컬러
                    
                }]
            },
            options:{                      
	            	scales:{
	                    xAxes:[{
	                        ticks:{
	                            min: 0,
	                        }
	                    }]
	                },
                    legend:{
                        position: "top",
                        align: "end"
                    }
            }
        });

        let charttypeBar = new Chart(authorchartbar, {
            type: 'bar',
            data: {
                labels: commitcountdata.commitMonth, // 하단 라벨

                datasets: [{
                    label: '커밋 갯수',
			        backgroundColor: ["#4422ff", "#4412ff", "#4402ff", "#4309ff", "#4319ff", "#4329ff", "#4339ff", "#4349ff", "#4359ff", "#4369ff", "#4379ff", "#4385ff"], // 막대 배경색
			        borderColor: ["#4422ff", "#4412ff", "#4402ff", "#4309ff", "#4319ff", "#4329ff", "#4339ff", "#4349ff", "#4359ff", "#4369ff", "#4379ff", "#4385ff"], // 막대 테두리 생상
                    data: commitcountdata.commitCount, // data 입력값
                    xAxisId: "", // x축 ID
                    yAxisId: "", // y축 ID
                    borderWidth: 1, // 막대 테두리 너비
                    hoverBackgroundColor: 'rgba(0, 0, 0, 0.5)', // 마우스 올릴때 그래프 색
                    hoverBorderColor: 'rgba(0, 0, 0, 0.5)', // 마우스 올릴 때 테두리 컬러
                    
                }]
            },
            options:{
	            legend:{
	                position: "top",
	                align: "end"
	            }
            }
        });
    }
});

function logFilter(){
	let startDate = $(".start-datetime").val();
	$("#logForm").find("[name='userStartDate']").val(startDate);
	
	let endDate = $(".end-datetime").val();
	$("#logForm").find("[name='userEndDate']").val(endDate);
	
	$("#logForm").submit();
}

// 날짜 포맷 YYYY
function getformatYear(date){
	let yearVal = "${scmVO.year}";
	console.log(yearVal);
    let year = (yearVal != null) && (yearVal.length>0) ? yearVal : date.getFullYear(); // YYYY
    console.log(year);
    return year;
}
</script>
</body>
</html>