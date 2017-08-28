jQuery(function($) {
  $('#main-search').keypress(function (e) {
    if (e.which == 13) {
      var textQuery = $('#main-search').val();

      $.get('search', { text_query: textQuery }, function(result) {
        $('.main-result').text(JSON.stringify(result['result']));
      });
    }
  });
});
