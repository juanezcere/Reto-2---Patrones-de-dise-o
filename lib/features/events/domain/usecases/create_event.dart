import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository repository;
  CreateEventUseCase(this.repository);

  Future<Either<Failure, Event>> call({
    required String title,
    required String date,
    required String location,
    required int artistId,
  }) =>
      repository.createEvent(
        title: title,
        date: date,
        location: location,
        artistId: artistId,
      );
}
