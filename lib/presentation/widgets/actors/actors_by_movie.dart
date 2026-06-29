import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbrv_movies_app/presentation/providers/providers.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const ActorsByMovie({super.key, required this.movieId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 50),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: EdgeInsets.all(8),
            width: 135,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    height: 180,
                    width: 135,
                    fit: BoxFit.cover,
                    actor.profilePath,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return CircularProgressIndicator(strokeWidth: 2);
                      }
                      return child;
                    },
                  ),
                ),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}