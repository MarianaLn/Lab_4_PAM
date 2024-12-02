import 'package:lab4_lunca_pam/domain/entities/wine.dart';

abstract class WineRepository {
  Future<List<Wine>> getWines();
}
