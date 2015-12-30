/**
 * Created by fabiomadeira on 25/02/15.
 */
// jQuery for page scrolling feature
jQuery(document).ready(function(e) {
    e(".scroll").click(function(t) {
        t.preventDefault();
        e("html,body").animate({
            scrollTop: e(this.hash).offset().top
        }, 1e3)
    })
});

$(function () {

    $("#toggle").click(function (event) {
        event.preventDefault();
        var target = $(this).attr("href");
        $(target).toggleClass("hidden");
    });

});



var trigger = document.getElementById('teaching-trigger'); //to toggle teaching panel

trigger.addEventListener('click', function(e) {
    e.preventDefault();
    var id = trigger.getAttribute('href').replace("#", "");
    var target = document.getElementById(id);
    target.classList.toggle('hidden'); 
});
