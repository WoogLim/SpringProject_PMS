<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="storage-container">
	<div class="container-header">
		<h2 class="container-title">파일 보관함</h2>
	</div>

	<div class="storageinner-header">
		<ul class="storage-filter">
			<li class="storage-searchandload">
				<div class="storage-searchfilter">
					<div class="storagefilter-filecheck">
						<input type="checkbox" class="filechecker" onchange="storageAllcheck(this)" disabled>
					</div>
					<div class="fileselect-group">

						<div class="storage-download" onclick="checklistdownload();">
							<div class="storage-uplodabtn">내려받기</div>
						</div>
	
						<div class="fileselect-message">
	
							<span class="filesel-count"> </span>
							<button type="button" class="filesel-init"
								onclick="filecheckinit(event)">선택해제</button>
						</div>
					</div>
				</div>
			</li>
			<li class="storageuse-guide">
				<span class="useguide-text no-drag">
					프로젝트 문서함에서는 업로드가 불가능하며 내려받기만 가능합니다. 
				</span>
			</li>
		</ul>
	</div>

	<div class="storageinner-content" onclick="filecheckinit(event)">
		<ul class="storageitemlist fileview-grid" onclick="filecheckinit(event)">
			<li class="storageitem">
				<div class="filedownload-btn" data-code="3" data-group="B" onclick="showthisfolder(this, event)">
					<div class="filetype-icon">
						<i class="fas fa-folder"></i>
					</div>
					<div class="fileitem-info">
						<span class="fileitem-name">일감 관리</span>
					</div>
				</div>
			</li>
			<li class="storageitem">
				<div class="filedownload-btn" data-code="2" data-group="B" onclick="showthisfolder(this, event)">
					<div class="filetype-icon">
						<i class="fas fa-folder"></i>
					</div>
					<div class="fileitem-info">
						<span class="fileitem-name">이슈 관리</span>
					</div>
				</div>
			</li>
			<li class="storageitem">
				<div class="filedownload-btn" data-code="12" data-group="B" onclick="showthisfolder(this, event)">
					<div class="filetype-icon">
						<i class="fas fa-folder"></i>
					</div>
					<div class="fileitem-info">
						<span class="fileitem-name">업무 보고</span>
					</div>
				</div>
			</li>
			<li class="storageitem">
				<div class="filedownload-btn" data-code="7" data-group="B" onclick="showthisfolder(this, event)">
					<div class="filetype-icon">
						<i class="fas fa-folder"></i>
					</div>
					<div class="fileitem-info">
						<span class="fileitem-name">위키</span>
					</div>
				</div>
			</li>
			<li class="storageitem">
				<div class="filedownload-btn" data-code="1" data-group="B" onclick="showthisfolder(this, event)">
					<div class="filetype-icon">
						<i class="fas fa-folder"></i>
					</div>
					<div class="fileitem-info">
						<span class="fileitem-name">공지</span>
					</div>
					<%-- <button type="button" class="checkthis-file"
						data-url="http://download.com" onclick="downloadlist(this)"
						onmouseover="listaddOver(this)" onmouseout="listaddOut(this)">
						<div class="filecheck-inner">
							<i class="fas fa-check"></i>
						</div>
					</button>
					<button type="button" class="uncheckthis-file"
						data-url="http://download.com" onclick="uncheckDownloadlist(this)">
						<div class="filecheck-inner">
							<i class="fas fa-check"></i>
						</div>
					</button> --%>
				</div>
			</li>
		</ul>
		
		<ul class="storagefilelist fileview-grid" onclick="filecheckinit(event)">
		</ul>
	</div>
</div>


<form action="" class="downloadfilelistform">

</form>

<form action="" class="singlefiledownloadform">
	<a href="" class="singledownloadtag"> </a>
</form>

<script type="text/javascript">
$(function () {
    $('.loader-container').fadeOut()
})

function storageAllcheck(input){
    if($(input).prop('checked')){
		let target = $('.uncheckthis-file').children('.filecheck-inner');
		let list = $('.storagefilelist').children('.storageitem');
		let cnt = 0;
		
        $(target).each(function(index, item){
		    if(!$(target[index]).hasClass('checkedfile')){
		    	$(this).parent('.uncheckthis-file').siblings('.checkthis-file').click();
		    }else{
		    	cnt++;
		    }
        })
        
        if(cnt == list.length){
        	$('.checkthis-file').click();
        }
    }else{
        $('.uncheckthis-file').click();
        $('.filedownload-btn').mouseout();
        
// 		let target = $('.uncheckthis-file').children('.filecheck-inner');
//         $(target).each(function(index, item){
// 		    if(!$(target[index]).hasClass('checkedfile')){
// 		    	$(this).parent('.uncheckthis-file').siblings('.checkthis-file').click();
// 		    }
//         })
    }
}

