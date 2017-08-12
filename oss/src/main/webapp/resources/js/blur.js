//created by cherry.xia
//2017.4.21
$(function(){
	$('body').on('focus','.search-keys',function(){
        var dropSubMenu = $(this).siblings('.drop-sub-menu');
        //var sltStr;
        dropSubMenu.slideDown();
        getStr(dropSubMenu);
        //sltStr = getStr(dropMenu);
        //$(this).find('input').val(sltStr);

        function getStr(obj){
            $(obj).on('click','li',function(){
                $(this).parents('.drop-sub-menu').find('li').removeClass('on');
                $(this).addClass('on');
                var str = $(this).html();
                $(this).parents('.search').find('.search-keys').val(str);
                dropSubMenu.slideUp();
            });
        }
    });
	$('body').on('blur','.search-keys',function(){
        $('.drop-sub-menu').slideUp();
    });
})