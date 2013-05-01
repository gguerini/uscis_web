$(document).ready(function() {
  $('#check_form')
    .on('ajax:success', function(data, status, xhr) {
      var template = document.getElementById('item-template').innerHTML;
      output = Mustache.render(template, { results: status });
      $("#results").html(output);
    })
    .on('ajax:error', function(xhr, status, error) {
      $("#results").html("Something went wrong. :(");
    });
});
