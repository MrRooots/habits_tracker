import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:habits_tracker/core/constants/constants.dart';

abstract interface class Session {
  /// Provide [http.get] request to given [url] with specific headers
  ///
  /// On success returns [http.Response]
  Future<http.Response> get({required final String url});

  /// Provide [http.post] request to given [url] with specific headers
  ///
  /// On success returns [http.Response]
  Future<http.Response> post({
    required final String url,
    required final Map<String, dynamic> data,
  });

  /// Provide [http.patch] request to given [url] with specific headers
  ///
  /// On success returns [http.Response]
  Future<http.Response> patch({
    required final String url,
    required final Map<String, dynamic> data,
  });

  /// Provide [http.delete] request to given [url] with specific headers
  ///
  /// On success returns [http.Response]
  Future<http.Response> delete({
    required final String url,
    final Map<String, dynamic>? data,
  });
}

/// Class implements the http session.
/// All requests contains authentication header.
final class SessionImpl implements Session {
  /// Headers and cookies container
  final Map<String, String> headers = {
    'Authorization': Constants.apiKey,
    'Content-Type': 'application/json',
  };

  @override
  Future<http.Response> get({required final String url}) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  @override
  Future<http.Response> post({
    required final String url,
    required final Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: convert.jsonEncode(data),
    );
  }

  @override
  Future<http.Response> patch({
    required String url,
    required final Map<String, dynamic> data,
  }) async {
    return await http.patch(
      Uri.parse(url),
      headers: headers,
      body: convert.jsonEncode(data),
    );
  }

  @override
  Future<http.Response> delete({
    required String url,
    final Map<String, dynamic>? data,
  }) async {
    return await http.delete(
      Uri.parse(url),
      headers: headers,
      body: convert.jsonEncode(data),
    );
  }
}
