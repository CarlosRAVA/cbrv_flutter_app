
import 'package:cbrv_movies_app/domain/entities/actor.dart';
import 'package:cbrv_movies_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Actor>> getActorsByMovie(String movieId);
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovie(String query);
  Future<List<Movie>> getSimilarMovie(String movieId);
  Future<List<dynamic>> getYoutubeVideoById(String movieId);
}