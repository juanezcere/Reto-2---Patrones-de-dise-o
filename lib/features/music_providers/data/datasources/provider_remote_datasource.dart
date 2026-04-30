import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/provider_model.dart';

abstract class ProviderRemoteDataSource {
  Future<List<String>> getCategories();
  Future<List<ProviderModel>> getProviders({String? category});
  Future<ProviderModel> createProvider({
    required String name,
    required String category,
    required String contactInfo,
  });
}

class ProviderRemoteDataSourceImpl implements ProviderRemoteDataSource {
  final Dio dio;
  ProviderRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await dio.get('/categories');
      return (response.data as List).map((e) => e as String).toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }

  @override
  Future<List<ProviderModel>> getProviders({String? category}) async {
    try {
      final response = await dio.get(
        '/providers',
        queryParameters:
            category != null ? {'category': category} : null,
      );
      final list = response.data as List;
      return list
          .map((e) => ProviderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }

  @override
  Future<ProviderModel> createProvider({
    required String name,
    required String category,
    required String contactInfo,
  }) async {
    try {
      final response = await dio.post('/providers', data: {
        'name': name,
        'category': category,
        'contact_info': contactInfo,
      });
      return ProviderModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }
}
