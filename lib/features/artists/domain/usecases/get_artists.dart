import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/artist.dart';
import '../repositories/artist_repository.dart';

class GetArtistsUseCase {
  final ArtistRepository repository;
  GetArtistsUseCase(this.repository);

  Future<Either<Failure, List<Artist>>> call() => repository.getArtists();
}
