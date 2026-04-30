import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository repository;
  CreateBookingUseCase(this.repository);

  Future<Either<Failure, Booking>> call({
    required int eventId,
    required int providerId,
  }) =>
      repository.createBooking(eventId: eventId, providerId: providerId);
}
