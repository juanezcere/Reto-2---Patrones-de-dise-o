import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provider_entity.dart';

abstract class ProviderRepository {
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProviderEntity>>> getProviders(
      {String? category});
  Future<Either<Failure, ProviderEntity>> createProvider({
    required String name,
    required String category,
    required String contactInfo,
  });
}
