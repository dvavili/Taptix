// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
    $("#reg_details").css("display","none");
        $(".reg_req").click(function(){
        if ($('input[name=reg]:checked').val() == "No" ) {
            $("#reg_details").slideDown("fast"); //Slide Down Effect
        } else {
            $("#reg_details").slideUp("fast");  //Slide Up Effect
        }
     });
});