import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/artist.dart';
import '../../domain/repositories/artist_repository.dart';
import '../datasources/artist_remote_datasource.dart';

class ArtistRepositoryImpl implements ArtistRepository {
  final ArtistRemoteDataSource remoteDataSource;
  ArtistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Artist>>> getArtists() async {
    try {
      return Right(await remoteDataSource.getArtists());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Artist>> createArtist(
      String name, String email) async {
    try {
      return Right(await remoteDataSource.createArtist(name, email));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
