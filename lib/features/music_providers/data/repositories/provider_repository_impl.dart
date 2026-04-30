import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/repositories/provider_repository.dart';
import '../datasources/provider_remote_datasource.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final ProviderRemoteDataSource remoteDataSource;
  ProviderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      return Right(await remoteDataSource.getCategories());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProviderEntity>>> getProviders(
      {String? category}) async {
    try {
      return Right(
          await remoteDataSource.getProviders(category: category));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProviderEntity>> createProvider({
    required String name,
    required String category,
    required String contactInfo,
  }) async {
    try {
      return Right(await remoteDataSource.createProvider(
        name: name,
        category: category,
        contactInfo: contactInfo,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
