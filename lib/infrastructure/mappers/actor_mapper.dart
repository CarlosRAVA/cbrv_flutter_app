import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:cbrv_movies_app/infrastructure/infraestructure.dart';


class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.castId,
    name: cast.name,
    profilePath: cast.profilePath.isNotEmpty
        ? 'https://imagen.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    character: cast.character,
  );
}