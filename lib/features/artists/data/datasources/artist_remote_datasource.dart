import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/artist_model.dart';

abstract class ArtistRemoteDataSource {
  Future<List<ArtistModel>> getArtists();
  Future<ArtistModel> createArtist(String name, String email);
}

class ArtistRemoteDataSourceImpl implements ArtistRemoteDataSource {
  final Dio dio;
  ArtistRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ArtistModel>> getArtists() async {
    try {
      final response = await dio.get('/artists');
      final list = response.data as List;
      return list
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }

  @override
  Future<ArtistModel> createArtist(String name, String email) async {
    try {
      final response = await dio.post(
        '/artists',
        data: {'name': name, 'email': email},
      );
      return ArtistModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }
}
