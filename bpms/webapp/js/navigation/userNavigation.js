$(function(){
	let url = (window.location.href).split("/");
	let schedule = url[5];
	
	let currentUrl = url[4].trim();
	let chartUrl = url[5].trim();
	chartUrl = chartUrl.split("?")[0];
	// 프로젝트 설정, 구성원 설정 빠짐
	let chart = chartUrl.split(".")[0];
	
	if(currentUrl == "serverNotice"){
		$('.navpro-servernotice').addClass('active');
	}
	else if(currentUrl == "proNotice"){
		$('.navpro-pronotice').addClass('active');
	}
	else if(currentUrl == "scm"){
		$('.navpro-scm').addClass('active');
	}
	else if(currentUrl == "wiki"){
		$('.navpro-wiki').addClass('active');
	}
	else if(currentUrl == "workReport"){
		$('.navpro-report').addClass('active');
	}
	else if(currentUrl == "history"){
		$('.navpro-history').addClass('active');
	}
	else if(currentUrl == "work"){
		$('.navpro-workreport').addClass('active');
	}
	else if(currentUrl == "issue"){
		$('.navpro-issuereport').addClass('active');
	}
	else if(currentUrl == "projectstorage"){
		$('.navpro-storage').addClass('active');
	}
	else if(chart == "ganttList"){
		$('.navpro-gantt').addClass('active');
	}	
	else if(chart == "calendarList"){
		console.log("캘린더");
		$('.navpro-calendar').addClass('active');
	}
	else{
		return;
	}
})