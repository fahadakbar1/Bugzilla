$(document).on('turbolinks:load', function() {
$(document).ready(function(){


$('#signinform').validate({
    onfocusout: function (element) {
        $(element).valid();
    },
    rules: {
      'user[email]': 'required',
      'user[password]': 'required'
     }
});

$('#edit_user').validate({
    onfocusout: function (element) {
        $(element).valid();
    },
    rules: {
      'user[username]': 'required',
      'user[email]': 'required',
      'user[current_password]': 'required',
      'user[password]' : {
       minlength: 6
     },
     }
});


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
      'user[password_confirmation]': 'required'
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

selector = document.getElementsByName('bug[screenshot]');

$(selector).change(function () {
    var ext = this.value.match(/\.(.+)$/)[1];
    switch (ext) {
        case 'png':
        case 'gif':
            break;
        default:
            alert('This is not an allowed file type. Please select PNG or GIF file');
            this.value = '';
    }
});

});
});
