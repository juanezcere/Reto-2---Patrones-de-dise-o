import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provider_entity.dart';
import '../repositories/provider_repository.dart';

class GetProvidersUseCase {
  final ProviderRepository repository;
  GetProvidersUseCase(this.repository);

  Future<Either<Failure, List<ProviderEntity>>> call({String? category}) =>
      repository.getProviders(category: category);
}
