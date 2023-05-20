import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/shared/sevices/apiclient.dart';
import '../model/singer.dart';

class SingerService {
  final ApiClient _apiClient = ApiClient();
  Future<List<Singer>> getSingers() async {
    try {
      String url = dotenv.env['singerurl']!;

      Response response = await _apiClient.get(url);
      print(response.data);
      // Convert String (JSON) to Object
      dynamic object = jsonDecode(response.data);
      //print(respose.data);
      //print(object.runtimeType);
      //print("****************");
      //print(response.data.runtimeType);
      List<dynamic> list = object['singers'];
      List<Singer> singer = list.map((m) => Singer.fromJSON(m)).toList();
      //print("Singers $singer");
      return singer;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
