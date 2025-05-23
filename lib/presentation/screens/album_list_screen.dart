import 'package:albums_list/bloc/album_bloc.dart';
import 'package:albums_list/presentation/widgets/error_retry_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';



class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
              if (state is AlbumLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AlbumError) {
                return ErrorRetryWidget(
                  message: state.message,
                  onRetry: () => context.read<AlbumBloc>().add(LoadAlbums()),
                );
              } else if (state is AlbumLoaded) {
                return ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final album = state.albums[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        tileColor: Theme.of(context).cardColor,
                        title: Text(
                          album.title,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => context.push('/album/${album.id}'),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
