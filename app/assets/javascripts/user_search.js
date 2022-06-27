$(document).ready(function () {
  $("#users-search-bar #term").on("keyup", function () {
    var jqxhr = $.get(
      $("#users-search-bar").attr("action"),
      { term: $("#users-search-bar #term").val() },
      function () {
        var result = $("#users-search-result").html();
        if (!result) {
          $("#users-search-bar #term").popover({
            content: "No result found.",
            placement: "bottom",
            html: true,
            trigger: "focus"
          });
        } else {
          $("#users-search-bar #term").popover({
            content: $("#users-search-result"),
            placement: "bottom",
            html: true,
            trigger: "focus"
          });
        }
        $("#users-search-bar #term").popover("show");
      }
    )
  })
});
