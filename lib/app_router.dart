import 'package:albums_list/presentation/screens/album_detail_screen.dart';
import 'package:albums_list/presentation/screens/album_list_screen.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/album/:id',
        builder: (context, state) {
          final albumId = int.parse(state.pathParameters['id']!);
          return AlbumDetailScreen(albumId: albumId);
        },
      ),
    ],
  );
}
