import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'app_router.dart';
import 'bloc/album_bloc.dart';
import 'data/repository/album_repository.dart';

void main() {
  final albumRepository = AlbumRepository(client: http.Client());

  runApp(MyApp(albumRepository: albumRepository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository albumRepository;

  const MyApp({super.key, required this.albumRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: albumRepository,
      child: BlocProvider(
        create: (_) => AlbumBloc(repository: albumRepository)..add(LoadAlbums()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Album App',
          routerConfig: AppRouter.router,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFE8F5E9), // Light mint green
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF66BB6A), // Medium green
              foregroundColor: Colors.white,
            ),
            cardColor: const Color(0xFFA5D6A7), // Soft green
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFF1B5E20)), // Deep green text
              bodyMedium: TextStyle(color: Color(0xFF1B5E20)),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF66BB6A),
              brightness: Brightness.light,
            ),
          ),
        ),
      ),
    );
  }
}
