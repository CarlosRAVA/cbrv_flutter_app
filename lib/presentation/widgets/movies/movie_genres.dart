import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:flutter/material.dart';

class MovieGenres extends StatelessWidget {
  final Movie movie;

  const MovieGenres({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map(
              (g) => Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(g.toString()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}