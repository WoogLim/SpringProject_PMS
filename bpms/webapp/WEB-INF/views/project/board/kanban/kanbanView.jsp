<%--
* [[개정이력(Modification Information)]]
* 수정일         		수정자    	 	수정내용
* ----------    -------- -----------------
* 2021. 2. 15.	임건			최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="page-kanban">
	<div class="page-inner" style="margin: 0 !important; padding:0 !important">
		<span class="project-path"> <a href="#">마이페이지</a> <a
			href="#">마이 칸반</a>
		</span>
	
		<div class="service__header">
			<h2>마이 보드</h2>
		</div>
	
		<div class="kanban__container">
			<div class="kanbanlist">
				<c:set value="${kanbanList }" var="boardList" />
					<c:if test="${not empty boardList}">
						<c:forEach items="${boardList }" var="project">
							<div class="list" data-culumns="kanbanlist" data-kboardId="${project.kboardId }">
							    <header class="no-drag listboard-title">
							       	${project.kboardTitle }
							    </header>
							
							    <div class="write__sticker">
							        <form method="post" class="writesticker-form" id="">
							        	<input type="hidden" class="parentboardId" name="kboardId" value="">
							        	
							            <header>제목</header>
							            <input type="text" name="kstickerTitle" class="form-stickerinput" required>
							            <header>설명</header>
							            <textarea class="form-textarea" name="kstickerContent" id="" cols="30" rows="10" required></textarea>
							            <input type="hidden" name="kstickerSort" class="ksticker-sort">
							            <div class="write__stickerbtn">
							                <button type="button" class="stickerwrite__submit" onclick="stickerwriteajax(this)">
							                    <i class="fas fa-check"></i>
							                </button>
							                <button type="button" class="stickerwrite__cancle" onclick="stickerhide(this)">
							                    <i class="fas fa-times"></i>
							                </button>
							            </div>
							        </form>
							    </div>
							    
							    <c:set value="${project.stickerList }" var="stickerList" />
						    		<c:forEach items="${stickerList }" var="sticker">
						    			<c:if test="${not empty sticker.kstickerId }">
											<div class="item-container" draggable="true">
	                                            <div class="list-item" onclick="stickermask(this)" data-kstickerid="${sticker.kstickerId}">
	                                                <div class="sticker__title">
	                                                       <span class="sticker-title">
	                                                            ${sticker.kstickerTitle }
	                                                       </span>
	                                                </div>
	                                                <div class="sticker__id">
	                                                    <i class="fas fa-pen-square"></i>
	                                                    <p class="sticker__name">${sticker.kstickerSort }
	                                                    </p>
	                                                </div>
	                                            </div>
	                                        </div>
							    		</c:if>
						    		</c:forEach>
						    	

							    <div class="column__settingbtn">
							        <button class="kanban__sticker-add" onclick="stickeradd(this);">
							            <i class="fas fa-edit"></i>
							        </button>
							        <button type="button" class="kanban__category-remove" onclick="kanbanboardRemove(this);" data-kboardId="${project.kboardId }" data-toggle="modal" data-target="#category__remove">
							            <i class="far fa-trash-alt"></i>
							        </button>
							    </div>
							</div>
						</c:forEach>
					</c:if>
			
				<div class="kanban__column-add">
					<i class="far fa-plus-square column__addicon"></i>
					<div class="column__addinput">
						<form action="" class="boardSubmit" onsubmit="return false;">
							<input type="text" name="kboardTitle" class="form-control" placeholder="보드 이름"
								required>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="sticker-mask">
        <div class="stickerinner-container">
            <div class="sticker-over" onclick="viewstickerOver(this)"></div>
            <div class="sticker-inner">
                <div class="sticker-content">
                    <ul class="stickerinner-content">
                        <li class="sticker-header">
                            <div class="stickerinner-icon">
                                <i class="fas fa-bookmark"></i>
                            </div>
                            <div class="stickerinner-titlename">
                                <div class="stickerinner-title">
                                    <span class="stickername">
                                    </span>
                                    <input type="text" name="kstickerTitle" class="stickerupdate-input">
                                    <button class="close-stickerinner" onclick="stickerinner();">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                                <span class="stickerfrom-board">
                                </span>
                            </div>
                        </li>

                        <li class="stickerinner-notice">

                            <div class="stickermain-content">
                            </div>
                            <textarea name="kstickerContent" class="stickerupdate-content"></textarea>
                        </li>

                        <li class="stickerwrite-info">
                        	<div class="sticker-dategroup">
	                            <span class="stikcerupdate-date">
	                            </span>
	                            <span class="stikcerupdate-current">
	                            </span>
                            </div>
                            <div class="stickersetting-btngroup">
	                    		<button class="stickersetting-update" onclick="stickerUpdateForm();">
	                    			수정
	                    		</button>
	                    		<button class="stickersetting-remove" onclick="stickerDelete(this);">
	                    			삭제
	                    		</button>
                            </div>
                            <div class="stickersetter-btngroup">
	                    		<button class="stickersetting-updatebtn sticker-updatebtn" onclick="stickerUpdate(this);">
	                    			수정
	                    		</button>
	                    		<button class="stickersetting-updatebtn sticker-cancelbtn" onclick="stickerUpdateCancel();">
	                    			취소
	                    		</button>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 카테고리 삭제 모달 -->
	<div class="modal fade customModal" id="category__remove">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-body">
	
					<div class="modal__header">카테고리 삭제</div>
	
					<div class="setting__roleSet">
	
						<span class="remove__category"></span>
	
						<div class="remove__categoryname"></div>
					</div>
	
					<div class="form-groupbtn">
						<button type="button" class="form-cancel" data-toggle="modal"
							data-target="#category__remove">취소</button>
						<button type="button" class="form-confirm" data-toggle="modal"
							data-target="#category__remove" onclick="removeboard(this);">제거</button>
					</div>
	
				</div>
			</div>
		</div>
	</div>
