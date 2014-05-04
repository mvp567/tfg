
$( document ).ready(function() {
    $('#tagid').submit(function() {  
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            url: $(this).attr('action'), //sumbits it to the given url of the form
            data: valuesToSubmit,
            dataType: "script" // you want a difference between normal and ajax-calls, and json is standard
        });
        return false; // prevents normal behaviour
    });
});