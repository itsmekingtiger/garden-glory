class UndefinedBehavior extends Error implements UnsupportedError {
  @override
  final String? message;

  UndefinedBehavior([this.message]);

  @override
  String toString() {
    var message = this.message;
    return (message != null) ? 'UndefinedBehavior: $message' : 'UndefinedBehavior';
  }
}

class NotReachable extends Error implements UnsupportedError {
  @override
  final String? message;

  NotReachable([this.message]);

  @override
  String toString() {
    var message = this.message;
    return (message != null) ? 'NotReachable: $message' : 'NotReachable';
  }
}
