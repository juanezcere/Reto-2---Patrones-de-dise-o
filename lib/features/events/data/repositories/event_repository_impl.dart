import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_datasource.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;
  EventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Event>>> getArtistEvents(int artistId) async {
    try {
      return Right(await remoteDataSource.getArtistEvents(artistId));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Event>> createEvent({
    required String title,
    required String date,
    required String location,
    required int artistId,
  }) async {
    try {
      return Right(await remoteDataSource.createEvent(
        title: title,
        date: date,
        location: location,
        artistId: artistId,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