function showcheck(input) {
    $(input).children('.checkthis-file').show();
};

function hidecheck(input) {
    $(input).children('.checkthis-file').hide();
};

function listaddOver(input) {
    $(input).children('.filecheck-inner').css("background", "#9bc6ff")
}

function listaddOut(input) {
    $(input).children('.filecheck-inner').css("background", "#bdbdbd")
}

function filecheckinit(e){
    if($(e.target).hasClass('storageinner-content') || $(e.target).hasClass('storageitemlist') || $(e.target).hasClass('filesel-init')){
        $('.uncheckthis-file').hide();
        $('.checkthis-file').hide();
        $('.filetype-icon').removeClass('checked-thisfile');
        $('.downloadfilelistform').children().remove();
    	$('.filechecker').prop("checked",false);

        uploadtype();
    }
}

// 다운로드 폼에 추가 할때
function downloadlist(input) {
    let url = $(input).data("url");

    let urltemplate = filedownURLItem(url);
    $(urltemplate).text(url);
    $('.downloadfilelistform').append(urltemplate);

    $(input).siblings('.filetype-icon').addClass('checked-thisfile');
    $(input).siblings('.uncheckthis-file').children('.filecheck-inner').addClass('checkedfile');
    $(input).siblings('.uncheckthis-file').css("display","flex");
    $(input).hide();

    uploadtype();
}

// 다운로드 폼에서 삭제할 때
function uncheckDownloadlist(input) {
    let url = $(input).data("url");

    $('.downloadfilelistform').children('a[href=' + '"' + url + '"' + ']').remove();

    $(input).siblings('.filetype-icon').removeClass('checked-thisfile');
    $(input).siblings('.checkthis-file').css("display","flex");
    $(input).hide();

    uploadtype();
}

function uploadtype() {
    let urlLength = $('.downloadfilelistform').children('a');
    if (urlLength.length > 0) {
        $('.storage-download').css("display", "inline-flex");
        $('.storage-delete').css("display", "inline-flex");
        $('.storage-upload').hide();
        $('.filesel-count').text(urlLength.length)
        $('.fileselect-message').css("display", "flex");
    } else {
        $('.storage-upload').css("display", "inline-flex");
        $('.storage-delete').hide();
        $('.storage-download').hide();
        $('.fileselect-message').hide();
    }
}

function filedownURLItem(url) {
    let template = $('<a href="" class="donwloadURL"></a>')
    $(template).attr('href', url);
    return template;
}

function showthisfolder(input, e){
	let code = $(input).data("code");
	let group = $(input).data("group");
	let param = `${param.proId }`
	let data = null;
	
	$.ajax({
   		url: '${pageContext.request.contextPath}/storage/storageViewFiles.do',
   		type: 'POST',
   		aysnc: false,
   		data: {"proId":param,
   			   "typeCode":code,
   			   "groupCode":group},
   		dataType: 'json',
   		success : function(resp){
   			$('.filechecker').prop("disabled",false);
   			$('.storageitemlist').hide();
   			$('.storagefilelist').children().remove();
   			$('.storagefilelist').show();
   			
   			let previoustemplate = previousbtn();
   			$('.storagefilelist').append(previoustemplate);
   			
			data = resp.projectFiles.attatchList;
			
			$(data).each(function(index, item){
				let template = fileTemplate(data[index]);
	   			$('.storagefilelist').append(template);
			})
			
			let selectUrl = $('.downloadfilelistform').children("a");
			
			$(selectUrl).each(function(index, item){
				let url = $(selectUrl[index]).attr("href");
				let target = $('.storagefilelist').children('.storageitem').children('div[data-url='+'"'+url+'"'+']');
				
				$(target).children('.filetype-icon').addClass('checked-thisfile');
			    $(target).children('.uncheckthis-file').children('.filecheck-inner').addClass('checkedfile');
			    $(target).children('.uncheckthis-file').css("display","flex");
			    $(target).children('.checkthis-file').hide();
			})
		    uploadtype();
			
			
   		},
   		error : function(error){
   			console.log(error)
   		}
   	})	
}

function showperviousfolder(){
	$('.filechecker').prop("checked",false);
	$('.filechecker').prop("disabled",true);
	$('.storagefilelist').hide();
	$('.storageitemlist').show();
}

