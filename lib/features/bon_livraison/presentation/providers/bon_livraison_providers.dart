import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/bon_livraison_remote_data_source.dart';
import '../../data/repositories/bon_livraison_repository_impl.dart';
import '../../domain/entities/bon_livraison_entity.dart';
import '../../domain/repositories/bon_livraison_repository.dart';
import '../../domain/usecases/get_bon_livraison.dart';

part 'bon_livraison_providers.g.dart';

@riverpod
BonLivraisonRemoteDataSource bonLivraisonRemoteDataSource(
  BonLivraisonRemoteDataSourceRef ref,
) =>
    BonLivraisonRemoteDataSourceImpl(DioClient());

@riverpod
BonLivraisonRepository bonLivraisonRepository(
  BonLivraisonRepositoryRef ref,
) =>
    BonLivraisonRepositoryImpl(
      ref.watch(bonLivraisonRemoteDataSourceProvider),
    );

@riverpod
GetBonLivraison getBonLivraisonUseCase(GetBonLivraisonUseCaseRef ref) =>
    GetBonLivraison(ref.watch(bonLivraisonRepositoryProvider));

@riverpod
Future<Either<Failure, BonLivraisonEntity>> bonLivraison(
  BonLivraisonRef ref,
  int orderId,
) {
  final usecase = ref.watch(getBonLivraisonUseCaseProvider);
  return usecase(orderId);
}
