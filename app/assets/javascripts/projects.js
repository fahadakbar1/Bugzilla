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
    'project[description]': 'required'
    }
});
});
