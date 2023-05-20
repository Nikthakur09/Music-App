import 'package:json_annotation/json_annotation.dart';
part 'song.g.dart';

@JsonSerializable()
class Song {
  String? trackName;
  @JsonKey(name: 'artworkUrl100')
  String? photo;
  @JsonKey(name: 'collectionCensoredName')
  String? artistName;
  String? previewUrl;
  // ignore: non_constant_identifier_names
  static Song SongFromJSON(Map<String, dynamic> map) => _$SongFromJson(map);
}
