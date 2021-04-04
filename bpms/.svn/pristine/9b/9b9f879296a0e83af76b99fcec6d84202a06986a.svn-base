/**
 * 
 */

const listBody = $('#listBody');
const pagingArea = $('#pagingArea');
const inputUI = $('#inputUI');

// pagingArea Decendent
pagingArea.on("click", "a", function(event) {
	event.preventDefault();
	let page = $(this).data("page");
	searchForm.find("input[name='page']").val(page);
	searchForm.submit();
	searchForm.find("input[name='page']").val("");
	return false;
});

// 검색어 입력 Trigger
$("#searchWord").on("keyup", function() {
	let searchType = inputUI.find(":input[name='searchType']").val();
	if(searchType != null && searchType.trim().length > 0) {
		$("#searchBtn").trigger("click");
	}
});

// searchBtn clickEvent
$("#searchBtn").on("click", function(){
	let inputs = inputUI.find(":input[name]");
	$(inputs).each(function(idx, element){
		let value = $(this).val();
		let name = $(this).attr("name");
		searchForm.find("[name='" + name + "']").val(value);
	});
	searchForm.submit();
});

// insertBtn clickEvent
$("#insertBtn").on("click", function(){
	location.href = $.getContextPath() + "/employee/employeeInsert.do"
});

// searchForm
let searchForm = $("#searchForm").ajaxForm({
	dataType : "json",
	success : function(resp) {
		console.log(resp);
		let dataList = resp.dataList;
		let trTags = [];
		$(dataList).each(function(idx, empVO){
			let tr = $("<tr>");
			trTags.push(
				$("<tr>").append(
					$("<td>").text(empVO.rnum)
					, $("<td>").text(empVO.employee_name)
					, $("<td>").text(empVO.employee_id)
					, $("<td>").text(empVO.employee_pwd)
					, $("<td>").text(empVO.employee_email)
					, $("<td>").text(empVO.employee_phone)
				)
			);
		});
		listBody.html(trTags);
		pagingArea.html(resp.pagingHTML);
	}	
}).submit();