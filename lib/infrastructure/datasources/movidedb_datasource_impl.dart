import 'package:cbrv_movies_app/config/config.dart';
import 'package:cbrv_movies_app/domain/datasources/movies_datasource.dart';
import 'package:cbrv_movies_app/domain/entities/actor.dart';
import 'package:cbrv_movies_app/domain/entities/movie.dart';
import 'package:cbrv_movies_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cbrv_movies_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cbrv_movies_app/infrastructure/models/moviedb/moviedb_credits.dart';
import 'package:cbrv_movies_app/infrastructure/models/moviedb/moviedb_detail.dart';
import 'package:cbrv_movies_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasourceImpl extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': Environment.language,
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final credits = MovieDbCredits.fromJson(response.data);

    List<Actor> actors = credits.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    final movies = movieDbResponse.results
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id $id not found');
    }

    final datail = MovieDbDetail.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailToEntity(datail);
    return movie;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    // TODO: implement getPopular
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getSimilarMovie(String movieId) {
    // TODO: implement getSimilarMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    // TODO: implement getTopRated
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    // TODO: implement getUpcoming
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getYoutubeVideoById(String id) {
    // TODO: implement getYoutubeVideoById
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    // TODO: implement searchMovie
    throw UnimplementedError();
  }
}


//! git commit -m "add: Uso de estructura limpia"