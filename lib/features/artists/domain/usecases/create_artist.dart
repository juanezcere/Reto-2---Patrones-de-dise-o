import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/artist.dart';
import '../repositories/artist_repository.dart';

class CreateArtistUseCase {
  final ArtistRepository repository;
  CreateArtistUseCase(this.repository);

  Future<Either<Failure, Artist>> call(String name, String email) =>
      repository.createArtist(name, email);
}
