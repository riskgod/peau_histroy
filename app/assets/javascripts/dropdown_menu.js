$(function() {
    $('ul.menubar ul > li').has('ul').each(function(index) {
        $(this).addClass('menu');
    });
    $('ul.menubar li').mouseover(function() {
        var li = $(this);       
        li.addClass('active');
        li.siblings().find(' > ul').hide();
        
        var ul = li.find(' > ul');
        if ( li.is('.menu') ) {
            var top = li.position().top;
            var width = li.width();
            ul.css('left', width + 1).css('top', top);
        }
        ul.fadeIn('show');
    });
    $('ul.menubar li').mouseout(function() {
        var li = $(this);
        li.removeClass('active');
        
        window.setTimeout(function() {
            if ( !li.is('.active') ) {
                li.find(' > ul').hide();
            }
        }, 50);
    });
});