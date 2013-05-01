function notify(notify_type, msg) {
  var alerts = $('#message');
  if (notify_type == 'success') {
    alerts.addClass('alert alerts-success').html(msg);
  }
  if (notify_type == 'failure') {
    alerts.addClass('alert alerts-error').html(msg);
  }
  alerts.append('<button type="button" class="close" data-dismiss="alert">&times;</button>');
}