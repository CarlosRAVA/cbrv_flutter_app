import 'package:card_swiper/card_swiper.dart';
import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return movies.isNotEmpty
        ? SizedBox(
            height: 210,
            width: double.infinity,
            child: Swiper(
              scale: 0.9,
              viewportFraction: 0.8,
              autoplay: true,
              autoplayDelay: 500,
              pagination: SwiperPagination(
                margin: EdgeInsets.only(top: 0),
                builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary,
                  color: colors.secondary
                )
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) => _Slide(movie: movies[index]),
            ),
          )
        : SizedBox();
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 10),
          blurRadius: 5,
          color: Colors.black
        )
      ]
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () {
              
            },
            child: Image.network(movie.backdropPath, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
              if (loadingProgress == null) return child;

              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                   ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                   : null,
                ),
              );
            },),
          ),
        )
      ),
    );
  }
}