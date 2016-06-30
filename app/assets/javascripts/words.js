var checkbox_tick = function() {
  $('.chb').on('change', function(){
  $('.chb').not(this).prop('checked', false);
  });
};                                   
$(document).ready(checkbox_tick);            
$(document).on('page:load', checkbox_tick);

var add_answer = function(){$('.add_answer').click(function() {
    var association = $(this).attr('data-association');
    var target = $(this).attr('target');
    var regexp = new RegExp('new_' + association, 'g');
    var new_id = new Date().getTime();
    var Dest = (target == '') ? $(this).parent() : $('#'+target);
    Dest.append(window[association+'_fields'].replace(regexp, new_id));
    checkbox_tick();
    remove_link();
    return false;
  });
};

$(document).ready(add_answer);            
$(document).on('page:load', add_answer);

var remove_link = function(){
  $('.remover_link').click(function(event){
    $(this).prev('input[type=hidden').val('1');
    $(this).closest('.removable').hide();
  });
};

$(document).ready(remove_link);            
$(document).on('page:load', remove_link);

function timeOut(){
  $('.edit_lesson').submit();
}

function startTimer(duration, display, form) {
  var timer = duration, minutes, seconds;
  setInterval(function () {
    minutes = parseInt(timer / 60, 10);
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    display.text(minutes + ':' + seconds);
    if (--timer < 0) {
      timeOut();
    }
  }, 1000);
}

jQuery(function ($) {
  var lesson_time = 20*60, display = $('#time');
  startTimer(lesson_time, display);
});
