import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_architecture/data/models/response/question_response.dart';

import '../../core/error/failure.dart';
import '../models/request/question_request.dart';
import '../models/response/question_response.dart';

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

class RemoteApi {
  static const String url = "https://opentdb.com/api.php";

  Future<List<QuestionResponse>> getQuestion(QuestionRequest request) async {
    // appel ws
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

      // récupérer réponse

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(
          data["results"],
        );
        if (results.isNotEmpty) {
          return results
              .map(
                (e) => QuestionResponse.fromMap(e),
              )
              .toList();
        }
      }
      return [];
      // Gérer  les erreurs
    } on DioError catch (err) {
      debugPrint(
        err.toString(),
      );
      throw Failure(
          message: err.response?.statusMessage ?? 'Something went wrong');
    } on SocketException catch (err) {
      debugPrint(err.toString());

      throw const Failure(message: 'Please check your connection');
    }
  }
}