</div>

<div class="list listitem d-none" data-culumns="kanbanlist">
    <header class="no-drag listboard-title">
    </header>

    <div class="write__sticker">
        <form method="post" id="" class="writesticker-form">
            <input type="hidden" class="parentboardId" name="kboardId" value="">

            <header>제목</header>
            <input type="text" name="kstickerTitle" class="form-stickerinput" required>
            <header>설명</header>
            <textarea class="form-textarea" name="kstickerContent" id="" cols="30" rows="10" required></textarea>
            <input type="hidden" name="kstickerSort" class="ksticker-sort">
            <div class="write__stickerbtn">
                <button type="button" class="stickerwrite__submit" onclick="stickerwriteajax(this);">
                    <i class="fas fa-check"></i>
                </button>
                <button type="button" class="stickerwrite__cancle" onclick="stickerhide(this);">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="column__settingbtn">
        <button class="kanban__sticker-add" onclick="stickeradd(this);">
            <i class="fas fa-edit"></i>
        </button>
        <button type="button" class="kanban__category-remove" onclick="kanbanboardRemove(this);" data-toggle="modal" data-target="#category__remove">
            <i class="far fa-trash-alt"></i>
        </button>
    </div>
</div>	
	
<div class="item-container d-none sticker-item" draggable="true">
    <div class="list-item" onclick="stickermask(this)">
        <div class="sticker__title">
               <span class="sticker-title">
               
               </span>
        </div>
        <div class="sticker__id">
            <i class="fas fa-pen-square"></i>
            <p class="sticker__name">
            
            </p>
        </div>
    </div>
</div>
<script>

