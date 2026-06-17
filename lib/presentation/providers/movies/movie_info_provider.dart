import 'package:flutter_riverpod/legacy.dart';
import 'package:cbrv_movies_app/domain/entities/domain.dart';

final movieInfoProvider = StateNotifierProvider();

typedef GetMovieCallback = Future<Movie>Function();

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }).super({});
}