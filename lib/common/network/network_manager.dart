import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/constants.dart';
import '../errors/exceptions.dart';

@injectable
class NetworkManager {
  Dio dio = Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      validateStatus: (_) => true))
    ..options.baseUrl = baseUrl
    ..options.connectTimeout = const Duration(milliseconds: 10000)
    ..options.receiveTimeout
    ..options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers.putIfAbsent("Authorization",
          () => "Bearer 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");
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      if (e.type == DioErrorType.unknown) {
      } else if (e.type == DioErrorType.connectionTimeout) {}

      return handler.next(e);
    }));

  Future<dynamic> post(String url, dynamic data) async {
    try {
      return await dio.post(url, data: data);
    } on Exception {
      throw ConnectionException();
    }
  }

  Future<dynamic> get(String url) async {
    try {
      return await dio.get(url);
    } on Exception {
      throw ConnectionException();
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    try {
      return await dio.put(url, data: data);
    } on Exception {
      throw ConnectionException();
    }
  }
}
