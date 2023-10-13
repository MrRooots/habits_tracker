import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/services/network_info.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:http/http.dart' as http;

import 'package:habits_tracker/core/exceptions/exceptions.dart';
import 'package:habits_tracker/core/constants/urls.dart';
import 'package:habits_tracker/core/services/session.dart';

import 'package:habits_tracker/features/data/models/habit_model.dart';

abstract interface class RemoteDataSource {
  /// Upload new habit to server
  ///
  /// Throws [ServerException] or [ConnectionException]
  Future<HabitModel> createHabit({
    required final String title,
    required final String description,
    required final HabitType type,
    required final Priority priority,
    required final int date,
    required final int count,
    required final int frequency,
  });

  /// Update existing habit on server
  ///
  /// Throws [ServerException] or [ConnectionException]
  Future<bool> updateHabit({required final HabitModel newHabit});

  /// Delete habit from server
  ///
  /// Throws [ServerException] or [ConnectionException]
  Future<bool> deleteHabit({required final HabitModel habit});
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkInfo networkInfo;
  final Session session;

  const RemoteDataSourceImpl({
    required this.networkInfo,
    required this.session,
  });

  @override
  Future<HabitModel> createHabit({
    required final String title,
    required final String description,
    required final HabitType type,
    required final Priority priority,
    required final int date,
    required final int count,
    required final int frequency,
  }) async {
    if (await networkInfo.isConnected) {
      final http.Response response = await session.post(
        url: Urls.habits,
        data: {
          "title": title,
          "description": description,
          "type": type.index,
          "priority": priority.index,
          "date": date,
          "count": count,
          "frequency": frequency,
        },
      );

      if (response.body.isEmpty) {
        throw ServerException(
          code: response.statusCode,
          message: 'Unexpected server failure :(',
        );
      }

      final Map<String, dynamic> responseJson =
          await compute(_parseResponse, response.body);

      if (response.statusCode == 200) {
        return HabitModel.fromJson(responseJson);
      } else {
        throw ServerException(
          code: responseJson['code'],
          message: responseJson['message'],
        );
      }
    } else {
      throw const ConnectionException(
        code: 0,
        message: Constants.noInternet,
      );
    }
  }

  @override
  Future<bool> updateHabit({required final HabitModel newHabit}) async {
    if (await networkInfo.isConnected) {
      final http.Response response = await session.patch(
        url: '${Urls.habits}/${newHabit.uid}',
        data: newHabit.toJson(),
      );

      if (response.body.isEmpty) {
        throw ServerException(
          code: response.statusCode,
          message: 'Empty response body',
        );
      }

      final Map<String, dynamic> responseJson =
          await compute(_parseResponse, response.body);

      if (response.statusCode == 200) {
        return responseJson['success'];
      } else if (response.statusCode == 400) {
        throw RequestException(
          code: responseJson['code'],
          message: responseJson['message'],
        );
      } else {
        throw ServerException(
          code: responseJson['code'],
          message: responseJson['message'],
        );
      }
    } else {
      throw const ConnectionException(
        code: 0,
        message: Constants.noInternet,
      );
    }
  }

  @override
  Future<bool> deleteHabit({required final HabitModel habit}) async {
    if (await networkInfo.isConnected) {
      final http.Response response = await session.delete(
        url: '${Urls.habits}/${habit.uid}',
      );

      if (response.body.isEmpty) {
        throw ServerException(
          code: response.statusCode,
          message: 'Empty response body',
        );
      }

      final Map<String, dynamic> responseJson =
          await compute(_parseResponse, response.body);

      if (response.statusCode == 200) {
        return responseJson['success'];
      } else if (response.statusCode == 400) {
        throw RequestException(
          code: responseJson['code'],
          message: responseJson['message'],
        );
      } else {
        throw ServerException(
          code: responseJson['code'],
          message: responseJson['message'],
        );
      }
    } else {
      throw const ConnectionException(
        code: 0,
        message: Constants.noInternet,
      );
    }
  }

  /// Json parsing to use in compute function
  ///
  /// Returns response parsed to json
  Map<String, dynamic> _parseResponse(final String responseBody) {
    final Map<String, dynamic> responseJson = convert.jsonDecode(responseBody);

    return responseJson;
  }
}
