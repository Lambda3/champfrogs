$ ->
  $("#motivators").sortable({ axis: "x" })
  $("#motivators").disableSelection()
  $( "#motivators" ).on "sortover", (event, ui) ->
    $(ui.item).tooltip("toggle")

  $(".motivator").each (index) ->
    $(this).tooltip(title: Window.motivatorsDescription[index]) 
