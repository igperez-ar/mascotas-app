part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteFetching extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Favorite> favorite;

  const FavoriteSuccess(this.favorite); 

  @override
  List<Object> get props => [favorite];
}

class FavoriteFailure extends FavoriteState {}