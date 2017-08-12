/**
 * Created by Administrator on 2017/1/4.
 */
$(function(){

    //下拉列表
    $('body').find('.spinner-warp').each(function(){
        $(this).on('click','.state,a',function(){
        	$('.spinner-warp').find('.spinner-box').slideUp();
        	var obj =  $(this).parents('.spinner-warp').find('.spinner-box');
        	if (obj.is(':hidden')){
        		$(this).parents('.spinner-warp').find('.spinner-box').slideDown();
  				stateTxt(obj);
        	}else{
				$(this).parents('.spinner-warp').find('.spinner-box').slideUp();

				/*var firstLang = $('#transerForm .good-lang-first').val();*/
            	/*if(firstLang.length == 0){
            		showEorr('请选择译员第一外语');
            		return false;
            	}

            	var secondLang = $('#transerForm .good-lang-second').val();
    			if(secondLang.length == 0){
    				showEorr('请选择译员第二外语');
    				return false;
    			}

            	var overseasExp = $('#transerForm .overseas-exp').val();
    			if(overseasExp.length == 0){
    				showEorr('请选择译员是否有海外经历');
    				return false;
    			}*/

    			
        	}
        });
    });

    $('.spinner-box').on('mouseover','li',function(){
        $('.spinner-box li').removeClass('on');
        $(this).addClass('on');
    });

    function stateTxt(obj){
        obj.on('click','li',function(){
            var str = $(this).text();
            obj.slideUp();
            obj.parents('.spinner-warp').find('.state').val(str);
        });
    }

    //表单验证
    $('#transerForm .name').blur(function(){
    	var name = $('#transerForm .name').val();

    	if(name.length == 0){
    		showEorr('请输入译员姓名');
    	}
    });
    $('#transerForm .phone-num').blur(function(){
    	var phone = $('#transerForm .phone-num').val();
    	var reg = /^1[3|4|5|7|8]\d{9}$/;

    	if(phone.length == 0){
    		showEorr('请输入译员手机号');
    	}else{
    		if(!reg.test(phone)){
    			$('#transerForm .phone-num').val("");
    			showEorr('手机号格式错误');
    			
    		}
    	}
    });
    $('#transerForm .transer-number').blur(function(){
    	var number = $('#transerForm .transer-number').val();

    	if(number.length == 0){
    		showEorr('请输入译员编号');
    	}
    });
  /*  $('#transerForm .sex').blur(function(){
    	var sex = $('#transerForm .sex').val();

    	if(sex.length == 0){
    		showEorr('请选择译员性别');
    	}
    });*/
   /* $('#transerForm .age').blur(function(){
    	var age = $('#transerForm .age').val();

    	if(age.length == 0){
    		showEorr('请选择译员年龄');
    	}
    });*/
    
    $('#transerForm .resident').blur(function(){
    	var age = $('#transerForm .resident').val();

    	if(age.length == 0){
    		showEorr('请选择译员常住地');
    	}
    });
    //$('#transerForm .good-lang-first').blur(function(){
    	//var firstLang = $('#transerForm .good-lang-first').val();

    	//if(firstLang.length == 0){
    		//showEorr('请选择译员第一外语');
    	//}
    //});
	//$('#transerForm .good-lang-second').blur(function(){
    	//var secondLang = $('#transerForm .good-lang-second').val();

    	//if(secondLang.length == 0){
    		//showEorr('请选择译员第二外语');
    	//}
    //});
    $('#transerForm .trans-exp').blur(function(){
    	var transExp = $('#transerForm .trans-exp').val();

    	if(transExp.length == 0){
    		showEorr('请输入译员翻译经验');
    	}
    });
    //$('#transerForm .resident').blur(function(){
    	//var resident = $('#transerForm .resident').val();

    	//if(resident.length == 0){
    		//showEorr('请输入译员常驻地');
    	//}
    //});
    $('#transerForm .education').blur(function(){
    	var education = $('#transerForm .education').val();

    	if(education.length == 0){
    		showEorr('请输入译员学历');
    	}
    });
	$('#transerForm .srv-times').blur(function(){
    	var srvTimes = $('#transerForm .srv-times').val();

    	if(srvTimes.length == 0){
    		showEorr('请输入译员服务次数');
    	}
    });
    //$('#transerForm .overseas-exp').blur(function(){
    	//var overseasExp = $('#transerForm .overseas-exp').val();

    	//if(overseasExp.length == 0){
    		//showEorr('请选择译员是否有海外经历');
    	//}
    //});
	console.log('擅长领域');
	console.log(goodFieldNum);
    $('#transerForm .good-field').on('click','.filed',function(){
      if($(this).hasClass('on')){
        $(this).removeClass('on');
        goodFieldNum --;
        console.log(goodFieldNum);
        var deleteStr = $(this).val();
        goodField.splice($.inArray(deleteStr,goodField),1);
      }else{
    	
        goodFieldNum ++;
        console.log(goodFieldNum);
        if(goodFieldNum <= 5){
          $(this).addClass('on');
          goodField.push($(this).text());
        }else{
          goodFieldNum = 5;
          showEorr('擅长领域支持多选，最多选择五个');
        }
        
      }
    });
    
    //个性标签
   
    $('#transerForm .character-tags').on('blur','.inp-tag-cont',function(){
    	tagStr = [];
    	var inpTagCont = $(this).parents('.character-tags').find('.inp-tag-cont').val();
    	if(inpTagCont.length == 0){
	    	showEorr('个性标签最少要输入1个字符');
	    }else{
	    	if(inpTagCont.length > 7){
	    		showEorr('个性标签最多只能输入7个字符');
	    		$(this).val(inpTagCont.substring(0,7));
	    	}else{
	    		$(this).parents('.character-tags').find('.inp-tag-cont').val(inpTagCont).attr('readonly','readonly').removeClass('inp-tag-cont');
	    		$(this).parents('.character-tags').find('.delete').css('visibility','visible');
	    		$(this).parents('.character-tags').find('.tag-inp').addClass('tag-inped');
	    	}
	    }
    	
    	$('#transerForm .character-tags').find('.tag-inped').each(function(i){
    		
			tagStr.push($('#transerForm .character-tags .tag-inped').eq(i).find('input').val());
    	});
    });

    $('#transerForm .character-tags').on('click','.btn',function(){
        var characterTagsNum = $('#transerForm .character-tags .tag-list').find('.tag-inp').length ;
        var inpTagCont = $(this).parents('.character-tags').find('.inp-tag-cont').val();
        if($(this).parents('.character-tags').find('input').hasClass('inp-tag-cont')){
          if(inpTagCont.length != 0){
            var node = $('<div class="tag-inp"><input type="text" class="inp-tag-cont" placeholder="请输入标签内容"/><a href="javascript:;" class="delete">删除</a></div>');
            $('#transerForm .character-tags').find('.tag-list').append(node);
            if(characterTagsNum == 3){
              $('#transerForm .character-tags .tag-list').find('.tag-inp:last').remove();
              showEorr('个性标签最多只能添加3个');
            }
          }else{
          showEorr('个性标签最少要输入1个字符');
          }      
        }else{
          var node = $('<div class="tag-inp"><input type="text" class="inp-tag-cont" placeholder="请输入标签内容"/><a href="javascript:;" class="delete">删除</a></div>');
          $('#transerForm .character-tags').find('.tag-list').append(node);
          if(characterTagsNum == 3){
            $('#transerForm .character-tags .tag-list').find('.tag-inp:last').remove();
            showEorr('个性标签最多只能添加3个');
           }
        }
      });

    //删除标签
    $('#transerForm .character-tags').on('click','.tag-list .delete',function(){
    	$(this).parents('.tag-inp').remove();
    	var deleteStr = $(this).siblings('input').val();
    	tagStr.splice($.inArray(deleteStr,tagStr),1);
    });

    //证书
    $('#transerForm .certificate').on('blur','.inp-tag-cont',function(){
    	certificateStr = [];
    	var inpTagCont = $(this).parents('.certificate').find('.inp-tag-cont').val();

    	if(inpTagCont.length == 0){
	    	showEorr('证书最少要输入1个字符');
	    }else{
	    	if(inpTagCont.length > 12){
	    		showEorr('证书最多只能输入12个字符');
	    		$(this).val(inpTagCont.substring(0,12));
	    	}else{
	    		$(this).parents('.certificate').find('.inp-tag-cont').val(inpTagCont).attr('readonly','readonly').removeClass('inp-tag-cont');
	    		$(this).parents('.certificate').find('.delete').css('visibility','visible');
	    		$(this).parents('.certificate').find('.tag-inp').addClass('tag-inped');
	    	}
	    }

    	$('#transerForm .certificate').find('.tag-inped').each(function(i){
			certificateStr.push($('#transerForm .certificate .tag-inped').eq(i).find('input').val());
    	});
    });

    $('#transerForm .certificate').on('click','.btn',function(){
        var characterTagsNum = $('#transerForm .certificate .tag-list').find('.tag-inp').length ;
        var inpTagCont = $(this).parents('.certificate').find('.inp-tag-cont').val();

        if($(this).parents('.certificate').find('input').hasClass('inp-tag-cont')){
          if(inpTagCont.length != 0){
            var node = $('<div class="tag-inp"><input type="text" class="inp-tag-cont" placeholder="填写证书名称"/><a href="javascript:;" class="delete">删除</a></div>');
            $('#transerForm .certificate').find('.tag-list').append(node)
            if(characterTagsNum == 3){
              $('#transerForm .certificate .tag-list').find('.tag-inp:last').remove();
              showEorr('证书最多只能添加3个');
            }
          }else{
            showEorr('证书要输入1个字符');
          }
        }else{
          var node = $('<div class="tag-inp"><input type="text" class="inp-tag-cont" placeholder="填写证书名称"/><a href="javascript:;" class="delete">删除</a></div>');
          $('#transerForm .certificate').find('.tag-list').append(node)
          if(characterTagsNum == 3){
            $('#transerForm .certificate .tag-list').find('.tag-inp:last').remove();
            showEorr('证书最多只能添加3个');
          }
        } 
      });

    //删除证书
    $('#transerForm .certificate').on('click','.tag-list .delete',function(){
    	$(this).parents('.tag-inp').remove();
    	var deleteStr = $(this).siblings('input').val();
    	certificateStr.splice($.inArray(deleteStr,certificateStr),1);
    });

    //表单取消按钮操作
    $('#transerForm').on('click','.cancel-btn',function(){
    	$('#maskBg').show();
    	$('#maskMain').fadeIn();
    	$('#maskMain').find('p').html('确认要取消新增译员吗？');
    });

    //表单确认按钮操作
    $('#transerForm').on('click','.save-btn',function(){
    	var imgFile = $('.inp-file').val();//头像
    	var name = $('#transerForm .name').val();//姓名
    	var phone = $('#transerForm .phone-num').val();//电话
    	var number = $('#transerForm .transer-number').val();//译员编号
    	var sex = $('#transerForm .sex').val();//性别
    	var age = $('#transerForm .age').val();//年龄
    	var firstLang = $('#transerForm .good-lang-first').val();//第一外语
    	var secondLang = $('#transerForm .good-lang-second').val();//第二外语
    	var firstPrice = $('#transerForm .first_price').val();//第一语种报价
    	var secondPrice = $('#transerForm .second_price').val();//第二语种报价
    	var transExp = $('#transerForm .trans-exp').val();//翻译经验
    	var resident = $('#transerForm .resident').val();//常驻地
    	var education = $('#transerForm .education').val();//学历
    	var srvTimes = $('#transerForm .srv-times').val();//服务次数
    	var overseasExp = $('#transerForm .overseas-exp').val();//海外经历
    	var evaluate = $('#transerForm .company_judge').val();//官方评价
    	//console.log("--------"+goodField.length+"-----------");
    	//console.log(secondLang);
    	if($("#haveHeadUrl").val() ==''||$("#haveHeadUrl").val() ==null){
    		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"请上传头像",function(r) {
      			if(r){
      				return false;
      			}
      		})
      		return false;
    	}
    	if(secondLang=='选填'){
    		secondLang='';
    		secondPrice='';
    	}else{
    		if(secondPrice == '' || secondPrice == null || secondPrice == undefined){
    			showEorr('第二语种报价未填写');
    			return false;
    		}
    	}
    	if(name == '' || name == null || name == undefined || phone == '' || phone == null || phone == undefined || number == '' || number == null || number == undefined ||
    	 sex == '' || sex == null || sex == undefined || age == '' || age == null || age == undefined || firstLang == '' || firstLang == null || firstLang == undefined || 
    	 firstPrice == '' || firstPrice == null || firstPrice == undefined ||transExp == '' || transExp == null || transExp == undefined || 
    	 resident == '' || resident == null || resident == undefined || education == '' || education == null || education == undefined ||evaluate == '' || evaluate == null || 
    	 evaluate == undefined||srvTimes == '' || srvTimes == null || srvTimes == undefined || overseasExp == '' || overseasExp == null || overseasExp == undefined ||goodFieldNum==0 )
    	{	
			showEorr('“*”表示必填项');
			return false;
    	}else{
    		var userid =$("#userid").val();
    		var isshow=$("#isshow").val();
    		var eduBeginTime1 = $.trim($("#eduBeginTime1").val());
    		var eduEndTime1 = $.trim($("#eduEndTime1").val());
    		var eduSchool1 = $.trim($("#eduSchool1").val());
    		var eduBeginTime2 = $.trim($("#eduBeginTime2").val());
    		var eduEndTime2 = $.trim($("#eduEndTime2").val());
    		var eduSchool2 = $.trim($("#eduSchool2").val());
    		var wrokBeginTime1 = $.trim($("#wrokBeginTime1").val());
    		var wrokEndTime1 = $.trim($("#wrokEndTime1").val());
    		var company1 = $.trim($("#company1").val());
    		var wrokBeginTime2 = $.trim($("#wrokBeginTime2").val());
    		var wrokEndTime2 = $.trim($("#wrokEndTime2").val());
    		var company2 = $.trim($("#company2").val());
    		var wrokBeginTime3 = $.trim($("#wrokBeginTime3").val());
    		var wrokEndTime3 = $.trim($("#wrokEndTime3").val());
    		var company3 = $.trim($("#company3").val());
    		var wrokBeginTime4 = $.trim($("#wrokBeginTime4").val());
    		var wrokEndTime4 = $.trim($("#wrokEndTime4").val());
    		var company4 = $.trim($("#company4").val());
    		var wrokBeginTime5 = $.trim($("#wrokBeginTime5").val());
    		var wrokEndTime5 = $.trim($("#wrokEndTime5").val());
    		var company5 = $.trim($("#company5").val());
    		var userInfo = $("#userInfo").val();
    		var addtimes=$('#transerForm .estimate-times').val();
    		if(addtimes == null || addtimes == undefined || addtimes == ''){
    			addtimes=0;
    		}
    		if(secondLang==''){
    			var language=firstLang;
    		}else{
    			var language=firstLang+"/"+secondLang;
    		}
    		var photoSecond=$("#photoSecond").val();
    		zdconfirm('<img src="'+ctx+'/resources/images/tishi@2x.png"','你确定要保存该译员信息',function(r) {
    			if(r){
    				$.ajaxFileUpload({
    	    	        url: ctx+'/resume/addUserResume', 
    	    	        type: 'post',
    	    	        data: { userid:userid,username: name,userphonenumber:phone,usernumber:number,sex:sex,age:age,language:language,workyears:transExp,firstPrice:firstPrice,secondPrice:secondPrice,
    	    	        	country:resident,education1:education,servicetime:srvTimes,othercountry:overseasExp,hangye:goodField,perlabel:tagStr,usertechnical:certificateStr,
    	    	        	eduBeginTime1:eduBeginTime1,eduEndTime1:eduEndTime1,eduSchool1:eduSchool1,eduBeginTime2:eduBeginTime2,eduEndTime2:eduEndTime2,
    	    	        	eduSchool2:eduSchool2,wrokBeginTime1:wrokBeginTime1,wrokEndTime1:wrokEndTime1,company1:company1,wrokBeginTime2:wrokBeginTime2,wrokEndTime2:wrokEndTime2,company2:company2,
    	    	        	wrokBeginTime3:wrokBeginTime3,wrokEndTime3:wrokEndTime3,company3:company3,wrokBeginTime4:wrokBeginTime4,wrokEndTime4:wrokEndTime4,company4:company4,wrokBeginTime5:wrokBeginTime5,
    	    	        	wrokEndTime5:wrokEndTime5,company5:company5,userInfo:userInfo,addtimes:addtimes,photoSecond:photoSecond,evaluate:evaluate,isshow:isshow},
    	    	        secureuri: false, //一般设置为false
    	    	        fileElementId: 'uploadfile', // 上传文件的id、name属性名
    	    	        dataType: 'text', //返回值类型，一般设置为json、
    	    	        success: function(data){  
    	    	        	var result=jQuery.parseJSON(jQuery(data).text());
    	    	        	if(result.status==200){
    	    	        		window.location.href=ctx+"/user/getuserinfo?userid="+result.data.result.userid;
    	    	        	}else{
    	    	        		if(result.data){
    	    	        			$("#photoSecond").val(result.data.result.logoimage);
    	    	        		}
    	    	        		zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',result.msg,function(r) {
    			          			if(r){
    			          				return true;
    			          			}
    			          		})
    	    	        	}
    	    	        },
    	    	        error: function(data, status, e){ 
    	    	            alert(e);
    	    	        }
    	    	    });
    			}
    		});
    		
			
    	}
    	
    	
    	
    });

    $('#maskMain').on('click','.no',function(){
    	$('#maskBg').hide();
    	$('#maskMain').fadeOut();
    });

    $('#maskMain').on('click','.yes',function(){
    	if($('#maskMain').find('p').html() == '确认要取消新增译员吗？'){
    		window.location.href=ctx+"/resume/getUserResumeList";
    	}

    	if($('#maskMain').find('p').html() == '译员信息已保存'){
    		//var data = $('#transerForm').serialize();
    		//console.log(data);

    		//$.post('', data , function(jsonResult) {

    		//});
    	}
    });

});

function showEorr(txt) {
    $("#showEorr").html(txt).show();
    setTimeout(function() {
        $("#showEorr").hide();
    }, 2000);
}