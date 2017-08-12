'use strict';
(function(){
	var bAdd = false;
	window.myCalendar = function (sName){
		var oTxt = document.getElementsByName(sName)[0];
		var oDiv = document.createElement('div');
		oDiv.className='myCalendar';
		oDiv.id='myCalendar';
		oDiv.innerHTML='<a href="javascript:;" class="prev">←</a>'+
			'<h4 class="date_h4">选择日期</h4>'+
			'<h2>2015-08</h2>'+
			'<div id="finish" class="finish">完成</div>'+
			'<a href="javascript:;" class="next">→</a>'+
			'<ol>'+
				'<li>一</li>'+
				'<li>二</li>'+
				'<li>三</li>'+
				'<li>四</li>'+
				'<li>五</li>'+
				'<li class="week_end">六</li>'+
				'<li class="week_end">日</li>'+
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
		var rc=$("#rc").val();
		var userid=$("#userid").val();
		//后台返回的数据
		var toData = $.parseJSON($("#dates").text());
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
		
		function calendar(){
			//修改h2的值
			var oDate = new Date();
			oDate.setMonth(oDate.getMonth()+iNow,1);
			var mM = oDate.getMonth()+1;
			if(mM<10){
				mM = "0"+ mM;
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
						aLi[i].className='';
					}
				}else if(iNow<0){
					aLi[i].className='past';
				}else if(iNow==0){	
					if(aLi[i].innerHTML<today){
						aLi[i].className='past';
					}else if(aLi[i].innerHTML>=today){
						aLi[i].className='cur';
						if(aLi[i].innerHTML==""){
							aLi[i].className='';
						}
					}
				}	
			}
			addClick();
			reColor();
		}
		
		
		//记录选中的日期
		var chooseDate =toData;
		function addClick(){
			$("li.cur").click(function(){
				var $this = $(this);
				var dateStr = $("#myCalendar h2").text()+"-"+$this.text();
				if($this.hasClass("today")){//已经选中，去除今天
					var index = chooseDate.indexOf(dateStr);
					chooseDate.splice(index,1);
					$this.removeClass("today")
				}else{
					$this.addClass("today");
					chooseDate.push(dateStr);
					console.log(chooseDate);
				}
				showDate();
			});
		}
		function showDate(){
			var text = "";
			chooseDate.sort();
			for(var i=0;i<chooseDate.length;i++){
				text += chooseDate[i]+"|";
			}
			$("#startDate").val(text);			
		}
		
		function reColor(){
			$("li.cur").each(function(){
				var $this = $(this);
				var dateStr = $("#myCalendar h2").text()+"-"+$this.text();
				if(chooseDate.indexOf(dateStr)>-1){
					$this.addClass("today");
				}
			})
		}
		
		//完成按钮
		var finish = document.getElementById('finish');
		finish.onclick = function(){
			console.log(oTxt.value);
			if(oTxt.value == ''){
		        console.log(chooseDate);
		        alert("请选择日期！");
		    }else{
				var strs= new Array(); //定义一数组
				var json = [];  //定义一个空json
				strs=oTxt.value.split("|"); //字符分割  
				strs.pop(); //删除最后一个数组元素
				for (var i in strs) 
				{ 
					json += '"'+strs[i]+'"'+','; //分割后的字符输出 
				} 
				if(json!=''){
					var json_arr = json.substr(0,json.length-1);
				}
				
				$.ajax({
					type:'post',
					url:rc+'/resume/getDate',
					data:{arrdata:json_arr,userid:userid},
					dataType: "json",
			        async:false,
			        success:function(data){
			        	if(data.status==200){
			        		
			        	}else{
			        		alert(data.msg);
			        	}
			        }
				}); 
				$("#data_hidden").val(json_arr);
				$('#myCalendar').hide();
		      }	
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
		oLink.href=rc+'/resources/css/calendar.css';
		var oHead = document.getElementsByTagName('head')[0];
		oHead.appendChild(oLink);
	}	
})();
