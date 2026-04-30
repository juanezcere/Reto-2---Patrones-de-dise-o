import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/artist.dart';

abstract class ArtistRepository {
  Future<Either<Failure, List<Artist>>> getArtists();
  Future<Either<Failure, Artist>> createArtist(String name, String email);
}
