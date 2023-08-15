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
      'user[password]': 'required',
      'user[password_confirmation]': 'required',
     }
});
});
});
