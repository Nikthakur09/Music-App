import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music_app/shared/sevices/apiclient.dart';

import '../Models/song.dart';

class SongService {
  ApiClient apiClient = ApiClient();
  //Singleton hota hai memory kam krne k liye jb hum api client k object bnayeege
  //lets create singleton
  //jsondecode tab legega jb string aayega
  //widget keyword use kiya jayega statefull k state me
  Future<List<Song>> getSongs(String singerName) async {
    try {
      final url = 'https://itunes.apple.com/search?term=$singerName&limit=25';
      Response response = await apiClient.get(url);
      print(response.data);
      // print(response.data.runtimeType);

      Map<String, dynamic> map = jsonDecode(response.data);
      List<dynamic> list = map['results'];
      List<Song> songs = list.map((e) => Song.SongFromJSON(e)).toList();
      //print(songs);
      return songs;
    } catch (e) {
      return [];
    }
  }
}
