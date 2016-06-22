$(document).ready(function(){
  $('.chb').change(function(){
    $('.chb').prop('checked', false);
    $(this).prop('checked', true);
  });

  $('.add_answer').click(function() {
    var association = $(this).attr('data-association');
    var target = $(this).attr('target');
    var regexp = new RegExp('new_' + association, 'g');
    var new_id = new Date().getTime();
    var Dest = (target == '') ? $(this).parent() : $('#'+target);
    Dest.append(window[association+'_fields'].replace(regexp, new_id));
    return false;
  });

  $('.remover_link').click(function(event){
    $(this).prev('input[type=hidden').val('1');
    $(this).closest('.removable').hide();
  });
})
