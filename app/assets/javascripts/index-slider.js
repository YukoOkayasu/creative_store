$(document).on('turbolinks:load', function() {
  $('.bxslider').bxSlider({
    pause: 3000,
    slideWidth: 'auto',
    randomStart: false,
    infiniteLoop: false,
    adaptiveHeight: true,
    controls: true,
    ticker: true,
    minSlides: 1,
    maxSlides: 4,
    slideMargin: 10,
    tickerHover: true,
    speed: 30000,
    moveSlides: 1,
  });
});
