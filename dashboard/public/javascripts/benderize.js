(function($) {
  $.fn.benderize = function(options) {
    var defaults = {
      enterOn: 'click', //timer, konami-code, click
      delayTime: 5000   //time before bender on timer mode
    };
    var options = $.extend(defaults, options);

    return this.each(function() {
      var _this = $(this);
      var audioSupported = false;
      if ($.browser.mozilla && $.browser.version.substr(0, 5) >= "1.9.2" || $.browser.webkit) {
        audioSupported = true;
      }

      var benderImageMarkup = '<img id="bmsma-image" style="display: none" src="bmsma.png" />'
      var benderAudioMarkup = '<audio id="bmsma-audio" preload="auto"><source src="bmsma.mp3" /><source src="bmsma.ogg" /></audio>';
      var locked = false;

      $('body').append(benderImageMarkup);
      if(audioSupported) { $('body').append(benderAudioMarkup); }
      var bender = $('#bmsma-image').css({
        "position":"fixed",
        "bottom": "-800px",
        "left" : "0",
        "display" : "block"
      })

      function init() {
        locked = true;

        if(audioSupported) {
          function playSound() {
            document.getElementById('bmsma-audio').play();
          }
          playSound();
        }

        bender.animate({
          "bottom" : "0"
        }, function() {
          $(this).animate({
            "bottom" : "-130px"
          }, 100, function() {
            var offset = (($(this).position().left)+1600);
            $(this).delay(300).animate({
              "left" : offset
            }, 2200, function() {
              bender = $('#bmsma-image').css({
                "bottom": "-800px",
                "left" : "0"
              })
              locked = false;
            })
          });
        });
      }

      if(options.enterOn == 'timer') {
        setTimeout(init, options.delayTime);
      } else if(options.enterOn == 'click') {
        _this.bind('click', function(e) {
          e.preventDefault();
          if(!locked) {
            init();
          }
        })
      } else if(options.enterOn == 'konami-code'){
        var kkeys = [], konami = "38,38,40,40,37,39,37,39,66,65";
        $(window).bind("keydown.benderz", function(e){
          kkeys.push( e.keyCode );
          if ( kkeys.toString().indexOf( konami ) >= 0 ) {
            init();
            $(window).unbind('keydown.benderz');
          }
        }, true);

      }

    });
  }
})(jQuery);
