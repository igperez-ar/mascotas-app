part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FetchFavorite extends FavoriteEvent {
  const FetchFavorite();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteEvent {
  final Favorite favorite;

  const AddFavorite(this.favorite);

  @override
  List<Object> get props => [favorite];
}

class RemoveFavorite extends FavoriteEvent {
  final Favorite favorite;

  const RemoveFavorite(this.favorite);

  @override
  List<Object> get props => [favorite];
}

class UpdateRecuerdos extends FavoriteEvent {
  final Favorite favorite;
  final List<String> recuerdos;

  const UpdateRecuerdos(this.favorite, this.recuerdos);

  @override
  List<Object> get props => [favorite, recuerdos];
}