function previousbtn(){
	let template = $(' <li class="previousfolder"> <div class="filedownload-btn" onclick="showperviousfolder()"> <div class="filetype-icon"> <i class="far fa-folder-open"></i> </div> <div class="fileitem-info"> <span class="fileitem-name">이전으로</span> </div> </div> </li>')

	return template;
}

function fileTemplate(att){
	let template = $('<li class="storageitem"> <div class="filedownload-btn" onmouseover="showcheck(this)" onmouseout="hidecheck(this)" onclick="singlefileDownload(this, event)"> <div class="filetype-icon"> </div> <div class="fileitem-info"> <span class="fileitem-name"></span><span class="fileitem-size"></span> </div> <button type="button" class="checkthis-file" onclick="downloadlist(this)" onmouseover="listaddOver(this)" onmouseout="listaddOut(this)"> <div class="filecheck-inner"> <i class="fas fa-check"></i> </div> </button> <button type="button" class="uncheckthis-file" onclick="uncheckDownloadlist(this)"> <div class="filecheck-inner"> <i class="fas fa-check"></i> </div> </button> </div> </li>')
	
	$(template).children('.filedownload-btn').attr("data-url",'http://localhost'+'${pageContext.request.contextPath}/board/download.do?'+'attNo='+att.attNo);
	$(template).children('.filedownload-btn').children('.fileitem-info').children('.fileitem-name').text(att.attOriginname);
	$(template).children('.filedownload-btn').children('.fileitem-info').children('.fileitem-size').text(att.attFancy);
	$(template).children('.filedownload-btn').children('.checkthis-file').attr("data-url",'http://localhost'+'${pageContext.request.contextPath}/board/download.do?'+'attNo='+att.attNo);
	$(template).children('.filedownload-btn').children('.uncheckthis-file').attr("data-url",'http://localhost'+'${pageContext.request.contextPath}/board/download.do?'+'attNo='+att.attNo);
	
	let mimeType = (att.attMime).split("/");
	
	let imageTemplate = $('<img>');
	
	if(mimeType[0] == "image"){
		$(imageTemplate).attr("src","${pageContext.request.contextPath }/assets/img/boardFiles/"+att.attSavename);
		$(template).children('.filedownload-btn').children('.filetype-icon').append(imageTemplate);
	}else if(mimeType[1] == "pdf"){
		$(template).children('.filedownload-btn').children('.filetype-icon').addClass('filetype-pdf')
		$(template).children('.filedownload-btn').children('.filetype-icon').append($('<i class="fas fa-file-pdf"></i>'))
	}else if(mimeType[1] == "doc" || mimeType[1] == "hwp"){
		$(template).children('.filedownload-btn').children('.filetype-icon').addClass('filetype-doc')
		$(template).children('.filedownload-btn').children('.filetype-icon').append($('<i class="fas fa-file-word"></i>'))
	}else if(mimeType[1] == "csv" || mimeType[1] == "xlsx"){
		$(template).children('.filedownload-btn').children('.filetype-icon').addClass('filetype-csv')
		$(template).children('.filedownload-btn').children('.filetype-icon').append($('<i class="fas fa-file-excel"></i>'))
	}else if(mimeType[1] == "pptx" || mimeType[1] == "ppt"){
		$(template).children('.filedownload-btn').children('.filetype-icon').addClass('filetype-ppt')
		$(template).children('.filedownload-btn').children('.filetype-icon').append($('<i class="fas fa-file-powerpoint"></i>'))
	}else{
		$(template).children('.filedownload-btn').children('.filetype-icon').append($('<i class="fas fa-file-alt"></i>'))
	}
	
	return template;
}

// 파일 다운로드
function singlefileDownload(input, e){
	let target = $(e.target);
	if(target.hasClass('fa-check') || target.hasClass('filecheck-inner') || target.hasClass('checkedfile') || target.hasClass('checkthis-file') || target.hasClass('uncheckthis-file')){
		return;
	}
	let url = $(input).data("url");
	$('.singledownloadtag').attr("href",url);
	$('.singledownloadtag').get(0).click();
}

function checklistdownload(){
	let downloadlist = $('.downloadfilelistform').children('a');
	$('.downloadfilelistform').children('a').remove();

	$('.uncheckthis-file').click();
	$('.filedownload-btn').mouseout();
	$('.filechecker').prop("checked",false);
    
	$(downloadlist).each(function(index, item){
		let downloaditem = downloadlist[index];
	    downloaditem.click();
        fnSleep(500); //각 파일별 시간 텀을 준다
	})
	uploadtype();
}

fnSleep = function (delay){
    
    let start = new Date().getTime();
    while (start + delay > new Date().getTime());

};
</script>
