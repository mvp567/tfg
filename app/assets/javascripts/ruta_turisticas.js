$(function() {
    $( "#sortable" ).sortable({
      placeholder: "ui-state-highlight"
    });
    $( "#sortable" ).disableSelection();
});

/*
$(function() {
      $(".text_autocomplete").autocomplete ({
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
                label: item.nom,
                value: item.nom
              } //end return
            })); //end response
          }
        });
      }
    });
  });*/