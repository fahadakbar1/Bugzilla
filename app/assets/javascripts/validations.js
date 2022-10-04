$(document).on('turbolinks:load', function() {
$(document).ready(function(){
$('form').validate({
    onfocusout: function (element) {
        $(element).valid();
    },
    rules: {

   'project[title]': {
       required: true,
       minlength: 6
     },
    'project[description]': 'required',
    'bug[title]': {
       required: true,
       minlength: 6
     },
      'user[username]': 'required',
      'user[email]': 'required',
      'user[password]' : {
       required: true,
       minlength: 6
     },
      'user[password_confirmation]': 'required',
     }
});

$('.dev_form').submit(function(event){

  var $form = $(this);

  var x = $form.find("select");
  if (x.val() == null){
    alert("Developer was not selected");
    return false;}
});

$('.qa_form').submit(function(event){

  var $form = $(this);

  var x = $form.find("select");
  if (x.val() == null){
    alert("QA was not selected");
    return false;}
});

});
});
