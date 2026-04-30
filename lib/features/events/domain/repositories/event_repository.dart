import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getArtistEvents(int artistId);
  Future<Either<Failure, Event>> createEvent({
    required String title,
    required String date,
    required String location,
    required int artistId,
  });
}
