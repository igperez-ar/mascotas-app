import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:mascotas_app/models/models.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> with HydratedMixin {

  FavoriteBloc() : super(FavoriteInitial()) {
    hydrate();
  }

  @override
  FavoriteState fromJson(Map<String, dynamic> json) {
    try {
      print('HydratedFavorite loaded!');
      final List favorite = json['favorite'];
      return FavoriteSuccess(
        favorite.map((e) => Favorite.fromJson(jsonDecode(e))).toList()
      );
      
    } catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Map<String,dynamic> toJson(FavoriteState state) {
    if (state is FavoriteSuccess) {
      print('HydratedFavorite saved!');
      return {'favorite': state.favorite.map((e) => jsonEncode(e.toJson())).toList()};

    } else {
      return null;
    }
  }


  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event
  ) async* {
    if (event is FetchFavorite) {
      yield* _mapFavoriteLoadedToState();
    } else if (event is AddFavorite) {
      yield* _mapFavoriteAddedToState(event);
    } else if (event is RemoveFavorite) {
      yield* _mapFavoriteRemovedToState(event);
    } else if (event is UpdateRecuerdos) {
      yield* _mapFavoriteUpdatedToState(event);
    } 
  }

  Stream<FavoriteState> _mapFavoriteLoadedToState() async* {
    yield FavoriteFetching();

    try {
      final List<Favorite> favorite = []; 
      
      yield FavoriteSuccess(favorite);
    } catch (e) {
      print(e);
      yield FavoriteFailure();
    }
  } 

  Stream<FavoriteState> _mapFavoriteAddedToState(
    AddFavorite event
  ) async* {
    if (state is FavoriteSuccess){
      final List<Favorite> updatedFavorite = List
        .from((state as FavoriteSuccess).favorite)
        ..add(event.favorite);
        
      yield FavoriteSuccess(updatedFavorite);
    }
  } 

  Stream<FavoriteState> _mapFavoriteRemovedToState(
    RemoveFavorite event
  ) async* {
    if (state is FavoriteSuccess) {
      final List<Favorite> updatedFavorite = (state as FavoriteSuccess)
        .favorite
        .where((element) => !(element.id == event.favorite.id
                         && element.tipo == event.favorite.tipo))
        .toList();

      yield FavoriteSuccess(updatedFavorite);
    }
  } 

  Stream<FavoriteState> _mapFavoriteUpdatedToState(
    UpdateRecuerdos event
  ) async* {
    if (state is FavoriteSuccess){
      final List<Favorite> updatedFavorite = List.from((state as FavoriteSuccess).favorite);
      final index = updatedFavorite.indexOf(event.favorite);
      final favorite = Favorite(
        id: event.favorite.id,
        tipo: event.favorite.tipo,
        recuerdos: event.recuerdos
      );

      updatedFavorite[index] = favorite;
        
      yield FavoriteSuccess(updatedFavorite);
    }
  } 
}
