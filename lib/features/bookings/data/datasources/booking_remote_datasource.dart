import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getEventBookings(int eventId);
  Future<BookingModel> createBooking({
    required int eventId,
    required int providerId,
  });
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;
  BookingRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<BookingModel>> getEventBookings(int eventId) async {
    try {
      final response = await dio.get('/events/$eventId/bookings');
      final list = response.data as List;
      return list
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }

  @override
  Future<BookingModel> createBooking({
    required int eventId,
    required int providerId,
  }) async {
    try {
      final response = await dio.post('/bookings', data: {
        'event_id': eventId,
        'provider_id': providerId,
      });
      return BookingModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error');
    }
  }
}
