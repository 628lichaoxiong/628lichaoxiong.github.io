$(function () {
	$pc.init();
});
$pc = function(){
	var sNum = null, id=null, payflag=null,meetinguserphone=null,userid=null,searchkey=null,changeNoneCount=null,addYueData=null,count=null,result=null,num=null,len=null,
	type=null,numCount=null,originalTime=null,message=null,method=null,name=null,orderList=null,totalFee=null,costPrice=null;
	return{
		init:function(){
			this.initVars();
			this.renderUI();
			this.bindUI();
			this.order();
		},
		initVars:function(){
		    orderList=[];
		    totalFee = 0;
			num=0;
			result=0;
			changeNoneCount=1;
			sNum = 0;
			count=0;
			numCount=0;
			id=$("#id").val();
			payflag=$("#payflag").val();
			meetinguserphone=$("#meetinguserphone").val();
			userid=$("#userid").val();
			searchkey=$("#search_key").val();
			addYueData=new Array();
			len = $(".list_price").length;
			type=$("#type").val();
			message=$("#message").val();
			method=$("#method").val();
			name=$("#userResumeName").text();
			costPrice=0;
		},
		renderUI:function(){
			//判断高亮显示
			var spanLen = $(".service_edit ol li span").length;
			for(var i = 0; i<spanLen;i++){
				var alt = $(".service_edit ol li span").eq(i).attr("alt");
				var serviceInputVal = $(".service_input").val();
				if(serviceInputVal==alt){
					$(".service_edit ol li span").eq(i).addClass("hover");	
				}
			}
			//译员总金额
			var noRes=false;//是否有译员
			$('#transnFee').find('.fee').each(function(i){
				var price = $(this).parents('tr').find('input').val();
				var time = $(this).parents('tr').find('.transn-time').html();

				$(this).html(price * time);
				noRes=true;
			});

			/*$('body').on('focus','.list_Orderprice',function(){
				$(this).val('');
			});*/
			var redpackMoney=$("#redpackMoney").val();
			 
			$('#transnFee').on('input','.list_Orderprice',function(){
				totalFee=0;
				var price = $(this).val();
				var time = $(this).parents('tr').find('.transn-time').html();

				$(this).parents('tr').find('.fee').html(price * time);

				$('#transnFee').find('.fee').each(function(i){
					totalFee = totalFee + parseInt($('#transnFee .fee').eq(i).html());
				});
				$('#transnFee .total-fee').html(totalFee);
				/*$("#sum_price1").val(result+totalFee);*/
				$("#sum_price").html(result+totalFee); 
				$("#sum_price_end").html(result+totalFee-redpackMoney); 
				$("#totalmoney").val(result+totalFee); 
			});
			//初始化总金额
			for(var p = 0; p<len;p++){
				var price= parseInt($(".list_price").eq(p).val());
			 	if(!isNaN(price)){
			   		result += price;
			 	}
			}
			if(noRes){//如果有译员则显示译员的价格
				$("#sum_price").html(result+totalFee);
				$("#sum_price_end").html(result+totalFee-redpackMoney); 
				$("#totalmoney").val(result+totalFee);
			}
			
			
		},
		bindUI:function(){
			//服务弹窗展示和选择处理
			$(".service_xz").click(function(){
				sNum++;
				if(sNum==1){
					$(this).attr("sNum",sNum);	
					$(this).find("img").attr("src",ctx+"/resources/images/icon_up@2x.png");
					$(".service_edit").show();
				}else if(sNum>1){
					sNum = 0;	
					$(this).attr("sNum",sNum);
					$(this).find("img").attr("src",ctx+"/resources/images/icon_drop@2x.png");
					$(".service_edit").hide();
				}
			});
			//显示之后
			$(".service_edit ol li span").click(function(){
				$(".service_edit ol li").find("span").removeClass("hover");
				$(this).addClass("hover").siblings().removeClass("hover");
				sNum = 0;	
				$(".service_xz").attr("sNum",sNum);
				$(".service_xz").find("img").attr("src",ctx+"/resources/images/icon_drop@2x.png");
				$(".service_edit").hide();
				$(".service_input").val($(this).attr("alt"));
			});
			//查看反馈
			$("#scanFadeback").click(function(){
		         window.location.href=ctx+"/feedbackOrder/feedbackByOrder?id="+id+"&source=1"+"&payflag="+payflag+"&phonenumber="+meetinguserphone+"&userid="+userid;
			});
			//添加反馈
			$("#addFadeback").click(function(){
				window.location.href=ctx+"/feedbackOrder/addFeedbackOrder?id="+id+"&payflag="+payflag+"&phonenumber="+meetinguserphone+"&userid="+userid;
			});
			//查找译员
			$("#search_key").keyup(function(){
				var searchInput = $.trim($(this).val());
				searchkey = searchInput;
			})
			$("#searchMeeting").click(function(){
				var optype=$("#optype").val();
				$.ajax({
					type:'post',
					url:ctx+'/compation/getSearchResume',
					data:{optype:optype,searchkey:searchkey},
					dataType:"html",
			        async:false,
			        success:function(result){
			        	$("#allResumeList").html(result);
			        	$("#allResumeList").show();
			        	
			        }
				});
			});
			//展开和隐藏事件
			$(".clickchange").click(function(){
				changeNoneCount++;
				if(changeNoneCount%2==0){
					$(this).find("img").attr("src",ctx+"/resources/images/change_show.png");
					$("#allResumeList").hide();	
				}else{
					$(this).find("img").attr("src",ctx+"/resources/images/change_none.png");
					$("#allResumeList").show();	
				}
			})
			//ajax分页逻辑
			$("#allResumeList").on('click','.pager',function(){
				var n=$(this).attr("index");
				var optype=$("#optype").val();
				$.ajax({
					type:'post',
					url:ctx+'/compation/getSearchResume',
					data:{optype:optype,searchkey:searchkey,n:n},
					dataType:"html",
			        async:false,
			        success:function(result){
			        	$("#allResumeList").html(result);
			        	$("#allResumeList").show();
			        }
				});
			});
			//添加译员
			$("#allResumeList").on("click",".add",function(){
				var count=$("#resumeCount").val();
				if(count ==null){
					count =0;
				}
				//添加当有译员需求的时候，不进行3个译员判断
//				console.log(count); 
				if(count>=3 && !$("#havaAskinfo").val()){ 
					zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"','译员只能添加三个',function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          		return false;
				}
				var userid=$(this).parent(".cus_td").find(".searchreusme").val();
				var fromLan=$(this).parents().find(".fromLan option:selected").val();
				var toLan=$(this).parents().find(".toLan option:selected").val();
				if(fromLan===toLan){
					zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"','源语言和目标语言不能一致',function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          		return false;
				}
				var objectThis=$(this);
				 $.ajax({
					type:'post',
					url:ctx+'/compation/addResume',
					data:{userid:userid,serviceId:id,fromLan:fromLan,toLan:toLan},
					dataType:"json",
			        async:false,
			        success:function(data){
			        	if(data.status==200){ 
			        		/*costPrice=data.data.result;*/
			        		dynamicAdd(objectThis,fromLan,toLan,userid);
			        		var count=parseInt($("#resumeCount").val())+1;
			        		$("#resumeCount").val(count);
			        		$("#peoplenumber").val(count+'人');
			        		addOrderList();
			        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"添加译员成功",function(r) {
			          			if(r){
			          				return true;
			          			}
			          		})
			          	}else{
			          		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
			          			if(r){
			          				return true;
			          			}
			          		})
			          	}
			        }
				}); 
			});
			/*$("#userResumeAcceptedList").on("click",".add",function(){
				var userid=$(this).parent(".cus_td").find(".reusme").val();
				var fromLan="中文";
				var toLan=$("#orderLanguage").html();
				if(fromLan===toLan){
					zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"','源语言和目标语言不能一致',function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          		return false;
				}
				var objectThis=$(this);
				 $.ajax({
					type:'post',
					url:ctx+'/compation/addResume',
					data:{userid:userid,serviceId:id,fromLan:fromLan,toLan:toLan},
					dataType:"json",
			        async:false,
			        success:function(data){
			        	if(data.status==200){
			        		costPrice=data.data.result;
			        		dynamicAdd(objectThis,fromLan,toLan,userid);
			        		var count=parseInt($("#resumeCount").val())+1;
			        		$("#resumeCount").val(count);
			        		$("#peoplenumber").val(count+'人');
			        		addOrderList();
			        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"添加译员成功",function(r) {
			          			if(r){
			          				return true;
			          			}
			          		})
			          	}else{
			          		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
			          			if(r){
			          				return true;
			          			}
			          		})
			          	}
			        }
				}); 
			});*/
			//查看档期
			$("#allResumeList").on('click','.scanDate',function(){
				var userid=$(this).parent().find(".searchreusme").val();
				console.log(userid);
			 	var that=$(this);
			 	$.ajax({
			 		type:'post',
			 		url:ctx+'/resume/getCalendar',
			 		data:{userid:userid},
			 		dataType:"json",
			         success:function(result){
			         	test=result.result;
			         	myCalendar("startDate");
			         	$("#myCalendar").show();
			         	that.parents(".cus_td").css({"position":"relative"});
			         	that.after($("#myCalendar")); 
			         }
			 	});
			});
			//删除已经预约的译员
			$("#userResumeList").on("click",".delete",function(){
				var that = $(this);
				var userid=$(this).parents(".cus_td").find(".reusme").val();
				zdconfirm('<img src="'+ctx+'/resources/images/tishi@2x.png"','你确认删除该条数据吗',function(r) {//确认
					if(r){
						  $.ajax({
							type:'post',
							url:ctx+'/compation/deleteResume',
							data:{userid:userid,serviceId:id},
							dataType:"json",
					        async:false,
					        success:function(data){
					        	if(data.status==200){
					        	  that.parent().parent('tr').remove();	
					        	   var count=parseInt($("#resumeCount").val())-1;
					        		$("#resumeCount").val(count);
					        		$("#peoplenumber").val(count+'人');
					        		addOrderList();
					       		}else{
					       			zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
					          			if(r){
					          				return true;
					          			}
					          		})
					       		}
					        }
						});
					}
				});	 
			});
			//修改译员价格
			$("#userResumeList").on("click",".updatePrice",function(){
				var that = $(this);
				var userid=$(this).parents(".cus_td").find(".reusme").val();
				var costPrice=prompt("请输入译员成本价","");
				if (costPrice!=null && costPrice!=""){
					 $.ajax({
							type:'post',
							url:ctx+'/compation/updateServiceBaomingPrice',
							data:{costPrice:costPrice,serviceId:id,userid:userid},
							dataType:"json",
					        async:false,
					        success:function(data){
					        	if(data.status==200){
					        		alert("操作成功");
					        		that.parents(".userResumeList_tr").find(".costPrice").html(costPrice);
					       		}else{
					       			alert(data.msg);
					       		}
					        }
						});
				}
				
			});
			//js删除方法
			$("#meetingLists").on('click','.last_order_input',function(){
				var $this=$(this);
				zdconfirm('<img src="'+ctx+'/resources/images/tishi@2x.png"','你确认删除该条数据吗',function(r) {//确认删除
					if(r){
						$this.parents('tr').remove();	
					    sumAnd(this);
					}    
				 });
			});
			//新增一行
			$("#meetingLists").on('click','.last_tr',function(){
				var index=0;
				$('#meetingLists tr').each(function () {
		            var context = $(this).find(".order_input").val();
		            if(context==''||context==undefined){
		            	index++;
		            }
		         });
				if(index>1){
					return false;
				}
				  num++;
				  $(this).attr("num",num);
				  var tr = '<tr>';
				      	tr+='<td align="center">';
						tr+='	<div class="price_input">';
						tr+='		<input type="text" class="op_btn order_input" name="orderlist" value="">';
						tr+='		<img src="'+ctx+'/resources/images/icon_edit@2x.png" />';
						tr+='	</div>	';
						tr+='</td>';
				    	tr+='<td align="center">';
						tr+='	<div class="price_num_input">';
						tr+='		<input type="text" class="op_btn order_input list_price" name="orderlist" value="0" placeholder="">';
						tr+='		<img src="'+ctx+'/resources/images/icon_edit@2x.png" />';
						tr+='	</div>';	
						tr+='</td>';
				    	tr+='<td align="center"><input type="button" class="op_btn order_input last_order_input" value="删除" ></td>';
				    tr+='</tr>';  
				  	$(this).before(tr);
				});
			//计算合计
			$("#meetingLists").on("keyup",".list_price",function(){
				   sumAnd(this);
			});
			//金额输入框失去焦点事件
			$("#meetingLists").on("blur",".list_price",function(){
				var number=$(this).val();
				if(number==''){
					$(this).val("0");
				}
			});
			$("#meetingLists").on("focus",".list_price",function(){
				$(this).val("");
			});
			//发送给客户确认
			$("#send_sub").click(function(){
				getUserMonery();
				/*目前服务费为0
				 * var servicemonery=$("#sumOrdermoney").text();
				if(servicemonery ==null|| servicemonery ==''){
					servicemonery =0;
				}*/
	 			$("#servicemoney").val(0);
	 			/*if(orderList ==null || orderList.length ==0){
	 				zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"','请添加译员',function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          		return false;
				}*/
				var json=JSON.stringify(orderList);
				$("#unitCost").val(json);
				zdconfirm('<img src="'+ctx+'/resources/images/tishi@2x.png"','你确认发送给客户吗',function(r) {
					if(r){
						$.ajax({
					        type: "POST",
					        url:ctx+"/compation/sendMessage",
					        data:$('#formID').serialize(),// 要提交的表单 
					        success: function(data){
					        	if(data.status==200){
					        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"消息发送成功",function(r) {
					          			if(r){
					          				window.onbeforeunload=close;
					          				window.location.href=ctx+"/compation/getcompationInfo?id="+id+"&type=1"+"&isscan=1";
					          			}
					          		})
					          		
					          		}else{
					          			zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
						          			if(r){
						          				if(data.status==201){
						          					window.onbeforeunload=close;
						          					window.location.href=ctx+"/compation/getcompationInfo?id="+id+"&type=1"+"&isscan=1";
						          				}else{
						          					return true;
						          				}
						          				
						          			}
						          		})
					          	}
					        }
					    });
					}
				});
			});
			//修改订单信息
			$("#save_send_sub").click(function(){
				getUserMonery();
				/*目前服务费为0
				 * var servicemonery=$("#sumOrdermoney").text();
				if(servicemonery ==null|| servicemonery ==''){
					servicemonery =0;
				}*/
	 			$("#servicemoney").val(0);
	 			/*if(orderList ==null || orderList.length ==0){
	 				zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"','请添加译员',function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          		return false;
				}*/
				var json=JSON.stringify(orderList);
				$("#unitCost").val(json);
				zdconfirm('<img src="'+ctx+'/resources/images/tishi@2x.png"','确定保存修改的信息？',function(r) {
					if(r){
						$.ajax({
					        type: "POST",
					        url:ctx+"/compation/updateCompationInfo",
					        data:$('#formID').serialize(),// 要提交的表单 
					        success: function(data){
					        	if(data.status==200){
					        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"保存成功",function(r) {
					          			if(r){
					          				window.onbeforeunload=close;
					          				window.location.href=ctx+"/compation/getcompationInfo?id="+id+"&type=0"+"&isscan=1";
					          			}
					          		})
					          		
					          		}else{
					          			zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
						          			if(r){
						          				if(data.status==201){
						          					window.onbeforeunload=close;
						          					window.location.href=ctx+"/compation/getcompationInfo?id="+id+"&type=0"+"&isscan=1";
						          				}else{
						          					return true;
						          				}
						          				
						          			}
						          		})
					          	}
					        }
					    });
					}
				});
			});
			//修改会议开始时间
			 $("#servcetimebegin").bind("change focus",function(){
				var changeTime;
				var servcetimeend=$("#servcetimeend").val();
				numCount++; 
				$(this).attr("numCount",numCount); 
				if(numCount==1){
					originalTime=$(this).val();
					return false;
				}else if(numCount > 1){
					changeTime=$(this).val();
					if(changeTime!=originalTime){
						$.ajax({
							type:'post',
							url:ctx+'/compation/serviceTimeChange',
							data:{serviceid:id,beginTime:changeTime,endTime:servcetimeend},
							dataType:"json",
					        success:function(data){
					        	if(data.status!=200){
					        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
					          			if(r){
					          				$("#servcetimebegin").val(originalTime);
					          				return true;
					          			}
					          		})
					        	}
					        	
					        }
						});
					}
				}
			 });
			//修改会议结束时间
			 $("#servcetimeend").bind("change focus",function(){
				var changeTime;
				var servcetimebegin=$("#servcetimebegin").val();
				numCount++; 
				$(this).attr("numCount",numCount); 
				if(numCount==1){
					originalTime=$(this).val();
					return false;
				}else if(numCount > 1){
					changeTime=$(this).val();
					if(changeTime!=originalTime){
						$.ajax({
							type:'post',
							url:ctx+'/compation/serviceTimeChange',
							data:{serviceid:id,beginTime:servcetimebegin,endTime:changeTime},
							dataType:"json",
					        success:function(data){
					        	if(data.status!=200){
					        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
					          			if(r){
					          				$("#servcetimeend").val(originalTime);
					          				return true;
					          			}
					          		})
					        	}
					        	
					        }
						});
					}
				}
			 });
			 //反馈查看更多
			 $("#feedBackResumeList").on('click','.look_more',function(){
				 $(".jump_mask").show();
				 $(this).next(".more_content").show();
			 });
			 //关闭查看更多弹窗
			 $("#feedBackResumeList").on('click','.more_content_close',function(){
				 $(".jump_mask").hide();
				 $(this).parents(".more_content").hide();
			 });
			 //反馈编辑处理方法
			 $("#feedBackResumeList").on('click','.feedBack_input',function(){
				 	$(this).hide();
					$(this).next(".feedBack_edit_input").show();
			 });
			 //反馈不编辑取消
			 $("#feedBackResumeList").on('click','.span_img_1',function(){
				 	$(this).parents(".feedBack_edit_input").find("input").val("");
				 	$(this).parents(".feedBack_edit_input").hide();
				 	$(this).parents(".feedBack_edit_input").prev(".feedBack_input").show();
			 });
			 
			 //反馈编辑之后确认
			 $("#feedBackResumeList").on('click','.span_img_2',function(){
				 var $this=$(this);
				 var id=$(this).parents(".feedback").find(".feedbackId").val();
				 var inputVal = $(this).parents(".feedBack_edit_input").find("input").val();
				    $.ajax({
						type:'post',
						url:ctx+'/feedbackOrder/changeState',
						data:{id:id,state:1,method:inputVal},
						dataType:"json",
				        success:function(data){
				        	if(data.status==200){
				        		$this.parents(".feedBack_edit_input").hide();
				        		$this.parents(".feedBack_edit_input").prev(".feedBack_input").show();
				        		$this.parents(".feedBack_edit_input").prev(".feedBack_input").find("input").val(inputVal);
				        		$this.parents(".feedBack_edit_input").find("input").val(inputVal);
				        	}else{
				        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
				          			if(r){
				          				return true;
				          			}
				          		})
				        	}
				        }
					});
			 });
			 //反馈分页
				$("#feedBackResumeList").on('click','.pager',function(){
					var n=$(this).attr("index");
					$.ajax({
						type:'post',
						url:ctx+'/feedbackOrder/feedbackByOrder',
						data:{id:id,source:1,n:n},
						dataType:"html",
				        success:function(result){
				        	$("#feedBackResumeList").html(result);
				        }
					});
				});
			//添加反馈
				$("#addFeedBack").click(function(){
					$(".jump_mask").show();
					$(".add_feedback").show();
					$("#message").val("");
					$("#method").val("");
					method="";
			 		message="";
				});
			//关闭添加反馈窗口
				$(".add_feedback_close").click(function(){
					$(".jump_mask").hide();
					$(this).parents(".add_feedback").hide();
					$("#message").val("");
					$("#method").val("");
					method="";
			 		message="";
				});
			//添加保存反馈
				$("#preservation_add_submit").click(function(){
					if(message==''){
						alert("反馈内容不能为空");
		          		return false;
					}
					$.ajax({
						type:'post',
						url:ctx+'/feedbackOrder/addFeedback',
						data:{orderId:id,userid:userid,payflag:payflag,mobile:meetinguserphone,method:method,message:message,name:name},
						dataType:"json",
				        success:function(data){
				 			if(data.status==200){
				 				$(".add_feedback").hide();
				 				$("#jump_mask").hide();
				 				$.ajax({
				 					type:'post',
				 					url:ctx+'/feedbackOrder/feedbackByOrder',
				 					data:{id:id,source:1},
				 					dataType:"html",
				 			        //async:false,
				 			        success:function(result){
				 			 			$("#feedBackResumeList").html(result);
				 			 			$("#message").val("");
				 						$("#method").val("");
				 						method="";
				 				 		message="";
				 			        }
				 				});
				 			}else{
				 				zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',data.msg,function(r) {
				          			if(r){
				          				return true;
				          			}
				          		})
				 			}
				        }
					});
				});
				
				//获取添加反馈的反馈内容和处理方法的值
				$("#message").keyup(function(){
					message = $(this).val();  //将输入的值传给空变量
				});
				//获取添加反馈的反馈内容和处理方法的值
				$("#method").keyup(function(){
					method = $(this).val();  //将输入的值传给空变量
				})
		},
		//页面初始化获取所有已经预约的译员
		order:function(){
			$.ajax({
				type:'post',
				url:ctx+'/compation/getOrderResume',
				data:{id:id,type:type},
				dataType:"html",
		        //async:false,
		        success:function(result){
		 			$("#userResumeList").html(result);
		 			$("#peoplenumber").val($("#resumeCount").val()+'人');
		        }
			});
			$.ajax({
				type:'post',
				url:ctx+'/feedbackOrder/feedbackByOrder',
				data:{id:id,source:1},
				dataType:"html",
		        //async:false,
		        success:function(result){
		 			$("#feedBackResumeList").html(result);
		        }
			});
			addOrderList();
			$.ajax({
				type:'post',
				url:ctx+'/compation/getOrderAcceptedResume',
				data:{id:id,type:type},
				dataType:"html",
		        //async:false,
		        success:function(result){
		 			$("#userResumeAcceptedList").html(result);
		        }
			});
		}
	};
	//js动态添加译员方法
	function dynamicAdd(obj,fromLan,toLan,userid){
		var tdText =  $(obj).parents(".parent_tr").find(".td_text");
		addYueData.splice(0,addYueData.length);  //清空数组，防止二次确认之后取消重新选择其他译员产生数据冲突
		var tdText =  $(obj).parents(".parent_tr").find(".td_text");
		var userid=$(obj).parents(".parent_tr").find(".reusme").val();
		var tdTextLen = tdText.length;
		for(var i = 0;i < tdTextLen;i++){
			var tdData =  tdText.eq(i).html();   //获取当前tr下面的语言td的文本
			addYueData.push(tdData);
		}
		var isChoice ="否";
		if($("#orderType").val() == 2){//如果是发布，则是选中
			isChoice="是";
		}
		var strP = fromLan+"-"+toLan;
		addYueData.push(strP);    //获取tr所有元素值
		addYueData.push(userid);//获取userid的值
		var addTr = '<tr class="userResumeList_tr">';
		addTr +='<td align="center" style="background: #F3FAEB; position:relative;">'+addYueData[0];
		addTr +='<img src="'+ctx+'/resources/images/icon_new@2x.png" style=" width:23px; height;auto; position:absolute; left:6px; top:23px; z-index:9999;" />';
		addTr +='</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[1]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[2]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[3]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[4]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[5]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[6]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[7]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;">'+addYueData[8]+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;" class="costPrice">'+costPrice+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;" >'+isChoice+'</td>';
		addTr +='<td align="center" style="background: #F3FAEB;" class="cus_td">'; 
		addTr+='    <input type="hidden" value="'+userid+'" class="reusme"/>';
		addTr +='	<input type="button" class="op_btn btn scan" value="查看档期" style="margin-right:0px;">';
		/*addTr +='	<input type="button" class="op_btn btn updatePrice" value="修改成本价" style="margin-right:0px;">';
		addTr +='	<input type="button" class="op_btn btn delete" value="删除">';
		*/addTr +='</td>';
		addTr +='</tr>';
		$("#userResumeList tr").last().after(addTr);
		//获得总数据
		var total=$(obj).parents().find(".totalmsg").html();
		//改变条数
		$(obj).parents().find(".totalmsg").html(total-1);
		if(count==9){
			var totalpage=$(obj).parents().find(".totalpage").html();
			$(obj).parents().find(".totalpage").html(totalpage-1);
		}
		$(obj).parents(".parent_tr").remove();	
		count++;	
	};
	function sumAnd(obj){
			var pNum = $(obj).parents().find(".list_price").val();
			var epre  = /^[0-9]*$/;
			  if(pNum =="underfind"){
				  $(obj).val("0");
			  }else if(!epre.test(pNum)){ 
				  $(obj).val("");
			  }
			    result = 0;      //重新计算必须先清零
			    len=$(".list_price").length;
				for(var p = 0; p<len;p++){
					var price= parseInt($(".list_price").eq(p).val());
				 	if(!isNaN(price)){
				   		result += price;
				 	}
				}
				var redpackMoney=$("#redpackMoney").val();
				$("#sum_price1").val(result+totalFee);
				$("#sum_price").html(result+totalFee);
				$("#sum_price_end").html(result+totalFee-redpackMoney); 
				$("#totalmoney").val(result+totalFee);
				

	};
	//添加订单结算明细
	function addOrderList(){
		var beginTime=$("#servcetimebegin").val();
		var endTime=$("#servcetimeend").val();
		$.ajax({
			type:'post',
			url:ctx+'/compation/getOrderFee',
			data:{id:id,beginTime:beginTime,endTime:endTime},
			dataType:"html",
	        success:function(result){
	        	//alert(result);
	 			$("#transnFee").html(result);
//	 			var result1=$("#sum_price1").val();
				var totalmoney=$("#startTotalmoney").val();//totalmoney有可能被修改了
				var totalPrice =0;
				var noRes=true;//是否有译员
				$('#transnFee').find('.fee').each(function(i){
					var price = $(this).html();
					totalPrice=totalPrice+parseInt(price);
					noRes=false;
				});
//				$("#sum_price1").val(parseInt(result1)+parseInt(fee));
//				$("#sum_price").val(parseInt(result1)+parseInt(fee));
				var redpackMoney=$("#redpackMoney").val();
				if(noRes){//为空说明没有议员，显示默认价格
					$("#sum_price").html(totalmoney); 
					$("#sum_price_end").html(totalmoney-redpackMoney); 
					$("#totalmoney").val(totalmoney); 
				}else{ 
					$("#sum_price").html(totalPrice);
					$("#sum_price_end").html(totalPrice-redpackMoney); 
					$("#totalmoney").val(totalPrice);
					$("#sumOrdermoney").text(totalPrice);
				}
				
	        }
		});
	}
	//获取译员单价
	function getUserMonery(){
		orderList=[];
		$('#transnFee tr').each(function () {
	            var fee = $(this).find(".fee_monery").val();
	            var userid=$(this).find(".user_id").val();
	            var option={userid:userid,fee:fee}
	           orderList.push(option);
	    });
	}
}();





