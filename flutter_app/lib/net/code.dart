// ignore: import_of_legacy_library_into_null_safe
import 'package:event_bus/event_bus.dart';
import 'package:flutter_app/event/http_error_event.dart';

class Code {
  static const NETWORK_ERROR = -1;
  static const NETWORK_TIMEOUT = -2;
  static const NETWORK_JSON_EXCEPTION = -3;
  static const SUCCESS = 200;
  static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
