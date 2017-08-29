jQuery(function($) {
  $('#main-search').keypress(function (e) {
    if (e.which == 13) {
      var textQuery = $('#main-search').val();

      $.get('search', { text_query: textQuery }, function(result) {
        $('.main-result').empty();

        var htmlToInsert = convertToHtml(result['result']);

        $('.main-result').html(htmlToInsert);
      });
    }
  });

  function convertToHtml(receivedData) {
    var html = '';

    $.each(receivedData, function(_index, data) {
      html += "<div class='card'>";
      html += "<div class='card-body'>"
      html += "<p><h3>" + data['Name'] + "</h3></p>"
      html += "<p><dl class='row'>";
      html += "<dt class='col-sm-3'>Type</dt>"
      html += "<dd class='col-sm-9'>" + data['Type'] + "</dd>"
      html += "<dt class='col-sm-3'>Designed By</dt>"
      html += "<dd class='col-sm-9'>" + data['Designed by'] + "</dd>"
      html += "</p></dl>";
      html += "</div>"
      html += "</div>"
      html += "<br>"
    });

    return html;
  }
});
