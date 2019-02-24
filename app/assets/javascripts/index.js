$("#menu li").hover(function() {
    $(this).children('ul').show();
}, function() {
    $(this).children('ul').hide();
});

$('.pattern4').slick({
  centerMode: true,
  centerPadding: '160px'
  accessibility: true,
  autoplaySpeed: 3000,
  fade: true,
  arrows: true,
  speed: 400,
});
