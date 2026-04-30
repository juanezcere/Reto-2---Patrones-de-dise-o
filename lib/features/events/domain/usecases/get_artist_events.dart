import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetArtistEventsUseCase {
  final EventRepository repository;
  GetArtistEventsUseCase(this.repository);

  Future<Either<Failure, List<Event>>> call(int artistId) =>
      repository.getArtistEvents(artistId);
}
