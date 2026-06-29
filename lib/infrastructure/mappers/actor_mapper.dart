import 'package:cbrv_movies_app/domain/entities/domain.dart';
import 'package:cbrv_movies_app/infrastructure/infraestructure.dart';


class ActorMapper {

  static Actor castToEntity ( Cast cast ) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath.isEmpty ? 'https://image.tmdb.org.t/p/w500${cast.profilePath}' : 'https://www.freeiconspng.com/img/1681',
    character: cast.character
  );
}