// JavaScript Document
$(document).ready(function () {
    $('#Top .Toolbar1 .CentreBox .Menu .List1 li').mouseenter(function () {
        var index = $(this).parent().children().index(this);
        $(this).parent().children().each(function () {
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).addClass('Select');

        $('#Top .Toolbar2 .CentreBox .Menu').each(function () {
            if (!$(this).hasClass('Hide')) {
                $(this).addClass('Hide');
            }
        });
        $('#Top .Toolbar2 .CentreBox .Menu').eq(index).removeClass('Hide');
    });
    
    $('#Top .Toolbar1 .CentreBox .Menu .List1 li').click(function () {
        var index = $(this).parent().children().index(this);
        $(this).parent().children().each(function () {
            if ($(this).hasClass('Click')) {
                $(this).removeClass('Click');
            }
            $(this).find("a").css({color:"#FFFFFF"});
        });
        $(this).addClass('Click');
        $(this).find("a").css({color:"#383838"});

    
    });
    
 

    $('#Top .Toolbar2 .CentreBox .Menu ul li a').mouseenter(function () {
        var index = $('#Top .Toolbar2 .CentreBox .Menu ul li a').index(this);
        $('#Top .Toolbar2 .CentreBox .Menu ul li').each(function () {
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).parent().addClass('Select');
    });
});