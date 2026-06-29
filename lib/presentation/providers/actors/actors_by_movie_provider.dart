// State
import 'package:cbrv_movies_app/domain/entities/actor.dart';
import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:cbrv_movies_app/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final actorsByMovieProvider = StateNotifierProvider((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

//Notifier

typedef GetActorsCallBack = Future<List<Actor>> Function(String moviedb);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}