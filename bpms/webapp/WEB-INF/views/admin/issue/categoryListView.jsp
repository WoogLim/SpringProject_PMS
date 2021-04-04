<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  -------- -----------------
* 2021. 1. 28.	임건		최초작성
* 2021. 2. 05.  임건		유형 모달 추가
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="panel-header">
	<div class="page-inner">
		<span class="project-path"> 
			<a href="#">이슈관리</a> 
			<a href="#"> 이슈 유형</a>
		</span>

		<div class="setting__header">
			<h2>이슈 유형</h2>
			<div class="role__add">
				<button type="button" class="role__newrolebtn custom-initbtn" data-toggle="modal" data-target="#setting-status">
					<i class="fas fa-plus-circle"></i>
					새 유형
				</button>
			</div>
		</div>

		<div class="role__card">
			<div class="card__row">
				<ul class="role__title row">
					<li class="col-4">등록된 유형</li>
				</ul>

				<%-- role__item <ui> </ul> 태그가 생성한 역할 1개
                                    <span class="set__role-name"> 권한이름 </span> 이 권한이름
                                    아이콘 색상 role__icon 태그에 클래스로 추가해주면됨.
                                    [종류]
                                    .role__color-orange, .role__color-yellow, .role__color-lightgreen .role__color-green
                                    .role__color-figment, .role__color-lightblue, .role__color-blue
                                    .role__color-lightpurple, .role__color-purple .role__color-lightpink
                                    .role__color-pink, .role__color-lightred, .role__color-red
                --%>
				<c:if test="${not empty categoryList }">
					<c:forEach items="${categoryList }" var="customInfoVO">
						<ul class="role__item row">
							<li class="role__rule col-4" data-no="${customInfoVO.customNo }" data-code="${customInfoVO.code }">
								<span class="custom-iconbox" style="background-color: ${customInfoVO.backgroundColor}">
									<span class="custom-icon" style="color: ${customInfoVO.iconColor}">
										<i class="${customInfoVO.iconClass }"></i>
									</span>
									<span class="custom-text" style="color: ${customInfoVO.textColor}">${customInfoVO.text }</span>
								</span>
							</li>
							<li class="role__itembtn-box col-4">
								<button class="role__itembtn" data-toggle="modal"
									data-target="#setting-status" id="modifyBtn">
									<i class="fas fa-wrench"></i>
									수정
								</button>
								<button class="role__itembtn" data-toggle="modal"
									data-target="#set__roleRemove" onclick="setrole($(this));">
									<i class="fas fa-trash"></i>
									제거
								</button>
							</li>
						</ul>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>

<!-- 삭제 모달 -->
<div class="modal fade" id="set__roleRemove">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-body">

				<div class="modal__header">이슈유형 삭제</div>
				<form action="${pageContext.request.contextPath }/admin/issue/customInfoDelete.do" method="post" id="removeForm">
					<input type="hidden" name="code">
					<input type="hidden" name="customNo">
					<input type="hidden" name="text">
					<input type='hidden' name="groupCode" value="IT">
					
					<div class="setting__roleSet">
						<span class="copy__rolename">삭제할 유형 : </span>
						<div class="set__role"></div>
					</div>
				
					<div class="form-groupbtn">
						<button type="button" class="form-cancel" data-toggle="modal"
							data-target="#set__roleRemove">취소</button>
						<button type="button" class="form-confirm" id="removeBtnInModal">제거</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
</div>

<%-- 
	수정일 : 2021-02-05
	작성자 : 임건
	설   명 : 유형 추가 모달
