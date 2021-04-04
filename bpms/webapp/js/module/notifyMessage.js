/**
 * <h4>notify.js를 이용한 메세지 출력</h4>
 * <pre>
 * message : 메세지의 내용
 * from : 메시지 출력위치 (botton, top) default:top
 * align: 메세지 정렬기준 (left, center, right) default:right
 * timeout: 메세지 출력 유지시간 (단위: ms) default: 2000
 * type: 메세지 디자인 유형 (기존 notify와 달라서 알아봐야함) default: info
 * </pre> 
 */ 

// show notify.js message
function showMessage(options) {
	
	let text = options.text;
	let from = options.from;
	let align = options.align;
	let timeout = options.timeout;
	let type = options.type;
	
	$.notify({
		// options
		icon: 'flaticon-alarm-1'
		, message: text
	},{
		// settings
		element: 'body'
		, position: null
		, type: type
		, allow_dismiss: true
		, newest_on_top: false
		, showProgressbar: false
		, placement: {
		 	from: from
		 	, align: align
		 }
		, offset: 20
		, spacing: 10
		, z_index: 1031
		, delay: 5000
		, timer: timeout
		, url_target: '_blank'
		, mouse_over: null
		, animate: {
		 	enter: 'animated fadeInDown'
		 	, exit: 'animated fadeOutUp'
		 }
		, onShow: null
		, onShown: null
		, onClose: null
		, onClosed: null
		, icon_type: 'class'
	});
}