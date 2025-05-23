import 'package:albums_list/data/models/album.dart';
import 'package:albums_list/data/models/photo.dart';
import 'package:albums_list/data/repository/album_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc({required this.repository}) : super(AlbumInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await repository.fetchAlbums();
      final photos = await repository.fetchPhotos();

      // Map albumId to its thumbnail photo (you can choose the first photo of each album)
      final Map<int, Photo> albumThumbnails = {};
      for (var photo in photos) {
        if (!albumThumbnails.containsKey(photo.albumId)) {
          albumThumbnails[photo.albumId] = photo;
        }
      }

      emit(AlbumLoaded(albums: albums, thumbnails: albumThumbnails));
    } catch (_) {
      emit(AlbumError('Failed to load albums'));
    }
  }
}
