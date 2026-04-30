import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

Dio createDioClient() {
  return Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));
}
