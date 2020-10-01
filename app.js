/* UI-related code, which is not expected to influence Ur/Web functioning.

Includes:
* click interval adjustments for mobile devices
* smooth scrolling
* menu positioning.

 */

jQuery(function ($) {

    // make menu visible everytime on tablets and larger screens
    positionMenu=()=>{
        var viewportHeight = window.innerHeight;
        var menuHeight = $('.menu').height();
        var logoHeight = viewportHeight - menuHeight;
        var releaseAt = $('.img_resp').height();
        
        if (($(window).scrollTop() > releaseAt) && (window.innerWidth > 768)){
            $('.menu').css({position: 'fixed', top: '0px'});
        } else {
            $('.menu').css({position: 'relative'});
        };
    }
    window.addEventListener("orientationchange", positionMenu);
    $(window).scroll(positionMenu);
    $(window).resize(positionMenu);
    positionMenu();
    // END make menu visible everytime on tablets and larger screens

    // remove 300ms delay on mobile devices
    FastClick.attach(document.body);
    // remove 300ms delay on mobile devices
    
    // smooth scrolling for intra-page anchors
    $('.menu a').bind('click', function (e) {
        var hash = "#" + $(this).attr('href').split("#").pop();
        var target = $(hash);
        $('html, body').stop().animate(
            {
                scrollTop: target.offset().top
            }, 
            { 
                duration: 150,
                complete: function (){ window.location.hash = hash; }
            }
        );
        e.preventDefault();
    });
    // END smooth scrolling for intra-page anchors

});
