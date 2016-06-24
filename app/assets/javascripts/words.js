$(document).ready(function(){
  checkbox_tick();

  $('.add_answer').click(function() {
    var association = $(this).attr('data-association');
    var target = $(this).attr('target');
    var regexp = new RegExp('new_' + association, 'g');
    var new_id = new Date().getTime();
    var Dest = (target == '') ? $(this).parent() : $('#'+target);
    Dest.append(window[association+'_fields'].replace(regexp, new_id));
    checkbox_tick();
    return false;
  });

  $('.remover_link').click(function(event){
    $(this).prev('input[type=hidden').val('1');
    $(this).closest('.removable').hide();
  });
})

function checkbox_tick() {
    $('.chb').on("change", function(){
    $('.chb').not(this).prop('checked', false);
  });
}
