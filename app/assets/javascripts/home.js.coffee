$ ->
  $("#motivators").sortable({ axis: "x" })
  $("#motivators").disableSelection()
  $( "#motivators" ).on "sortover", (event, ui) ->
    $(ui.item).tooltip("toggle")

  $("#motivators li").on "mouseleave", ->
    $("#description").html("Ordene os itens segudo seu entendimento")

  $("#motivators li").on "mouseenter", ->
    $("#description").html(Window.motivatorsDescription[$(this).data("index")]) 