--%>
<div class="modal fade" id="setting-status" class="custom-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">

                <div class="common-madalheader mb-5 no-drag">
                    이슈 유형 추가
                </div>
				<form id="customForm" action="${pageContext.request.contextPath }/admin/issue/customInfoInsert.do" method="post">
					<%-- CustomInfoVO HiddenTag --%>
					<input type="hidden" name="customNo">
					<input type="hidden" name="text">
					<input type="hidden" name="groupCode" value="IT">
					<input type="hidden" name="iconClass">
					<input type="hidden" name="textColor">
					<input type="hidden" name="iconColor">
					<input type="hidden" name="backgroundColor">
					
					<%-- CodeVO HiddenTag (code: selectKey, createDate: SYSDATE --%>
					<input type="hidden" name="groupName" value="이슈 유형">
					<input type="hidden" name="codeName">
					<input type="hidden" name="code">
					
	                <div class="common-modalcontent">
	                    
	                    <label for="common-statusname" class="common-label no-drag">이름</label>
	                    <input type="text" class="common-text" id="common-statusname" maxlength="6">
	                    <span class="errors" id="textSpan"></span>
	
	                    <label class="common-label mt-4 no-drag" for="">아이콘</label>
	
	                    <div class="common-iconselect mb-4">
	                        <label for="icon-style1" class="common-iconlabel"><i class="fas fa-bug"></i></label>
	                        <input type="radio" name="icon" id="icon-style1" class="common-iconbtn" value="fas fa-bug" onchange="iconselect(this)">
	
	                        <label for="icon-style2" class="common-iconlabel"><i class="fab fa-stack-overflow"></i></label>
	                        <input type="radio" name="icon" id="icon-style2" class="common-iconbtn" value="fab fa-stack-overflow" onchange="iconselect(this)">
	
	                        <label for="icon-style3" class="common-iconlabel"><i class="fas fa-code"></i></label>
	                        <input type="radio" name="icon" id="icon-style3" class="common-iconbtn" value="fas fa-code" onchange="iconselect(this)">
	
	                        <label for="icon-style4" class="common-iconlabel"><i class="fas fa-exclamation-circle"></i></label>
	                        <input type="radio" name="icon" id="icon-style4" class="common-iconbtn" value="fas fa-exclamation-circle" onchange="iconselect(this)">
	                        
	                        <label for="icon-style5" class="common-iconlabel"><i class="fas fa-flask"></i></label>
	                        <input type="radio" name="icon" id="icon-style5" class="common-iconbtn" value="fas fa-flask" onchange="iconselect(this)">
	
	                        <label for="icon-style6" class="common-iconlabel"><i class="fab fa-angular"></i></label>
	                        <input type="radio" name="icon" id="icon-style6" class="common-iconbtn" value="fab fa-angular" onchange="iconselect(this)">
	
	                        <label for="icon-style7" class="common-iconlabel"><i class="fas fa-eye"></i></label>
	                        <input type="radio" name="icon" id="icon-style7" class="common-iconbtn" value="fas fa-eye" onchange="iconselect(this)">
	
	                        <label for="icon-style8" class="common-iconlabel"><i class="fab fa-microsoft"></i></label>
	                        <input type="radio" name="icon" id="icon-style8" class="common-iconbtn" value="fab fa-microsoft" onchange="iconselect(this)">
	
	                        <label for="icon-style9" class="common-iconlabel"><i class="fab fa-github"></i></label>
	                        <input type="radio" name="icon" id="icon-style9" class="common-iconbtn" value="fab fa-github" onchange="iconselect(this)">
	
	                        <label for="icon-style10" class="common-iconlabel"><i class="fab fa-hotjar"></i></label>
	                        <input type="radio" name="icon" id="icon-style10" class="common-iconbtn" value="fab fa-hotjar" onchange="iconselect(this)"> 
	
	                        <label for="icon-style11" class="common-iconlabel"><i class="far fa-pause-circle"></i></label>
	                        <input type="radio" name="icon" id="icon-style11" class="common-iconbtn" value="far fa-pause-circle" onchange="iconselect(this)">
	
	                        <label for="icon-style12" class="common-iconlabel"><i class="fas fa-play-circle"></i></label>
	                        <input type="radio" name="icon" id="icon-style12" class="common-iconbtn" value="fas fa-play-circle" onchange="iconselect(this)">
	
	                        <label for="icon-style13" class="common-iconlabel"><i class="fas fa-redo-alt"></i></label>
	                        <input type="radio" name="icon" id="icon-style13" class="common-iconbtn" value="fas fa-redo-alt" onchange="iconselect(this)">
	
	                        <label for="icon-style14" class="common-iconlabel"><i class="far fa-question-circle"></i></label>
	                        <input type="radio" name="icon" id="icon-style14" class="common-iconbtn" value="far fa-question-circle" onchange="iconselect(this)">
	
	                        <label for="icon-style15" class="common-iconlabel"><i class="fas fa-wrench"></i></label>
	                        <input type="radio" name="icon" id="icon-style15" class="common-iconbtn" value="fas fa-wrench" onchange="iconselect(this)">
	
	                        <label for="icon-style16" class="common-iconlabel"><i class="fab fa-js-square"></i></label>
	                        <input type="radio" name="icon" id="icon-style16" class="common-iconbtn" value="fab fa-js-square" onchange="iconselect(this)">
	
	                        <label for="icon-style17" class="common-iconlabel"><i class="fas fa-thumbtack"></i></label>
	                        <input type="radio" name="icon" id="icon-style17" class="common-iconbtn" value="fas fa-thumbtack" onchange="iconselect(this)">
	                        
	                        <label for="icon-style18" class="common-iconlabel"><i class="fab fa-java"></i></label>
	                        <input type="radio" name="icon" id="icon-style18" class="common-iconbtn" value="fab fa-java" onchange="iconselect(this)">
	
	                        <label for="icon-style19" class="common-iconlabel"><i class="fab fa-aws"></i></label>
	                        <input type="radio" name="icon" id="icon-style19" class="common-iconbtn" value="fab fa-aws" onchange="iconselect(this)">
	
	                        <label for="icon-style20" class="common-iconlabel"><i class="fas fa-database"></i></label>
	                        <input type="radio" name="icon" id="icon-style20" class="common-iconbtn" value="fas fa-database" onchange="iconselect(this)">
	
	                        <label for="icon-style21" class="common-iconlabel"><i class="fas fa-map-marker-alt"></i></label>
	                        <input type="radio" name="icon" id="icon-style21" class="common-iconbtn" value="fas fa-map-marker-alt" onchange="iconselect(this)">
	
	                        <label for="icon-style22" class="common-iconlabel"><i class="fab fa-sistrix"></i></label>
	                        <input type="radio" name="icon" id="icon-style22" class="common-iconbtn" value="fab fa-sistrix" onchange="iconselect(this)">
	
	                        <label for="icon-style23" class="common-iconlabel"><i class="fas fa-share-alt"></i></label>
	                        <input type="radio" name="icon" id="icon-style23" class="common-iconbtn" value="fas fa-share-alt" onchange="iconselect(this)">
	                        
	                        <label for="icon-style24" class="common-iconlabel"><i class="fas fa-ban"></i></label>
	                        <input type="radio" name="icon" id="icon-style24" class="common-iconbtn" value="fas fa-ban" onchange="iconselect(this)">
	                    </div>
	                    <div>
	                    	<span class="errors" id="iconSpan"></span>
	                    </div>
	
	                    <div class="common-iconstyle mt-4 mb-5">
	                        <div class="common-iconcolorselect">
	                            <div class="color-selectitem">
	                                <label for="" class="common-label no-drag">배경색 지정</label>
	                                <button type="button" class="random-color">
	                                	<i class="fas fa-random"></i>
	                                </button>
	                                <input type="color" class="common-colorinput" data-selector="background" oninput="iconcolor(this)" id="backgroundColor">
	                                <span class="color-hex"></span>
	                            </div>
	                            <div class="color-selectitem">
	                                <label for="" class="common-label no-drag">아이콘 색상</label>
	                                <button type="button" class="random-color">
	                                	<i class="fas fa-random"></i>
	                                </button>
	                                <input type="color" class="common-colorinput" data-selector="icon" oninput="iconcolor(this)" id="iconColor">
	                                <span class="color-hex"></span>
	                            </div>
	                            <div class="color-selectitem">
	                                <label for="" class="common-label no-drag">텍스트 색상</label>
	                                <button type="button" class="random-color">
	                                	<i class="fas fa-random"></i>
	                                </button>
	                                <input type="color" class="common-colorinput" data-selector="text" oninput="iconcolor(this)" id="textColor">
	                                <span class="color-hex"></span>
	                            </div>
	                        </div>
	
	                        <div class="icon-preview">
	                            <label for="" class="common-label no-drag">미리보기</label>
	                            <span class="custom-iconbox">
	                                <span class="custom-icon"><i></i></span>
	                                <span class="custom-text"></span>
	                            </span>
	                        </div>
	                    </div>
	                </div>
	
	                <div class="common-modalbtn float--left" data-type="issue">
	                    <button type="button" class="common-addbtn" id="insertBtnInModal">추가</button>
	                    <button type="button" class="common-addbtn" id="modifyBtnInModal">수정</button>
	                    <button type="button" class="common-cancelbtn" data-toggle="modal"
	                        data-target="#setting-status" id="cancelBtnInModal">취소</button>
	                </div>
				</form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/admin/customInfo/customInfo.js"></script>
















