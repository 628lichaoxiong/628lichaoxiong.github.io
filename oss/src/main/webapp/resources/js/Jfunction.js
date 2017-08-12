

/* 菜单 */
$().ready(function(){/*
	$('.select_new').click(function(){
		$(this).find('.seleopt').css('display','block');
		$(this).attr('class').indexOf('on')>0?$(this).removeClass('on').find('.seleopt').css('display','none'):$(this).addClass('on');
		$(this).find('.seleopt a').last().css({border:"0"})
		return false;
	})
	$('.select_new .seleopt a').click(function(){
		$('.select_new').removeClass('on').find('.seleopt').hide();
		var sel_o = $(this).parent().parent();
		sel_o.find('i').html($(this).html());
		sel_o.find('.seleopt').css('display','none');
		sel_o.removeClass('on');
		$(this).addClass('selected').siblings().removeClass('selected');
		sel_o.find('input').val($(this).attr('value')).trigger('change');
		return false;
	})*/
	$('body').on('click', '.select_new', function(){
		$('.select_new').removeClass('on').find('.seleopt').hide();
		$(this).find('.seleopt').css('display','block');
		$(this).attr('class').indexOf('on')>0?$(this).removeClass('on').find('.seleopt').css('display','none'):$(this).addClass('on');
		$(this).find('.seleopt a').last().css({border:"0"})
		return false;
	})
	$('body').on('click', '.select_new .seleopt a', function(){
		var sel_o = $(this).parent().parent();
		sel_o.find('i').html($(this).html());
		sel_o.find('.seleopt').css('display','none');
		sel_o.removeClass('on');
		$(this).addClass('selected').siblings().removeClass('selected');
		sel_o.find('input').val($(this).attr('value')).trigger('change');
		return false;
	})

	$('body').click(function(e){
		$('.select_new').removeClass('on').find('.seleopt').hide();
	})
});