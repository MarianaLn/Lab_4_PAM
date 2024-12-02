import '../../domain/entities/wine.dart';
import '../../domain/repositories/wine_repository.dart';
import '../datasources/wine_datasource.dart';

class WineRepositoryImpl implements WineRepository {
  final WineDataSource dataSource;

  WineRepositoryImpl(this.dataSource);

  @override
  Future<List<Wine>> getWines() async {
    return await dataSource.fetchWines();
  }
}
