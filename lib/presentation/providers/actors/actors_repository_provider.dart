import 'package:cbrv_movies_app/infrastructure/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasourceImpl());
});