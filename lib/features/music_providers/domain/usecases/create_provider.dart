import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provider_entity.dart';
import '../repositories/provider_repository.dart';

class CreateProviderUseCase {
  final ProviderRepository repository;
  CreateProviderUseCase(this.repository);

  Future<Either<Failure, ProviderEntity>> call({
    required String name,
    required String category,
    required String contactInfo,
  }) =>
      repository.createProvider(
        name: name,
        category: category,
        contactInfo: contactInfo,
      );
}
