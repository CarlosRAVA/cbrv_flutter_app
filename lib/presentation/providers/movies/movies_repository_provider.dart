
import 'package:cbrv_movies_app/infrastructure/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovidedbDatasourceImpl());
});