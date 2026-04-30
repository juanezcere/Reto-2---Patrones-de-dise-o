import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Booking>>> getEventBookings(
      int eventId) async {
    try {
      return Right(await remoteDataSource.getEventBookings(eventId));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Booking>> createBooking({
    required int eventId,
    required int providerId,
  }) async {
    try {
      return Right(await remoteDataSource.createBooking(
        eventId: eventId,
        providerId: providerId,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
