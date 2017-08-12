'use strict';
(function(){
	var bAdd = false;
	window.myCalendar = function (sName){
		var oTxt = document.getElementsByName(sName)[0];
		var oDiv = document.createElement('div');
		oDiv.className='myCalendar';
		oDiv.id='myCalendar';
		//var oDiv = document.getElementById("myCalendar");
		oDiv.innerHTML='<a href="javascript:;" class="prev"></a>'+
			'<h4 class="date_h4">选择日期</h4>'+
			'<h2>2015-08</h2>'+
			'<div class="close_gb" id="close_gb">×</div>'+
			'<a href="javascript:;" class="next"></a>'+
			'<ol>'+
				'<li>一</li>'+
				'<li>二</li>'+
				'<li>三</li>'+
				'<li>四</li>'+
				'<li>五</li>'+
				'<li>六</li>'+
				'<li>日</li>'+
			'</ol>'+
			'<ul></ul>';
		oTxt.parentNode.insertBefore(oDiv,oTxt);
		var oPrev = oDiv.getElementsByTagName('a')[0];
		var oNext = oDiv.getElementsByTagName('a')[1];
		var oH2 = oDiv.getElementsByTagName('h2')[0];
		var oUl = oDiv.getElementsByTagName('ul')[0];
		var aLi = oUl.children;
		var iNow = 0;
		var str = "";
		oTxt.onfocus=function(){
			oDiv.style.left=this.offsetLeft+'px';
			oDiv.style.top=this.offsetTop+this.offsetHeight+5+'px';
			oDiv.style.display='block';
		};
		
		/*document.onclick=function(){
			oDiv.style.display='none';
		};*/
		
		oDiv.onclick=oTxt.onclick=function(ev){
			var oEvent = ev||event;
			oEvent.cancelBubble=true;
		};
		//可以控制的数组
		
		function getDateType(dateStr){
			if(!test)
				return 0;
			for(var i=0;i<test.length;i++){
				if(dateStr==test[i].time){
					return test[i].flag;
				}
			}
			return 0;
		}
		function calendar(){
			//修改h2的值
			var oDate = new Date();
			oDate.setMonth(oDate.getMonth()+iNow,1);
			var mM = oDate.getMonth()+1;
			if(mM<10){
				mM = "0"+mM;	
			}
			oH2.innerHTML=oDate.getFullYear()+'-'+(mM);				
			//每次调用，都要把之前的干掉。
			oUl.innerHTML='';
			//在前面插空格。第一天是周几，就空周几-1的格。
			//获取第一天是周几
			var oDate = new Date();	//?
			oDate.setMonth(oDate.getMonth()+iNow,1);
			oDate.setDate(1);
			var w = oDate.getDay();//第一天的星期是w
			//星期如果是周日就为0，如果为0要变成7
			if(w==0)w=7;
			//空w--的格
			w--;
			for(var i=0;i<w;i++){
				var oLi = document.createElement('li');
				oUl.appendChild(oLi);
			}
			
			//获取本月有多少天
			var oDate = new Date();	//?
			oDate.setMonth(oDate.getMonth()+iNow,1);
			oDate.setMonth(oDate.getMonth()+1,0);
			var n = oDate.getDate();//这个月有n天
			//有多少天，就创建多少个li
			for(var i=0;i<n;i++){
				var oLi = document.createElement('li');
				oLi.innerHTML=i+1;
				if(oLi.innerHTML<10){
					oLi.innerHTML = "0"+oLi.innerHTML;
				}
				
				oUl.appendChild(oLi);
			}
			
			
			
			//获取今天的日。判断是今天还是之前的天or当前时间戳
			var oDate = new Date();
			var today = oDate.getDate();
			var dateChoose = new Array();
			for(var i=0;i<aLi.length;i++){
				if(iNow>0){
					aLi[i].className='cur';		
					if(aLi[i].innerHTML==""){
						aLi[i].className='past';
						if($(".past").text()==""){
							$(".past").css("border","none");	
						}
					}
					if(aLi[i].className=='cur'){
						var liText = $(aLi[i]).html();
						$(aLi[i]).html('<p class="aLi_first">'+liText+'</p>'+'<p style="font-size:10px; color:#333;">空闲</p>');	
					}
				}else if(iNow<0){
					aLi[i].className='past';
					if($(".past").text()==""){
						$(".past").css("border","none");	
					}
				}else if(iNow==0){	
					if(aLi[i].innerHTML<today){
						aLi[i].className='past';
						if($(".past").text()==""){
							$(".past").css("border","none");	
						}
					}else if(aLi[i].innerHTML>=today){
						aLi[i].className='cur';
						if(aLi[i].className=='cur'){
							var liText = $(aLi[i]).html();
							$(aLi[i]).html('<p class="aLi_first">'+liText+'</p>'+'<p style="font-size:10px; color:#333;">空闲</p>');	
						}
						if(aLi[i].innerHTML==""){
							aLi[i].className='';
						}
					}
				}	
			}
			addClick();
			reColor();
			$(".myCalendar ul li").each(function(){
				if($(this).attr("class")=="cur today"){
					if($(this).find("p:last").text()=="已约"){
						$(this).find("p:last").text("已约");
						$(this).find("p:last").css("color","#fff");
					}else{
						$(this).find("p:last").text("预约");
						$(this).find("p:last").css("color","#fff");
					}
				}
			})
		}
		//记录选中的日期
		function addClick(){
			var $this = $(this);
			var dateStr = $("#myCalendar h2").text()+"-"+$this.find(".aLi_first").text();		
			if($this.hasClass("today")){//已经选中，去除今天
				var index = getDateIndex(dateStr);
				test.splice(index,1);
				$this.removeClass("today");
				$this.html('<p class="aLi_first">'+$this.find(".aLi_first").text()+'</p>'+'<p style="font-size:10px; color:#333;">空闲</p>');
			}else{
				$this.addClass("xianxia");
				var currentClickDate ={
					"time":dateStr,
					"flag":3
				}
				test.push(currentClickDate);
				$this.html('<p class="aLi_first">'+$this.find(".aLi_first").text()+'</p>'+'<p style="font-size:10px; color:#fff;">预约</p>');	
			}
			showDate();
		}
		function getDateIndex(dateStr){
			for(var i=0;i<test.length;i++){
				if(test[i].time==dateStr){
					return i;
				}
			}
			return -1;
		}
		function showDate(){
			var text = "";
			var redDateArr = new Array();
			for(var i=0;i<test.length;i++){
				if(test[i].flag==3){
					redDateArr.push(test[i].time);
				}
			}
			redDateArr.sort();
			for(var i=0;i<redDateArr.length;i++){
				text+=redDateArr[i]+"|";
			}
			
			$("#startDate").val(text);			
		}
		
		function reColor(){
			$("li.cur").each(function(){
				var $this = $(this);
				var dateStr = $("#myCalendar h2").text()+"-"+$this.find("p.aLi_first").text();
				if(getDateIndex(dateStr)>-1){
					$this.addClass("today");
				}
				var dateType = getDateType(dateStr);
				if(dateType==3){
					$this.removeAttr("class","today");
					$this.attr("class","xianxia");	
					$this.find("p").eq(1).text("已约").css({"color":"#fff","font-size":"12px"});
				}else if(dateType==1||dateType==2){//不能预定
					$this.removeClass("cur");
					$this.attr("class","today");
					$this.unbind("click");
					$this.find("p").eq(1).text("已约").css({"color":"#fff","font-size":"12px"});
				}
			})
		}
		

		//完成按钮
		var finish = document.getElementById('close_gb');
		finish.onclick = function(){  
			$("#myCalendar").remove();
		}
		calendar();
		//上个月
		oPrev.onclick=function(){
			iNow--;
			calendar();
		};
		//下个月
		oNext.onclick=function(){
			iNow++;
			calendar();		
		};
		if(bAdd)return;
		bAdd=true;
		var oLink = document.createElement('link');
		oLink.rel='stylesheet';
		oLink.href=ctx+'/resources/css/scanCalendar.css';
		var oHead = document.getElementsByTagName('head')[0];
		oHead.appendChild(oLink);
	}	
})();