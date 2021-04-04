'use strict';

/*eslint-disable*/

var SCHEDULE_CATEGORY = [
    'milestone',
    'task'
];

function ScheduleInfo() {
    this.id = null;			    //ID
    this.calendarId = null;     //캘린더ID
                                
    this.title = null;          //일정 제목
    this.body = null;           //일정 상세
    this.isAllday = false;      //하루 전체 (BOOLEAN)
    this.start = null;          //시작 날짜
    this.end = null;            //마감 날짜
    this.category = '';         //카테고리
                                
    this.color = null;          
    this.bgColor = null;        
    this.dragBgColor = null;    
    this.borderColor = null;    
    this.customStyle = '';      
                                
    this.isFocused = false;     
    this.isPending = false;     
    this.isVisible = true;      
    this.isReadOnly = false;    //읽기전용
    this.goingDuration = 0;     
    this.comingDuration = 0;    
    this.recurrenceRule = '';   
    this.state = '';            
}