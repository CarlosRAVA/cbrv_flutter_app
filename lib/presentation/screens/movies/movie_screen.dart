import 'package:flutter/material.dart';
import 'package:cbrv_movies_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cbrv_movies_app/config/config.dart';
import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:cbrv_movies_app/presentation/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          //AppBar
          _CustomSliverAppBar(movie: movie),
          //Description
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titulo, overview y rating
        _TitleAndOverview(movie: movie),

        // Todo: Generos de la pelicula
        MovieGenres(movie: movie),

        // Todo: Actores de la pelicula
        ActorsByMovie(movieId: movie.id.toString()),

        // Todo: Trailers de la pelicula

        // Todo: Peliculas similares
      ],
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  final Movie movie;
  const _TitleAndOverview({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(movie.posterPath, width: size.width * 0.3),
          ),

          SizedBox(width: 10),

          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleLarge),
                Text(
                  movie.overview.isNotEmpty
                      ? movie.overview
                      : 'Sin información',
                ),

                SizedBox(height: 10),
                MovieRating(voteAverage: movie.voteAverage),

                Row(
                  children: [
                    Text(
                      'Estreno',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.red),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 0),
        title: _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return CircularProgressIndicator();
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.4],
              colors: [Colors.black54, Colors.transparent],
            ),
            _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final List<double>? stops;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.colors,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}

//! git commit -m "fix: Construcción del detalle de la pelicula"