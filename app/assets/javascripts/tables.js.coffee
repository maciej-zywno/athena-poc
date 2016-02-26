jQuery ->
  $("tr[data-link]").on "click", "td:not(.actions)", ->
    window.location = $(this).parent().data("link")