$(function(){
	
	   const list_items = document.querySelectorAll('.item-container');
       const lists = document.querySelectorAll('.list');

       let draggedItem = null;

       for (let i = 0; i < list_items.length; i++) {
           const item = list_items[i];

           item.addEventListener('dragstart', function () {
               draggedItem = item;
               // 3ms초 이후 함수가 실행되므로 그전에 none 처리
               setTimeout(function () {
                   item.style.display = 'none';
               }, 0)
           });

           item.addEventListener('dragend', function () {
               setTimeout(function () {
                   draggedItem.style.display = 'block';
                   draggedItem = null;
               }, 0);
           })
       }
       
       for (let j = 0; j < lists.length; j++) {
           const list = lists[j];

           list.addEventListener('dragover', function (e) {
               e.preventDefault();
           });

           list.addEventListener('dragenter', function (e) {
               e.preventDefault();
           });

           list.addEventListener('dragleave', function (e) {
               e.preventDefault();
           });

           list.addEventListener('drop', function (e) {
               e.preventDefault();
               if ($(draggedItem).hasClass('item-container')) {
                   this.append(draggedItem);
               }
           });
       }

       $('.kanban__column-add').click(function () {
           $('.kanbanlist').addClass('coulumnadd__active')
           $('.column__addinput').css({
               "display": "block"
           })
           $('.column__addicon').css({
               "display": "none"
           })
           $(this).find('.form-control').focus();
       })
       $('body').click(function (e) {
           if (!$(e.target).hasClass('column__addicon') && !$(e.target).hasClass('column__addinput') && !$(e
                   .target).hasClass('form-control')) {
               $('.column__addinput').css({
                   "display": "none"
               })
               $('.column__addicon').css({
                   "display": "block"
               })
           }
       })
       
       var submitAction = function() {
	   	    return false;
	   };
	   
	   $('.boardSubmit').bind('submit', submitAction, function(){
		    let template = boardTemplate();
		    let title = $(this).serialize();
		    console.log(title);
		    
		    $.ajax({
	       		url: '${pageContext.request.contextPath}/kanban/boardInsert',
	       		type: 'POST',
	       		data: title,
	       		dataType: 'json',
	       		async: false,
	       		success : function(resp){
	       			template.attr("data-kboardid",resp.boarditem[0].kboardId);
	       			template.children('.column__settingbtn').children('.kanban__category-remove').attr("data-kboardid",resp.boarditem[0].kboardId);
	       			template.children('.listboard-title').text(resp.boarditem[0].kboardTitle);
	    	   		$('.kanban__column-add').before(template);
	    	   		$('.boardSubmit').children('.form-control').val(null);
	    	   		$('.column__addinput').hide();
	       		},
	       		error : function(error){
	       			console.log('에러 발생')
	       		}
	       	})
	   });
	})
       
    String.prototype.IsNullOrEmpty = function () {
    var arg = arguments[0] === undefined ? this.toString() : arguments[0];
    	if (arg === undefined || arg === null || arg === "") { return true; }
	    else { 
	        if (typeof (arg) != "string") { throw "Property or Arguments was not 'String' Types"; }
	        return false; 
	    }
	};   
       
    function stickerwriteajax(input){
    let template = stickerTemplate();
   	// 스티커 생성시 폼 
   	let parentboardid = $(input).parent().parent().parent().parent('.list').data('kboardid');
   	$(input).parent().siblings('.parentboardId').val(parentboardid);
   	let thisform = input.parentNode.parentNode;
   	let addstickerAdd = $(input).parent().parent().parent('.write__sticker');
   	
   	let formdata = $(thisform).serialize()
   	
   	let id = $(thisform).children('.form-stickerinput').val();
   	let board = $(thisform).children('.form-textarea').val();

	console.log(template);
	console.log(formdata);
   	if(!id.IsNullOrEmpty() && !board.IsNullOrEmpty()){
	   	$.ajax({
	   		url: '${pageContext.request.contextPath}/kanban/stickerInsert',
	   		type: 'POST',
	   		data: formdata,
	   		dataType: 'json',
	   		aysnc: false,
	   		success : function(resp){
	   			console.log(resp);
	   			template.children('.list-item').attr("data-kstickerid",resp.stickeritem[0].kstickerId);
	   			template.children().children('.sticker__title').children('.sticker-title').text(resp.stickeritem[0].kstickerTitle);
	   			$(input).parent().parent().parent('.write__sticker').after(template);
	   			dragrender();
	   		},
	   		error : function(error){
	   			console.log('에러 발생')
	   		}
	   	})
   	}else{
   		swal("에러!", "제목 혹은 내용을 입력해주세요!", "error")
   	}
   	
	
   	$(thisform).children('.ksticker-sort').val(null)
   	$(thisform).children('.parentboardId').val(null)
   	$(thisform).children('.form-stickerinput').val(null)
   	$(thisform).children('.form-textarea').val(null)
   	addstickerAdd.hide();
	}

    function stickerinner(){
    	$('.sticker-mask').hide();
	}
       
    function stickermask(input){
    	let kboardTitle = $(input).parent().siblings('.listboard-title').text();
   		let kstickerId = $(input).data('kstickerid');
		$('.stickername').text('');
		$('.stickerfrom-board').text('')
		$('.stickermain-content').text('');
		$('.stikcerupdate-date').text('');
		$('.stikcerupdate-current').text('');
   		
   		console.log(kboardTitle);
   		$.ajax({
	   		url: '${pageContext.request.contextPath}/kanban/stickerView',
	   		type: 'POST',
	   		data: {"kstickerId":kstickerId},
	   		dataType: 'json',
	   		aysnc: false,
	   		success : function(resp){
	   			$('.stickername').text(resp.stickerInfo.kstickerTitle);
	   			$('.stickerfrom-board').text(kboardTitle)
	   			$('.stickermain-content').text(resp.stickerInfo.kstickerContent);
	   			$('.stikcerupdate-date').text(" : " + resp.stickerInfo.createDate);
	   			$('.stikcerupdate-current').text(resp.stickerInfo.modifyDate + " 수정됨");
	   			$('.stickersetting-remove').attr("data-kstickerid", resp.stickerInfo.kstickerId);
	   			$('.stickersetting-updatebtn').attr("data-kstickerid", resp.stickerInfo.kstickerId);
	   		},
	   		error : function(error){
	   			console.log('에러 발생')
	   		}
	   	})
   		$('.sticker-mask').show();
   		
	}
       
    function stickerDelete(input){
   		let kstickerId = $(input).data('kstickerid');
   		console.log(kstickerId);

   		$.ajax({
	   		url: '${pageContext.request.contextPath}/kanban/stickerDelete',
	   		type: 'POST',
	   		aysnc: false,
	   		data: {"kstickerId":kstickerId},
	   		dataType: 'text',
	   		success : function(resp){
	   			if(resp.trim() == "OK"){
	   				swal("삭제완료", "해당 스티커가 제거되었습니다.", "success")
	   			}else{
	   				swal("에러", "해당 스티커가 제거되지않았습니다.", "error")
	   			}
	   			$('.list-item[data-kstickerid='+kstickerId+']').parent().remove();
	   		},
	   		error : function(error){
	   			console.log(error)
	   		}
	   	})
   		$('.sticker-mask').hide();
    }

    function stickerUpdate(input){
    	let kstickerId = $(input).data('kstickerid');
    	
    	let updatetitle = $('.stickerupdate-input').val();
    	let updatecontent = $('.stickerupdate-content').val();
    	
   		$.ajax({
	   		url: '${pageContext.request.contextPath}/kanban/stickerUpdate',
	   		type: 'POST',
	   		aysnc: false,
	   		data: {"kstickerId":kstickerId,
	   			   "kstickerTitle":updatetitle,
	   			   "kstickerContent":updatecontent},
	   		dataType: 'json',
	   		success : function(resp){
				console.log(resp);
				console.log(resp.stickeritem[0].kstickerId);
	   			$('.list-item[data-kstickerid='+resp.stickeritem[0].kstickerId+']').children('.sticker__title').text(resp.stickeritem[0].kstickerTitle)
	   		},
	   		error : function(error){
	   			console.log(error)
	   		}
	   	})
	   	stickerUpdateCancel();
   		$('.sticker-mask').hide();
    }
    
    function removeboard(input){
    	let kboardid = $(input).data('kboardid');
    	
    	$.ajax({
	   		url: '${pageContext.request.contextPath}/kanban/boardDelete',
	   		type: 'POST',
	   		aysnc: false,
	   		data: {"kboardId":kboardid},
	   		dataType: 'text',
	   		success : function(resp){
				console.log(resp);
				$('.list[data-kboardid='+'"'+kboardid+'"'+']').remove();
	   		},
	   		error : function(error){
	   			console.log(error)
	   		}
	   	})
    }
    
    function stickerUpdateForm(){
    	$('.stickersetting-update').hide();
    	$('.stickersetting-remove').hide();
    	$('.stickerupdate-input').val($('.stickername').text());
    	$('.stickerupdate-content').val($('.stickermain-content').text());
    	$('.stickerupdate-input').show();
    	$('.stickerupdate-content').show();
    	$('.stickersetter-btngroup').css('display','flex');
    	$('.stickersetter-btngroup').show();
    }
    
    function stickerUpdateCancel(){
    	$('.stickersetting-updatebtn').show();
    	$('.stickerupdate-input').hide();
    	$('.stickerupdate-content').hide();
    	$('.stickersetter-btngroup').css('display','none');
    	$('.stickersetter-btngroup').hide();
    	$('.stickersetting-update').show();
    	$('.stickersetting-remove').show();
    }
    
    function kanbanboardRemove(input){
        let categorynumber = $(input).data('kboardid');
        let categoryname = $(input).parents('.list').children('header').text().trim();
        
        $('.remove__categoryname').text('카테고리 제목 :' + categoryname);
        $('.form-confirm').attr("data-kboardid",categorynumber);
    }
    
    function stickeradd(input){
	   	let addstickerAdd = $(input).parents().siblings('.write__sticker');
	   	
	   	addstickerAdd.children().find('.form-stickerinput').val('')
	   	addstickerAdd.children().find('.form-textarea').val('')
	   	
        addstickerAdd.show();
	}
	
	function stickerhide(input){
       	let addstikercancle = $(input).parent().parent().parent('.write__sticker')
       	
        addstikercancle.hide();
	}
	
	function viewstickerOver(){
        $('.sticker-mask').hide();
	}

	function boardTemplate(){
		let template = $('.listitem').clone();
		template.removeClass('d-none');
		template.removeClass('listitem');
		return template;
	}
	
	function stickerTemplate(){
		let template = $('.sticker-item').clone();		
		template.removeClass('d-none');
		template.removeClass('sticker-item');
	    console.log(template);
		return template;
	}
	
	function dragrender(){
		   let list_items = document.querySelectorAll('.item-container');
	       let lists = document.querySelectorAll('.list');

	       let draggedItem = null;

	       for (let i = 0; i < list_items.length; i++) {
	           const item = list_items[i];

	           item.addEventListener('dragstart', function () {
	               draggedItem = item;
	               // 3ms초 이후 함수가 실행되므로 그전에 none 처리
	               setTimeout(function () {
	                   item.style.display = 'none';
	               }, 0)
	           });

	           item.addEventListener('dragend', function () {
	               setTimeout(function () {
	                   draggedItem.style.display = 'block';
	                   draggedItem = null;
	               }, 0);
	           })
	       }
	       
	       for (let j = 0; j < lists.length; j++) {
	           const list = lists[j];

	           list.addEventListener('dragover', function (e) {
	               e.preventDefault();
	           });

	           list.addEventListener('dragenter', function (e) {
	               e.preventDefault();
	           });

	           list.addEventListener('dragleave', function (e) {
	               e.preventDefault();
	           });

	           list.addEventListener('drop', function (e) {
	               e.preventDefault();
	               if ($(draggedItem).hasClass('item-container')) {
	                   this.append(draggedItem);
	               }
	           });
	       }
	}
   </script>
       
       	
</body>
</html>