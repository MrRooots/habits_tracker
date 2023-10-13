final class Urls {
  /// Domain url
  static const String domain = 'https://habits-internship.doubletapp.ai';

  /// Base API url
  static const String baseUrl = '$domain/api';

  /// Habits manipulation url [GET, POST, PATCH (with id), DELETE (with id)]
  static const String habits = '$baseUrl/habits';
}
