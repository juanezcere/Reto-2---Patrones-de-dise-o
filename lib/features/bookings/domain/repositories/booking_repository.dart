import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<Booking>>> getEventBookings(int eventId);
  Future<Either<Failure, Booking>> createBooking({
    required int eventId,
    required int providerId,
  });
}
