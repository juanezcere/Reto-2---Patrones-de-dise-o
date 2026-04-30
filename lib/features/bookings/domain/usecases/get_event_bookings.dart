import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetEventBookingsUseCase {
  final BookingRepository repository;
  GetEventBookingsUseCase(this.repository);

  Future<Either<Failure, List<Booking>>> call(int eventId) =>
      repository.getEventBookings(eventId);
}
