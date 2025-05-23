import 'dart:convert';
import 'package:albums_list/data/models/album.dart';
import 'package:albums_list/data/models/photo.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  final http.Client client;

  AlbumRepository({required this.client});

  Future<List<Album>> fetchAlbums() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch albums');
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch photos');
    }
  }
}
