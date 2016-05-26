jQuery(document).ready(function($) {

  var login_link = $("#link-to-login");
  var header_login_form = $("#header_login_form");
  var cart_link = $(".cart_link");
  var cart_info_form = $("#cart_info_form");
  var search_link = $("#header_search_link");
  var search_form = $("#header_search_form");

  // $(".product-property-desc").click(function(event) {
  //   var property = $(this).parent().find(".product-property-value");
  //   property.slideToggle();
  // });

  // var add_hover_effect = function(link, form){
  //   link.bind('mouseover', null, function(event) {
  //     $(".float_active").hide();
  //     form.show();
  //     form.addClass('float_active');
  //     link.mouseleave(function(event) {
  //       setTimeout(function(){
  //         if(form.is(':hover')){ return; }
  //         form.hide();
  //       }, 2000);
  //     });
  //   });
  //   form.bind('mouseleave', null, function(event) {
  //     $(this).hide();
  //   });
  // }

  // add_hover_effect(login_link, header_login_form);
  // add_hover_effect(cart_link, cart_info_form);
  // add_hover_effect(search_link, search_form);

  $.each(['privacy', 'law', 'customer'], function(index, val) {
    $("#info_" + val).bind('click', null, function(event) {
      $.ajax({
        url: "/info/" + val,
        type: 'POST',
        dataType: 'script',
        data: null
      });
    });
  });

  // 避免在 dropdown-menu 中无法点击其他
  $("ul.dropdown-menu").on("click", "[data-stopPropagation]", function(e) {
    e.stopPropagation();
  });

  if ($(window).width() > 768) {
    $(".menu-search").mouseover(function(){
      $(".menu-search").animate({"width":"250px"});
      $(".menu-search").attr("placeholder", "开启你的peau de fée之旅");
    }).mouseout(function(){
      $(".menu-search").animate({"width":"146px"});
      $(".menu-search").attr("placeholder", "");
    });
  }
});
