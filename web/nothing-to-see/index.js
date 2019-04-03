_link = "a secret in plain sight >:)";

$(document).ready(function(){
    $("a").click(function(){
        $(this).fadeOut(200, function() {
          $(this).parent().text(_link).fadeIn(200);
        });
    });
});