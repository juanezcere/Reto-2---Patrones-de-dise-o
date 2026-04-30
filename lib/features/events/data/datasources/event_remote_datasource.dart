import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getArtistEvents(int artistId);
  Future<EventModel> createEvent({
    required String title,
    required String date,
    required String location,
    required int artistId,
  });
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final Dio dio;
  EventRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<EventModel>> getArtistEvents(int artistId) async {
    try {
      final response = await dio.get('/artists/$artistId/events');
      final list = response.data as List;
      return list
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }

  @override
  Future<EventModel> createEvent({
    required String title,
    required String date,
    required String location,
    required int artistId,
  }) async {
    try {
      final response = await dio.post('/events', data: {
        'title': title,
        'date': date,
        'location': location,
        'artist_id': artistId,
      });
      return EventModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }
}
