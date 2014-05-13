$(function() {
    $( "#sortable" ).sortable({
      placeholder: "ui-state-highlight",
      stop: function(e, ui) {
        var cont = 1;
      $("li").each(function(event, ui) {
        var element = $(event.target);
        $(ui).children("input[id$='ordre']").val(cont);
        cont++;
      })


        //alert("New position: " + ui.item.index());
            console.log($.map($(this).find('li'), function(el) {
                return el.id + ' = ' + $(el).index();
            }));
        }
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