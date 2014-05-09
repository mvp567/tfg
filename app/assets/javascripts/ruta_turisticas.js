$(function() {
    $( "#sortable" ).sortable({
      placeholder: "ui-state-highlight"
    });
    $( "#sortable" ).disableSelection();
});


$(function() {
    /*var availableTags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ];*/

    $( "#tags" ).autocomplete({
      //source: availableTags
      source: function( request, response ) {
        $.ajax({
           url: '/pdis',
           dataType: "json",
           data: {
            featureClass: "P",
            style: "full",
            maxRows: 12,
            request_term: request.term
          },
          success: function( data ) {
            response( $.map( data, function( item ) {
              return {
                label: item.nom, //+ (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
                value: item.nom 
                //item.id
              }
            }));
          }
        });
      }


    });
  });