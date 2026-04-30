import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/provider_repository.dart';

class GetCategoriesUseCase {
  final ProviderRepository repository;
  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<String>>> call() =>
      repository.getCategories();
}
