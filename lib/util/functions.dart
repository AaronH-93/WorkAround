import 'package:async/async.dart';

//and get him to explain this
class ResultExtended<T> {
  static Future<Result<T>> fromFutureWithTimeout<T>(
      Future<T> Function() computation) async {
    try {
      return ValueResult<T>(
        await computation().timeout(const Duration(seconds: 3)),
      );
    } catch (e, s) {
      return ErrorResult(e, s);
    }
  }
}

class Success {}
